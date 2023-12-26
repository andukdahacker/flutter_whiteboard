import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/controllers/cursor_provider.dart';
import 'package:flutter_whiteboard/controllers/drawable_provider.dart';
import 'package:flutter_whiteboard/controllers/scale_provider.dart';
import 'package:flutter_whiteboard/drawables/drawable.dart';
import 'package:flutter_whiteboard/drawables/drawable_circle.dart';
import 'package:provider/provider.dart';

import 'drawable_painter.dart';

class DrawableWidget extends StatelessWidget {
  const DrawableWidget({super.key, required this.drawable});

  final Drawable drawable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (drawable.isSelected)
          Positioned(
            top: drawable.dy - drawable.width / 2,
            left: drawable.dx - drawable.height / 2,
            child: Consumer<ScaleProvider>(
              builder: (context, value, child) => Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey, width: 1 / value.scale),
                ),
                width: drawable.width,
                height: drawable.height,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            context.read<DrawableProvider>().selectDrawable(drawable);
          },
          onPanDown: (details) {
            print('DrawableWidget.build');
          },
          onPanUpdate: (details) {
            print('DrawableWidget.build update ${details.localPosition}');
            context.read<DrawableProvider>().updateDrawable(offset: details.localPosition, drawable: drawable);
          },
          child: CustomPaint(
            size: Size(drawable.width, drawable.height),
            painter: DrawablePainter(drawable: drawable),
          ),
        ),
        if (drawable.isSelected)
          ...drawable
              .getCorners()
              .map(
                (e) => Consumer<ScaleProvider>(
                  builder: (context, value, child) => GestureDetector(
                    onPanUpdate: (details) {
                      context.read<DrawableProvider>().updateDrawable(size: details.primaryDelta, drawable: drawable);
                    },
                    child: CustomPaint(
                      painter: DrawablePainter(
                        drawable: DrawableCircle(
                          centerX: e.dx,
                          centerY: e.dy,
                          radius: 2 / value.scale * 2,
                          strokeWidth: 1 / value.scale,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
      ],
    );
  }
}
