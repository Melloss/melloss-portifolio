import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc()
      : super(
          const UIState(
            isExplorerOpen: false,
            isBrowserOpen: false,
            minimazedPath: ['/'],
            isTerminalOpen: false,
            isCalculatorOpen: false,
            isPortifolioOpen: false,
          ),
        ) {
    on<IsExplorerOpened>(onIsExplorerOpended);
    on<IsTerminalOpended>(onTermnialOpen);
    on<SetMinimazedPath>(onSetMinimazedPath);
    on<IsBrowserOpened>(_onIsBroswerOpened);
    on<IsCalculatorOpened>(_onIsCalculatorOpened);
    on<IsPortifolioOpened>(_onIsPortifolioOpened);
  }
  _onIsPortifolioOpened(IsPortifolioOpened event, Emitter emit) async {
    emit(
      state.copyWith(
        isPortifolioOpen: event.isOpened,
      ),
    );
  }

  _onIsCalculatorOpened(IsCalculatorOpened event, Emitter emit) async {
    emit(
      state.copyWith(
        isCalculatorOpen: event.isOpened,
      ),
    );
  }

  _onIsBroswerOpened(IsBrowserOpened event, Emitter emit) async {
    emit(
      state.copyWith(
        isBrowserOpen: event.isOpened,
      ),
    );
  }

  onTermnialOpen(IsTerminalOpended event, Emitter emit) {
    emit(
      state.copyWith(
        isTerminalOpen: event.isOpended,
      ),
    );
  }

  onSetMinimazedPath(SetMinimazedPath event, Emitter emit) {
    emit(
      state.copyWith(
        minimazedPath: event.path,
      ),
    );
  }

  onIsExplorerOpended(IsExplorerOpened event, Emitter emit) {
    emit(
      state.copyWith(
        isExplorerOpen: event.isOpended,
      ),
    );
  }
}
