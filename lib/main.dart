import 'package:flutter/material.dart';
import 'package:flutter_whiteboard/grid_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final transformController = TransformationController();
  final GlobalKey _interactiveViewerKey = GlobalKey();

  double scale = 10;

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
            final newScale =
                transformController.value.getMaxScaleOnAxis() * 2.0;
            if (newScale > 640) return;

            transformController.value = Matrix4.identity()
              ..translate(childTapped.dx, childTapped.dy)
              ..scale(newScale)
              ..translate(-childTapped.dx, -childTapped.dy);

            setState(() {
              scale = newScale * 10;
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
                painter: GridPainter(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
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
                          transformController.value = Matrix4.identity()
                            ..scale(scale / 10 + 0.1);
                          setState(() {
                            scale = scale + 10;
                          });
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          if (scale <= 10) return;
                          transformController.value = Matrix4.identity()
                            ..scale(scale / 10 - 0.1);
                          setState(() {
                            scale = scale - 10;
                          });
                        },
                        icon: const Icon(Icons.remove))
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
