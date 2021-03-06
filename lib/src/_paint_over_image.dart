import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '_image_painter.dart';
import '_ported_interactive_viewer.dart';
import 'delegates/text_delegate.dart';
import 'widgets/_color_widget.dart';
import 'widgets/_mode_widget.dart';
import 'widgets/_range_slider.dart';
import 'widgets/_text_dialog.dart';

export '_image_painter.dart';

enum ControllerAxis { horizontal, vertical }

///[ImageSketcher] widget.
@immutable
class ImageSketcher extends StatefulWidget {
  const ImageSketcher._(
      {Key? key,
      this.assetPath,
      this.networkUrl,
      this.byteArray,
      this.file,
      this.enableToolbar = true,
      this.toolbarBGColor,
      this.enableControlMode = true,
      this.enableColorSelection = true,
      this.enableBrush = true,
      this.enableText = true,
      this.enableUndo = true,
      this.enableClear = true,
      this.customToolItems = const [],
      this.height,
      this.width,
      this.placeHolder,
      this.isScalable,
      this.brushIcon,
      this.clearAllIcon,
      this.colorIcon,
      this.undoIcon,
      this.isSignature = false,
      this.controllerPosition = Alignment.topCenter,
      this.isControllerOverlay = false,
      this.controllerAxis = ControllerAxis.vertical,
      this.controllerDecoration,
      this.controllerHeight,
      this.controllerWidth,
      this.controllerPadding,
      this.controllerMargin,
      this.signatureBackgroundColor,
      this.colors,
      this.initialPaintMode,
      this.initialStrokeWidth,
      this.initialColor,
      this.onColorChanged,
      this.onStrokeWidthChanged,
      this.onPaintModeChanged,
      this.textDelegate})
      : super(key: key);

  ///Constructor for loading image from network url.
  factory ImageSketcher.network(
    String url, {
    required Key key,
    bool enableToolbar = true,
    Color? toolbarBGColor,
    bool enableControlMode = true,
    bool enableColorSelection = true,
    bool enableBrush = true,
    bool enableText = true,
    bool enableUndo = true,
    bool enableClear = true,
    List<Widget> customToolItems = const [],
    double? height,
    double? width,
    Widget? placeholderWidget,
    bool? scalable,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
    TextDelegate? textDelegate,
    AlignmentGeometry controlPosition = Alignment.topCenter,
    bool isControllerOverlay = false,
    ControllerAxis controllerAxis = ControllerAxis.vertical,
    BoxDecoration? controllerDecoration,
    double? controllerHeight,
    double? controllerWidth,
    EdgeInsetsGeometry? controllerPadding,
    EdgeInsetsGeometry? controllerMargin,
  }) {
    return ImageSketcher._(
      key: key,
      networkUrl: url,
      enableToolbar: enableToolbar,
      toolbarBGColor: toolbarBGColor,
      enableControlMode: enableControlMode,
      enableColorSelection: enableColorSelection,
      enableBrush: enableBrush,
      enableText: enableText,
      enableUndo: enableUndo,
      enableClear: enableClear,
      customToolItems: customToolItems,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      isScalable: scalable,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
      textDelegate: textDelegate,
      controllerPosition: controlPosition,
      isControllerOverlay: isControllerOverlay,
      controllerAxis: controllerAxis,
      controllerDecoration: controllerDecoration,
      controllerHeight: controllerHeight,
      controllerWidth: controllerWidth,
      controllerPadding: controllerPadding,
      controllerMargin: controllerMargin,
    );
  }

