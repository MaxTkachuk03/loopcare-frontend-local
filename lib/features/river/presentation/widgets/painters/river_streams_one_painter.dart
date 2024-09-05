import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_stream_painter.dart';

class RiverStreamsOnePainter extends RenderRiverStreamPainter {
  const RiverStreamsOnePainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.360;

  @override
  double get greenDarkHeightCoefficient => 0.325;

  @override
  double get petrolHeightCoefficient => 0.247;

  @override
  double get petrolDarkHeightCoefficient => 0.242;

  @override
  double get coralHeightCoefficient => 0.283;

  @override
  double get coralDarkHeightCoefficient => 0.269;

  @override
  double get orangeHeightCoefficient => 0.328;

  @override
  double get orangeDarkHeightCoefficient => 0.317;

  @override
  double get yellowHeightCoefficient => 0.367;

  @override
  double get yellowDarkHeightCoefficient => 0.286;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.564;

  @override
  double get greenDarkOffsetCoefficient => 0.527;

  @override
  double get petrolOffsetCoefficient => 0.496;

  @override
  double get petrolDarkOffsetCoefficient => 0.456;

  @override
  double get coralOffsetCoefficient => 0.358;

  @override
  double get coralDarkOffsetCoefficient => 0.404;

  @override
  double get orangeOffsetCoefficient => 0.242;

  @override
  double get orangeDarkOffsetCoefficient => 0.234;

  @override
  double get yellowOffsetCoefficient => 0.14;

  @override
  double get yellowDarkOffsetCoefficient => 0.223;

  // PATH ====================================================================>
  @override
  Path green(Size size) => Path()
      ..moveTo(0, size.height * 0.47)
      ..lineTo(0, size.height * 0.54)
      ..cubicTo(size.width * 0.08, size.height * 0.4, size.width * 0.18, size.height * 0.28, size.width * 0.34, size.height * 0.32)
      ..cubicTo(size.width * 0.56, size.height * 0.36, size.width * 0.65, size.height * 0.51, size.width * 0.75, size.height * 0.68)
      ..cubicTo(size.width * 0.81, size.height * 0.78, size.width * 0.87, size.height * 0.88, size.width * 0.96, size.height * 0.97)
      ..cubicTo(size.width * 0.97, size.height * 0.98, size.width, size.height, size.width, size.height)
      ..lineTo(size.width, size.height * 0.7)
      ..cubicTo(size.width * 0.85, size.height * 0.6, size.width * 0.71, size.height * 0.42, size.width * 0.61, size.height * 0.27)
      ..cubicTo(size.width * 0.57, size.height * 0.22, size.width * 0.53, size.height * 0.17, size.width / 2, size.height * 0.13)
      ..cubicTo(size.width * 0.36, size.height * (-0.04), size.width * 0.28, size.height * (-0.01), size.width * 0.24, size.height * 0.05)
      ..cubicTo(size.width * 0.19, size.height * 0.1, size.width * 0.15, size.height * 0.19, size.width * 0.11, size.height * 0.27)
      ..cubicTo(size.width * 0.07, size.height * 0.34, size.width * 0.04, size.height * 0.42, 0, size.height * 0.47)
      ..close();

