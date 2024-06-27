import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:melloss_portifolio/presentation/widgets/folder.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
        DragAndDropLists(
          constrainDraggingAxis: true,
          children: contents,
          onItemReorder: onItemReorder,
          onListReorder: onListReorder,
        )
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
}
