// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CalculatorModel {
  final String expression;
  final String result;
  CalculatorModel({
    required this.expression,
    required this.result,
  });

  CalculatorModel copyWith({
    String? expression,
    String? result,
  }) {
    return CalculatorModel(
      expression: expression ?? this.expression,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expression': expression,
      'result': result,
    };
  }

  factory CalculatorModel.fromMap(Map<String, dynamic> map) {
    return CalculatorModel(
      expression: map['expression'] as String,
      result: map['result'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalculatorModel.fromJson(String source) =>
      CalculatorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CalculatorModel(expression: $expression, result: $result)';

  @override
  bool operator ==(covariant CalculatorModel other) {
    if (identical(this, other)) return true;

    return other.expression == expression && other.result == result;
  }

  @override
  int get hashCode => expression.hashCode ^ result.hashCode;
}