  ///Constructor for loading image from assetPath.
  factory ImageSketcher.asset(
    String path, {
    required Key key,
    bool enableToolbar = true,
    Color? toolbarBGColor,
    bool enableControlMode = true,
    bool enableColorSelection = true,
    bool enableBrush = true,
    bool enableText = true,
    bool enableUndo = true,
    bool enableClear = true,
    List<Widget> customToolItems = const [],
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
    TextDelegate? textDelegate,
    AlignmentGeometry controlPosition = Alignment.topCenter,
    bool isControllerOverlay = false,
    ControllerAxis controllerAxis = ControllerAxis.vertical,
    BoxDecoration? controllerDecoration,
    double? controllerHeight,
    double? controllerWidth,
    EdgeInsetsGeometry? controllerPadding,
    EdgeInsetsGeometry? controllerMargin,
  }) {
    return ImageSketcher._(
      key: key,
      assetPath: path,
      enableToolbar: enableToolbar,
      toolbarBGColor: toolbarBGColor,
      enableControlMode: enableControlMode,
      enableColorSelection: enableColorSelection,
      enableBrush: enableBrush,
      enableText: enableText,
      enableUndo: enableUndo,
      enableClear: enableClear,
      customToolItems: customToolItems,
      height: height,
      width: width,
      isScalable: scalable ?? false,
      placeHolder: placeholderWidget,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
      textDelegate: textDelegate,
      controllerPosition: controlPosition,
      isControllerOverlay: isControllerOverlay,
      controllerAxis: controllerAxis,
      controllerDecoration: controllerDecoration,
      controllerHeight: controllerHeight,
      controllerWidth: controllerWidth,
      controllerPadding: controllerPadding,
      controllerMargin: controllerMargin,
    );
  }

  ///Constructor for loading image from [File].
  factory ImageSketcher.file(
    File file, {
    required Key key,
    bool enableToolbar = true,
    Color? toolbarBGColor,
    bool enableControlMode = true,
    bool enableColorSelection = true,
    bool enableBrush = true,
    bool enableText = true,
    bool enableUndo = true,
    bool enableClear = true,
    List<Widget> customToolItems = const [],
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
    TextDelegate? textDelegate,
    AlignmentGeometry controlPosition = Alignment.topCenter,
    bool isControllerOverlay = false,
    ControllerAxis controllerAxis = ControllerAxis.vertical,
    BoxDecoration? controllerDecoration,
    double? controllerHeight,
    double? controllerWidth,
    EdgeInsetsGeometry? controllerPadding,
    EdgeInsetsGeometry? controllerMargin,
  }) {
    return ImageSketcher._(
      key: key,
      file: file,
      enableToolbar: enableToolbar,
      toolbarBGColor: toolbarBGColor,
      enableControlMode: enableControlMode,
      enableColorSelection: enableColorSelection,
      enableBrush: enableBrush,
      enableText: enableText,
      enableUndo: enableUndo,
      enableClear: enableClear,
      customToolItems: customToolItems,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      colors: colors,
      isScalable: scalable ?? false,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
      textDelegate: textDelegate,
      controllerPosition: controlPosition,
      isControllerOverlay: isControllerOverlay,
      controllerAxis: controllerAxis,
      controllerDecoration: controllerDecoration,
      controllerHeight: controllerHeight,
      controllerWidth: controllerWidth,
      controllerPadding: controllerPadding,
      controllerMargin: controllerMargin,
    );
  }

  ///Constructor for loading image from memory.
  factory ImageSketcher.memory(
    Uint8List byteArray, {
    required Key key,
    bool enableToolbar = true,
    Color? toolbarBGColor,
    bool enableControlMode = true,
    bool enableColorSelection = true,
    bool enableBrush = true,
    bool enableText = true,
    bool enableUndo = true,
    bool enableClear = true,
    List<Widget> customToolItems = const [],
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
    TextDelegate? textDelegate,
    AlignmentGeometry controlPosition = Alignment.topCenter,
    bool isControllerOverlay = false,
    ControllerAxis controllerAxis = ControllerAxis.vertical,
    BoxDecoration? controllerDecoration,
    double? controllerHeight,
    double? controllerWidth,
    EdgeInsetsGeometry? controllerPadding,
    EdgeInsetsGeometry? controllerMargin,
  }) {
    return ImageSketcher._(
      key: key,
      byteArray: byteArray,
      enableToolbar: enableToolbar,
      toolbarBGColor: toolbarBGColor,
      enableControlMode: enableControlMode,
      enableColorSelection: enableColorSelection,
      enableBrush: enableBrush,
      enableText: enableText,
      enableUndo: enableUndo,
      enableClear: enableClear,
      customToolItems: customToolItems,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      isScalable: scalable ?? false,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
      textDelegate: textDelegate,
      controllerPosition: controlPosition,
      isControllerOverlay: isControllerOverlay,
      controllerAxis: controllerAxis,
      controllerDecoration: controllerDecoration,
      controllerHeight: controllerHeight,
      controllerWidth: controllerWidth,
      controllerPadding: controllerPadding,
      controllerMargin: controllerMargin,
    );
  }

