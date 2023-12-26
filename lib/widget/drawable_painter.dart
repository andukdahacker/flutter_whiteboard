import 'package:flutter/material.dart';

import '../drawables/drawable.dart';

class DrawablePainter extends CustomPainter {
  DrawablePainter({required this.drawable});

  final Drawable drawable;
  Path? _path;

  @override
  void paint(Canvas canvas, Size size) {
    _path = drawable.drawOnCanvas(canvas, size);
  }

  @override
  bool shouldRepaint(covariant DrawablePainter oldDelegate) =>
      oldDelegate.drawable != drawable;

  @override
  bool? hitTest(Offset position) {
    final hit = _path?.contains(position);
    return hit;
  }
}
