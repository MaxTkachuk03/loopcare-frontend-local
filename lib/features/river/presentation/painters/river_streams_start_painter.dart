import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class RiverStreamsStartPainter extends RenderRiverStreamPainter {
  const RiverStreamsStartPainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.422;

  @override
  double get greenDarkHeightCoefficient => 0.401;

  @override
  double get petrolHeightCoefficient => 0.363;

  @override
  double get petrolDarkHeightCoefficient => 0.321;

  @override
  double get coralHeightCoefficient => 0.215;

  @override
  double get coralDarkHeightCoefficient => 0.26;

  @override
  double get orangeHeightCoefficient => 0.168;

  @override
  double get orangeDarkHeightCoefficient => 0.148;

  @override
  double get yellowHeightCoefficient => 0.119;

  @override
  double get yellowDarkHeightCoefficient => 0.097;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.353;

  @override
  double get greenDarkOffsetCoefficient => 0.347;

  @override
  double get petrolOffsetCoefficient => 0.341;

  @override
  double get petrolDarkOffsetCoefficient => 0.331;

  @override
  double get coralOffsetCoefficient => 0.327;

  @override
  double get coralDarkOffsetCoefficient => 0.33;

  @override
  double get orangeOffsetCoefficient => 0.324;

  @override
  double get orangeDarkOffsetCoefficient => 0.318;

  @override
  double get yellowOffsetCoefficient => 0.276;

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
  // PATH ====================================================================>
  @override
  Path green(Size size) => Path()
      ..moveTo(size.width / 2, size.height * 0.66)
      ..cubicTo(size.width * 0.41, size.height * 0.54, size.width * 0.19, size.height / 4, size.width * 0.02, 0)
      ..cubicTo(size.width * 0.02, size.height * 0.04, size.width * 0.06, size.height * 0.09, size.width * 0.1, size.height * 0.16)
      ..cubicTo(size.width * 0.18, size.height * 0.28, size.width * 0.27, size.height * 0.42, size.width * 0.32, size.height / 2)
      ..cubicTo(size.width * 0.49, size.height * 0.8, size.width * 0.78, size.height * 1.14, size.width, size.height * 0.96)
      ..lineTo(size.width, size.height * 0.9)
      ..cubicTo(size.width * 0.81, size.height * 1.03, size.width * 0.6, size.height * 0.77, size.width / 2, size.height * 0.66)
      ..close();

  @override
  Path greenDark(Size size) => Path()
      ..moveTo(size.width, size.height * 0.85)
      ..cubicTo(size.width * 0.83, size.height * 0.94, size.width * 0.71, size.height * 0.87, size.width * 0.54, size.height * 0.68)
      ..cubicTo(size.width * 0.42, size.height * 0.54, size.width * 0.16, size.height / 5, size.width * 0.02, 0)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.18, size.height * 0.29, size.width * 0.4, size.height * 0.59, size.width * 0.49, size.height * 0.72)
      ..cubicTo(size.width * 0.59, size.height * 0.83, size.width * 0.8, size.height * 1.1, size.width, size.height * 0.97)
      ..lineTo(size.width, size.height * 0.85)
      ..close();

  @override
  Path petrol(Size size) => Path()
      ..moveTo(size.width * 0.53, size.height * 0.77)
      ..cubicTo(size.width * 0.7, size.height * 0.98, size.width * 0.82, size.height * 1.06, size.width, size.height * 0.96)
      ..lineTo(size.width, size.height * 0.812)
      ..cubicTo(size.width * 0.85, size.height * 0.91, size.width * 0.72, size.height * 0.81, size.width * 0.51, size.height * 0.61)
      ..cubicTo(size.width * 0.37, size.height * 0.47, size.width * 0.08, size.height * 0.09, size.width * 0.02, 0)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.14, size.height * 0.24, size.width * 0.4, size.height * 0.62, size.width * 0.53, size.height * 0.77)
      ..close();

  @override
  Path petrolDark(Size size) => Path()
      ..moveTo(size.width, size.height * 0.95)
      ..cubicTo(size.width * 0.89, size.height * 1.05, size.width * 0.75, size.height, size.width * 0.55, size.height * 0.79)
      ..cubicTo(size.width * 0.36, size.height * 0.58, size.width * 0.09, size.height * 0.18, 0, size.height * 0.03)
      ..lineTo(size.width * 0.02, 0)
      ..cubicTo(size.width * 0.09, size.height * 0.09, size.width * 0.22, size.height / 4, size.width * 0.34, size.height * 0.4)
      ..cubicTo(size.width * 0.43, size.height * 0.5, size.width * 0.44, size.height * 0.52, size.width * 0.46, size.height * 0.54)
      ..cubicTo(size.width * 0.66, size.height * 0.8, size.width * 0.83, size.height * 0.87, size.width, size.height * 0.745)
      ..lineTo(size.width, size.height * 0.95)
      ..close();

  @override
  Path coral(Size size) => Path()
      ..moveTo(size.width * 0.44, size.height * 0.72)
      ..cubicTo(size.width * 0.58, size.height * 0.94, size.width * 0.71, size.height * 1.05, size.width, size.height * 0.99)
      ..lineTo(size.width, size.height * 0.685)
      ..cubicTo(size.width * 0.85, size.height * 0.84, size.width * 0.71, size.height * 0.74, size.width * 0.55, size.height * 0.61)
      ..cubicTo(size.width / 3, size.height * 0.43, size.width * 0.07, size.height * 0.11, size.width * 0.01, 0)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.08, size.height * 0.17, size.width * 0.3, size.height / 2, size.width * 0.44, size.height * 0.72)
      ..close();

  @override
  Path coralDark(Size size) => Path()
      ..moveTo(size.width * 0.41, size.height * 0.62)
      ..cubicTo(size.width * 0.54, size.height * 0.82, size.width * 0.75, size.height * 1.15, size.width, size.height * 0.93)
      ..lineTo(size.width, size.height * 0.71)
      ..cubicTo(size.width * 0.89, size.height * 0.79, size.width * 0.72, size.height * 0.76, size.width * 0.51, size.height * 0.56)
      ..cubicTo(size.width * 0.27, size.height * 0.35, size.width * 0.12, size.height * 0.17, size.width * 0.06, size.height * 0.08)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.08, size.height * 0.13, size.width * 0.27, size.height * 0.42, size.width * 0.41, size.height * 0.62)
      ..close();

  @override
  Path orange(Size size) => Path()
      ..moveTo(size.width * 0.59, size.height * 0.87)
      ..cubicTo(size.width * 0.71, size.height, size.width * 0.87, size.height * 1.08, size.width, size.height * 0.9)
      ..lineTo(size.width, size.height * 0.6)
      ..cubicTo(size.width * 0.86, size.height * 0.75, size.width * 0.75, size.height * 0.8, size.width * 0.6, size.height * 0.69)
      ..cubicTo(size.width * 0.44, size.height * 0.56, size.width * 0.12, size.height * 0.19, size.width * 0.01, 0)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.09, size.height * 0.24, size.width * 0.47, size.height * 0.75, size.width * 0.59, size.height * 0.87)
      ..close();

  @override
  Path orangeDark(Size size) => Path()
      ..moveTo(size.width * 0.58, size.height * 0.89)
      ..cubicTo(size.width * 0.67, size.height, size.width * 0.8, size.height * 1.12, size.width, size.height * 0.78)
      ..lineTo(size.width, size.height * 0.35)
      ..cubicTo(size.width * 0.82, size.height * 0.56, size.width * 0.78, size.height * 0.6, size.width * 0.63, size.height * 0.6)
      ..cubicTo(size.width * 0.48, size.height * 0.6, size.width * 0.01, 0, size.width * 0.01, 0)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.1, size.height * 0.26, size.width * 0.48, size.height * 0.78, size.width * 0.58, size.height * 0.89)
      ..close();

  @override
  Path yellow(Size size) => Path()
      ..moveTo(size.width * 0.53, size.height)
      ..cubicTo(size.width * 0.7, size.height, size.width * 0.86, size.height * 0.88, size.width, size.height * 0.58)
      ..lineTo(size.width, 0)
      ..cubicTo(size.width * 0.78, size.height * 0.41, size.width * 0.67, size.height * 0.6, size.width * 0.58, size.height * 0.69)
      ..cubicTo(size.width * 0.4, size.height * 0.84, size.width * 0.13, size.height * 0.55, 0, size.height * 0.32)
      ..lineTo(0, size.height * 0.34)
      ..cubicTo(size.width * 0.05, size.height * 0.53, size.width * 0.37, size.height * 1.02, size.width * 0.53, size.height)
      ..close();

  @override
  Path yellowDark(Size size) => Path()
      ..moveTo(size.width * 0.56, size.height * 0.78)
      ..cubicTo(size.width * 0.43, size.height * 0.74, size.width * 0.18, size.height * 0.42, 0, 0)
      ..lineTo(0, size.height * 0.05)
      ..cubicTo(0, size.height * 0.05, size.width * 0.34, size.height * 1.04, size.width * 0.59, size.height)
      ..cubicTo(size.width * 0.84, size.height * 0.96, size.width * 0.88, size.height * 0.88, size.width, size.height * 0.57)
      ..lineTo(size.width, size.height * 0.29)
      ..cubicTo(size.width * 0.88, size.height * 0.59, size.width * 0.69, size.height * 0.82, size.width * 0.56, size.height * 0.78)
      ..close();
}
