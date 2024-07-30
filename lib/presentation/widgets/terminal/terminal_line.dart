import 'package:flutter/material.dart';

class TerminalLine extends StatefulWidget {
  List<String> currentPath;
  bool isActive;
  Function(String) onEnter;
  Function()? onInitial;
  bool isPopend;

  TextEditingController controller;
  TerminalLine(
      {super.key,
      required this.currentPath,
      required this.onEnter,
      required this.controller,
      this.isActive = false,
      this.isPopend = false,
      this.onInitial});

  @override
  State<TerminalLine> createState() => _TerminalLineState();
}

class _TerminalLineState extends State<TerminalLine> {
  List<String> currentPath = [];
  @override
  void initState() {
    if (widget.onInitial != null) {
      widget.onInitial!.call();
    }
    currentPath = List.from(widget.currentPath);
    if (widget.isPopend) {
      currentPath.removeLast();
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              '[ ~${currentPath.length == 1 ? '' : ' / '}${currentPath.sublist(1).join(' / ')} ]',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.cyan,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Row(
            children: [
              CustomPaint(
                painter: ArrowPainter(),
                child: SizedBox(
                  width: 150,
                  height: 30,
                  child: Center(
                    child: Text(
                      'Melloss',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: TextField(
                onSubmitted: (command) {
                  widget.onEnter(command);
                },
                cursorWidth: 10,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                controller: widget.controller,
                autofocus: widget.isActive,
                decoration: InputDecoration(
                  hoverColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  filled: true,
                  enabled: widget.isActive,
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path.moveTo(0, 0); // Start at the top left
    path.lineTo(size.width - size.height * 0.5,
        0); // Line to the top right minus half the height
    path.lineTo(
        size.width, size.height * 0.5); // Line to the middle right (arrow tip)
    path.lineTo(size.width - size.height * 0.5,
        size.height); // Line to the bottom right minus half the height
    path.lineTo(0, size.height); // Line to the bottom left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
