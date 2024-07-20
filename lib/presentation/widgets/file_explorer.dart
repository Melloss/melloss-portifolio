import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/data/models/folder_model.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/button_widget.dart';
import 'package:melloss_portifolio/presentation/widgets/folder_icon.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/file_system/file_system_bloc.dart';
import '../../bloc/ui/ui_bloc.dart';
import '../../core/utils/text_dialog.dart';

class FileExplorer extends StatefulWidget {
  const FileExplorer({super.key});

  @override
  State<FileExplorer> createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  double top = 100;
  double left = 300;
  double width = 70.sh;
  double height = 70.sw;

  bool isSearching = false;
  String lastPath = '';

  List<FolderModel> filteredFolder = [];
  final searchController = TextEditingController();

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      top += details.delta.dy;
      left += details.delta.dx;
      width = 70.sh;
      height = 70.sw;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return width == 100.sh
        ? _buildMainBoard()
        : Positioned(
            top: top,
            left: left,
            child: _buildMainBoard(),
          );
  }

  _buildHeader() {
    return Container(
      height: 55,
      color: ColorName.darkBlackColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Row(
                  children: [
                    ButtonWidget(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: const Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        final state = context.read<FileSystemBloc>().state;
                        setState(() {
                          lastPath = state.currentPath.last;
                        });
                        context.read<FileSystemBloc>().add(Pop());
                      },
                    ),
                    const SizedBox(width: 3),
                    ButtonWidget(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: const Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        if (lastPath.isNotEmpty) {
                          context
                              .read<FileSystemBloc>()
                              .add(PushTo(path: lastPath));
                          lastPath = '';
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: width == 100.sh
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      _buildCurrentPathAndSearching(),
                      const SizedBox(width: 10),
                      ButtonWidget(
                          backgroundColor: isSearching ? Colors.black : null,
                          child: const Icon(
                            Bootstrap.search,
                            size: 17,
                          ),
                          onPressed: () {
                            setState(() {
                              isSearching = !isSearching;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Bootstrap.dash,
                  size: 14,
                ),
                onPressed: () {
                  final state = context.read<FileSystemBloc>().state;
                  context
                      .read<UIBloc>()
                      .add(SetMinimazedPath(path: state.currentPath));
                  context.pop();
                },
              ),
              const SizedBox(width: 7),
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Icons.check_box_outline_blank,
                  size: 14,
                ),
                onPressed: () {
                  if (width == 100.sh) {
                    setState(() {
                      width = 70.sh;
                      height = 70.sw;
                    });
                  } else {
                    setState(() {
                      width = 100.sh;
                      height = 100.sw;
                    });
                  }
                },
              ),
              const SizedBox(width: 7),
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Icons.close,
                  size: 14,
                ),
                onPressed: () {
                  context.read<UIBloc>().add(
                        const ToggleIsExplorerOpened(isOpended: false),
                      );
                  context.read<UIBloc>().add(
                        const SetMinimazedPath(path: ['/']),
                      );

                  context.pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildCurrentPathAndSearching() {
    return BlocBuilder<FileSystemBloc, FileSystemState>(
      builder: (context, state) {
        return Container(
          width: width == 100.sh ? 30.sh : 23.sh,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorName.backgroundColor,
          ),
          child: isSearching
              ? Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: width == 100.sh ? 30.sh : 23.sh,
                    height: 40,
                    child: TextField(
                      controller: searchController,
                      autofocus: isSearching,
                      onChanged: (query) {
                        setState(() {
                          filteredFolder = state.folders
                              .where((folder) => folder.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        });
                      },
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                      decoration: const InputDecoration(
                          fillColor: ColorName.backgroundColor,
                          filled: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Bootstrap.search,
                            size: 16,
                            color: Colors.white60,
                          )),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < state.currentPath.length; i++)
                        Row(
                          children: [
                            _buildPathButton(
                                path: state.currentPath[i],
                                onPressed: state.currentPath[i] ==
                                        state.currentPath.last
                                    ? null
                                    : () {
                                        final currentPath = state.currentPath
                                            .sublist(0, (i + 1));
                                        context.read<FileSystemBloc>().add(
                                              NavigateTo(
                                                currentPath: currentPath,
                                              ),
                                            );
                                      }),
                            Visibility(
                              visible: state.currentPath[i] !=
                                  state.currentPath.last,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "/",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white60),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  _buildPathButton({required String path, required Function()? onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
      onPressed: onPressed,
      child: Text(
        path == '/' ? 'Home' : path,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  _buildMainBoard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorName.backgroundColor,
        borderRadius: width == 100.sh ? null : BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Draggable(
            ignoringFeedbackPointer: true,
            feedback: const SizedBox.shrink(),
            onDragUpdate: onDragUpdate,
            child: _buildHeader(),
          ),
          Container(
            color: Colors.black87,
            height: 0.5,
            width: double.infinity,
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color(0xFF272727),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        _buildSideBarTab(
                            icon: Icons.home_outlined,
                            title: 'Home',
                            path: ['/']),
                        _buildSideBarTab(
                          icon: Icons.download_outlined,
                          title: 'Downloads',
                          path: ['/', 'Downloads'],
                        ),
                        _buildSideBarTab(
                          icon: Icons.sticky_note_2_outlined,
                          title: 'Documents',
                          path: ['/', 'Documents'],
                        ),
                        _buildSideBarTab(
                          icon: Icons.music_note_outlined,
                          title: 'Musics',
                          path: ['/', 'Musics'],
                        ),
                        _buildSideBarTab(
                          icon: Icons.photo,
                          title: 'Pictures',
                          path: ['/', 'Pictures'],
                        ),
                        _buildSideBarTab(
                          icon: Icons.video_camera_back_outlined,
                          title: 'Videos',
                          path: ['/', 'Videos'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black87,
                height: double.infinity,
                width: 0.5,
              ),
              Expanded(
                flex: 10,
                child: _buildFileDisplayer(),
              )
            ],
          ))
        ],
      ),
    );
  }

  _buildFileDisplayer() {
    return GestureDetector(
      onSecondaryTapUp: (details) => _showContextMenu(details.globalPosition),
      child: Container(
        color: ColorName.backgroundColor,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<FileSystemBloc, FileSystemState>(
          builder: (context, state) {
            if (searchController.text.isNotEmpty &&
                filteredFolder.isEmpty &&
                isSearching) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Not Found on this directory',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              );
            }
            return Wrap(
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                if (isSearching && filteredFolder.isNotEmpty)
                  for (var folder in filteredFolder)
                    FolderIcon(
                      folderName: folder.name,
                      onTab: () {
                        setState(() {
                          isSearching = false;
                          filteredFolder = [];
                        });
                      },
                    )
                else
                  for (var folder in state.folders)
                    FolderIcon(
                      folderName: folder.name,
                      onTab: () {
                        setState(() {
                          isSearching = false;
                          filteredFolder = [];
                        });
                      },
                    ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildSideBarTab(
      {required IconData icon,
      required String title,
      required List<String> path}) {
    return BlocBuilder<FileSystemBloc, FileSystemState>(
      builder: (context, state) {
        return TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            shape: const ContinuousRectangleBorder(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            foregroundColor: Colors.white60,
            backgroundColor: (path.length == state.currentPath.length &&
                    path.every((value) => state.currentPath.contains(value)))
                ? Colors.white12
                : Colors.transparent,
          ),
          onPressed: () {
            context.read<FileSystemBloc>().add(
                  NavigateTo(currentPath: path),
                );
          },
          child: Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white60,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showContextMenu(Offset position) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          position & const Size(40, 40), Offset.zero & overlay.size),
      color: Colors.black87,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.black38,
        ),
      ),
      surfaceTintColor: Colors.white,
      constraints: BoxConstraints.tight(const Size(300, 200)),
      items: [
        PopupMenuItem(
          onTap: () async {
            final folderName = await showTextDialog(context);
            if (folderName.isNotEmpty) {
              // ignore: use_build_context_synchronously
              context.read<FileSystemBloc>().add(
                    CreateDirectory(directoryName: folderName),
                  );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "New Folder",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
        ),
        const PopupMenuItem(
          height: 5,
          enabled: false,
          child: Divider(
            color: Colors.white54,
            thickness: 0.3,
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Open in Terminal",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
        ),
        const PopupMenuItem(
          height: 5,
          enabled: false,
          child: Divider(
            color: Colors.white54,
            thickness: 0.3,
          ),
        ),
        PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Properties",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
