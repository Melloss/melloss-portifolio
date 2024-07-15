part of 'file_system_bloc.dart';

class FileSystemState {
  final List<String> currentPath;
  final Map<String, dynamic> fileSystem;
  final List<FolderModel> folders;
  final FileSystemState? desktopFileSystem;

  FileSystemState({
    required this.fileSystem,
    required this.currentPath,
    required this.folders,
    this.desktopFileSystem,
  });

  FileSystemState copyWith({
    List<String>? currentPath,
    Map<String, dynamic>? fileSystem,
    List<FolderModel>? folders,
    FileSystemState? desktopFileSystem,
  }) {
    return FileSystemState(
        currentPath: currentPath ?? this.currentPath,
        fileSystem: fileSystem ?? this.fileSystem,
        folders: folders ?? this.folders,
        desktopFileSystem: desktopFileSystem ?? this.desktopFileSystem);
  }
}
