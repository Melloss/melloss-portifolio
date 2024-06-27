import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryLevel> {
  BatteryBloc() : super(BatteryLevel(batterLevel: 100)) {
    on<CheckBatterLevel>(checkBatteryLevelHandler);
  }

  checkBatteryLevelHandler(CheckBatterLevel event, Emitter emit) async {
    var battery = Battery();

    final batterLevel = await battery.batteryLevel;
    emit(state.coptyWith(
      batterLevel: batterLevel,
    ));
  }
}
