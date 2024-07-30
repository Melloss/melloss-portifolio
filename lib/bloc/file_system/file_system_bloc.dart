import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/data/models/folder_model.dart';

part 'file_system_event.dart';
part 'file_system_state.dart';

class FileSystemBloc extends Bloc<FileSystemEvent, FileSystemState> {
  FileSystemBloc()
      : super(FileSystemState(
          folders: [
            FolderModel(name: 'Desktop'),
            FolderModel(name: 'Documents'),
            FolderModel(name: 'Musics'),
            FolderModel(name: 'Downloads'),
            FolderModel(name: 'Videos'),
            FolderModel(name: 'Pictures'),
          ],
          currentPath: ['/'],
          fileSystem: {
            '/': {
              'Desktop': {
                'home': {},
              },
              'Documents': {},
              'Musics': {},
              'Downloads': {},
              'Videos': {},
              'Pictures': {}
            }
          },
        )) {
    on<PushTo>(onPushTo);
    on<NavigateTo>(onNavigateTo);
    on<Pop>(onPop);
    on<CreateDirectory>(onCreateDirectory);
    on<DeleteDirectory>(onDeleteDirectory);
    on<RenameDirectory>(onRenameDirectory);
  }

  onRenameDirectory(RenameDirectory event, Emitter emit) {
    final foldersNames =
        findFolders(event.path, state.fileSystem).map((f) => f.name);
    if (foldersNames.contains(event.nameOfDirectory.trim())) {
      Map<String, dynamic> newFileSystem = _renameDirectoryInPath(
        jsonDecode(jsonEncode(state.fileSystem)),
        event.path,
        event.nameOfDirectory,
        event.newDirectoryName,
      );
      final fileSystem = jsonDecode(jsonEncode(newFileSystem));
      emit(state.copyWith(
        fileSystem: fileSystem,
        folders: findFolders(state.currentPath, fileSystem),
        currentPath: [...state.currentPath],
        desktopFileSystem: (state.currentPath.first == '/' &&
                state.currentPath.last == 'Desktop')
            ? state.copyWith(
                fileSystem: newFileSystem,
                folders: findFolders(['/', 'Desktop'], fileSystem),
              )
            : state.desktopFileSystem,
      ));
    } else {
      emit(
        FileSystemError(
          type: FileSystemErrorType.renameDirectory,
          errorMessage:
              'cannot rename \'${event.newDirectoryName}\' : No such file or directory',
          fileSystem: state.fileSystem,
          currentPath: state.currentPath,
          desktopFileSystem: state.desktopFileSystem,
          folders: state.folders,
        ),
      );
    }
  }

  onDeleteDirectory(DeleteDirectory event, Emitter emit) {
    final foldersNames =
        findFolders(event.path, state.fileSystem).map((f) => f.name);
    if (foldersNames.contains(event.nameOfDirectory.trim())) {
      Map<String, dynamic> newFileSystem = _deleteDirectoryInPath(
        jsonDecode(jsonEncode(state.fileSystem)),
        event.path,
        event.nameOfDirectory,
      );
      final fileSystem = jsonDecode(jsonEncode(newFileSystem));
      emit(state.copyWith(
        fileSystem: fileSystem,
        folders: findFolders(state.currentPath, fileSystem),
        currentPath: [...state.currentPath],
        desktopFileSystem: (state.currentPath.first == '/' &&
                state.currentPath.last == 'Desktop')
            ? state.copyWith(
                fileSystem: newFileSystem,
                folders: findFolders(['/', 'Desktop'], fileSystem),
              )
            : state.desktopFileSystem,
      ));
    } else {
      emit(
        FileSystemError(
          type: FileSystemErrorType.deleteDirectory,
          errorMessage:
              'failed to remove \'${event.nameOfDirectory.trim()}\' : No such file or directory',
          fileSystem: state.fileSystem,
          currentPath: state.currentPath,
          desktopFileSystem: state.desktopFileSystem,
          folders: state.folders,
        ),
      );
    }
  }

  onNavigateTo(NavigateTo event, Emitter emit) {
    final folders = findFolders(event.currentPath, state.fileSystem);
    emit(state.copyWith(
      folders: folders,
      currentPath: [...event.currentPath],
      desktopFileSystem: event.currentPath.last == 'Desktop'
          ? state.copyWith(
              folders: folders,
              currentPath: event.currentPath,
            )
          : null,
    ));
  }

  onCreateDirectory(CreateDirectory event, Emitter emit) {
    final newFileSystem = _createFolderInPath(
      jsonDecode(jsonEncode(state.fileSystem)),
      [...state.currentPath],
      event.directoryName.trim(),
      event.isForDesktop,
    );
    final fileSystem = jsonDecode(jsonEncode(newFileSystem));
    emit(state.copyWith(
      fileSystem: fileSystem,
      folders: findFolders(state.currentPath, fileSystem),
      currentPath: [...state.currentPath],
      desktopFileSystem: event.isForDesktop ||
              (state.currentPath.first == '/' &&
                  state.currentPath.last == 'Desktop')
          ? state.copyWith(
              fileSystem: newFileSystem,
              folders: findFolders(['/', 'Desktop'], fileSystem),
            )
          : state.desktopFileSystem,
    ));
  }

