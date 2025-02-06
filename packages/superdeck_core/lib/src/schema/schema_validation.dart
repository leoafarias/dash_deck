part of 'schema.dart';

class ValidationResult {
  final String schemaName;
  final List<String> path;
  final List<ValidationError> errors;
  final Object? value;

  const ValidationResult(
    this.schemaName,
    this.path, {
    required this.errors,
    required this.value,
  });

  bool get isValid => errors.isEmpty;

  const ValidationResult.valid(this.schemaName, this.path, this.value)
      : errors = const [];

  @override
  String toString() {
    return 'ValidationResult(schemaName: $schemaName, path: $path, errors: $errors, value: $value)';
  }
}

sealed class ValidationError {
  String get message;

  const ValidationError();
}

class DiscriminatorMissingValidationError extends ValidationError {
  final String propertyKey;

  const DiscriminatorMissingValidationError({
    required this.propertyKey,
  });

  @override
  String get message => 'Missing discriminator key: [$propertyKey]';
}

class UnalowedAdditionalPropertyValidationError extends ValidationError {
  final String propertyKey;

  const UnalowedAdditionalPropertyValidationError({
    required this.propertyKey,
  });

  @override
  String get message => 'Unallowed property: [$propertyKey]';
}

class EnumViolatedValidationError extends ValidationError {
  final String value;
  final List<String> possibleValues;

  const EnumViolatedValidationError({
    required this.value,
    required this.possibleValues,
  });

  @override
  String get message =>
      'Wrong value: [$value] \n\n Possible values: $possibleValues';
}

class RequiredPropMissingValidationError extends ValidationError {
  final String property;

  const RequiredPropMissingValidationError({
    required this.property,
  });

  @override
  String get message => 'Missing prop: [$property]';
}

class InvalidTypeValidationError extends ValidationError {
  final Type value;
  final Type expectedType;

  const InvalidTypeValidationError({
    required this.value,
    required this.expectedType,
  });

  @override
  String get message => 'Invalid type: expected [$expectedType] got [$value]';
}

class ConstraintsValidationError extends ValidationError {
  final String _message;
  const ConstraintsValidationError(this._message);

  @override
  String get message => 'Constraints: $_message';
}

class UnknownValidationError extends ValidationError {
  const UnknownValidationError();

  @override
  String get message => 'Unknown Validation error';
}

/// An exception thrown when schema validation fails.
class SchemaValidationException implements Exception {
  final ValidationResult result;

  const SchemaValidationException(this.result);

  @override
  String toString() {
    final errorMessages =
        result.errors.map((e) => '${e.runtimeType}: ${e.message}').join('\n');
    final location = result.path.isNotEmpty
        ? 'Location: ${result.path.join('.')}'
        : 'No specific location in schema.';
    // return 'SchemaValidationException:\nSchema: ${result.schemaName}\n$errorMessages\n$location';
    return '''
Validation Failed:

Schema: ${result.schemaName}
Value: ${result.value}

Errors:
$errorMessages

Location: $location
''';
  }
}
