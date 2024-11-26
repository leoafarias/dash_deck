part of 'schema.dart';

typedef JSON = Map<String, Object?>;

class SchemaObj extends SchemaValue<JSON> {
  final Map<String, SchemaValue> properties;
  final bool additionalProperties;
  const SchemaObj(
    this.properties, {
    super.optional = true,
    this.additionalProperties = false,
    super.validators = const [],
  });

  @override
  SchemaObj copyWith({
    bool? optional,
    bool? additionalProperties,
    Map<String, SchemaValue>? properties,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return SchemaObj(
      properties ?? this.properties,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      optional: optional ?? optionalValue,
      validators: validators ?? this.validators,
    );
  }

  @override
  JSON? tryParse(Object? value) {
    return value is JSON ? value : null;
  }

  SchemaObj mergeSchema(SchemaObj schema) {
    return extend(
      schema.properties,
      additionalProperties: schema.additionalProperties,
    );
  }

  T? getSchemaValue<T extends SchemaValue>(String key) {
    return properties[key] as T?;
  }

  SchemaObj extend(
    Map<String, SchemaValue> properties, {
    bool? additionalProperties,
    bool? optional,
  }) {
    // if property SchemaValue is of SchemaMap, we need to merge them
    final mergedProperties = {...this.properties};

    for (final entry in properties.entries) {
      final key = entry.key;
      final prop = entry.value;

      final existingProp = mergedProperties[key];

      if (existingProp is SchemaObj && prop is SchemaObj) {
        mergedProperties[key] = existingProp.extend(prop.properties);
      } else {
        mergedProperties[key] = prop;
      }
    }

    return copyWith(
      properties: mergedProperties,
      optional: optional,
      additionalProperties: additionalProperties,
    );
  }

  @override
  ValidationResult validate(List<String> path, Object? value) {
    try {
      if (value == null) {
        return optionalValue
            ? ValidationResult.valid(path)
            : throw RequiredPropMissingValidationError(property: path.last);
      }

      final parsedValue = tryParse(value);

      if (parsedValue == null) {
        throw InvalidTypeValidationError(
          value: value.runtimeType,
          expectedType: Map<String, dynamic>,
        );
      }

      final keys = parsedValue.keys.toSet();

      final required = properties.entries
          .where((entry) => !entry.value.optionalValue)
          .map((entry) => entry.key);

      final requiredKeys = required.toSet();

      for (final key in requiredKeys.difference(keys)) {
        throw RequiredPropMissingValidationError(property: key);
      }

      if (additionalProperties == false) {
        final extraKeys = keys.difference(properties.keys.toSet());
        if (extraKeys.isNotEmpty) {
          for (final key in extraKeys) {
            throw UnalowedAdditionalPropertyValidationError(property: key);
          }
        }
      }
      for (final entry in parsedValue.entries) {
        final key = entry.key;
        final prop = properties[key];

        if (prop == null) {
          if (additionalProperties == false) {
            throw UnalowedAdditionalPropertyValidationError(property: key);
          }
        } else {
          final result = prop.validate([...path, key], entry.value);
          if (!result.isValid) {
            return result;
          }
        }
      }

      return ValidationResult.valid(path);
    } on ValidationError catch (e) {
      return ValidationResult(path: path, errors: [e]);
    }
  }
}

class SchemaList<T extends SchemaValue> extends SchemaValue<List<T>> {
  final T items;
  const SchemaList(
    this.items, {
    super.optional = true,
    super.validators = const [],
  });

  @override
  SchemaList<T> copyWith({
    bool? optional,
    List<Validator<List<T>>>? validators,
  }) {
    return SchemaList(
      items,
      optional: optional ?? optionalValue,
      validators: validators ?? this.validators,
    );
  }

  @override
  List<T>? tryParse(Object? value) {
    if (value is List) {
      print('Runtimetype: ${items.runtimeType}');
      print('Expected: ${value.runtimeType}');
      print('Value: $value');
      final parsedList = value.map((e) => items.tryParse(e) as T?);

      return parsedList.any((e) => e == null) ? null : List<T>.from(parsedList);
    }
    return null;
  }

  @override
  ValidationResult validate(List<String> path, Object? value) {
    final validationResult = super.validate(path, value);
    if (!validationResult.isValid) {
      return validationResult;
    }
    try {
      final parsedValue = tryParse(value)!;

      for (var i = 0; i < parsedValue.length; i++) {
        final result = items.validate([...path, i.toString()], parsedValue[i]);
        if (!result.isValid) {
          return result;
        }
      }

      return ValidationResult.valid(path);
    } on ValidationError catch (e) {
      return ValidationResult(path: path, errors: [e]);
    }
  }
}

typedef _DoubleType = double;
typedef _IntType = int;

class Schema {
  const Schema._();

  static const string = SchemaValue<String>();
  static const object = SchemaObj.new;
  static const double = SchemaValue<_DoubleType>();
  static const int = SchemaValue<_IntType>();
  static const boolean = SchemaValue<bool>();
  static const any = SchemaObj({}, additionalProperties: true);
  static const list = SchemaList.new;
}

class DiscriminatorSchema extends SchemaValue<Map<String, dynamic>> {
  final String discriminatorKey;
  final SchemaValue baseSchema;
  final Map<String, SchemaValue> schemas;

  DiscriminatorSchema({
    required this.discriminatorKey,
    required this.schemas,
    required this.baseSchema,
    super.optional,
    super.validators = const [],
  });

  @override
  DiscriminatorSchema copyWith({
    bool? optional,
    Map<String, SchemaObj>? schemas,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return DiscriminatorSchema(
      discriminatorKey: discriminatorKey,
      schemas: schemas ?? this.schemas,
      baseSchema: baseSchema,
      optional: optional ?? optionalValue,
      validators: validators ?? this.validators,
    );
  }

  @override
  ValidationResult validate(List<String> path, Object? value) {
    // First, perform the base validation using super.validate
    final baseValidationResult = super.validate(path, value);
    if (!baseValidationResult.isValid) {
      return baseValidationResult;
    }

    final mapValue = tryParse(value)!;

    final baseSchemaResult = baseSchema.validate(path, mapValue);

    if (!baseSchemaResult.isValid) {
      return baseSchemaResult;
    }

    final discriminatorValue = mapValue[discriminatorKey];
    if (discriminatorValue == null) {
      return ValidationResult(
        path: path,
        errors: [
          RequiredPropMissingValidationError(
            property: discriminatorKey,
          )
        ],
      );
    }

    final schema = schemas[discriminatorValue];
    if (schema == null) {
      return ValidationResult(
        path: path,
        errors: [
          InvalidTypeValidationError(
            value: discriminatorValue.runtimeType,
            expectedType: Map<String, dynamic>,
          )
        ],
      );
    }

    // Validate against the selected schema
    return schema.validate(path, value);
  }
}
