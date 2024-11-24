part of 'ui_bloc.dart';

class UIState {
  final bool isExplorerOpen;
  final bool isTerminalOpen;
  final bool isBrowserOpen;
  final bool isCalculatorOpen;
  final List<String> minimazedPath;
  const UIState(
      {required this.isExplorerOpen,
      required this.minimazedPath,
      required this.isTerminalOpen,
      required this.isBrowserOpen,
      required this.isCalculatorOpen});

  UIState copyWith({
    bool? isExplorerOpen,
    bool? isTerminalOpen,
    bool? isBrowserOpen,
    bool? isCalculatorOpen,
    List<String>? minimazedPath,
  }) {
    return UIState(
      isExplorerOpen: isExplorerOpen ?? this.isExplorerOpen,
      isTerminalOpen: isTerminalOpen ?? this.isTerminalOpen,
      minimazedPath: minimazedPath ?? this.minimazedPath,
      isBrowserOpen: isBrowserOpen ?? this.isBrowserOpen,
      isCalculatorOpen: isCalculatorOpen ?? this.isCalculatorOpen,
    );
  }
}
