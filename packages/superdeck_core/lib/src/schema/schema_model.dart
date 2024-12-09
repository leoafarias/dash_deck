part of 'schema.dart';

typedef JSON = Map<String, Object?>;

class SchemaList<T extends SchemaValue<V>, V> extends SchemaValue<List<V>> {
  final T itemSchema;
  const SchemaList(
    this.itemSchema, {
    super.required,
    super.validators = const [],
  });

  @override
  SchemaList<T, V> copyWith({
    bool? required,
    List<Validator<List<V>>>? validators,
  }) {
    return SchemaList(
      itemSchema,
      required: required ?? isRequired,
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
    for (var i = 0; i < value.length; i++) {
      final result = itemSchema.validate([...path, i.toString()], value[i]);
      if (!result.isValid) {
        return result;
      }
    }

    return ValidationResult.valid(path);
  }
}

class Schema {
  const Schema._();

  static const string = StringSchema();
  static const object = ObjectSchema.new;
  static const double = DoubleSchema();
  static const int = IntSchema();
  static const boolean = BooleanSchema();
  static const any = ObjectSchema({}, additionalProperties: true);
  static const list = SchemaList.new;
}