  onPop(Pop event, Emitter emit) {
    List<String> currentPath = state.currentPath;
    if (currentPath.length >= 2) {
      currentPath.removeLast();
      emit(state.copyWith(
        currentPath: currentPath,
        folders: findFolders(currentPath, state.fileSystem),
      ));
    }
  }

  onPushTo(PushTo event, Emitter emit) {
    if (event.path == '..') {
      add(Pop());
    } else {
      if (state.folders.map((f) => f.name).contains(event.path.trim())) {
        List<String> currentPath = [
          ...state.currentPath,
          event.path,
        ];
        final folders = findFolders(currentPath, state.fileSystem);
        emit(state.copyWith(
          folders: folders,
          currentPath: [...currentPath],
          desktopFileSystem: event.path == 'Desktop'
              ? state.copyWith(
                  folders: folders,
                  currentPath: currentPath,
                )
              : null,
        ));
      } else {
        emit(FileSystemError(
          type: FileSystemErrorType.navigationToDirectory,
          errorMessage: 'no such file or directory: ${event.path}',
          fileSystem: state.fileSystem,
          currentPath: state.currentPath,
          folders: state.folders,
          desktopFileSystem: state.desktopFileSystem,
        ));
      }
    }
  }

  Map<String, dynamic> _renameDirectoryInPath(Map<String, dynamic> fileSystem,
      List<String> path, String nameOfDirectory, String newName) {
    // Validate path (optional)
    if (path.isEmpty) {
      throw Exception('Path cannot be empty');
    }

    // Traverse the path using fold and create a copy of the target map
    final targetMap = path.fold<Map<String, dynamic>>(
        fileSystem.cast<String, dynamic>(), (currentMap, key) {
      if (!currentMap.containsKey(key)) {
        return {}; // Return empty map if key doesn't exist
      }
      return Map.from(currentMap[key] as Map<String, dynamic>);
    });

    final tempMap = targetMap[nameOfDirectory];
    targetMap.remove(nameOfDirectory);
    targetMap[newName] = tempMap;

    // Update the fileSystem with the modified targetMap (avoid modifying original)
    Map<String, dynamic> updatedFileSystem = Map.from(fileSystem);
    updatedFileSystem = updateSubMap(updatedFileSystem, path, targetMap);
    return updatedFileSystem;
  }

  Map<String, dynamic> _deleteDirectoryInPath(Map<String, dynamic> fileSystem,
      List<String> path, String nameOfDirectory) {
    // Validate path (optional)
    if (path.isEmpty) {
      throw Exception('Path cannot be empty');
    }

    // Traverse the path using fold and create a copy of the target map
    final targetMap = path.fold<Map<String, dynamic>>(
        fileSystem.cast<String, dynamic>(), (currentMap, key) {
      if (!currentMap.containsKey(key)) {
        return {}; // Return empty map if key doesn't exist
      }
      return Map.from(currentMap[key] as Map<String, dynamic>);
    });

    // remove the map
    targetMap.remove(nameOfDirectory);

    // Update the fileSystem with the modified targetMap (avoid modifying original)
    Map<String, dynamic> updatedFileSystem = Map.from(fileSystem);
    updatedFileSystem = updateSubMap(updatedFileSystem, path, targetMap);
    return updatedFileSystem;
  }

  Map<String, dynamic> _createFolderInPath(Map<String, dynamic> fileSystem,
      List<String> path, String newMapKey, bool isForDesktop) {
    if (isForDesktop) {
      path = ['/', 'Desktop'];
    }
    // Validate path (optional)
    if (path.isEmpty) {
      throw Exception('Path cannot be empty');
    }

    // Traverse the path using fold and create a copy of the target map
    final targetMap = path.fold<Map<String, dynamic>>(
        fileSystem.cast<String, dynamic>(), (currentMap, key) {
      if (!currentMap.containsKey(key)) {
        return {}; // Return empty map if key doesn't exist
      }
      return Map.from(currentMap[key] as Map<String, dynamic>);
    });

    // Create the new map
    targetMap[newMapKey] = {};

    // Update the fileSystem with the modified targetMap (avoid modifying original)
    Map<String, dynamic> updatedFileSystem = Map.from(fileSystem);
    updatedFileSystem = updateSubMap(updatedFileSystem, path, targetMap);
    return updatedFileSystem;
  }

// Helper function to update sub-maps recursively
  Map<String, dynamic> updateSubMap(Map<String, dynamic> currentMap,
      List<String> remainingPath, Map<String, dynamic> updatedMap) {
    if (remainingPath.isEmpty) {
      return updatedMap;
    }
    final key = remainingPath[0];
    final subMap = currentMap[key];
    currentMap[key] = updateSubMap(
        subMap as Map<String, dynamic>, remainingPath.sublist(1), updatedMap);
    return currentMap;
  }

  List<FolderModel> findFolders(
      List<String> newCurrentPath, Map newFileSystem) {
    Map currentDirectory = newFileSystem;
    List<FolderModel> folders = [];
    for (var folder in newCurrentPath) {
      currentDirectory = currentDirectory[folder] as Map;
    }
    currentDirectory.forEach((key, value) {
      folders.add(
        FolderModel(
          name: key,
        ),
      );
    });
    return folders;
  }
}
