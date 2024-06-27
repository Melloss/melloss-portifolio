part of 'battery_bloc.dart';

class BatteryLevel {
  final int batterLevel;

  BatteryLevel({required this.batterLevel});

  BatteryLevel coptyWith({int? batterLevel}) {
    return BatteryLevel(batterLevel: batterLevel ?? this.batterLevel);
  }
}
