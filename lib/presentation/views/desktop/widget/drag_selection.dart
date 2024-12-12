import 'package:flutter/material.dart';

class DragSelection extends StatefulWidget {
  const DragSelection({super.key});

  @override
  DragSelectionState createState() => DragSelectionState();
}

class DragSelectionState extends State<DragSelection> {
  Rect? selectionRect;
  Offset? dragStart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          dragStart = details.localPosition;
          selectionRect = Rect.fromLTWH(
            dragStart!.dx,
            dragStart!.dy,
            0,
            0,
          );
        });
      },
      onPanUpdate: (details) {
        setState(() {
          final current = details.localPosition;
          selectionRect = Rect.fromPoints(dragStart!, current);
        });
      },
      onPanEnd: (details) {
        setState(() {
          dragStart = null;
          selectionRect = null; // Clear the selection rectangle
        });
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: CustomPaint(
                painter: SelectionPainter(selectionRect),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionPainter extends CustomPainter {
  final Rect? selectionRect;

  SelectionPainter(this.selectionRect);

  @override
  void paint(Canvas canvas, Size size) {
    if (selectionRect != null) {
      final paint = Paint()
        ..color = Colors.red.withOpacity(0.3)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawRect(selectionRect!, paint);
      canvas.drawRect(selectionRect!, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
