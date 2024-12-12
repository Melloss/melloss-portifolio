part of 'calculator_bloc.dart';

sealed class CalculatorEvent {
  const CalculatorEvent();
}

final class AddCalculationHistory extends CalculatorEvent {
  final CalculatorModel calculatorModel;

  const AddCalculationHistory({required this.calculatorModel});
}
