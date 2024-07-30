import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/bloc/file_system/file_system_bloc.dart';
import 'package:melloss_portifolio/gen/colors.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/button_widget.dart';
import 'package:melloss_portifolio/presentation/widgets/file_explorer.dart';
import 'package:melloss_portifolio/presentation/widgets/terminal/terminal_line.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/ui/ui_bloc.dart';
import '../../../data/models/terminal_model.dart';

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
  bool isCleared = true;
  List<TerminalModel> terminals = [];
  List<String> commandResults = [];
  List<int> currentCommandIds = [];
  List<List<String>> terminalHistory = [];
  int currentTerminalLine = 0;
  bool isPoped = false;

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      top += details.delta.dy;
      left += details.delta.dx;
      width = 70.sh;
      height = 70.sw;
    });
  }

  onEnterHandler(String c, FileSystemState state, int commandId) async {
    try {
      String command = c.trim();
      setState(() {
        commandResults = [];
      });
      if (command == 'clear') {
        terminals.clear();
        commandResults.clear();
        currentCommandIds.clear();
        terminalHistory.clear();
        terminals = [
          TerminalModel(
            path: state.currentPath,
            controller: TextEditingController(),
          )
        ];
      } else if (command == 'exit') {
        context.pop();
      } else if (command.startsWith('mkdir')) {
        List args = command.split(' ');
        if (args.first == 'mkdir' && args.length == 2) {
          context.read<FileSystemBloc>().add(
                CreateDirectory(directoryName: args.last),
              );
          terminals.add(
            TerminalModel(
              path: state.currentPath,
              controller: TextEditingController(),
            ),
          );
        }
      } else if (command.startsWith('rmdir')) {
        List args = command.split(' ');
        if (args.first == 'rmdir' && args.length == 2) {
          context.read<FileSystemBloc>().add(
                DeleteDirectory(
                    path: state.currentPath, nameOfDirectory: args.last),
              );
          terminals.add(
            TerminalModel(
              path: state.currentPath,
              controller: TextEditingController(),
            ),
          );
        }
      } else if (command.startsWith('mv')) {
        List args = command.split(' ');
        if (args.first == 'mv' && args.length == 3) {
          context.read<FileSystemBloc>().add(
                RenameDirectory(
                    path: state.currentPath,
                    nameOfDirectory: args[1],
                    newDirectoryName: args.last),
              );
          terminals.add(
            TerminalModel(
              path: state.currentPath,
              controller: TextEditingController(),
            ),
          );
        }
      } else if (command.startsWith('open')) {
        List<String> args = command.split(' ');
        if (args.first == 'open' && args.length == 2) {
          if (args.last == '.') {
            context.pop();
            showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.transparent,
                builder: (_) => const Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        FileExplorer(),
                      ],
                    ));
          }
        }
      } else if (command == 'ls') {
        currentCommandIds.add(commandId);
        setState(() {
          currentCommandIds = currentCommandIds;
        });
        terminals.add(
          TerminalModel(
            path: state.currentPath,
            controller: TextEditingController(),
          ),
        );
      } else if (command.startsWith('cd')) {
        List args = command.split(' ');
        if (args.first == 'cd' && args.length == 2) {
          context.read<FileSystemBloc>().add(PushTo(path: args.last));
          await Future.delayed(const Duration(milliseconds: 100));
          if (args.last.trim() == '..') {
            List<String> path = state.currentPath;
            terminals.add(
              TerminalModel(
                path: path,
                controller: TextEditingController(),
              ),
            );
          } else {
            terminals.add(
              TerminalModel(
                path: [...state.currentPath, args.last],
                controller: TextEditingController(),
              ),
            );
          }
        } else {
          terminals.add(
            TerminalModel(
              path: state.currentPath,
              controller: TextEditingController(),
            ),
          );
        }
      } else {
        terminals.add(
          TerminalModel(
            path: state.currentPath,
            controller: TextEditingController(),
          ),
        );
      }

      terminalHistory.add([]);
    } catch (e) {
      terminals.add(
        TerminalModel(
          path: state.currentPath,
          controller: TextEditingController(),
        ),
      );
    } finally {
      setState(() {
        terminals = terminals;
        currentTerminalLine = commandId;
      });
    }
  }

  @override
  void initState() {
    terminals.add(TerminalModel(
        path: widget.currentPath, controller: TextEditingController()));
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
                  child: _buildTerminalLines(),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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

  Widget _buildCommandRestponse(int id, List commands) {
    log('response id $id');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var result in commands)
            Text(
              result,
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
    );
  }

  _buildTerminalLines() {
    return BlocConsumer<FileSystemBloc, FileSystemState>(
      listener: (context, state) {
        if (state is FileSystemError) {
          if (state.type == FileSystemErrorType.deleteDirectory ||
              state.type == FileSystemErrorType.renameDirectory) {
            terminalHistory[currentTerminalLine] = [state.errorMessage];
            setState(() {
              terminalHistory = terminalHistory;
            });
          } else if (state.type == FileSystemErrorType.navigationToDirectory) {
            if (terminalHistory.length == 1) {
              terminalHistory[currentTerminalLine] = [state.errorMessage];
            } else {
              terminalHistory[currentTerminalLine + 1] = [state.errorMessage];
            }
            setState(() {
              terminalHistory = terminalHistory;
              isPoped = true;
            });
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            for (int i = 0; i < terminals.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TerminalLine(
                      currentPath: terminals[i].path,
                      isActive: i == (terminals.length - 1),
                      controller: terminals[i].controller,
                      isPopend: isPoped,
                      onInitial: () {
                        terminalHistory.add([]);
                        log(terminalHistory.toString());
                      },
                      onEnter: (command) {
                        onEnterHandler(command, state, i);
                        if (command.trim() == 'ls') {
                          terminalHistory[i] =
                              state.folders.map((f) => f.name).toList();
                        }
                        setState(() {
                          isPoped = false;
                        });
                      }),
                  if (terminalHistory.isNotEmpty)
                    _buildCommandRestponse(
                      i,
                      terminalHistory[i],
                    ),
                ],
              )
          ],
        );
      },
    );
  }
}
