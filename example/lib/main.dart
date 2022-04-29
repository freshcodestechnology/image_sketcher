import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_sketcher/image_sketcher.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Painter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SketcherExample(),
    );
  }
}

class SketcherExample extends StatefulWidget {
  const SketcherExample({Key? key}) : super(key: key);

  @override
  _SketcherExampleState createState() => _SketcherExampleState();
}

class _SketcherExampleState extends State<SketcherExample> {
  final _imageKey = GlobalKey<ImageSketcherState>();
  final _key = GlobalKey<ScaffoldState>();

  Color color = Colors.green;

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File(fullPath);
    imgFile.writeAsBytesSync(image!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Image Exported successfully.",
                style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () => OpenFile.open(fullPath),
              child: Text(
                "Open",
                style: TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Sketcher Example"),
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          ImageSketcher.asset(
            "assets/sample.jpeg",
            key: _imageKey,
            scalable: true,
            initialStrokeWidth: 2,
            initialColor: color,
            initialPaintMode: PaintMode.freeStyle,
            controlPosition: Alignment.topCenter,
            isControllerOverlay: true,
            controllerAxis: ControllerAxis.vertical,
            controllerDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            controllerMargin: EdgeInsets.all(10),
            toolbarBGColor: Colors.white,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.clearAll();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.undo();
                    },
                    icon: const Icon(Icons.undo),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.changePaintMode(PaintMode.line);
                    },
                    icon: const Icon(Icons.mode_edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.changeBrushWidth(20);
                    },
                    icon: const Icon(Icons.brush),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.addText('Abcd');
                    },
                    icon: const Icon(Icons.text_fields),
                  ),
                  IconButton(
                    onPressed: saveImage,
                    icon: const Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.updateColor(Colors.red);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.updateColor(Colors.green);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _imageKey.currentState?.updateColor(Colors.yellow);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.yellow,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
