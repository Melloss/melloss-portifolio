import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:melloss_portifolio/bloc/browser/browser_bloc.dart';
import 'package:melloss_portifolio/data/models/browser_tab_model.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';

import '../../../bloc/ui/ui_bloc.dart';

class BrowserTab extends StatelessWidget {
  final BrowserTabModel browserTabModel;
  final int selectedIndex;
  final Function() onTab;
  final Function(int index) onRemoveTab;

  const BrowserTab({
    super.key,
    required this.browserTabModel,
    required this.onTab,
    required this.selectedIndex,
    required this.onRemoveTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: 230,
        height: 40,
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: selectedIndex == browserTabModel.id
              ? const Color(0xFF4C4C4C)
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Assets.images.firefoxLogo.image(
                  width: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  browserTabModel.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                final tabs = context.read<BrowserBloc>().state.browserTabs;
                if (tabs.length == 1) {
                  context.read<UIBloc>().add(
                        const IsExplorerOpened(isOpended: false),
                      );
                  context.read<UIBloc>().add(
                        const SetMinimazedPath(path: ['/']),
                      );

                  context.pop();
                } else {
                  context.read<BrowserBloc>().add(RemoveTab(
                        id: browserTabModel.id,
                      ));
                }
                onRemoveTab(browserTabModel.id);
              },
              icon: const Icon(
                Icons.close_rounded,
                size: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
