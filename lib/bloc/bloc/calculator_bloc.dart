import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/data/models/calculator_model.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc()
      : super(CalculatorState(
          histories: [],
        )) {
    on<AddCalculationHistory>(_onCalculationHisotory);
  }

  _onCalculationHisotory(AddCalculationHistory event, Emitter emit) {
    final histories = state.histories;

    emit(state.copyWith(
      histories: [event.calculatorModel, ...histories],
    ));
  }
}
