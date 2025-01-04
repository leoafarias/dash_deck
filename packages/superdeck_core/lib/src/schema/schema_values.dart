part of 'schema.dart';

sealed class Schema<T> {
  const Schema({
    this.validators = const [],
  });

  Schema<T> copyWith({
    List<Validator<T>>? validators,
  });

  final List<Validator<T>> validators;

  static const string = StringSchema.new;
  static const object = ObjectSchema.new;
  static const double = DoubleSchema.new;
  static const int = IntSchema.new;
  static const boolean = BooleanSchema.new;
  static const any = ObjectSchema({}, additionalProperties: true);
  static const list = SchemaList.new;
  static final enumValue = StringSchema.enumString;

  @protected
  T? parseValue(Object? value, T? Function(String) fromString) {
    if (value is T) return value;
    if (value is String) return fromString(value);
    return null;
  }

  T? tryParse(Object? value);

  void validateOrThrow(Object value) {
    final result = validate([], value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }

  ValidationResult validate(List<String> path, Object value) {
    // Attempt parsing
    final typedValue = tryParse(value);
    if (typedValue == null) {
      return ValidationResult(
        path,
        errors: [
          InvalidTypeValidationError(value: value.runtimeType, expectedType: T)
        ],
      );
    }

    final allErrors = <ValidationError>[];
    for (final validator in validators) {
      final error = validator.validate(typedValue);
      if (error != null) {
        allErrors.add(ConstraintsValidationError(error.message));
      }
    }
    if (allErrors.isNotEmpty) {
      return ValidationResult(path, errors: allErrors);
    }

    // Now let the subclass validate the typed value specifically
    return validateValue(path, typedValue);
  }

  @protected
  ValidationResult validateValue(List<String> path, T value) {
    return ValidationResult.valid(path);
  }
}

class BooleanSchema extends Schema<bool> {
  const BooleanSchema({super.validators = const []});

  @override
  BooleanSchema copyWith({
    List<Validator<bool>>? validators,
  }) {
    return BooleanSchema(
      validators: validators ?? this.validators,
    );
  }

  @override
  bool? tryParse(Object? value) {
    return parseValue(value, (value) {
      final valueString = value.toLowerCase();
      if (valueString == 'true') {
        return true;
      } else if (valueString == 'false') {
        return false;
      }
      return null;
    });
  }
}

final class StringSchema extends Schema<String> {
  const StringSchema({super.validators = const []});

  @override
  StringSchema copyWith({
    List<Validator<String>>? validators,
  }) {
    return StringSchema(
      validators: validators ?? this.validators,
    );
  }

  static StringSchema enumString<E extends Enum>(List<E> values) {
    return StringSchema(validators: [
      ArrayValidator(values.map((e) => e.name.snakeCase()).toList()),
    ]);
  }

  @override
  String? tryParse(Object? value) {
    // Value is already a string
    return parseValue(value, (value) => value);
  }

  Schema<String> isPosixPath() {
    return copyWith(validators: [
      ...validators,
      const PosixPathValidator(),
    ]);
  }

  Schema<String> isEmail() {
    return copyWith(validators: [
      ...validators,
      const EmailValidator(),
    ]);
  }

  Schema<String> isHexColor() {
    return copyWith(validators: [
      ...validators,
      const HexColorValidator(),
    ]);
  }

  Schema<String> isArray(List<String> values) {
    return copyWith(validators: [
      ...validators,
      ArrayValidator(values),
    ]);
  }

  Schema<String> isEmpty() {
    return copyWith(validators: [
      ...validators,
      const IsEmptyValidator(),
    ]);
  }

  Schema<String> minLength(int min) {
    return copyWith(validators: [
      ...validators,
      MinLengthValidator(min),
    ]);
  }

  Schema<String> maxLength(int max) {
    return copyWith(validators: [
      ...validators,
      MaxLengthValidator(max),
    ]);
  }
}

final class IntSchema extends Schema<int> {
  const IntSchema({super.validators = const []});

  @override
  IntSchema copyWith({
    List<Validator<int>>? validators,
  }) {
    return IntSchema(
      validators: validators ?? this.validators,
    );
  }

  @override
  int? tryParse(Object? value) {
    return parseValue(value, int.tryParse);
  }
}

final class DoubleSchema extends Schema<double> {
  const DoubleSchema({super.validators = const []});

  @override
  DoubleSchema copyWith({
    List<Validator<double>>? validators,
  }) {
    return DoubleSchema(validators: validators ?? this.validators);
  }

  @override
  double? tryParse(Object? value) {
    return parseValue(value, double.tryParse);
  }
}

class DiscriminatedObjectSchema extends Schema<Map<String, dynamic>> {
  final String discriminatorKey;
  final Map<String, Schema> schemas;

  DiscriminatedObjectSchema({
    required this.discriminatorKey,
    required this.schemas,
    super.validators,
  });