  @override
  Path greenDark(Size size) => Path()
      ..moveTo(0, size.height * 0.49)
      ..lineTo(0, size.height * 0.64)
      ..cubicTo(size.width * 0.05, size.height * 0.58, size.width * 0.1, size.height * 0.48, size.width * 0.14, size.height * 0.38)
      ..cubicTo(size.width * 0.17, size.height * 0.3, size.width / 5, size.height * 0.22, size.width * 0.24, size.height * 0.17)
      ..cubicTo(size.width * 0.28, size.height * 0.11, size.width * 0.36, size.height * 0.07, size.width / 2, size.height * 0.26)
      ..cubicTo(size.width * 0.54, size.height * 0.31, size.width * 0.59, size.height * 0.4, size.width * 0.65, size.height * 0.49)
      ..cubicTo(size.width * 0.75, size.height * 0.67, size.width * 0.87, size.height * 0.88, size.width, size.height)
      ..lineTo(size.width, size.height * 0.66)
      ..cubicTo(size.width * 0.87, size.height * 0.61, size.width * 0.75, size.height * 0.44, size.width * 0.64, size.height * 0.29)
      ..cubicTo(size.width * 0.57, size.height * 0.18, size.width * 0.49, size.height * 0.08, size.width * 0.42, size.height * 0.02)
      ..cubicTo(size.width * 0.31, size.height * (-0.07), size.width / 5, size.height * 0.14, size.width * 0.1, size.height * 0.32)
      ..cubicTo(size.width * 0.06, size.height * 0.39, size.width * 0.03, size.height * 0.45, 0, size.height * 0.49)
      ..close();

  @override
  Path petrol(Size size) => Path()
      ..moveTo(0, size.height * 0.57)
      ..lineTo(0, size.height * 0.78)
      ..cubicTo(size.width * 0.04, size.height * 0.71, size.width * 0.09, size.height * 0.61, size.width * 0.13, size.height / 2)
      ..cubicTo(size.width * 0.22, size.height * 0.28, size.width * 0.32, size.height * 0.05, size.width * 0.42, size.height * 0.16)
      ..cubicTo(size.width * 0.49, size.height * 0.23, size.width * 0.57, size.height * 0.37, size.width * 0.64, size.height * 0.51)
      ..cubicTo(size.width * 0.75, size.height * 0.71, size.width * 0.87, size.height * 0.93, size.width, size.height)
      ..lineTo(size.width, size.height * 0.81)
      ..cubicTo(size.width * 0.91, size.height * 0.7, size.width * 0.82, size.height * 0.53, size.width * 0.75, size.height * 0.38)
      ..cubicTo(size.width * 0.71, size.height * 0.29, size.width * 0.67, size.height * 0.22, size.width * 0.64, size.height * 0.16)
      ..cubicTo(size.width / 2, size.height * (-0.09), size.width / 3, size.height * (-0.01), size.width * 0.19, size.height / 5)
      ..cubicTo(size.width * 0.12, size.height * 0.29, size.width * 0.08, size.height * 0.39, size.width * 0.04, size.height * 0.47)
      ..cubicTo(size.width * 0.03, size.height * 0.48, size.width * 0.02, size.height * 0.52, 0, size.height * 0.57)
      ..close();

  @override
  Path petrolDark(Size size) => Path()
      ..moveTo(0, size.height * 0.47)
      ..lineTo(0, size.height * 0.75)
      ..cubicTo(size.width * 0.05, size.height * 0.61, size.width * 0.11, size.height / 2, size.width * 0.19, size.height * 0.41)
      ..cubicTo(size.width / 5, size.height * 0.4, size.width / 5, size.height * 0.39, size.width * 0.22, size.height * 0.38)
      ..cubicTo(size.width * 0.36, size.height * 0.24, size.width * 0.51, size.height * 0.08, size.width * 0.64, size.height * 0.33)
      ..cubicTo(size.width * 0.67, size.height * 0.39, size.width * 0.71, size.height * 0.48, size.width * 0.75, size.height * 0.56)
      ..cubicTo(size.width * 0.82, size.height * 0.71, size.width * 0.91, size.height * 0.89, size.width, size.height)
      ..lineTo(size.width, size.height * 0.89)
      ..cubicTo(size.width * 0.92, size.height * 0.79, size.width * 0.86, size.height * 0.63, size.width * 0.8, size.height * 0.48)
      ..cubicTo(size.width * 0.73, size.height * 0.31, size.width * 0.66, size.height * 0.16, size.width * 0.58, size.height * 0.08)
      ..cubicTo(size.width * 0.37, size.height * (-0.15), size.width * 0.15, size.height * 0.19, 0, size.height * 0.47)
      ..close();

