
import 'package:flutter/material.dart';

import '../extensions/hex_color_extension.dart';
import 'drawable.dart';

class DrawableCircle implements Drawable {
  DrawableCircle({
    required this.centerX,
    required this.centerY,
    this.fill = 'white',
    required this.radius,
    this.strokeColor = 'black',
    this.strokeWidth = 1,
  });

  final double centerX;
  final double centerY;
  final double radius;
  final String fill;
  final String strokeColor;
  final double strokeWidth;

  String getSvgString() {
    return '''
        <circle cx="$centerX" cy="$centerY" r="$radius" stroke-width="$strokeWidth" fill="$fill"/>
    ''';
  }

  @override
  void drawOnCanvas(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = HexColor.fromHex(fill);
    paint.strokeWidth = strokeWidth;
    paint.style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }
}