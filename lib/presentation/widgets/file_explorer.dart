import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/button_widget.dart';
import 'package:melloss_portifolio/presentation/widgets/folder_icon.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/file_system/file_system_bloc.dart';
import '../../bloc/ui/ui_bloc.dart';

class FileExplorer extends StatefulWidget {
  const FileExplorer({super.key});

  @override
  State<FileExplorer> createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  double top = 0.0;
  double left = 0.0;
  double width = 70.sh;
  double height = 70.sw;

  bool isSearching = false;
  String lastPath = '';

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
              ? SizedBox(
                  width: width == 100.sh ? 30.sh : 23.sh,
                  height: 40,
                  child: TextField(
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
                    color: const Color(0xFF272727),
                  )),
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
    return Container(
      color: ColorName.backgroundColor,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<FileSystemBloc, FileSystemState>(
        builder: (context, state) {
          return Wrap(
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (var folder in state.folders)
                FolderIcon(
                  folderName: folder.name,
                ),
            ],
          );
        },
      ),
    );
  }
}