  @override
  Path coral(Size size) => Path()
      ..moveTo(0, size.height * 0.41)
      ..lineTo(0, size.height * 0.56)
      ..cubicTo(size.width * 0.01, size.height * 0.55, size.width * 0.02, size.height * 0.52, size.width * 0.04, size.height * 0.48)
      ..cubicTo(size.width * 0.11, size.height * 0.36, size.width / 4, size.height * 0.12, size.width * 0.38, size.height * 0.17)
      ..cubicTo(size.width * 0.61, size.height * 0.26, size.width * 0.65, size.height * 0.32, size.width * 0.78, size.height * 0.63)
      ..cubicTo(size.width * 0.85, size.height * 0.77, size.width * 0.92, size.height * 0.91, size.width, size.height)
      ..lineTo(size.width, size.height * 0.75)
      ..cubicTo(size.width * 0.9, size.height * 0.66, size.width * 0.8, size.height * 0.51, size.width * 0.71, size.height * 0.36)
      ..cubicTo(size.width * 0.63, size.height * 0.23, size.width * 0.55, size.height * 0.11, size.width * 0.48, size.height * 0.04)
      ..cubicTo(size.width / 3, size.height * (-0.1), size.width * 0.15, size.height * 0.16, 0, size.height * 0.41)
      ..close();

  @override
  Path coralDark(Size size) => Path()
      ..moveTo(0, size.height * 0.41)
      ..lineTo(0, size.height * 0.62)
      ..cubicTo(size.width * 0.15, size.height * 0.37, size.width * 0.45, size.height * 0.18, size.width * 0.61, size.height * 0.32)
      ..cubicTo(size.width * 0.68, size.height * 0.39, size.width * 0.74, size.height * 0.52, size.width * 0.81, size.height * 0.66)
      ..cubicTo(size.width * 0.86, size.height * 0.79, size.width * 0.92, size.height * 0.92, size.width, size.height)
      ..lineTo(size.width, size.height * 0.88)
      ..cubicTo(size.width * 0.92, size.height * 0.78, size.width * 0.85, size.height * 0.64, size.width * 0.78, size.height * 0.49)
      ..cubicTo(size.width * 0.65, size.height * 0.17, size.width * 0.61, size.height * 0.09, size.width * 0.38, 0)
      ..cubicTo(size.width / 4, size.height * (-0.04), size.width * 0.11, size.height / 5, size.width * 0.04, size.height * 0.33)
      ..cubicTo(size.width * 0.02, size.height * 0.37, size.width * 0.01, size.height * 0.40, 0, size.height * 0.41)
      ..close();

  @override
  Path orange(Size size) => Path()
      ..moveTo(0, size.height * 0.39)
      ..lineTo(0, size.height * 0.71)
      ..cubicTo(size.width * 0.15, size.height * 0.49, size.width / 3, size.height * 0.27, size.width * 0.48, size.height * 0.39)
      ..cubicTo(size.width * 0.55, size.height * 0.45, size.width * 0.63, size.height * 0.56, size.width * 0.71, size.height * 0.67)
      ..cubicTo(size.width * 0.8, size.height * 0.8, size.width * 0.9, size.height * 0.94, size.width, size.height * 1.01)
      ..lineTo(size.width, size.height * 0.81)
      ..cubicTo(size.width * 0.9, size.height * 0.72, size.width * 0.82, size.height * 0.55, size.width * 0.74, size.height * 0.4)
      ..cubicTo(size.width * 0.61, size.height * 0.13, size.width * 0.47, size.height * (-0.16), size.width * 0.26, size.height * 0.11)
      ..cubicTo(size.width * 0.1, size.height / 3, size.width * 0.02, size.height * 0.39, 0, size.height * 0.39)
      ..close();

