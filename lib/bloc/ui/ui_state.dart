part of 'ui_bloc.dart';

class UIState {
  final bool isExplorerOpen;
  final List<String> minimazedPath;
  const UIState({required this.isExplorerOpen, required this.minimazedPath});

  UIState copyWith({
    bool? isExplorerOpen,
    List<String>? minimazedPath,
  }) {
    return UIState(
      isExplorerOpen: isExplorerOpen ?? this.isExplorerOpen,
      minimazedPath: minimazedPath ?? this.minimazedPath,
    );
  }
}
