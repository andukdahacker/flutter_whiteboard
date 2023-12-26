import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_whiteboard/controllers/cursor_provider.dart';
import 'package:flutter_whiteboard/controllers/drawable_provider.dart';
import 'package:flutter_whiteboard/controllers/scale_provider.dart';
import 'package:flutter_whiteboard/controllers/tool_provider.dart';
import 'package:flutter_whiteboard/widget/app_gesture_detect_wrapper.dart';
import 'package:flutter_whiteboard/widget/drawable_widget.dart';
import 'package:flutter_whiteboard/widget/grid_painter.dart';
import 'package:flutter_whiteboard/widget/tool_selector.dart';
import 'package:flutter_whiteboard/widget/zoomer_widget.dart';
import 'package:provider/provider.dart';


void main() async {
  debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
}

enum Tool {
  selector(icon: Icon(Icons.mouse_outlined)),
  hand(icon: Icon(Icons.back_hand_outlined)),
  square(icon: Icon(Icons.square_outlined)),
  circle(icon: Icon(Icons.circle_outlined));

  final Icon icon;

  const Tool({required this.icon});
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToolProvider()),
        ChangeNotifierProvider(create: (context) => CursorProvider()),
        ChangeNotifierProvider(create: (context) => ScaleProvider()),
        ChangeNotifierProvider(
          create: (context) => DrawableProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final transformationController = TransformationController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final currentScale = context.read<ScaleProvider>().scale;
      final size = MediaQuery.of(context).size;
      final center = Offset(size.height / 2.0, size.width / 2.0);
      transformationController.value = Matrix4.identity()
        ..translate(center.dx, center.dy)
        ..scale(currentScale * 10.0)
        ..translate(-center.dx, -center.dy);

      context.read<ScaleProvider>().updateScale(currentScale * 10.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CursorProvider>(
        builder: (context, value, child) {
          print('_MyHomePageState.build ${value.cursor}');
          return MouseRegion(
          cursor: value.cursor,
          child: child,
        );
        },
        child: AppGestureDetectWrapper(
          transformationController: transformationController,
          child: Stack(children: [
            Consumer<ToolProvider>(
              builder: (context, value, child) => InteractiveViewer(
                maxScale: 640.0,
                minScale: 0.01,
                panEnabled: value.tool == Tool.hand,
                scaleEnabled: true,
                transformationController: transformationController,
                onInteractionUpdate: (details) {
                  final newScale =
                      transformationController.value.getMaxScaleOnAxis();
                  context.read<ScaleProvider>().updateScale(newScale);
                },
                child: child!,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomPaint(
                      painter: GridPainter(),
                    ),
                    Consumer<DrawableProvider>(
                      builder: (context, value, child) {
                        return Stack(
                          fit: StackFit.expand,
                          children: List.generate(
                              value.drawables.length,
                              (index) => DrawableWidget(
                                  drawable: value.drawables[index])),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ZoomControllerWidget(
                  transformationController: transformationController),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: ToolSelector(),
            )
          ]),
        ),
      ),
    );
  }
}
