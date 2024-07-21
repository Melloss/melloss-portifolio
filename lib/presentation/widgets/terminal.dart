import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/bloc/file_system/file_system_bloc.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/button_widget.dart';
import 'package:melloss_portifolio/presentation/widgets/terminal_line.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/ui/ui_bloc.dart';
import '../../data/models/terminal_model.dart';

class Terminal extends StatefulWidget {
  final List<String> currentPath;
  const Terminal({super.key, required this.currentPath});

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  double top = 100;
  double left = 300;
  double width = 70.sh;
  double height = 70.sw;
  List<TerminalModel> terminals = [];
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
    terminals.add(
      TerminalModel(path: widget.currentPath),
    );
    context.read<FileSystemBloc>().add(
          NavigateTo(
            currentPath: widget.currentPath,
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        color: ColorName.backgroundColor.withOpacity(0.8),
        borderRadius: width == 100.sh ? null : BorderRadius.circular(10),
      ),
      child: BlocBuilder<FileSystemBloc, FileSystemState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Draggable(
                ignoringFeedbackPointer: true,
                feedback: const SizedBox.shrink(),
                onDragUpdate: onDragUpdate,
                child: _buildHeader(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < terminals.length; i++)
                        TerminalLine(
                          currentPath: terminals[i].path,
                          isActive: i == (terminals.length - 1),
                          onEnter: (command) {
                            if (command.trim() == 'clear') {
                              terminals.clear();
                            }
                            terminals
                                .add(TerminalModel(path: state.currentPath));
                            setState(() {
                              terminals = terminals;
                            });
                          },
                        )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _buildHeader() {
    return Container(
      width: width,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: ColorName.forgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          BlocBuilder<FileSystemBloc, FileSystemState>(
            builder: (context, state) {
              return Text(
                'mellossDev@website:~/${state.currentPath.sublist(1).join('/')}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              );
            },
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
}
