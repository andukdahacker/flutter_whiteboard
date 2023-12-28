import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/extensions/hex_color_extension.dart';

import '../drawables/drawable.dart';

class DrawablePainter extends CustomPainter {
  DrawablePainter({required this.drawables, required this.scale});

  final List<Drawable> drawables;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    for(final Drawable drawable in drawables) {
      drawable.drawOnCanvas(canvas, size);
      if(drawable.isSelected) {
        final cornerPaint = Paint();
        cornerPaint.color = HexColor.fromHex('#b74093');
        cornerPaint.strokeWidth = 1 / scale;
        cornerPaint.style = PaintingStyle.fill;
        canvas.drawCircle(drawable.topLeftCorner, 2 / scale * 2 , cornerPaint);
        canvas.drawCircle(drawable.topRightCorner, 2 / scale * 2 , cornerPaint);
        canvas.drawCircle(drawable.bottomRightCorner, 2 / scale * 2 , cornerPaint);
        canvas.drawCircle(drawable.bottomLeftCorner, 2 / scale * 2 , cornerPaint);

        final linePath = Path();

        linePath.moveTo(drawable.topLeftCorner.dx, drawable.topLeftCorner.dy);
        linePath.lineTo(drawable.topRightCorner.dx, drawable.topRightCorner.dy);
        linePath.lineTo(drawable.bottomRightCorner.dx, drawable.bottomRightCorner.dy);
        linePath.lineTo(drawable.bottomLeftCorner.dx, drawable.bottomLeftCorner.dy);
        linePath.lineTo(drawable.topLeftCorner.dx, drawable.topRightCorner.dy);

        final linePaint = Paint();

        linePaint.strokeWidth = 1 / scale;
        linePaint.color = HexColor.fromHex('#b74093');
        linePaint.style = PaintingStyle.stroke;

        canvas.drawPath(linePath, linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawablePainter oldDelegate) => true;
}
