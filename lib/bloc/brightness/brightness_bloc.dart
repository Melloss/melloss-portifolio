import 'package:flutter_bloc/flutter_bloc.dart';

part 'brightness_event.dart';
part 'brightness_state.dart';

class BrightnessBloc extends Bloc<BrightnessEvent, BrightnessState> {
  BrightnessBloc() : super(BrightnessState(brightnessLevel: 1)) {
    on<ChangeBrightness>(changeBrightnessHandler);
  }
  changeBrightnessHandler(ChangeBrightness event, Emitter emit) {
    emit(
      state.copyWith(brightness: event.brightnessLevel),
    );
  }
}
