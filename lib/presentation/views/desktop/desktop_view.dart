import 'dart:developer';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/core/utils/text_dialog.dart';
import 'package:melloss_portifolio/presentation/widgets/file_explorer.dart';
import 'package:melloss_portifolio/presentation/widgets/folder_icon.dart';
import 'package:melloss_portifolio/presentation/widgets/terminal.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/brightness/brightness_bloc.dart';
import '../../../bloc/file_system/file_system_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/ubuntu_appbar.dart';

part 'desktop_viewmodel.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  late List<DragAndDropList> contents;

  double width = 100.sh;
  double height = 100.sw;

  @override
  void initState() {
    super.initState();
    contents = List.generate(2, (index) {
      return DragAndDropList(
          header: FolderIcon(folderName: 'Melloss $index'),
          children: [
            DragAndDropItem(
              child: const SizedBox.shrink(),
            )
          ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ubuntuAppBar(
        context,
        onActivityClickes: () {
          setState(() {
            if (width == 100.sh) {
              width = 70.sh;
              height = 70.sw;
            } else {
              width = 100.sh;
              height = 100.sw;
            }
          });
        },
      ),
      body: Stack(children: [
        GestureDetector(
          onTap: () {
            if (width != 100.sh) {
              setState(() {
                width = 100.sh;
                height = 100.sw;
              });
            }
          },
          child: Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: width,
              height: height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius:
                    width == 100.sh ? null : BorderRadius.circular(20),
              ),
              child: Assets.images.ubuntuWallpaper.image(
                width: 100.sh,
                height: 100.sw,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        BlocBuilder<BrightnessBloc, BrightnessState>(
          builder: (context, state) {
            return Visibility(
              visible: width == 100.sh,
              child: Container(
                color: state.brightnessLevel <= 0.2
                    ? Colors.black.withOpacity(0.8)
                    : Colors.black.withOpacity(1 - state.brightnessLevel),
                child: GestureDetector(
                  onSecondaryTapUp: (details) =>
                      _showContextMenu(details.globalPosition),
                  child: Container(
                    color: Colors.transparent,
                    width: 100.sh,
                    height: 100.sw,
                    child: Opacity(
                      opacity: state.brightnessLevel < 0.2
                          ? 0.2
                          : state.brightnessLevel,
                      child: BlocBuilder<FileSystemBloc, FileSystemState>(
                        builder: (context, state) {
                          if (state.desktopFileSystem != null) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              child: Wrap(
                                direction: Axis.vertical,
                                verticalDirection: VerticalDirection.down,
                                children: [
                                  for (var folder
                                      in state.desktopFileSystem!.folders)
                                    FolderIcon(
                                      folderName: folder.name,
                                      initialpath: [
                                        '/',
                                        'Desktop',
                                        folder.name,
                                      ],
                                    ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Align(
              alignment: Alignment.center,
              child: BlocBuilder<BrightnessBloc, BrightnessState>(
                builder: (context, state) {
                  return Opacity(
                    opacity: state.brightnessLevel < 0.7
                        ? 0.7
                        : state.brightnessLevel,
                    child: const BottomNavigation(),
                  );
                },
              )),
        ),
        // Visibility(visible: width == 100.sh, child: const FileExplorer()),
      ]),
    );
  }

  _showContextMenu(Offset position) async {
    log(position.toString());
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          position & const Size(40, 40), Offset.zero & overlay.size),
      color: Colors.black87,
      elevation: 20,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.black38,
        ),
      ),
      shadowColor: Colors.white.withOpacity(0.1),
      surfaceTintColor: Colors.white,
      useRootNavigator: true,
      constraints: BoxConstraints.tight(const Size(300, 500)),
      items: [
        PopupMenuItem(
          onTap: () async {
            final folderName = await showTextDialog(context);
            if (folderName.isNotEmpty) {
              // ignore: use_build_context_synchronously
              context.read<FileSystemBloc>().add(
                    CreateDirectory(
                        directoryName: folderName, isForDesktop: true),
                  );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "New Folder",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
          onTap: () {
            showDialog(
              barrierDismissible: false,
              barrierColor: Colors.transparent,
              context: context,
              builder: (_) => const Terminal(
                currentPath: ['/', 'Desktop'],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Open in Terminal",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
