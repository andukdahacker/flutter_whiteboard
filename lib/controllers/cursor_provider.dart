
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CursorProvider extends ChangeNotifier {
  MouseCursor _cursor = SystemMouseCursors.basic;

  MouseCursor get cursor => _cursor;

  void changeCursor(SystemMouseCursor cursor) {
    _cursor = cursor;
    notifyListeners();
  }

  void resetCursor() {
    _cursor = SystemMouseCursors.basic;
    notifyListeners();
  }
}