import 'package:flutter/material.dart';

import '../main.dart';

class ToolProvider extends ChangeNotifier {
  Tool _tool = Tool.selector;

  Tool get tool => _tool;

  void changeTool(Tool tool) {
    _tool = tool;
    notifyListeners();
  }

  void resetTool() {
    _tool = Tool.selector;
    notifyListeners();
  }
}