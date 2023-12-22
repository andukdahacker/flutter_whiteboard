import 'package:flutter/material.dart';

import '../drawables/drawable.dart';

class DrawablePainter extends CustomPainter {
  DrawablePainter({required this.drawables});
  final List<Drawable> drawables;

  @override
  void paint(Canvas canvas, Size size) {
    for(final Drawable drawable in drawables) {
      drawable.drawOnCanvas(canvas, size);
    }
    drawShapes(canvas, size);
    drawConnectionLines(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


  void drawShapes(Canvas canvas, Size size) {
    final center = Offset(size.width / 4, size.height / 4);
    const radius = 50.0;
    canvas.drawCircle(center, radius, Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke);

    final rect = Rect.fromCenter(center: Offset(size.width * 0.75, size.height / 4), width: 100, height: 80);
    canvas.drawRect(rect, Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke);
  }

  void drawConnectionLines(Canvas canvas, Size size) {
    final start = Offset(size.width / 4 + 50, size.height / 4);
    final end = Offset(size.width * 0.75 - 50, size.height / 4);

    canvas.drawLine(start, end, Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke);
  }

}