import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melloss_portifolio/bloc/file_system/file_system_bloc.dart';
import 'package:melloss_portifolio/bloc/ui/ui_bloc.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';
import 'package:melloss_portifolio/presentation/widgets/file_explorer.dart';

class FolderIcon extends StatefulWidget {
  final String folderName;
  final List<String>? initialpath;
  final Function()? onTab;
  const FolderIcon(
      {super.key, required this.folderName, this.initialpath, this.onTab});

  @override
  State<FolderIcon> createState() => _FolderIconState();
}

class _FolderIconState extends State<FolderIcon> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20),
      child: GestureDetector(
        onDoubleTap: () {
          final state = context.read<UIBloc>().state;
          if (state.isExplorerOpen) {
            if (widget.initialpath != null) {
              context
                  .read<FileSystemBloc>()
                  .add(NavigateTo(currentPath: widget.initialpath!));
            } else {
              context
                  .read<FileSystemBloc>()
                  .add(PushTo(path: widget.folderName));
            }
          } else {
            if (widget.initialpath != null) {
              context
                  .read<FileSystemBloc>()
                  .add(NavigateTo(currentPath: widget.initialpath!));
            }
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
              ),
            );
            context
                .read<UIBloc>()
                .add(const ToggleIsExplorerOpened(isOpended: true));
          }
          if (widget.onTab != null) {
            widget.onTab!();
          }
        },
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              isClicked ? Colors.orange.withOpacity(0.5) : Colors.transparent,
            ),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: const WidgetStatePropertyAll(
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.folderIcon.image(
                  width: 60,
                  height: 60,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.folderName.length < 20
                      ? widget.folderName
                      : '${widget.folderName.substring(0, 20)}...',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
