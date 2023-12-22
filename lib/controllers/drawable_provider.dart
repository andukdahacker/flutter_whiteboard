import 'package:flutter/material.dart';

import '../drawables/drawable.dart';
import '../drawables/drawable_circle.dart';

class DrawableProvider extends ChangeNotifier {
  final List<Drawable> _drawables = [];

  List<Drawable> get drawables => _drawables;

  void drawCircle({required Offset position, required double scale}) {
    final circle = DrawableCircle(centerX: position.dx, centerY: position.dy, radius: 50.0 / scale, fill: '#b74093', strokeWidth: 1 / scale);

    _drawables.add(circle);
    notifyListeners();
  }
}