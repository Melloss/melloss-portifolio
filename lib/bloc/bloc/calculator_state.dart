// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calculator_bloc.dart';

class CalculatorState {
  final List<CalculatorModel> histories;

  CalculatorState({required this.histories});

  CalculatorState copyWith({
    List<CalculatorModel>? histories,
  }) {
    return CalculatorState(
      histories: histories ?? this.histories,
    );
  }
}
