import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/controllers/scale_provider.dart';
import 'package:provider/provider.dart';

class ZoomControllerWidget extends StatelessWidget {
  const ZoomControllerWidget({
    super.key,
    this.zoomMaxLimit = 640,
    this.zoomMinLimit = 10,
    required this.transformationController,
  });

  final double zoomMaxLimit;
  final double zoomMinLimit;
  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
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
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ScaleProvider>(
            builder: (context, state, child) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${state.scale.floor() * 10} %'),
                IconButton(
                  onPressed: () {
                    if (state.scale >= zoomMaxLimit) return;

                    final currentScale = context.read<ScaleProvider>().scale;
                    final size = MediaQuery.of(context).size;
                    final center = Offset(size.height / 2.0, size.width / 2.0);
                    transformationController.value = Matrix4.identity()
                      ..translate(center.dx, center.dy)
                      ..scale(currentScale + 1.0)
                      ..translate(-center.dx, -center.dy);

                    context.read<ScaleProvider>().updateScale(currentScale + 1.0);
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    if (state.scale <= zoomMinLimit) return;

                    final currentScale = context.read<ScaleProvider>().scale;
                    final size = MediaQuery.of(context).size;
                    final center = Offset(size.height / 2.0, size.width / 2.0);
                    transformationController.value = Matrix4.identity()
                      ..translate(center.dx, center.dy)
                      ..scale(currentScale - 1.0)
                      ..translate(-center.dx, -center.dy);
                    context.read<ScaleProvider>().updateScale(currentScale - 1.0);
                  },
                  icon: const Icon(Icons.remove),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
