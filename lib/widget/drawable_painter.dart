import 'package:flutter/material.dart';

import '../drawables/drawable.dart';

class DrawablePainter extends CustomPainter {
  DrawablePainter({required this.drawable});

  final Drawable drawable;

  @override
  void paint(Canvas canvas, Size size) {
    drawable.drawOnCanvas(canvas, size);
  }

  @override
  bool shouldRepaint(covariant DrawablePainter oldDelegate) =>
      oldDelegate.drawable.dy != drawable.dy ||
      oldDelegate.drawable.dx != drawable.dx;

  @override
  bool? hitTest(Offset position) {
    return super.hitTest(position);
  }
}
