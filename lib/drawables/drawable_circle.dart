import 'package:flutter/material.dart';

import '../extensions/hex_color_extension.dart';
import 'drawable.dart';

class DrawableCircle extends Drawable {
  DrawableCircle({
    required String id,
    required this.centerX,
    required this.centerY,
    this.fill = '#b74093',
    required this.radius,
    this.strokeColor = 'black',
    this.strokeWidth = 1,
    bool isSelected = false,
  }) : super(
            id: id,
            dx: centerX,
            dy: centerY,
            width: radius * 2.0,
            height: radius * 2.0,
            isSelected: isSelected);

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
    paint.style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(centerX, centerY);

    path.addOval(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
    );

    canvas.drawPath(path, paint);
  }

  @override
  Drawable copyWith({
    double? dx,
    double? dy,
    double? width,
    double? height,
    bool? isSelected,
  }) =>
      DrawableCircle(
        id: id,
        centerX: dx ?? centerX,
        centerY: dy ?? centerY,
        radius: radius,
        isSelected: isSelected ?? false,
      );
}
