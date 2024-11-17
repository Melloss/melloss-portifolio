part of 'ui_bloc.dart';

sealed class UIEvent extends Equatable {
  const UIEvent();

  @override
  List<Object> get props => [];
}

final class IsExplorerOpened extends UIEvent {
  final bool isOpended;

  const IsExplorerOpened({required this.isOpended});
}

final class SetMinimazedPath extends UIEvent {
  final List<String> path;

  const SetMinimazedPath({required this.path});
}

final class IsTerminalOpended extends UIEvent {
  final bool isOpended;

  const IsTerminalOpended({required this.isOpended});
}

final class IsBrowserOpened extends UIEvent {
  final bool isOpened;

  const IsBrowserOpened({required this.isOpened});
}
