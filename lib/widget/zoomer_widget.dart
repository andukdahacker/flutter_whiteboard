import 'package:flutter/material.dart';

class ZoomControllerWidget extends StatelessWidget {
  const ZoomControllerWidget(
      {super.key,
      required this.onZoomIn,
      required this.onZoomOut,
      required this.scale,
      this.zoomMaxLimit = 640,
      this.zoomMinLimit = 10});

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final double scale;
  final double zoomMaxLimit;
  final double zoomMinLimit;

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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${scale.floor()} %'),
              IconButton(
                onPressed: () {
                  if (scale >= zoomMaxLimit) return;
                  onZoomIn.call();
                },
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  if (scale <= zoomMinLimit) return;
                  onZoomOut.call();
                },
                icon: const Icon(Icons.remove),
              )
            ],
          ),
        ),
      ),
    );
  }
}
