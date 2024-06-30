part of 'brightness_bloc.dart';

class BrightnessState {
  final double brightnessLevel;

  BrightnessState({required this.brightnessLevel});

  BrightnessState copyWith({double? brightness}) {
    return BrightnessState(brightnessLevel: brightness ?? brightnessLevel);
  }
}