  ///Constructor for signature painting.
  factory ImageSketcher.signature({
    required Key key,
    Color? signatureBgColor,
    double? height,
    double? width,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
    TextDelegate? textDelegate,
  }) {
    return ImageSketcher._(
      key: key,
      height: height,
      width: width,
      isSignature: true,
      isScalable: false,
      colors: colors,
      signatureBackgroundColor: signatureBgColor ?? Colors.white,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
      textDelegate: textDelegate,
    );
  }

  ///Only accessible through [ImagePainter.network] constructor.
  final String? networkUrl;

  ///Only accessible through [ImagePainter.memory] constructor.
  final Uint8List? byteArray;

  ///Only accessible through [ImageSketcher.file] constructor.
  final File? file;

  ///Only accessible through [ImagePainter.asset] constructor.
  final String? assetPath;

  ///Toolbar background color
  final bool enableToolbar;

  ///Toolbar background color
  final Color? toolbarBGColor;

  ///Enable/Disable Control Mode
  final bool enableControlMode;

  ///Enable/Disable Color Selection
  final bool enableColorSelection;

  ///Enable/Disable Brush
  final bool enableBrush;

  ///Enable/Disable Text
  final bool enableText;

  ///Enable/Disable Undo
  final bool enableUndo;

  ///Enable/Disable Clear
  final bool enableClear;

  ///Custom toolbar item widgets
  final List<Widget> customToolItems;

  ///Height of the Widget. Image is subjected to fit within the given height.
  final double? height;

  ///Width of the widget. Image is subjected to fit within the given width.
  final double? width;

  ///Widget to be shown during the conversion of provided image to [ui.Image].
  final Widget? placeHolder;

  ///Defines whether the widget should be scaled or not. Defaults to [false].
  final bool? isScalable;

  ///Flag to determine signature or image;
  final bool isSignature;

  ///Signature mode background color
  final Color? signatureBackgroundColor;

  ///List of colors for color selection
  ///If not provided, default colors are used.
  final List<Color>? colors;

  ///Icon Widget of strokeWidth.
  final Widget? brushIcon;

  ///Widget of Color Icon in control bar.
  final Widget? colorIcon;

  ///Widget for Undo last action on control bar.
  final Widget? undoIcon;

  ///Widget for clearing all actions on control bar.
  final Widget? clearAllIcon;

  ///Control position.
  final AlignmentGeometry controllerPosition;

  ///Control position.
  final bool isControllerOverlay;

  ///Control position.
  final ControllerAxis controllerAxis;

  ///Control position.
  final BoxDecoration? controllerDecoration;

  ///Control height.
  final double? controllerHeight;

  ///Control width.
  final double? controllerWidth;

  ///Control width.
  final EdgeInsetsGeometry? controllerPadding;

  ///Control width.
  final EdgeInsetsGeometry? controllerMargin;

  ///Initial PaintMode.
  final PaintMode? initialPaintMode;

  //the initial stroke width
  final double? initialStrokeWidth;

  //the initial color
  final Color? initialColor;

  final ValueChanged<Color>? onColorChanged;

  final ValueChanged<double>? onStrokeWidthChanged;

  final ValueChanged<PaintMode>? onPaintModeChanged;

