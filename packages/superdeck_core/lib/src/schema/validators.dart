part of 'schema.dart';

abstract class Validator<T> {
  const Validator();

  ValidationError? validate(T value);
}

class ArrayValidator extends Validator<String> {
  final List<String> values;
  const ArrayValidator(this.values);

  @override
  ValidationError? validate(Object? value) {
    if (value is String) {
      if (values.contains(value)) {
        return null;
      }
    }
    return EnumViolatedValidationError(value: '$value', possibleValues: values);
  }
}

class EmailValidator extends RegexValidator {
  const EmailValidator()
      : super(
          name: 'email',
          pattern: r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$',
          example: 'example@domain.com',
        );
}

class UrlValidator extends RegexValidator {
  const UrlValidator()
      : super(
          name: 'url',
          pattern:
              r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
          example: 'https://example.com',
        );
}

class PosixPathValidator extends RegexValidator {
  const PosixPathValidator()
      : super(
          name: 'posix path',
          example: '/path/to/file',
          pattern: r'^(/[^/ ]*)+/?$',
        );
}

class HexColorValidator extends RegexValidator {
  const HexColorValidator()
      : super(
          name: 'hex color',
          example: '#ff0000',
          pattern: r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$',
        );
}

class RegexValidator extends Validator<String> {
  final String name;
  final String pattern;
  final String example;
  const RegexValidator({
    required this.name,
    required this.pattern,
    required this.example,
  });

  @override
  ValidationError? validate(String value) {
    if (!RegExp(pattern).hasMatch(value)) {
      return ConstraintsValidationError(
        'String does is not $name. Example: $example',
      );
    }

    return null;
  }
}

class IsEmptyValidator extends Validator<String> {
  const IsEmptyValidator();

  @override
  ValidationError? validate(String value) {
    return value.isEmpty
        ? null
        : const ConstraintsValidationError('String is not empty');
  }
}

class MinLengthValidator extends Validator<String> {
  final int min;
  const MinLengthValidator(this.min);

  @override
  ValidationError? validate(String value) {
    return value.length >= min
        ? null
        : ConstraintsValidationError(
            'String length is less than the minimum required length: $min',
          );
  }
}

class MaxLengthValidator extends Validator<String> {
  final int max;
  const MaxLengthValidator(this.max);

  @override
  ValidationError? validate(String value) {
    return value.length <= max
        ? null
        : ConstraintsValidationError(
            'String length is greater than the maximum required length: $max',
          );
  }
}

class MinValueValidator extends Validator<num> {
  final num min;
  const MinValueValidator(this.min);

  @override
  ValidationError? validate(num value) {
    return value >= min
        ? null
        : ConstraintsValidationError(
            'Value is less than the minimum required value: $min',
          );
  }
}

class MaxValueValidator extends Validator<num> {
  final num max;
  const MaxValueValidator(this.max);

  @override
  ValidationError? validate(num value) {
    return value <= max
        ? null
        : ConstraintsValidationError(
            'Value is greater than the maximum required value: $max',
          );
  }
}

class RangeValidator extends Validator<num> {
  final num min;
  final num max;
  const RangeValidator(this.min, this.max);

  @override
  ValidationError? validate(num value) {
    return value >= min && value <= max
        ? null
        : ConstraintsValidationError(
            'Value is not within the required range: $min - $max',
          );
  }
}

class RequiredValidator<T> extends Validator<T> {
  const RequiredValidator();

  @override
  ValidationError? validate(value) {
    return value != null
        ? null
        : const ConstraintsValidationError('is required');
  }
}

// unique item list validator
class UniqueItemsValidator<T> extends Validator<List<T>> {
  const UniqueItemsValidator();

  @override
  ValidationError? validate(List<T> value) {
    final unique = value.toSet().toList();
    return unique.length == value.length
        ? null
        : const ConstraintsValidationError('List items are not unique');
  }
}

// min length of list validator
class MinItemsValidator<T> extends Validator<List<T>> {
  final int min;
  const MinItemsValidator(this.min);

  @override
  ValidationError? validate(List<T> value) {
    return value.length >= min
        ? null
        : ConstraintsValidationError(
            'List length is less than the minimum required length: $min',
          );
  }
}

// max length of list validator
class MaxItemsValidator<T> extends Validator<List<T>> {
  final int max;
  const MaxItemsValidator(this.max);

  @override
  ValidationError? validate(List<T> value) {
    return value.length <= max
        ? null
        : ConstraintsValidationError(
            'List length is greater than the maximum required length: $max',
          );
  }
}
