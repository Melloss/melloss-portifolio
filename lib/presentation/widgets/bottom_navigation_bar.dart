import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/file_explorer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/file_system/file_system_bloc.dart';
import '../../bloc/ui/ui_bloc.dart';
import '../../gen/colors.gen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(2),
      width: 60.sw,
      height: 80,
      decoration: BoxDecoration(
        color: ColorName.forgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<UIBloc, UIState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    style: _buttonStyle(isActive: state.isExplorerOpen),
                    onPressed: () {
                      final state = context.read<UIBloc>().state;
                      context
                          .read<FileSystemBloc>()
                          .add(NavigateTo(currentPath: state.minimazedPath));

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        builder: (_) => const Stack(
                          children: [
                            FileExplorer(),
                          ],
                        ),
                      );
                      context
                          .read<UIBloc>()
                          .add(const ToggleIsExplorerOpened(isOpended: true));
                    },
                    icon: Assets.images.folderIcon.image(width: 55, height: 55),
                  ),
                  Visibility(
                    visible: state.isExplorerOpen,
                    child: Positioned(
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                              color: ColorName.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // IconButton(
          //   style: _buttonStyle(),
          //   onPressed: () {},
          //   icon: Assets.images.terminalIcon.image(),
          // ),
          IconButton(
            style: _buttonStyle(),
            onPressed: () {},
            icon: const Icon(
              Icons.apps,
              size: 55,
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle({bool isActive = false}) {
    return IconButton.styleFrom(
        backgroundColor: isActive ? Colors.grey.withOpacity(0.2) : null,
        hoverColor: ColorName.backgroundColor.withOpacity(0.1),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ));
  }
}
