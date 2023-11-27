import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const columnWidth = 5.0;
    const rowHeight = 5.0;

    final columns = size.width / columnWidth;

    final rows = size.height / rowHeight;

    // Draw vertical grid lines
    for (int i = 0; i <= columns; i++) {
      final dx = i * columnWidth;
      canvas.drawLine(
          Offset(dx, 0),
          Offset(dx, size.height),
          Paint()
            ..color = Colors.grey.withOpacity(0.3)
            ..strokeWidth = 0.1);
    }

    // Draw horizontal grid lines
    for (int i = 0; i <= rows; i++) {
      final dy = i * rowHeight;
      canvas.drawLine(
          Offset(0, dy),
          Offset(size.width, dy),
          Paint()
            ..color = Colors.grey.withOpacity(0.3)
            ..strokeWidth = 0.1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
