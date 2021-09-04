class Field {
  final String operator;
  final value;

  factory Field.isLessThan(value) => Field._("<", value);

  factory Field.isLessThanOrEqualTo(value) => Field._("<=", value);

  factory Field.isGreaterThan(value) => Field._(">", value);

  factory Field.isGreaterThanOrEqualTo(value) => Field._(">=", value);

  factory Field.isEqual(value) => Field._("=", value);

  factory Field.isNotEqual(value) => Field._("!=", value);

  factory Field.isLike(value) => Field._("like", value);

  factory Field.isNotLike(value) => Field._("not like", value);

  factory Field.isIn(value) => Field._("in", value);

  factory Field.isNotIn(value) => Field._("not in", value);

  Field._(this.operator, this.value);
}