  //the text delegate
  final TextDelegate? textDelegate;

  @override
  ImageSketcherState createState() => ImageSketcherState();
}

///
class ImageSketcherState extends State<ImageSketcher> {
  final _repaintKey = GlobalKey();
  ui.Image? _image;
  bool _inDrag = false;
  final _paintHistory = <PaintInfo>[];
  final _points = <Offset?>[];
  late final ValueNotifier<Controller> _controller;
  late final ValueNotifier<bool> _isLoaded;
  late final TextEditingController _textController;
  Offset? _start, _end;
  int _strokeMultiplier = 1;
  late TextDelegate textDelegate;

  @override
  void initState() {
    super.initState();
    _isLoaded = ValueNotifier<bool>(false);
    _resolveAndConvertImage();
    if (widget.isSignature) {
      _controller = ValueNotifier(
          const Controller(mode: PaintMode.freeStyle, color: Colors.black));
    } else {
      _controller = ValueNotifier(
        const Controller().copyWith(
          mode: widget.initialPaintMode,
          strokeWidth: widget.initialStrokeWidth,
          color: widget.initialColor,
        ),
      );
    }
    _textController = TextEditingController();
    textDelegate = widget.textDelegate ?? TextDelegate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _isLoaded.dispose();
    _textController.dispose();
    super.dispose();
  }

  Paint get _painter => Paint()
    ..color = _controller.value.color
    ..strokeWidth = _controller.value.strokeWidth * _strokeMultiplier
    ..style = _controller.value.mode == PaintMode.dashLine
        ? PaintingStyle.stroke
        : _controller.value.paintStyle;

  ///Converts the incoming image type from constructor to [ui.Image]
  Future<void> _resolveAndConvertImage() async {
    if (widget.networkUrl != null) {
      _image = await _loadNetworkImage(widget.networkUrl!);
      if (_image == null) {
        throw ("${widget.networkUrl} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.assetPath != null) {
      final img = await rootBundle.load(widget.assetPath!);
      _image = await _convertImage(Uint8List.view(img.buffer));
      if (_image == null) {
        throw ("${widget.assetPath} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.file != null) {
      final img = await widget.file!.readAsBytes();
      _image = await _convertImage(img);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided file.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.byteArray != null) {
      _image = await _convertImage(widget.byteArray!);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided byteArray.");
      } else {
        _setStrokeMultiplier();
      }
    } else {
      _isLoaded.value = true;
    }
  }

  ///Dynamically sets stroke multiplier on the basis of widget size.
  ///Implemented to avoid thin stroke on high res images.
  _setStrokeMultiplier() {
    if ((_image!.height + _image!.width) > 1000) {
      _strokeMultiplier = (_image!.height + _image!.width) ~/ 1000;
    }
  }

  ///Completer function to convert asset or file image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _convertImage(Uint8List img) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(img, (image) {
      _isLoaded.value = true;
      return completer.complete(image);
    });
    return completer.future;
  }

