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
            }
          },
        )) {
    on<PushTo>(pushToHandler);
    on<NavigateTo>(navigateToHandler);
    on<Pop>(popHandler);
    on<CreateDirectory>(createDirectoryHandler);
  }

  navigateToHandler(NavigateTo event, Emitter emit) {
    final folders = findFolders(event.currentPath);
    emit(state.copyWith(
      folders: folders,
      currentPath: event.currentPath,
      desktopFileSystem: event.currentPath.last == 'Desktop'
          ? state.copyWith(
              folders: folders,
              currentPath: event.currentPath,
            )
          : null,
    ));
  }

  createDirectoryHandler(CreateDirectory event, Emitter emit) {
    final newFileSystem = createFolderInPath(
      state.fileSystem,
      state.currentPath,
      event.directoryName.trim(),
      event.isForDesktop,
    );

    emit(state.copyWith(
      fileSystem: newFileSystem,
      folders: findFolders(state.currentPath),
      desktopFileSystem: event.isForDesktop
          ? state.copyWith(
              fileSystem: newFileSystem,
              folders: findFolders(['/', 'Desktop']),
            )
          : state.desktopFileSystem,
    ));
  }

  popHandler(Pop event, Emitter emit) {
    List<String> currentPath = state.currentPath;
    if (currentPath.length >= 2) {
      currentPath.removeLast();
      emit(state.copyWith(
        currentPath: currentPath,
        folders: findFolders(currentPath),
      ));
    }
  }

  pushToHandler(PushTo event, Emitter emit) {
    if (state.currentPath.contains(event.path) == false) {
      List<String> currentPath = [
        ...state.currentPath,
        event.path,
      ];
      final folders = findFolders(currentPath);
      emit(state.copyWith(
        folders: folders,
        currentPath: currentPath,
        desktopFileSystem: event.path == 'Desktop'
            ? state.copyWith(
                folders: folders,
                currentPath: currentPath,
              )
            : null,
      ));
    }
  }

  Map<String, dynamic> createFolderInPath(Map<String, dynamic> fileSystem,
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
    updatedFileSystem['/'] =
        updateSubMap(updatedFileSystem['/'], path.sublist(1), targetMap);
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

  List<FolderModel> findFolders(List<String> newCurrentPath) {
    Map currentDirectory = state.fileSystem;
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
