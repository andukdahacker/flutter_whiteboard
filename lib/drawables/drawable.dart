import 'package:flutter/material.dart';

abstract class Drawable {
  Drawable({
    required this.id,
    required this.dx,
    required this.dy,
    required this.width,
    required this.height,
    this.isSelected = false,
  });

  final String id;
  final double dx;
  final double dy;
  final double width;
  final double height;
  final bool isSelected;

  Drawable copyWith({
    double? dx,
    double? dy,
    double? width,
    double? height,
    bool? isSelected,
  });

  Path drawOnCanvas(Canvas canvas, Size size);

  List<Offset> getCorners() {
    final double halfWidth = width / 2;
    final double halfHeight = height / 2;

    return [
      Offset(dx - halfWidth, dy - halfHeight),
      // Top-left corner
      Offset(dx + halfWidth, dy - halfHeight),
      // Top-right corner
      Offset(dx - halfWidth, dy + halfHeight),
      // Bottom-left corner
      Offset(dx + halfWidth, dy + halfHeight),
      // Bottom-right corner
    ];
  }

  Offset get topLeftCorner {
    final double halfWidth = width / 2;
    final double halfHeight = height / 2;
    return Offset(dx - halfWidth, dy - halfHeight);
  }

  Offset get topRightCorner {
    final double halfWidth = width / 2;
    final double halfHeight = height / 2;
    return Offset(dx + halfWidth, dy - halfHeight);
  }

  Offset get bottomLeftCorner {
    final double halfWidth = width / 2;
    final double halfHeight = height / 2;
    return Offset(dx - halfWidth, dy + halfHeight);
  }

  Offset get bottomRightCorner {
    final double halfWidth = width / 2;
    final double halfHeight = height / 2;
    return Offset(dx + halfWidth, dy + halfHeight);
  }
}
