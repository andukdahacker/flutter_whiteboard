import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/controllers/cursor_provider.dart';
import 'package:flutter_whiteboard/controllers/tool_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ToolSelector extends StatelessWidget {
  const ToolSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                offset: const Offset(2, -1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(Tool.values.length, (index) {
              final tool = Tool.values[index];

              return GestureDetector(
                onTap: () {
                  context.read<ToolProvider>().changeTool(tool);

                  switch(tool) {
                    case Tool.selector:
                      context.read<CursorProvider>().changeCursor(SystemMouseCursors.basic);
                    case Tool.hand:
                      context.read<CursorProvider>().changeCursor(SystemMouseCursors.grab);
                    case Tool.square:
                      context.read<CursorProvider>().changeCursor(SystemMouseCursors.precise);
                    case Tool.circle:
                      context.read<CursorProvider>().changeCursor(SystemMouseCursors.precise);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ToolProvider>(
                    builder: (context, state, child) => DecoratedBox(
                      decoration: BoxDecoration(
                          color: state.tool == tool
                              ? Theme.of(context).hoverColor
                              : null,
                          borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: tool.icon,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
