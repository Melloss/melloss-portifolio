part of 'ui_bloc.dart';

sealed class UIEvent extends Equatable {
  const UIEvent();

  @override
  List<Object> get props => [];
}

final class ToggleIsExplorerOpened extends UIEvent {
  final bool isOpended;

  const ToggleIsExplorerOpened({required this.isOpended});
}

final class SetMinimazedPath extends UIEvent {
  final List<String> path;

  const SetMinimazedPath({required this.path});
}
