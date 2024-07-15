import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc() : super(const UIState(isExplorerOpen: false, minimazedPath: ['/'])) {
    on<ToggleIsExplorerOpened>(toggleIsExplorerOpenedHandler);
    on<SetMinimazedPath>(setMinimazedPathHandler);
  }

  setMinimazedPathHandler(SetMinimazedPath event, Emitter emit) {
    emit(
      state.copyWith(
        minimazedPath: event.path,
      ),
    );
  }

  toggleIsExplorerOpenedHandler(ToggleIsExplorerOpened event, Emitter emit) {
    emit(
      state.copyWith(
        isExplorerOpen: event.isOpended,
      ),
    );
  }
}
