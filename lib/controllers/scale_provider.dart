import 'package:flutter/material.dart';

class ScaleProvider extends ChangeNotifier {
  static const double initialScale = 1;

  double _scale = initialScale;

  double get scale => _scale;

  void updateScale(double scale) {
    _scale = scale;
    notifyListeners();
  }

  void resetScale() {
    _scale = initialScale;
    notifyListeners();
  }

}