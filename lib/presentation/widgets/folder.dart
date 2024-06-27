import 'package:flutter/material.dart';
import 'package:melloss_portifolio/gen/assets.gen.dart';

class Folder extends StatefulWidget {
  final String folderName;
  const Folder({super.key, required this.folderName});

  @override
  State<Folder> createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20),
      child: GestureDetector(
        onDoubleTap: () {
          print('double tab');
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
                widget.folderName,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
