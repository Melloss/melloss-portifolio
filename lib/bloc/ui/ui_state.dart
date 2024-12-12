part of 'ui_bloc.dart';

class UIState {
  final bool isExplorerOpen;
  final bool isTerminalOpen;
  final bool isBrowserOpen;
  final bool isCalculatorOpen;
  final bool isPortifolioOpen;

  final List<String> minimazedPath;
  const UIState(
      {required this.isExplorerOpen,
      required this.minimazedPath,
      required this.isTerminalOpen,
      required this.isBrowserOpen,
      required this.isPortifolioOpen,
      required this.isCalculatorOpen});

  UIState copyWith({
    bool? isExplorerOpen,
    bool? isTerminalOpen,
    bool? isBrowserOpen,
    bool? isCalculatorOpen,
    bool? isPortifolioOpen,
    List<String>? minimazedPath,
  }) {
    return UIState(
      isPortifolioOpen: isPortifolioOpen ?? this.isPortifolioOpen,
      isExplorerOpen: isExplorerOpen ?? this.isExplorerOpen,
      isTerminalOpen: isTerminalOpen ?? this.isTerminalOpen,
      minimazedPath: minimazedPath ?? this.minimazedPath,
      isBrowserOpen: isBrowserOpen ?? this.isBrowserOpen,
      isCalculatorOpen: isCalculatorOpen ?? this.isCalculatorOpen,
    );
  }
}
