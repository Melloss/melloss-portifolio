part of 'file_system_bloc.dart';

sealed class FileSystemEvent {}

final class PushTo extends FileSystemEvent {
  final String path;

  PushTo({required this.path});
}

final class NavigateTo extends FileSystemEvent {
  final List<String> currentPath;
  NavigateTo({required this.currentPath});
}

final class Pop extends FileSystemEvent {}

final class CreateDirectory extends FileSystemEvent {
  final String directoryName;
  final bool isForDesktop;

  CreateDirectory({required this.directoryName, this.isForDesktop = false});
}
