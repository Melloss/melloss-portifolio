import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:melloss_portifolio/data/models/browser_tab_model.dart';
import 'package:melloss_portifolio/presentation/widgets/browser/browser_tab.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/browser/browser_bloc.dart';
import '../../../bloc/file_system/file_system_bloc.dart';
import '../../../bloc/ui/ui_bloc.dart';
import '../button_widget.dart';
import 'web_view_displayer.dart';

class FirefoxBrowser extends StatefulWidget {
  const FirefoxBrowser({super.key});

  @override
  State<FirefoxBrowser> createState() => _FirefoxBrowserState();
}

class _FirefoxBrowserState extends State<FirefoxBrowser> {
  double top = 100;
  double left = 300;
  double width = 70.sh;
  double height = 70.sw;
  bool isMinimized = false;

  int index = 0;

  @override
  void initState() {
    final tabs =
        context.read<BrowserBloc>().state.browserTabs.map((t) => t.id).toList();
    tabs.sort();
    setState(() {
      index = tabs.first;
    });
    super.initState();
  }

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
    context.read<UIBloc>().add(IsBrowserOpened(isOpened: isMinimized));
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
          Expanded(
            child: BlocBuilder<BrowserBloc, BrowserState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    for (var tab in state.browserTabs)
                      Visibility(
                        maintainState: true,
                        visible: index == tab.id,
                        child: WebViewDisplayer(
                          browserTabModel: tab,
                          isExpanded: width == 100.sh,
                        ),
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      color: const Color(0xFF222222),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              //
            },
            icon: const Icon(
              Icons.tab_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const VerticalDivider(
            width: 0.5,
            color: Colors.white30,
          ),
          const SizedBox(width: 5),
          Expanded(
              child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<BrowserBloc, BrowserState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      for (var tab in state.browserTabs)
                        BrowserTab(
                          browserTabModel: tab,
                          onTab: () {
                            setState(() {
                              index = tab.id;
                            });
                          },
                          selectedIndex: index,
                          onRemoveTab: (removedIndex) {
                            if (state.browserTabs.length != 1) {
                              if (state.browserTabs.last.id == removedIndex) {
                                final tabsIndex =
                                    state.browserTabs.map((t) => t.id).toList();
                                tabsIndex.removeWhere((t) => t == index);
                                tabsIndex.sort();

                                setState(() {
                                  index = tabsIndex.last;
                                });
                              }
                            }
                          },
                        ),
                      IconButton(
                        onPressed: () {
                          final tabs = state.browserTabs;
                          tabs.sort((a, b) => a.id.compareTo(b.id));
                          context.read<BrowserBloc>().add(
                                AddTab(
                                  browserTabModel: BrowserTabModel(
                                    id: (tabs.last.id + 1),
                                    url: '',
                                    title: 'New Tab',
                                  ),
                                ),
                              );
                          setState(() {
                            index = tabs.last.id + 1;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          )),
          Row(
            children: [
              ButtonWidget(
                backgroundColor: Colors.transparent,
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
                  isMinimized = true;
                  context.pop();
                },
              ),
              const SizedBox(width: 7),
              ButtonWidget(
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                backgroundColor: Colors.transparent,
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
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                minimumSize: const Size(40, 40),
                child: const Icon(
                  Icons.close,
                  size: 14,
                ),
                onPressed: () {
                  context.read<UIBloc>().add(
                        const IsExplorerOpened(isOpended: false),
                      );
                  context.read<UIBloc>().add(
                        const SetMinimazedPath(path: ['/']),
                      );

                  context.read<BrowserBloc>().add(SetInitial());

                  context.pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
