part of 'schema.dart';

sealed class SchemaValue<T> {
  const SchemaValue({
    bool required = false,
    this.validators = const [],
  }) : isRequired = required;

  SchemaValue<T> copyWith({
    bool? required,
    List<Validator<T>>? validators,
  });
  SchemaValue<T> required() => copyWith(required: true);

  SchemaValue<T> optional() => copyWith(required: false);

  final List<Validator<T>> validators;

  final bool isRequired;

  bool get isOptional => !isRequired;

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

  ValidationResult validate(List<String> path, Object? value) {
    // Check null and required
    if (value == null) {
      return isOptional
          ? ValidationResult.valid(path)
          : ValidationResult(
              path,
              errors: [
                RequiredPropMissingValidationError(
                    property: path.lastOrNull ?? '')
              ],
            );
    }

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

class BooleanSchema extends SchemaValue<bool> {
  const BooleanSchema({super.required, super.validators = const []});

  @override
  BooleanSchema copyWith({
    bool? required,
    List<Validator<bool>>? validators,
  }) {
    return BooleanSchema(
      required: required ?? isRequired,
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

final class StringSchema extends SchemaValue<String> {
  const StringSchema({super.required = false, super.validators = const []});

  @override
  StringSchema copyWith({
    bool? required,
    List<Validator<String>>? validators,
  }) {
    return StringSchema(
      required: required ?? isRequired,
      validators: validators ?? this.validators,
    );
  }

  @override
  String? tryParse(Object? value) {
    // Value is already a string
    return parseValue(value, (value) => value);
  }

  SchemaValue<String> isPosixPath() {
    return copyWith(validators: [
      ...validators,
      const PosixPathValidator(),
    ]);
  }

  SchemaValue<String> isEmail() {
    return copyWith(validators: [
      ...validators,
      const EmailValidator(),
    ]);
  }

  SchemaValue<String> isHexColor() {
    return copyWith(validators: [
      ...validators,
      const HexColorValidator(),
    ]);
  }

  SchemaValue<String> isArray(List<String> values) {
    return copyWith(validators: [
      ...validators,
      ArrayValidator(values),
    ]);
  }

  SchemaValue<String> isEmpty() {
    return copyWith(validators: [
      ...validators,
      const IsEmptyValidator(),
    ]);
  }

  SchemaValue<String> minLength(int min) {
    return copyWith(validators: [
      ...validators,
      MinLengthValidator(min),
    ]);
  }

  SchemaValue<String> maxLength(int max) {
    return copyWith(validators: [
      ...validators,
      MaxLengthValidator(max),
    ]);
  }
}

final class IntSchema extends SchemaValue<int> {
  const IntSchema({super.required, super.validators = const []});

  @override
  IntSchema copyWith({
    bool? required,
    List<Validator<int>>? validators,
  }) {
    return IntSchema(
      required: required ?? isRequired,
      validators: validators ?? this.validators,
    );
  }

  @override
  int? tryParse(Object? value) {
    return parseValue(value, int.tryParse);
  }
}

final class DoubleSchema extends SchemaValue<double> {
  const DoubleSchema({super.required, super.validators = const []});

  @override
  DoubleSchema copyWith({
    bool? required,
    List<Validator<double>>? validators,
  }) {
    return DoubleSchema(
        required: required ?? isRequired,
        validators: validators ?? this.validators);
  }

  @override
  double? tryParse(Object? value) {
    return parseValue(value, double.tryParse);
  }
}

class DiscriminatedObjectSchema extends SchemaValue<Map<String, dynamic>> {
  final String discriminatorKey;
  final Map<String, SchemaValue> schemas;

  DiscriminatedObjectSchema({
    required this.discriminatorKey,
    required this.schemas,
    super.required,
    super.validators,
  });

  @override
  DiscriminatedObjectSchema copyWith({
    bool? required,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return DiscriminatedObjectSchema(
      discriminatorKey: discriminatorKey,
      schemas: schemas,
      required: required ?? isRequired,
      validators: validators ?? this.validators,
    );
  }

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  SchemaValue? getDiscriminatedKeyValue(Map<String, dynamic> value) {
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

class ObjectSchema extends SchemaValue<Map<String, dynamic>> {
  final Map<String, SchemaValue> properties;
  final bool additionalProperties;

  const ObjectSchema(
    this.properties, {
    super.required = false,
    this.additionalProperties = false,
    super.validators = const [],
  });

  @override
  ObjectSchema copyWith({
    bool? required,
    bool? additionalProperties,
    Map<String, SchemaValue>? properties,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return ObjectSchema(
      properties ?? this.properties,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      required: required ?? isRequired,
      validators: validators ?? this.validators,
    );
  }

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  T? getSchemaValue<T extends SchemaValue>(String key) {
    return properties[key] as T?;
  }

  ObjectSchema extend(
    Map<String, SchemaValue> properties, {
    bool? additionalProperties,
    bool? required,
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
          required: required,
          validators: validators,
        );
      } else {
        mergedProperties[key] = prop;
      }
    }

    return copyWith(
      properties: mergedProperties,
      required: required,
      additionalProperties: additionalProperties,
      validators: validators,
    );
  }

  @override
  ValidationResult validateValue(
      List<String> path, Map<String, dynamic> value) {
    // At this point, we are guaranteed `parsedValue` is a Map<String,dynamic> due to tryParse.

    final keys = value.keys.toSet();
    final requiredKeys = properties.entries
        .where((entry) => entry.value.isRequired)
        .map((entry) => entry.key)
        .toSet();

    // Check missing required keys
    final missingKeys = requiredKeys.difference(keys);
    if (missingKeys.isNotEmpty) {
      // Collect all errors for missing keys
      return ValidationResult(
        path,
        errors: missingKeys
            .map((key) => RequiredPropMissingValidationError(property: key))
            .toList(),
      );
    }

    final validationErrors = <ValidationError>[];

    // Check additional properties
    if (!additionalProperties) {
      final extraKeys = keys.difference(properties.keys.toSet());
      for (final key in extraKeys) {
        validationErrors
            .add(UnalowedAdditionalPropertyValidationError(propertyKey: key));
      }
      if (validationErrors.isNotEmpty) {
        return ValidationResult(path, errors: validationErrors);
      }
    }

    // Validate each property
    for (final entry in properties.entries) {
      final key = entry.key;
      final schema = entry.value;
      final prop = value[key];
      final result = schema.validate([...path, key], prop);
      if (!result.isValid) {
        return result;
      }
    }

    return ValidationResult.valid(path);
  }
}
