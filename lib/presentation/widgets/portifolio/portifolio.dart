import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/presentation/widgets/portifolio/portifolio_man_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/file_system/file_system_bloc.dart';
import '../../../bloc/ui/ui_bloc.dart';
import '../../../gen/colors.gen.dart';
import '../button_widget.dart';

class Portifolio extends StatefulWidget {
  const Portifolio({super.key});

  @override
  State<Portifolio> createState() => _PortifolioState();
}

class _PortifolioState extends State<Portifolio> {
  double top = 100;
  double left = 300;
  double width = 100.sh;
  double height = 100.sw;
  bool isMinimized = false;

  void onDragUpdate(DragUpdateDetails details) {
    if (top <= 30) {
      setState(() {
        top = 30 + 1;
      });
    } else {
      setState(() {
        top += details.delta.dy;
      });
    }
    setState(() {
      left += details.delta.dx;
      width = 70.sh;
      height = 70.sw;
    });
  }

  @override
  void deactivate() {
    context.read<UIBloc>().add(IsPortifolioOpened(isOpened: isMinimized));
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        width == 100.sh
            ? _buildMainBoard()
            : Positioned(top: top, left: left, child: _buildMainBoard()),
      ],
    );
  }

  _buildMainBoard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2A33),
        borderRadius: width == 100.sh ? null : BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Draggable(
            ignoringFeedbackPointer: true,
            feedback: const SizedBox.shrink(),
            onDragUpdate: onDragUpdate,
            child: _buildHeader(),
          ),
          const Expanded(
            child: PortifolioManPage(),
          )
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      height: 55,
      color: ColorName.darkBlackColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
                    const IsPortifolioOpened(isOpened: false),
                  );
              context.read<UIBloc>().add(
                    const SetMinimazedPath(path: ['/']),
                  );

              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
