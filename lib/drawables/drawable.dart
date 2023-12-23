import 'package:flutter/material.dart';

abstract class Drawable {
  Drawable({required this.dx, required this.dy, required this.width, required this.height});

  void drawOnCanvas(Canvas canvas, Size size);

  final double dx;
  final double dy;
  final double width;
  final double height;
}