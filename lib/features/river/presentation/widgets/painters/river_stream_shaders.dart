import 'dart:ui';

import 'package:flutter/foundation.dart';

class RiverStreamShader {
  static final RiverStreamShader _instance = RiverStreamShader._internal();

  static RiverStreamShader get instance => _instance;

  RiverStreamShader._internal();

  bool _initialised = false;

  late FragmentProgram _fragmentProgram;

  /// Initialise FragmentProgram from shader file. The file must be in a
  /// different directory from assets and declared in the pubspec.yaml file.
  Future<void> init(String path) async {
    if (_initialised) return;

    _fragmentProgram = await FragmentProgram.fromAsset(path);
    _initialised = true;
  }

  FragmentShader createShader({
    required double step,
    required double time,
    required Size size,
    required Color begin,
    required Color end,
  }) {
    if (!_initialised) {
      throw FlutterError('RiverStreamShader is not initialised');
    }

    return _fragmentProgram.fragmentShader()
      ..setFloat(0, 0.0)
      ..setFloat(0, step)
      ..setFloat(1, time)
      ..setFloat(2, size.width)
      ..setFloat(3, size.height)
      ..setFloat(4, begin.red.toDouble() / 255)
      ..setFloat(5, begin.green.toDouble() / 255)
      ..setFloat(6, begin.blue.toDouble() / 255)
      ..setFloat(7, begin.alpha.toDouble() / 255)
      ..setFloat(8, end.red.toDouble() / 255)
      ..setFloat(9, end.green.toDouble() / 255)
      ..setFloat(10, end.blue.toDouble() / 255)
      ..setFloat(11, end.alpha.toDouble() / 255);
  }

  FragmentProgram get fragmentProgram =>
      _initialised ? _fragmentProgram : throw FlutterError('RiverStreamShader is not initialised');
}
