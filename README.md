# image_sketcher

[![pub package](https://img.shields.io/pub/v/image_painter.svg)](https://pub.dev/packages/image_sketcher)
![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)
[![Platform Badge](https://img.shields.io/badge/platform-android%20|%20ios%20-green.svg)](https://pub.dev/packages/image_sketcher)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  image_sketcher: latest
```


In your library add the following import:

```dart
import 'package:image_sketcher/image_sketcher.dart';
```

## Using the library

[Check out the example](./example)

Basic usage of the libary:

- `ImageSketcher.network`: Painting over image from network url.

```dart
final _imageKey = GlobalKey<ImageSketcherState>();
//Provide controller to the painter.
ImageSketcher.network("https://sample_image.png",
                  key: _imageKey,scalable: true),

///Export the image:
Uint8List byteArray = await _imageKey.currentState.exportImage();
```
**For more thorough implementation guide, check the [example](./example).**