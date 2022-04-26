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
      body: ImageSketcher.asset(
        "assets/sample.jpeg",
        key: _imageKey,
        scalable: true,
        initialStrokeWidth: 2,
        initialColor: Colors.green,
        initialPaintMode: PaintMode.freeStyle,
        controlPosition: ControlPosition.Overlay,
        toolbarBGColor: Colors.white,
        enableControlMode: false,
        enableBrush: false,
        enableText: false,
        customToolItems: [
          IconButton(
            onPressed: saveImage,
            icon: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