  @override
  Path orangeDark(Size size) => Path()
      ..moveTo(0, size.height * 0.43)
      ..lineTo(0, size.height * 0.63)
      ..cubicTo(size.width * 0.02, size.height * 0.6, size.width * 0.04, size.height * 0.57, size.width * 0.06, size.height * 0.54)
      ..cubicTo(size.width * 0.19, size.height / 3, size.width * 0.35, size.height * 0.1, size.width * 0.49, size.height / 5)
      ..cubicTo(size.width * 0.56, size.height * 0.27, size.width * 0.64, size.height * 0.42, size.width * 0.73, size.height * 0.58)
      ..cubicTo(size.width * 0.82, size.height * 0.73, size.width * 0.9, size.height * 0.9, size.width, size.height)
      ..lineTo(size.width, size.height * 0.85)
      ..cubicTo(size.width * 0.9, size.height * 0.75, size.width * 0.81, size.height * 0.59, size.width * 0.74, size.height * 0.42)
      ..cubicTo(size.width * 0.73, size.height * 0.39, size.width * 0.71, size.height * 0.36, size.width * 0.7, size.height * 0.33)
      ..cubicTo(size.width * 0.59, size.height * 0.1, size.width * 0.49, size.height * (-0.11), size.width * 0.29, size.height * 0.07)
      ..cubicTo(size.width * 0.19, size.height * 0.16, size.width * 0.15, size.height * 0.23, size.width * 0.11, size.height * 0.29)
      ..cubicTo(size.width * 0.08, size.height / 3, size.width * 0.05, size.height * 0.37, 0, size.height * 0.43)
      ..close();

  @override
  Path yellow(Size size) => Path()
      ..moveTo(0, size.height * 0.37)
      ..lineTo(0, size.height * 0.62)
      ..cubicTo(size.width * 0.03, size.height * 0.59, size.width * 0.06, size.height * 0.58, size.width * 0.08, size.height * 0.56)
      ..cubicTo(size.width * 0.12, size.height * 0.53, size.width * 0.16, size.height * 0.51, size.width * 0.26, size.height * 0.38)
      ..cubicTo(size.width * 0.47, size.height * 0.13, size.width * 0.61, size.height * 0.4, size.width * 0.74, size.height * 0.63)
      ..cubicTo(size.width * 0.82, size.height * 0.76, size.width * 0.9, size.height * 0.91, size.width, size.height)
      ..lineTo(size.width, size.height * 0.76)
      ..cubicTo(size.width * 0.93, size.height * 0.68, size.width * 0.88, size.height * 0.54, size.width * 0.82, size.height * 0.41)
      ..cubicTo(size.width * 0.76, size.height / 4, size.width * 0.7, size.height * 0.1, size.width * 0.63, size.height * 0.05)
      ..cubicTo(size.width * 0.41, size.height * (-0.1), size.width * 0.19, size.height * 0.15, 0, size.height * 0.37)
      ..close();

  @override
  Path yellowDark(Size size) => Path()
      ..moveTo(0, size.height * 0.42)
      ..lineTo(0, size.height * 0.52)
      ..cubicTo(size.width * 0.05, size.height * 0.46, size.width * 0.07, size.height * 0.43, size.width * 0.12, size.height * 0.37)
      ..cubicTo(size.width * 0.15, size.height / 3, size.width * 0.19, size.height * 0.28, size.width * 0.26, size.height / 5)
      ..cubicTo(size.width * 0.49, size.height * (-0.06), size.width * 0.61, size.height * 0.26, size.width * 0.74, size.height * 0.52)
      ..cubicTo(size.width * 0.82, size.height * 0.7, size.width * 0.9, size.height * 0.88, size.width, size.height)
      ..lineTo(size.width, size.height * 0.86)
      ..cubicTo(size.width * 0.91, size.height * 0.77, size.width * 0.82, size.height * 0.59, size.width * 0.73, size.height * 0.41)
      ..cubicTo(size.width * 0.66, size.height / 4, size.width * 0.58, size.height * 0.1, size.width * 0.51, size.height * 0.04)
      ..cubicTo(size.width * 0.36, size.height * (-0.1), size.width * 0.15, size.height * 0.18, 0, size.height * 0.42)
      ..close();
}
