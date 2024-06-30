part of 'brightness_bloc.dart';

sealed class BrightnessEvent {}

final class ChangeBrightness extends BrightnessEvent {
  final double brightnessLevel;

  ChangeBrightness({required this.brightnessLevel});
}
