import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whiteboard/widget/drawable_circle.dart';
import 'package:flutter_whiteboard/widget/grid_painter.dart';
import 'package:flutter_whiteboard/widget/svg_painter.dart';
import 'package:flutter_whiteboard/widget/zoomer_widget.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final transformController = TransformationController();
  final GlobalKey _interactiveViewerKey = GlobalKey();

  double scale = 10;

  List<Drawable> drawable = [];

  @override
  void initState() {
    transformController.value = Matrix4.identity()..scale(10);
    setState(() {
      scale = 100;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GestureDetector(
          onDoubleTapDown: (details) {
            final childTapped =
                transformController.toScene(details.localPosition);
            // final newScale =
            //     transformController.value.getMaxScaleOnAxis() * 2.0;
            // if (newScale > 640) return;
            //
            // transformController.value = Matrix4.identity()
            //   ..translate(childTapped.dx, childTapped.dy)
            //   ..scale(newScale)
            //   ..translate(-childTapped.dx, -childTapped.dy);
            //
            // setState(() {
            //   scale = newScale * 10;
            // });

            final circle = DrawableCircle(centerX: childTapped.dx, centerY: childTapped.dy, radius: 50, fill: '#b74093');
            setState(() {
              drawable.add(circle);
            });
          },
          child: InteractiveViewer(
            key: _interactiveViewerKey,
            maxScale: 640,
            minScale: 0.1,
            panEnabled: true,
            scaleEnabled: true,
            transformationController: transformController,
            onInteractionUpdate: (details) {
              final newScale = transformController.value.getMaxScaleOnAxis();

              setState(() {
                scale = newScale * 10;
              });
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: SvgPainter(drawables: drawable),
                foregroundPainter: GridPainter(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ZoomControllerWidget(
            onZoomIn: () {
              final size = MediaQuery.of(context).size;
              final center = Offset(size.height / 2, size.width / 2);
              transformController.value = Matrix4.identity()
                ..translate(center.dx, center.dy)
                ..scale(scale / 10 + 0.1)
                ..translate(-center.dx, -center.dy);
              setState(() {
                scale = scale + 10;
              });
            },
            onZoomOut: () {
              final size = MediaQuery.of(context).size;
              final center = Offset(size.height / 2, size.width / 2);
              transformController.value = Matrix4.identity()
                ..translate(center.dx, center.dy)
                ..scale(scale / 10 - 0.1)
                ..translate(-center.dx, -center.dy);
              setState(() {
                scale = scale - 10;
              });
            },
            scale: scale,
          ),
        ),
      ]),
    );
  }
}
