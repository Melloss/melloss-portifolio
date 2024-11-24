import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/browser/firefox_browser.dart';
import 'package:melloss_portifolio/presentation/widgets/calculator/calculator.dart';
import 'package:melloss_portifolio/presentation/widgets/file_explorer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/file_system/file_system_bloc.dart';
import '../../bloc/ui/ui_bloc.dart';
import '../../gen/colors.gen.dart';
import 'terminal/terminal.dart';

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
      child: BlocBuilder<UIBloc, UIState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
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
                          .add(const IsExplorerOpened(isOpended: true));
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
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    style: _buttonStyle(isActive: state.isTerminalOpen),
                    onPressed: () {
                      final fileSystemState =
                          context.read<FileSystemBloc>().state;
                      context
                          .read<FileSystemBloc>()
                          .add(NavigateTo(currentPath: state.minimazedPath));
                      context
                          .read<UIBloc>()
                          .add(const IsTerminalOpended(isOpended: true));

                      showDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (_) => Terminal(
                          currentPath: state.isTerminalOpen
                              ? fileSystemState.currentPath
                              : ['/'],
                        ),
                      );
                    },
                    icon: Assets.images.terminal.image(width: 55, height: 55),
                  ),
                  Visibility(
                    visible: state.isTerminalOpen,
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
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    style: _buttonStyle(isActive: state.isCalculatorOpen),
                    onPressed: () {
                      context.read<FileSystemBloc>().state;
                      context
                          .read<FileSystemBloc>()
                          .add(NavigateTo(currentPath: state.minimazedPath));
                      context
                          .read<UIBloc>()
                          .add(const IsCalculatorOpened(isOpened: true));

                      showDialog(
                        barrierDismissible: false,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (_) => const Calculator(),
                      );
                    },
                    icon: Assets.images.calculatorLogo
                        .image(width: 55, height: 55),
                  ),
                  Visibility(
                    visible: state.isCalculatorOpen,
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
              ),
              Stack(
                children: [
                  IconButton(
                      style: _buttonStyle(),
                      onPressed: () {
                        context
                            .read<UIBloc>()
                            .add(const IsBrowserOpened(isOpened: true));
                        showDialog(
                            barrierDismissible: false,
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (_) => const FirefoxBrowser());
                      },
                      icon: Assets.images.firefoxLogo
                          .image(width: 50, height: 50)),
                  Visibility(
                    visible: state.isBrowserOpen,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
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
              ),
              IconButton(
                style: _buttonStyle(),
                onPressed: () {
                  //
                },
                icon: const Icon(
                  Icons.apps,
                  size: 55,
                  color: Colors.white70,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  ButtonStyle _buttonStyle({bool isActive = false}) {
    return IconButton.styleFrom(
        backgroundColor: isActive ? Colors.grey.withOpacity(0.05) : null,
        hoverColor: ColorName.backgroundColor.withOpacity(0.1),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ));
  }
}
