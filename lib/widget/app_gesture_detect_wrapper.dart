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
  void _handleDoubleTapDownAsSelector(
      TapDownDetails details, BuildContext context) {
    final childTapped =
        widget.transformationController.toScene(details.localPosition);
    final newScale =
        widget.transformationController.value.getMaxScaleOnAxis() * 2.0;
    if (newScale > 640) return;

    widget.transformationController.value = Matrix4.identity()
      ..translate(childTapped.dx, childTapped.dy)
      ..scale(newScale)
      ..translate(-childTapped.dx, -childTapped.dy);

    context.read<ScaleProvider>().updateScale(newScale * 10);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final toolProvider = context.watch<ToolProvider>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTapDown: (details) {
        switch (toolProvider.tool) {
          case Tool.selector:
            _handleDoubleTapDownAsSelector(details, context);
            break;
          case Tool.hand:
            break;
          case Tool.square:
            break;
          case Tool.circle:
            break;
        }
      },
      onTapUp: (details) {
        switch (toolProvider.tool) {
          case Tool.selector:
            break;
          case Tool.hand:
            break;
          case Tool.square:
            break;
          case Tool.circle:
            final position =
                widget.transformationController.toScene(details.localPosition);

            final scale = context.read<ScaleProvider>().scale;
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