  @override
  DiscriminatedObjectSchema copyWith({
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return DiscriminatedObjectSchema(
      discriminatorKey: discriminatorKey,
      schemas: schemas,
      validators: validators ?? this.validators,
    );
  }

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  Schema? getDiscriminatedKeyValue(Map<String, dynamic> value) {
    final discriminatorValue = value[discriminatorKey];
    return discriminatorValue != null ? schemas[discriminatorValue] : null;
  }

  @override
  ValidationResult validateValue(
    List<String> path,
    Map<String, dynamic> value,
  ) {
    // Similar logic to ObjectSchema, except we must first find the right schema based on the discriminator.
    final discriminatedSchema = getDiscriminatedKeyValue(value);
    if (discriminatedSchema == null) {
      return ValidationResult(
        path,
        errors: [
          RequiredPropMissingValidationError(property: discriminatorKey),
          DiscriminatorMissingValidationError(propertyKey: discriminatorKey),
        ],
      );
    }

    // Just defer to the discriminated schema for final validation.
    return discriminatedSchema.validate(path, value);
  }
}

class ObjectSchema extends Schema<Map<String, dynamic>> {
  final Map<String, Schema> properties;
  final bool additionalProperties;
  final List<String> required;

  const ObjectSchema(
    this.properties, {
    this.additionalProperties = false,
    super.validators = const [],
    this.required = const [],
  });

  @override
  ObjectSchema copyWith({
    bool? additionalProperties,
    List<String>? required,
    Map<String, Schema>? properties,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return ObjectSchema(
      properties ?? this.properties,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      required: required ?? this.required,
      validators: validators ?? this.validators,
    );
  }

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  T? getSchemaValue<T extends Schema>(String key) {
    return properties[key] as T?;
  }

  ObjectSchema extend(
    Map<String, Schema> properties, {
    bool? additionalProperties,
    List<String>? required,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    // if property SchemaValue is of SchemaMap, we need to merge them
    final mergedProperties = {...this.properties};

    for (final entry in properties.entries) {
      final key = entry.key;
      final prop = entry.value;

      final existingProp = mergedProperties[key];

      if (existingProp is ObjectSchema && prop is ObjectSchema) {
        mergedProperties[key] = existingProp.extend(
          prop.properties,
          additionalProperties: additionalProperties,
          validators: validators,
          required: required,
        );
      } else {
        mergedProperties[key] = prop;
      }
    }

    return copyWith(
      properties: mergedProperties,
      additionalProperties: additionalProperties,
      validators: validators,
      required: required,
    );
  }

  @override
  ValidationResult validateValue(
    List<String> path,
    Map<String, dynamic> value,
  ) {
    final valueKeys = value.keys.toSet();
    final schemaKeys = properties.keys.toSet();

    final validationErrors = <ValidationError>[];

    final requiredKeys = properties.entries
        .where((entry) => required.contains(entry.key))
        .map((entry) => entry.key)
        .toSet();

    final allKeys = valueKeys.union(schemaKeys);

    // Validate each property
    for (final key in allKeys) {
      if (!schemaKeys.contains(key) && !additionalProperties) {
        validationErrors.add(
          UnalowedAdditionalPropertyValidationError(propertyKey: key),
        );
        continue;
      }

      final schema = properties[key];

      if (schema == null) {
        continue;
      }

      final prop = value[key];
      if (prop == null) {
        if (requiredKeys.contains(key)) {
          validationErrors.add(
            RequiredPropMissingValidationError(property: key),
          );
        }
        continue;
      }
      final result = schema.validate([...path, key], prop);
      if (!result.isValid) {
        return result;
      }
    }

    if (validationErrors.isNotEmpty) {
      return ValidationResult(path, errors: validationErrors);
    }

    return ValidationResult.valid(path);
  }
}

class SchemaList<T extends Schema<V>, V> extends Schema<List<V>> {
  final T itemSchema;
  const SchemaList(
    this.itemSchema, {
    super.validators = const [],
  });

  @override
  SchemaList<T, V> copyWith({
    bool? required,
    List<Validator<List<V>>>? validators,
  }) {
    return SchemaList(
      itemSchema,
      validators: validators ?? this.validators,
    );
  }

  @override
  List<V>? tryParse(Object? value) {
    if (value is List) {
      if (value is List<V>) return value;
      final isInvalid = value.any((v) => itemSchema.tryParse(v) == null);

      if (isInvalid) {
        return null;
      }
      return value as List<V>;
    }
    return null;
  }

  @override
  ValidationResult validateValue(List<String> path, List<V> value) {
    final errors = <ValidationError>[];
    for (var i = 0; i < value.length; i++) {
      final result = itemSchema.validate([...path, i.toString()], value[i]!);
      if (!result.isValid) {
        errors.addAll(result.errors);
      }
    }

    if (errors.isNotEmpty) {
      return ValidationResult(path, errors: errors);
    }

    return ValidationResult.valid(path);
  }
}
