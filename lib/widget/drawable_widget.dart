import 'package:flutter/material.dart';
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
      ],
    );
  }
}
