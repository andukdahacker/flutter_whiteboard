import 'package:flutter/material.dart';

import '../drawables/drawable.dart';
import '../drawables/drawable_circle.dart';

class DrawableProvider extends ChangeNotifier {
  final List<Drawable> _drawables = [];

  List<Drawable> get drawables => _drawables;

  void drawCircle({required Offset position, required double scale}) {
    final circle = DrawableCircle(centerX: position.dx, centerY: position.dy, radius: 50.0 / scale, fill: '#b74093', strokeWidth: 1 / scale);

    _drawables.add(circle);
    selectDrawable(circle);
    notifyListeners();
  }

  void updateDrawable({Offset? offset, double? size, required Drawable drawable}) {
    final newDrawable = drawable.copyWith(dx: offset?.dx, dy: offset?.dy, isSelected: true);

    final index = _drawables.indexWhere((element) {
      return element.id == drawable.id;
    });

    if(index > -1) {
      _drawables[index] = newDrawable;
      notifyListeners();
    }
  }

  void selectDrawable(Drawable drawable) {
    final newList = _drawables.map((e) {
      if(e.id == drawable.id) {
        return drawable.copyWith(isSelected: true);
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();

    _drawables.clear();
    _drawables.addAll(newList);

    notifyListeners();
  }
}