import 'package:flutter/material.dart';

import '../drawables/drawable.dart';
import '../drawables/drawable_circle.dart';

class DrawableProvider extends ChangeNotifier {
  final List<Drawable> _drawables = [];
  Drawable? _selected;

  List<Drawable> get drawables => _drawables;

  Drawable? get selectedDrawable => _selected;

  void drawCircle({required Offset position, required double scale}) {
    final circle = DrawableCircle(
      centerX: position.dx,
      centerY: position.dy,
      radius: 50.0 / scale,
      fill: '#b74093',
      strokeWidth: 1 / scale,
      id: UniqueKey().toString(),
    );

    _drawables.add(circle);
    selectDrawable(circle);
    notifyListeners();
  }

  void updateDrawable(
      {Offset? offset, double? size, required Drawable drawable}) {
    final index = _drawables.indexWhere((element) {
      return element.id == drawable.id;
    });

    if (index > -1) {
      final newDrawable =
      drawable.copyWith(dx: offset?.dx, dy: offset?.dy, isSelected: true);
      _drawables[index] = newDrawable;
      _selected = newDrawable;
      notifyListeners();
    }
  }

  void findDrawable(Offset pointerPosition, double scale) {
    final newList = _drawables.map((drawable) {
      if (drawable is DrawableCircle) {
        final dx = pointerPosition.dx - drawable.dx;
        final dy = pointerPosition.dy - drawable.dy;
        final distance = dx * dx + dy * dy;
        final isWithinBounds = distance <= drawable.radius * drawable.radius;
        if (isWithinBounds) {
          _selected = drawable.copyWith(isSelected: true);
          return _selected!;
        } else {
          return drawable.copyWith(isSelected: false);
        }
      }

      return drawable;
    }).toList();

    _drawables.clear();
    _drawables.addAll(newList);

    notifyListeners();
  }

  void selectDrawable(Drawable drawable) {
    final newList = _drawables.map((e) {
      if (e.id == drawable.id) {
        _selected = drawable.copyWith(isSelected: true);
        return _selected!;
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();

    _drawables.clear();
    _drawables.addAll(newList);

    notifyListeners();
  }
}
