import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/browser_tab_model.dart';

part 'browser_event.dart';
part 'browser_state.dart';

class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  BrowserBloc()
      : super(BrowserState(
          browserTabs: [
            BrowserTabModel(
              id: 0,
              url: '',
              title: 'New Tab',
            )
          ],
        )) {
    on<AddTab>(_onAddTab);
    on<RemoveTab>(_onRemoveTab);
    on<SetInitial>(_onSetInitial);
  }

  _onSetInitial(SetInitial event, Emitter emit) {
    emit(state.copyWith([
      BrowserTabModel(
        id: 0,
        url: '',
        title: 'New Tab',
      )
    ]));
  }

  _onRemoveTab(RemoveTab event, Emitter emit) {
    List<BrowserTabModel> currentTabs = state.browserTabs;
    currentTabs.removeWhere((t) => t.id == event.id);
    emit(
      state.copyWith(
        currentTabs,
      ),
    );
  }

  _onAddTab(AddTab event, Emitter emit) {
    List<BrowserTabModel> currentTabs = state.browserTabs;
    currentTabs.add(event.browserTabModel);
    emit(
      state.copyWith(
        currentTabs,
      ),
    );
  }
}