  ///Completer function to convert network image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    _isLoaded.value = true;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoaded,
      builder: (_, loaded, __) {
        if (loaded) {
          return widget.isSignature ? _paintSignature() : _paintImage();
        } else {
          return Container(
            height: widget.height ?? double.maxFinite,
            width: widget.width ?? double.maxFinite,
            child: Center(
              child: widget.placeHolder ?? const CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ///paints image on given constrains for drawing if image is not null.
  Widget _paintImage() {
    return Stack(
      children: [
        SizedBox(
          height: widget.height ?? double.maxFinite,
          width: widget.width ?? double.maxFinite,
          child: Column(
            children: [
              if (widget.enableToolbar &&
                  !widget.isControllerOverlay &&
                  (widget.controllerPosition == Alignment.topLeft ||
                      widget.controllerPosition == Alignment.topCenter ||
                      widget.controllerPosition == Alignment.topRight))
                Align(
                  alignment: widget.controllerPosition,
                  child: _buildControls(
                    controlBarColor: widget.toolbarBGColor,
                    enableControlMode: widget.enableControlMode,
                    enableColorSelection: widget.enableColorSelection,
                    enableBrush: widget.enableBrush,
                    enableText: widget.enableText,
                    enableUndo: widget.enableUndo,
                    enableClear: widget.enableClear,
                    customToolItems: widget.customToolItems,
                    controllerAxis: widget.controllerAxis,
                    controllerDecoration: widget.controllerDecoration,
                    height: widget.controllerHeight,
                    width: widget.controllerWidth,
                    padding: widget.controllerPadding,
                    margin: widget.controllerMargin,
                  ),
                ),
              Expanded(
                child: FittedBox(
                  alignment: FractionalOffset.center,
                  child: ClipRect(
                    child: ValueListenableBuilder<Controller>(
                      valueListenable: _controller,
                      builder: (_, controller, __) {
                        return ImagePainterTransformer(
                          maxScale: 2.4,
                          minScale: 1,
                          panEnabled: controller.mode == PaintMode.none,
                          scaleEnabled: widget.isScalable!,
                          onInteractionUpdate: (details) =>
                              _scaleUpdateGesture(details, controller),
                          onInteractionEnd: (details) =>
                              _scaleEndGesture(details, controller),
                          child: CustomPaint(
                            size: Size(_image!.width.toDouble(),
                                _image!.height.toDouble()),
                            willChange: true,
                            isComplex: true,
                            painter: DrawImage(
                              image: _image,
                              points: _points,
                              paintHistory: _paintHistory,
                              isDragging: _inDrag,
                              update: UpdatePoints(
                                  start: _start,
                                  end: _end,
                                  painter: _painter,
                                  mode: controller.mode),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (widget.enableToolbar &&
                  !widget.isControllerOverlay &&
                  (widget.controllerPosition == Alignment.bottomLeft ||
                      widget.controllerPosition == Alignment.bottomCenter ||
                      widget.controllerPosition == Alignment.bottomRight))
                Align(
                  alignment: widget.controllerPosition,
                  child: _buildControls(
                    controlBarColor: widget.toolbarBGColor,
                    enableControlMode: widget.enableControlMode,
                    enableColorSelection: widget.enableColorSelection,
                    enableBrush: widget.enableBrush,
                    enableText: widget.enableText,
                    enableUndo: widget.enableUndo,
                    enableClear: widget.enableClear,
                    customToolItems: widget.customToolItems,
                    controllerAxis: widget.controllerAxis,
                    controllerDecoration: widget.controllerDecoration,
                    height: widget.controllerHeight,
                    width: widget.controllerWidth,
                    padding: widget.controllerPadding,
                    margin: widget.controllerMargin,
                  ),
                ),
            ],
          ),
        ),
        if (widget.enableToolbar && widget.isControllerOverlay)
          Align(
            alignment: widget.controllerPosition,
            child: _buildControls(
              controlBarColor: widget.toolbarBGColor,
              enableControlMode: widget.enableControlMode,
              enableColorSelection: widget.enableColorSelection,
              enableBrush: widget.enableBrush,
              enableText: widget.enableText,
              enableUndo: widget.enableUndo,
              enableClear: widget.enableClear,
              customToolItems: widget.customToolItems,
              controllerAxis: widget.controllerAxis,
              controllerDecoration: widget.controllerDecoration,
              height: widget.controllerHeight,
              width: widget.controllerWidth,
              padding: widget.controllerPadding,
              margin: widget.controllerMargin,
            ),
          ),
      ],
    );
  }

  Widget _paintSignature() {
    return Stack(
      children: [
        RepaintBoundary(
          key: _repaintKey,
          child: ClipRect(
            child: SizedBox(
              width: widget.width ?? double.maxFinite,
              height: widget.height ?? double.maxFinite,
              child: ValueListenableBuilder<Controller>(
                valueListenable: _controller,
                builder: (_, controller, __) {
                  return ImagePainterTransformer(
                    panEnabled: false,
                    scaleEnabled: false,
                    onInteractionStart: _scaleStartGesture,
                    onInteractionUpdate: (details) =>
                        _scaleUpdateGesture(details, controller),
                    onInteractionEnd: (details) =>
                        _scaleEndGesture(details, controller),
                    child: CustomPaint(
                      willChange: true,
                      isComplex: true,
                      painter: DrawImage(
                        isSignature: true,
                        backgroundColor: widget.signatureBackgroundColor,
                        points: _points,
                        paintHistory: _paintHistory,
                        isDragging: _inDrag,
                        update: UpdatePoints(
                            start: _start,
                            end: _end,
                            painter: _painter,
                            mode: controller.mode),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  tooltip: textDelegate.undo,
                  icon: widget.undoIcon ??
                      Icon(Icons.reply, color: Colors.grey[700]),
                  onPressed: () {
                    if (_paintHistory.isNotEmpty) {
                      setState(_paintHistory.removeLast);
                    }
                  }),
              IconButton(
                tooltip: textDelegate.clearAllProgress,
                icon: widget.clearAllIcon ??
                    Icon(Icons.clear, color: Colors.grey[700]),
                onPressed: () => setState(_paintHistory.clear),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _scaleStartGesture(ScaleStartDetails onStart) {
    if (!widget.isSignature) {
      setState(() {
        _start = onStart.focalPoint;
        _points.add(_start);
      });
    }
  }

  ///Fires while user is interacting with the screen to record painting.
  void _scaleUpdateGesture(ScaleUpdateDetails onUpdate, Controller ctrl) {
    setState(
      () {
        _inDrag = true;
        _start ??= onUpdate.focalPoint;
        _end = onUpdate.focalPoint;
        if (ctrl.mode == PaintMode.freeStyle) _points.add(_end);
        if (ctrl.mode == PaintMode.text &&
            _paintHistory
                .where((element) => element.mode == PaintMode.text)
                .isNotEmpty) {
          _paintHistory
              .lastWhere((element) => element.mode == PaintMode.text)
              .offset = [_end];
        }
      },
    );
  }

  ///Fires when user stops interacting with the screen.
  void _scaleEndGesture(ScaleEndDetails onEnd, Controller controller) {
    setState(() {
      _inDrag = false;
      if (_start != null &&
          _end != null &&
          (controller.mode == PaintMode.freeStyle)) {
        _points.add(null);
        _addFreeStylePoints();
        _points.clear();
      } else if (_start != null &&
          _end != null &&
          controller.mode != PaintMode.text) {
        _addEndPoints();
      }
      _start = null;
      _end = null;
    });
  }

  void _addEndPoints() => _addPaintHistory(
        PaintInfo(
          offset: <Offset?>[_start, _end],
          painter: _painter,
          mode: _controller.value.mode,
        ),
      );

  void _addFreeStylePoints() => _addPaintHistory(
        PaintInfo(
          offset: <Offset?>[..._points],
          painter: _painter,
          mode: PaintMode.freeStyle,
        ),
      );

  ///Provides [ui.Image] of the recorded canvas to perform action.
  Future<ui.Image> _renderImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = DrawImage(image: _image, paintHistory: _paintHistory);
    final size = Size(_image!.width.toDouble(), _image!.height.toDouble());
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  PopupMenuItem _showOptionsRow(Controller controller) {
    return PopupMenuItem(
      enabled: false,
      child: Center(
        child: SizedBox(
          child: Wrap(
            children: paintModes(textDelegate)
                .map(
                  (item) => SelectionItems(
                    data: item,
                    isSelected: controller.mode == item.mode,
                    onTap: () {
                      if (widget.onPaintModeChanged != null &&
                          item.mode != null) {
                        widget.onPaintModeChanged!(item.mode!);
                      }
                      _controller.value = controller.copyWith(mode: item.mode);
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  PopupMenuItem _showRangeSlider() {
    return PopupMenuItem(
      enabled: false,
      child: SizedBox(
        width: double.maxFinite,
        child: ValueListenableBuilder<Controller>(
          valueListenable: _controller,
          builder: (_, ctrl, __) {
            return RangedSlider(
              value: ctrl.strokeWidth,
              onChanged: (value) {
                _controller.value = ctrl.copyWith(strokeWidth: value);
                if (widget.onStrokeWidthChanged != null) {
                  widget.onStrokeWidthChanged!(value);
                }
              },
            );
          },
        ),
      ),
    );
  }

  PopupMenuItem _showColorPicker(Controller controller) {
    return PopupMenuItem(
        enabled: false,
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: (widget.colors ?? editorColors).map((color) {
              return ColorItem(
                isSelected: color == controller.color,
                color: color,
                onTap: () {
                  _controller.value = controller.copyWith(color: color);
                  if (widget.onColorChanged != null) {
                    widget.onColorChanged!(color);
                  }
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ));
  }

  ///Generates [Uint8List] of the [ui.Image] generated by the [renderImage()] method.
  ///Can be converted to image file by writing as bytes.
  Future<Uint8List?> exportImage() async {
    late ui.Image _convertedImage;
    if (widget.isSignature) {
      final _boundary = _repaintKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      _convertedImage = await _boundary.toImage(pixelRatio: 3);
    } else if (widget.byteArray != null && _paintHistory.isEmpty) {
      return widget.byteArray;
    } else {
      _convertedImage = await _renderImage();
    }
    final byteData =
        await _convertedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void _addPaintHistory(PaintInfo info) {
    if (info.mode != PaintMode.none) {
      _paintHistory.add(info);
    }
  }

  void _openTextDialog() {
    _controller.value = _controller.value.copyWith(mode: PaintMode.text);
    final fontSize = 6 * _controller.value.strokeWidth;

    TextDialog.show(context, _textController, fontSize, _controller.value.color,
        textDelegate, onFinished: (context) {
      if (_textController.text != '') {
        setState(() {
          _addPaintHistory(
            PaintInfo(
                mode: PaintMode.text,
                text: _textController.text,
                painter: _painter,
                offset: []),
          );
        });
        _textController.clear();
      }
      Navigator.of(context).pop();
    });
  }

  void updateColor(Color color) {
    _controller.value = _controller.value.copyWith(color: color);
    if (widget.onColorChanged != null) {
      widget.onColorChanged!(color);
    }
  }

  void changePaintMode(PaintMode mode) {
    if (widget.onPaintModeChanged != null) {
      widget.onPaintModeChanged!(mode);
    }
    _controller.value = _controller.value.copyWith(mode: mode);
  }

  void changeBrushWidth(double value){
    _controller.value = _controller.value.copyWith(strokeWidth: value);
    if (widget.onStrokeWidthChanged != null) {
      widget.onStrokeWidthChanged!(value);
    }
  }

  void addText(String text){
    setState(() {
      _controller.value = _controller.value.copyWith(mode: PaintMode.text);
      final fontSize = 6 * _controller.value.strokeWidth;
      _addPaintHistory(
        PaintInfo(
            mode: PaintMode.text,
            text: text,
            painter: _painter,
            offset: []),
      );
    });
  }

  void clearAll() {
    if (_paintHistory.isNotEmpty) {
      setState(_paintHistory.clear);
    }
  }

  void undo() {
    if (_paintHistory.isNotEmpty) {
      setState(_paintHistory.removeLast);
    }
  }

  Widget _buildControls({
    Color? controlBarColor,
    bool enableControlMode = true,
    bool enableColorSelection = true,
    bool enableBrush = true,
    bool enableText = true,
    bool enableUndo = true,
    bool enableClear = true,
    List<Widget> customToolItems = const [],
    ControllerAxis controllerAxis = ControllerAxis.vertical,
    BoxDecoration? controllerDecoration,
    double? height,
    double? width,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(4),
    EdgeInsetsGeometry? margin,
  }) {
    List<Widget> items = [
      if (enableControlMode)
        ValueListenableBuilder<Controller>(
            valueListenable: _controller,
            builder: (_, _ctrl, __) {
              return PopupMenuButton(
                tooltip: textDelegate.changeMode,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                icon: Icon(
                    paintModes(textDelegate)
                        .firstWhere((item) => item.mode == _ctrl.mode)
                        .icon,
                    color: Colors.grey[700]),
                itemBuilder: (_) => [_showOptionsRow(_ctrl)],
              );
            }),
      if (enableColorSelection)
        ValueListenableBuilder<Controller>(
            valueListenable: _controller,
            builder: (_, controller, __) {
              return PopupMenuButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tooltip: textDelegate.changeColor,
                icon: widget.colorIcon ??
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        color: controller.color,
                      ),
                    ),
                itemBuilder: (_) => [_showColorPicker(controller)],
              );
            }),
      if (enableBrush)
        PopupMenuButton(
          tooltip: textDelegate.changeBrushSize,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: widget.brushIcon ?? Icon(Icons.brush, color: Colors.grey[700]),
          itemBuilder: (_) => [_showRangeSlider()],
        ),
      if (enableText)
        IconButton(
            icon: const Icon(Icons.text_format), onPressed: _openTextDialog),
      const Spacer(),
      if (enableUndo)
        IconButton(
            tooltip: textDelegate.undo,
            icon: widget.undoIcon ?? Icon(Icons.reply, color: Colors.grey[700]),
            onPressed: () {
              print(_paintHistory.length);
              undo();
            }),
      if (enableClear)
        IconButton(
          tooltip: textDelegate.clearAllProgress,
          icon:
              widget.clearAllIcon ?? Icon(Icons.clear, color: Colors.grey[700]),
          onPressed: () => clearAll(),
        ),
      if (customToolItems.isNotEmpty) ...customToolItems,
    ];
    return Container(
      padding: padding,
      color: controllerDecoration == null
          ? controlBarColor ?? Colors.transparent
          : null,
      decoration: controllerDecoration,
      height: height,
      width: width,
      margin: margin,
      child: controllerAxis == ControllerAxis.vertical
          ? Row(
              children: items,
            )
          : Column(
              children: items,
            ),
    );
  }
}

///Gives access to manipulate the essential components like [strokeWidth], [Color] and [PaintMode].
@immutable
class Controller {
  ///Tracks [strokeWidth] of the [Paint] method.
  final double strokeWidth;

  ///Tracks [Color] of the [Paint] method.
  final Color color;

  ///Tracks [PaintingStyle] of the [Paint] method.
  final PaintingStyle paintStyle;

  ///Tracks [PaintMode] of the current [Paint] method.
  final PaintMode mode;

  ///Any text.
  final String text;

  ///Constructor of the [Controller] class.
  const Controller(
      {this.strokeWidth = 4.0,
      this.color = Colors.red,
      this.mode = PaintMode.line,
      this.paintStyle = PaintingStyle.stroke,
      this.text = ""});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Controller &&
        o.strokeWidth == strokeWidth &&
        o.color == color &&
        o.paintStyle == paintStyle &&
        o.mode == mode &&
        o.text == text;
  }

  @override
  int get hashCode {
    return strokeWidth.hashCode ^
        color.hashCode ^
        paintStyle.hashCode ^
        mode.hashCode ^
        text.hashCode;
  }

  ///copyWith Method to access immutable controller.
  Controller copyWith(
      {double? strokeWidth,
      Color? color,
      PaintMode? mode,
      PaintingStyle? paintingStyle,
      String? text}) {
    return Controller(
        strokeWidth: strokeWidth ?? this.strokeWidth,
        color: color ?? this.color,
        mode: mode ?? this.mode,
        paintStyle: paintingStyle ?? paintStyle,
        text: text ?? this.text);
  }
}
