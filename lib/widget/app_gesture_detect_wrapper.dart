import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/controllers/drawable_provider.dart';
import 'package:flutter_whiteboard/controllers/tool_provider.dart';
import 'package:flutter_whiteboard/main.dart';
import 'package:provider/provider.dart';

import '../controllers/scale_provider.dart';

class AppGestureDetectWrapper extends StatefulWidget {
  const AppGestureDetectWrapper(
      {super.key, required this.child, required this.transformationController});

  final Widget child;
  final TransformationController transformationController;

  @override
  State<AppGestureDetectWrapper> createState() =>
      _AppGestureDetectWrapperState();
}

class _AppGestureDetectWrapperState extends State<AppGestureDetectWrapper> {
  @override
  Widget build(BuildContext context) {
    final toolProvider = context.watch<ToolProvider>();
    return GestureDetector(
      onTapUp: (details) {
        switch (toolProvider.tool) {
          case Tool.selector:
            final scale = context.read<ScaleProvider>().scale;
            final position = widget.transformationController.toScene(details.localPosition);
            context.read<DrawableProvider>().findDrawable(position, scale);
            break;
          case Tool.hand:
            break;
          case Tool.square:
            break;
          case Tool.circle:
            final scale = context.read<ScaleProvider>().scale;
            final position = widget.transformationController.toScene(details.localPosition);
            context
                .read<DrawableProvider>()
                .drawCircle(position: position, scale: scale);
            break;
        }
      },
      child: widget.child,
    );
  }
}
