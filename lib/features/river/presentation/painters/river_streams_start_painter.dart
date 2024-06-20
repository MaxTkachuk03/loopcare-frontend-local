import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class RiverStreamsStartPainter extends RenderRiverStreamPainter {
  const RiverStreamsStartPainter({
    super.gradientPositionStart = 0,
    super.gradientPositionEnd = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.422;

  @override
  double get greenDarkHeightCoefficient => 0.399;

  @override
  double get petrolHeightCoefficient => 0.352;

  @override
  double get petrolDarkHeightCoefficient => 0.315;

  @override
  double get coralHeightCoefficient => 0.259;

  @override
  double get coralDarkHeightCoefficient => 0.257;

  @override
  double get orangeHeightCoefficient => 0.165;

  @override
  double get orangeDarkHeightCoefficient => 0.142;

  @override
  double get yellowHeightCoefficient => 0.119;

  @override
  double get yellowDarkHeightCoefficient => 0.096;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.353;

  @override
  double get greenDarkOffsetCoefficient => 0.348;

  @override
  double get petrolOffsetCoefficient => 0.341;

  @override
  double get petrolDarkOffsetCoefficient => 0.329;

  @override
  double get coralOffsetCoefficient => 0.327;

  @override
  double get coralDarkOffsetCoefficient => 0.33;

  @override
  double get orangeOffsetCoefficient => 0.324;

  @override
  double get orangeDarkOffsetCoefficient => 0.32;

  @override
  double get yellowOffsetCoefficient => 0.277;

  @override
  double get yellowDarkOffsetCoefficient => 0.315;

  @override
  double get greenHorizontalOffsetCoefficient => 0.385;

  @override
  double get greenDarkHorizontalOffsetCoefficient => 0.398;

  @override
  double get petrolHorizontalOffsetCoefficient => 0.409;

  @override
  double get petrolDarkHorizontalOffsetCoefficient => 0.42;

  @override
  double get coralHorizontalOffsetCoefficient => 0.43;

  @override
  double get coralDarkHorizontalOffsetCoefficient => 0.43;

  @override
  double get orangeHorizontalOffsetCoefficient => 0.436;

  @override
  double get orangeDarkHorizontalOffsetCoefficient => 0.439;

  @override
  double get yellowHorizontalOffsetCoefficient => 0.444;

  @override
  double get yellowDarkHorizontalOffsetCoefficient => 0.442;

  // PATH ====================================================================>
  @override
  Path green(Size size) {
    return Path()
      ..moveTo(size.width, size.height * 0.905)
      ..cubicTo(size.width * 0.81, size.height * 1.03, size.width * 0.55, size.height * 0.7, size.width * 0.47, size.height * 0.59)
      ..cubicTo(size.width * 0.44, size.height * 0.55, size.width * 0.37, size.height * 0.46, size.width * 0.29, size.height * 0.37)
      ..cubicTo(size.width * 0.18, size.height * 0.24, size.width * 0.06, size.height * 0.1, size.width * 0.02, 0)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.02, size.height * 0.04, size.width * 0.06, size.height * 0.09, size.width * 0.1, size.height * 0.15)
      ..cubicTo(size.width * 0.18, size.height * 0.26, size.width * 0.29, size.height * 0.41, size.width / 3, size.height * 0.48)
      ..cubicTo(size.width * 0.48, size.height * 0.76, size.width * 0.77, size.height * 1.12, size.width, size.height * 0.965)
      ..cubicTo(size.width, size.height * 0.965, size.width, size.height * 0.9, size.width, size.height * 0.905)
      ..lineTo(size.width, size.height * 0.905);
  }

  @override
  Path greenDark(Size size) {
    return Path()
        ..lineTo(size.width * 0.59, size.height * 0.64)
        ..cubicTo(size.width * 0.54, size.height * 0.6, size.width * 0.49, size.height * 0.55, size.width * 0.44, size.height * 0.52)
        ..cubicTo(size.width * 0.3, size.height * 0.42, size.width * 0.12, size.height * 0.19, size.width * 0.02, 0)
        ..lineTo(0, size.height * 0.01)
        ..cubicTo(size.width * 0.04, size.height * 0.12, size.width * 0.16, size.height * 0.27, size.width * 0.27, size.height * 0.4)
        ..cubicTo(size.width * 0.35, size.height / 2, size.width * 0.43, size.height * 0.59, size.width * 0.46, size.height * 0.65)
        ..cubicTo(size.width * 0.54, size.height * 0.8, size.width * 0.8, size.height * 1.1, size.width, size.height * 0.97)
        ..lineTo(size.width, size.height * 0.85)
        ..cubicTo(size.width * 0.86, size.height * 0.9, size.width * 0.72, size.height * 0.77, size.width * 0.59, size.height * 0.64)
      ..lineTo(size.width * 0.59, size.height * 0.64);
  }

  @override
  Path petrol(Size size) {
    return Path()
      ..moveTo(size.width * 0.65, size.height * 0.66)
      ..cubicTo(size.width * 0.62, size.height * 0.64, size.width * 0.59, size.height * 0.61, size.width * 0.55, size.height * 0.57)
      ..cubicTo(size.width * 0.38, size.height * 0.43, size.width * 0.07, size.height * 0.11, size.width * 0.02, 0)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.1, size.height * 0.23, size.width * 0.29, size.height / 2, size.width * 0.43, size.height * 0.62)
      ..cubicTo(size.width * 0.48, size.height * 0.65, size.width * 0.53, size.height * 0.71, size.width * 0.58, size.height * 0.76)
      ..cubicTo(size.width * 0.72, size.height * 0.9, size.width * 0.86, size.height * 1.05, size.width, size.height * 0.99)
      ..lineTo(size.width, size.height * 0.84)
      ..cubicTo(size.width * 0.91, size.height * 0.91, size.width * 0.79, size.height * 0.8, size.width * 0.65, size.height * 0.66)
      ..lineTo(size.width * 0.65, size.height * 0.66);
  }

  @override
  Path petrolDark(Size size) {
    return Path()
      ..moveTo(size.width * 0.55, size.height * 0.69)
      ..cubicTo(size.width * 0.72, size.height * 0.86, size.width * 0.89, size.height * 1.08, size.width, size.height * 0.98)
      ..lineTo(size.width, size.height * 0.772)
      ..cubicTo(size.width * 0.82, size.height * 0.82, size.width * 0.74, size.height * 0.7, size.width * 0.55, size.height * 0.55)
      ..cubicTo(size.width * 0.37, size.height * 0.39, size.width * 0.13, size.height * 0.12, size.width * 0.03, size.height * 0.01)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.04, size.height * 0.15, size.width * 0.37, size.height * 0.52, size.width * 0.55, size.height * 0.69)
      ..lineTo(size.width * 0.55, size.height * 0.69);
  }

  @override
  Path coral(Size size) {
    return Path()
      ..moveTo(size.width * 0.44, size.height * 0.6)
      ..cubicTo(size.width * 0.58, size.height * 0.8, size.width * 0.7, size.height * 1.14, size.width, size.height * 0.94)
      ..cubicTo(size.width, size.height * 0.94, size.width, size.height * 0.76, size.width, size.height * 0.77)
      ..lineTo(size.width, size.height * 0.57)
      ..cubicTo(size.width * 0.78, size.height * 0.63, size.width * 0.66, size.height * 0.59, size.width * 0.55, size.height * 0.51)
      ..cubicTo(size.width / 3, size.height * 0.34, size.width * 0.07, size.height * 0.09, size.width * 0.01, 0)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.08, size.height * 0.14, size.width * 0.31, size.height * 0.4, size.width * 0.44, size.height * 0.6)
      ..lineTo(size.width * 0.44, size.height * 0.6);
  }

  @override
  Path coralDark(Size size) {
    return Path()
      ..moveTo(size.width, size.height * 0.95)
      ..cubicTo(size.width * 0.7, size.height * 1.14, size.width * 0.58, size.height * 0.79, size.width * 0.44, size.height * 0.59)
      ..cubicTo(size.width * 0.36, size.height * 0.46, size.width * 0.24, size.height * 0.31, size.width * 0.14, size.height * 0.19)
      ..cubicTo(size.width * 0.1, size.height * 0.14, size.width * 0.08, size.height * 0.11, size.width * 0.06, size.height * 0.08)
      ..cubicTo(size.width * 0.04, size.height * 0.05, size.width * 0.02, size.height * 0.02, 0, 0)
      ..lineTo( size.width * 0.06, size.height * 0.08)
      ..cubicTo(size.width * 0.08, size.height * 0.11, size.width * 0.11, size.height * 0.15, size.width * 0.14, size.height * 0.19)
      ..cubicTo(size.width * 0.22, size.height * 0.28, size.width * 0.34, size.height * 0.42, size.width * 0.51, size.height * 0.57)
      ..cubicTo(size.width * 0.61, size.height * 0.66, size.width * 0.79, size.height * 0.84, size.width, size.height * 0.72)
      ..lineTo(size.width, size.height * 0.94);
  }

  @override
  Path orange(Size size) {
    return Path()
      ..moveTo(size.width * 0.57, size.height * 0.9)
      ..cubicTo(size.width * 0.67, size.height * 0.97, size.width * 0.87, size.height * 1.08, size.width, size.height * 0.91)
      ..lineTo(size.width, size.height / 2)
      ..cubicTo(size.width * 0.72, size.height * 0.65, size.width * 0.76, size.height * 0.73, size.width * 0.6, size.height * 0.65)
      ..cubicTo(size.width * 0.44, size.height * 0.57, size.width * 0.12, size.height * 0.19, size.width * 0.01, 0)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.09, size.height * 0.24, size.width * 0.47, size.height * 0.82, size.width * 0.57, size.height * 0.9)
      ..lineTo(size.width * 0.57, size.height * 0.9);
  }

  @override
  Path orangeDark(Size size) {
    return Path()
      ..moveTo(size.width * 0.01, 0)
      ..cubicTo(size.width * 0.01, size.height * 0.01, size.width * 0.34, size.height * 0.72, size.width * 0.59, size.height * 0.64)
      ..cubicTo(size.width * 0.83, size.height * 0.56, size.width * 0.87, size.height * 0.51, size.width * 0.97, size.height * 0.38)
      ..cubicTo(size.width * 0.98, size.height * 0.37, size.width, size.height * 0.34, size.width, size.height * 0.34)
      ..lineTo(size.width, size.height * 0.79)
      ..cubicTo(size.width * 0.83, size.height * 1.11, size.width * 0.67, size.height, size.width * 0.6, size.height * 0.94)
      ..cubicTo(size.width * 0.59, size.height * 0.93, size.width * 0.58, size.height * 0.93, size.width * 0.58, size.height * 0.92)
      ..cubicTo(size.width * 0.53, size.height * 0.9, size.width * 0.1, size.height * 0.27, 0, size.height * 0.03)
      ..lineTo(size.width * 0.01, 0);
  }

  @override
  Path yellow(Size size) {
    return Path()
      ..moveTo(size.width * 0.53, size.height)
      ..cubicTo(size.width * 0.69, size.height * 0.96, size.width * 0.86, size.height * 0.85, size.width, size.height * 0.57)
      ..lineTo(size.width, size.height * 0.01)
      ..cubicTo(size.width * 0.78, size.height * 0.42, size.width * 0.66, size.height * 0.64, size.width * 0.58, size.height * 0.69)
      ..cubicTo(size.width * 0.4, size.height * 0.78, size.width * 0.13, size.height * 0.55, 0, size.height * 0.32)
      ..lineTo(0, size.height * 0.34)
      ..cubicTo(size.width * 0.05, size.height * 0.53, size.width * 0.38, size.height * 1.05, size.width * 0.53, size.height)
      ..lineTo(size.width * 0.53, size.height);
  }

  @override
  Path yellowDark(Size size) {
    return Path()
      ..moveTo(size.width * 0.56, size.height * 0.79)
      ..cubicTo(size.width * 0.43, size.height * 0.98, size.width * 0.18, size.height * 0.42, 0, 0)
      ..lineTo(0, size.height * 0.05)
      ..cubicTo(0, size.height * 0.05, size.width / 3, size.height * 1.12, size.width * 0.59, size.height)
      ..cubicTo(size.width * 0.85, size.height * 0.88, size.width * 0.87, size.height * 0.81, size.width, size.height * 0.57)
      ..lineTo(size.width, size.height * 0.31)
      ..cubicTo(size.width, size.height * 0.32, size.width * 0.68, size.height * 0.74, size.width * 0.56, size.height * 0.79)
      ..lineTo(size.width * 0.56, size.height * 0.79);
  }
}
