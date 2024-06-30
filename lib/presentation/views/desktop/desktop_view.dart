import 'dart:developer';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/presentation/widgets/folder.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/brightness/brightness_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/ubuntu_appbar.dart';

part 'desktop_viewmodel.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  late List<DragAndDropList> contents;

  onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = contents[oldListIndex].children.removeAt(oldItemIndex);
      contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = contents.removeAt(oldListIndex);
      contents.insert(newListIndex, movedList);
    });
  }

  @override
  void initState() {
    super.initState();
    contents = List.generate(2, (index) {
      return DragAndDropList(
          header: Folder(folderName: 'Melloss $index'),
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
      appBar: ubuntuAppBar(context),
      body: Stack(children: [
        Assets.images.ubuntuWallpaper1.image(
          width: 100.sh,
          height: 100.sw,
          fit: BoxFit.cover,
        ),

        BlocBuilder<BrightnessBloc, BrightnessState>(
          builder: (context, state) {
            return Container(
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
                    child: DragAndDropLists(
                      constrainDraggingAxis: false,
                      children: contents,
                      onItemReorder: onItemReorder,
                      onListReorder: onListReorder,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //   child: Wrap(
        //     direction: Axis.vertical,
        //     verticalDirection: VerticalDirection.down,
        //     children: [
        //       Folder(
        //         folderName: 'Melloss',
        //       ),
        //       Folder(
        //         folderName: 'Second',
        //       ),
        //     ],
        //   ),
        // ),
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
      color: Colors.black,
      elevation: 20,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Colors.white.withOpacity(0.1),
      surfaceTintColor: Colors.white,
      useRootNavigator: true,
      constraints: BoxConstraints.tight(Size(300, 500)),
      items: [
        PopupMenuItem(
            child: Text(
          "item 1",
          style: Theme.of(context).textTheme.titleMedium,
        )),
        PopupMenuItem(
            child: Text(
          "item 2",
          style: Theme.of(context).textTheme.titleMedium,
        )),
      ],
    );
  }
}
