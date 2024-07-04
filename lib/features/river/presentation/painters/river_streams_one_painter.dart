import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class FunctionCoefficientsOne extends FunctionCoefficientsValues {
  const FunctionCoefficientsOne();

  @override
  List<double> get green => [-0.11, 0.7, 0.66, 0.33];

  @override
  List<double> get blue => [-0.08, -0.72, 0.14, 0.43];

  @override
  List<double> get red => [-0.08, -0.72, 0.09, 0.53];

  @override
  List<double> get orange => [-0.1, -0.71, 0.11, 0.63];

  @override
  List<double> get yellow => [-0.11, -0.675, 0.19, 0.73];
}

class ItemsPositionsOne extends ItemsPositionValues {
  const ItemsPositionsOne();

  @override
  List<double> get green => [0.79, 0.19, 0.46];

  @override
  List<double> get blue => [0.68, 0.29];

  @override
  List<double> get red => [0.9, 0.14];

  @override
  List<double> get orange => [0.76, 0.31];

  @override
  List<double> get yellow => [0.42, 0.1, 0.68];
}

class RiverStreamsOnePainter extends RenderRiverStreamPainter {
  const RiverStreamsOnePainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.258;

  @override
  double get greenDarkHeightCoefficient => 0.252;

  @override
  double get petrolHeightCoefficient => 0.241;

  @override
  double get petrolDarkHeightCoefficient => 0.223;

  @override
  double get coralHeightCoefficient => 0.283;

  @override
  double get coralDarkHeightCoefficient => 0.269;

  @override
  double get orangeHeightCoefficient => 0.328;

  @override
  double get orangeDarkHeightCoefficient => 0.309;

  @override
  double get yellowHeightCoefficient => 0.348;

  @override
  double get yellowDarkHeightCoefficient => 0.286;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.561;

  @override
  double get greenDarkOffsetCoefficient => 0.527;

  @override
  double get petrolOffsetCoefficient => 0.502;

  @override
  double get petrolDarkOffsetCoefficient => 0.476;

  @override
  double get coralOffsetCoefficient => 0.358;

  @override
  double get coralDarkOffsetCoefficient => 0.404;

  @override
  double get orangeOffsetCoefficient => 0.242;

  @override
  double get orangeDarkOffsetCoefficient => 0.241;

  @override
  double get yellowOffsetCoefficient => 0.16;

  @override
  double get yellowDarkOffsetCoefficient => 0.223;

  // PATH ====================================================================>
  @override
  Path green(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.67)
      ..lineTo(0, size.height * 0.77)
      ..cubicTo(size.width * 0.02, size.height * 0.75, size.width * 0.04, size.height * 0.69, size.width * 0.06, size.height * 0.62)
      ..cubicTo(size.width * 0.12, size.height * 0.43, size.width * 0.22, size.height * 0.15, size.width / 3, size.height * 0.26)
      ..cubicTo(size.width * 0.39, size.height * 0.32, size.width * 0.46, size.height * 0.42, size.width * 0.54, size.height * 0.53)
      ..cubicTo(size.width * 0.68, size.height * 0.72, size.width * 0.85, size.height * 0.94, size.width, size.height)
      ..lineTo(size.width, size.height * 0.84)
      ..cubicTo(size.width * 0.8, size.height * 0.7, size.width * 0.62, size.height * 0.4, size.width / 2, size.height / 5)
      ..cubicTo(size.width * 0.36, size.height * (-0.04), size.width * 0.28, size.height * (-0.01), size.width * 0.23, size.height * 0.06)
      ..cubicTo(size.width * 0.19, size.height * 0.15, size.width * 0.15, size.height * 0.27, size.width * 0.11, size.height * 0.38)
      ..cubicTo(size.width * 0.07, size.height * 0.49, size.width * 0.04, size.height * 0.6, 0, size.height * 0.67)
      ..lineTo(0, size.height * 0.67);
  }

  @override
  Path greenDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.64)
      ..lineTo(0, size.height * 0.82)
      ..cubicTo(size.width * 0.05, size.height * 0.75, size.width * 0.1, size.height * 0.62, size.width * 0.14, size.height * 0.49)
      ..cubicTo(size.width * 0.17, size.height * 0.39, size.width / 5, size.height * 0.29, size.width * 0.24, size.height * 0.22)
      ..cubicTo(size.width * 0.28, size.height * 0.14, size.width * 0.36, size.height * 0.09, size.width / 2, size.height * 0.34)
      ..cubicTo(size.width * 0.62, size.height * 0.54, size.width * 0.8, size.height * 0.85, size.width, size.height)
      ..lineTo(size.width, size.height * 0.85)
      ..cubicTo(size.width * 0.87, size.height * 0.79, size.width * 0.75, size.height * 0.58, size.width * 0.64, size.height * 0.38)
      ..cubicTo(size.width * 0.57, size.height * 0.24, size.width * 0.49, size.height * 0.11, size.width * 0.42, size.height * 0.03)
      ..cubicTo(size.width * 0.31, size.height * (-0.08), size.width / 5, size.height * 0.19, size.width * 0.1, size.height * 0.42)
      ..cubicTo(size.width * 0.06, size.height * 0.51, size.width * 0.03, size.height * 0.59, 0, size.height * 0.64)
      ..lineTo(0, size.height * 0.64);
  }

  @override
  Path petrol(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.56)
      ..lineTo(0, size.height * 0.78)
      ..cubicTo(size.width * 0.04, size.height * 0.71, size.width * 0.09, size.height * 0.6, size.width * 0.13, size.height * 0.49)
      ..cubicTo(size.width * 0.22, size.height * 0.27, size.width * 0.32, size.height * 0.03, size.width * 0.42, size.height * 0.14)
      ..cubicTo(size.width * 0.49, size.height * 0.22, size.width * 0.57, size.height * 0.36, size.width * 0.64, size.height / 2)
      ..cubicTo(size.width * 0.75, size.height * 0.71, size.width * 0.87, size.height * 0.93, size.width, size.height)
      ..lineTo(size.width, size.height * 0.81)
      ..cubicTo(size.width * 0.91, size.height * 0.69, size.width * 0.82, size.height * 0.52, size.width * 0.75, size.height * 0.36)
      ..cubicTo(size.width * 0.71, size.height * 0.28, size.width * 0.67, size.height / 5, size.width * 0.64, size.height * 0.14)
      ..cubicTo(size.width / 2, size.height * (-0.11), size.width / 3, size.height * 0.05, size.width * 0.18, size.height / 5)
      ..cubicTo(size.width * 0.12, size.height * 0.27, size.width * 0.04, size.height * 0.42, 0, size.height * 0.56)
      ..lineTo(0, size.height * 0.56);
  }

  @override
  Path petrolDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.43)
      ..lineTo(0, size.height * 0.73)
      ..cubicTo(size.width * 0.02, size.height * 0.69, size.width * 0.03, size.height * 0.65, size.width * 0.04, size.height * 0.61)
      ..cubicTo(size.width * 0.08, size.height * 0.51, size.width * 0.12, size.height * 0.4, size.width * 0.18, size.height * 0.35)
      ..cubicTo(size.width / 3, size.height * 0.18, size.width / 2, size.height * (-0.01), size.width * 0.64, size.height * 0.27)
      ..cubicTo(size.width * 0.67, size.height / 3, size.width * 0.71, size.height * 0.42, size.width * 0.75, size.height * 0.51)
      ..cubicTo(size.width * 0.82, size.height * 0.68, size.width * 0.91, size.height * 0.87, size.width, size.height)
      ..lineTo(size.width, size.height * 0.88)
      ..cubicTo(size.width * 0.92, size.height * 0.78, size.width * 0.86, size.height * 0.62, size.width * 0.81, size.height * 0.48)
      ..cubicTo(size.width * 0.74, size.height * 0.3, size.width * 0.68, size.height * 0.14, size.width * 0.61, size.height * 0.06)
      ..cubicTo(size.width * 0.45, size.height * (-0.11), size.width * 0.15, size.height * 0.12, 0, size.height * 0.43)
      ..lineTo(0, size.height * 0.43);
  }

  @override
  Path coral(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.41)
      ..lineTo(0, size.height * 0.55)
      ..cubicTo(size.width * 0.01, size.height * 0.55, size.width * 0.02, size.height * 0.53, size.width * 0.04, size.height * 0.49)
      ..cubicTo(size.width * 0.11, size.height * 0.37, size.width / 4, size.height * 0.12, size.width * 0.38, size.height * 0.17)
      ..cubicTo(size.width * 0.61, size.height * 0.26, size.width * 0.65, size.height / 3, size.width * 0.78, size.height * 0.63)
      ..cubicTo(size.width * 0.85, size.height * 0.78, size.width * 0.92, size.height * 0.91, size.width, size.height)
      ..lineTo(size.width, size.height * 0.75)
      ..cubicTo(size.width * 0.9, size.height * 0.65, size.width * 0.8, size.height * 0.5, size.width * 0.71, size.height * 0.35)
      ..cubicTo(size.width * 0.63, size.height * 0.22, size.width * 0.55, size.height * 0.1, size.width * 0.48, size.height * 0.04)
      ..cubicTo(size.width / 3, size.height * (-0.1), size.width * 0.15, size.height * 0.16, 0, size.height * 0.41)
      ..lineTo(0, size.height * 0.41);
  }

  @override
  Path coralDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height * 0.63)
      ..cubicTo(size.width * 0.15, size.height * 0.37, size.width * 0.45, size.height * 0.18, size.width * 0.61, size.height * 0.34)
      ..cubicTo(size.width * 0.68, size.height * 0.41, size.width * 0.74, size.height * 0.55, size.width * 0.81, size.height * 0.69)
      ..cubicTo(size.width * 0.86, size.height * 0.79, size.width * 0.92, size.height * 0.92, size.width, size.height)
      ..lineTo(size.width, size.height * 0.88)
      ..cubicTo(size.width * 0.92, size.height * 0.79, size.width * 0.85, size.height * 0.64, size.width * 0.78, size.height * 0.49)
      ..cubicTo(size.width * 0.65, size.height * 0.17, size.width * 0.61, size.height * 0.08, size.width * 0.38, 0)
      ..cubicTo(size.width / 4, size.height * (-0.04), size.width * 0.11, size.height / 5, size.width * 0.04, size.height * 0.34)
      ..cubicTo(size.width * 0.02, size.height * 0.38, size.width * 0.01, size.height * 0.39, 0, size.height * 0.41)
      ..lineTo(0, size.height * 0.4);
  }

  @override
  Path orange(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.39)
      ..lineTo(0, size.height * 0.71)
      ..cubicTo(size.width * 0.15, size.height * 0.49, size.width / 3, size.height * 0.27, size.width * 0.48, size.height * 0.39)
      ..cubicTo(size.width * 0.55, size.height * 0.44, size.width * 0.63, size.height * 0.55, size.width * 0.71, size.height * 0.66)
      ..cubicTo(size.width * 0.8, size.height * 0.79, size.width * 0.9, size.height * 0.92, size.width, size.height)
      ..lineTo(size.width, size.height * 0.81)
      ..cubicTo(size.width * 0.9, size.height * 0.71, size.width * 0.82, size.height * 0.54, size.width * 0.74, size.height * 0.39)
      ..cubicTo(size.width * 0.74, size.height * 0.39, size.width * 0.74, size.height * 0.39, size.width * 0.74, size.height * 0.39)
      ..cubicTo(size.width * 0.61, size.height * 0.13, size.width * 0.47, size.height * (-0.16), size.width * 0.26, size.height * 0.11)
      ..cubicTo(size.width * 0.1, size.height / 3, size.width * 0.02, size.height * 0.39, 0, size.height * 0.39)
      ..lineTo(0, size.height * 0.39);
  }

  @override
  Path orangeDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.42)
      ..lineTo(0, size.height * 0.62)
      ..cubicTo(size.width * 0.02, size.height * 0.59, size.width * 0.04, size.height * 0.56, size.width * 0.06, size.height * 0.53)
      ..cubicTo(size.width * 0.19, size.height * 0.32, size.width * 0.35, size.height * 0.07, size.width * 0.49, size.height * 0.18)
      ..cubicTo(size.width * 0.56, size.height / 4, size.width * 0.64, size.height * 0.4, size.width * 0.73, size.height * 0.57)
      ..cubicTo(size.width * 0.82, size.height * 0.73, size.width * 0.9, size.height * 0.9, size.width, size.height)
      ..lineTo(size.width, size.height * 0.86)
      ..cubicTo(size.width * 0.9, size.height * 0.76, size.width * 0.82, size.height * 0.58, size.width * 0.74, size.height * 0.41)
      ..cubicTo(size.width * 0.74, size.height * 0.41, size.width * 0.74, size.height * 0.41, size.width * 0.74, size.height * 0.41)
      ..cubicTo(size.width * 0.61, size.height * 0.13, size.width * 0.47, size.height * (-0.17), size.width * 0.26, size.height * 0.12)
      ..cubicTo(size.width * 0.1, size.height * 0.36, size.width * 0.02, size.height * 0.41, 0, size.height * 0.42)
      ..lineTo(0, size.height * 0.42);
  }

  @override
  Path yellow(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.34)
      ..lineTo(0, size.height * 0.6)
      ..cubicTo(size.width * 0.02, size.height * 0.6, size.width * 0.1, size.height * 0.55, size.width * 0.26, size.height * 0.34)
      ..cubicTo(size.width * 0.47, size.height * 0.08, size.width * 0.61, size.height * 0.35, size.width * 0.74, size.height * 0.6)
      ..cubicTo(size.width * 0.74, size.height * 0.6, size.width * 0.74, size.height * 0.6, size.width * 0.74, size.height * 0.6)
      ..cubicTo(size.width * 0.82, size.height * 0.75, size.width * 0.9, size.height * 0.91, size.width, size.height)
      ..lineTo(size.width, size.height * 0.79)
      ..cubicTo(size.width * 0.91, size.height * 0.73, size.width * 0.86, size.height * 0.56, size.width * 0.82, size.height * 0.4)
      ..cubicTo(size.width * 0.78, size.height / 4, size.width * 0.74, size.height * 0.09, size.width * 0.65, size.height * 0.03)
      ..cubicTo(size.width * 0.51, size.height * (-0.07), size.width * 0.24, size.height * 0.14, size.width * 0.05, size.height * 0.3)
      ..cubicTo(size.width * 0.03, size.height * 0.31, size.width * 0.02, size.height / 3, 0, size.height * 0.34)
      ..lineTo(0, size.height * 0.34);
  }

  @override
  Path yellowDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.43)
      ..lineTo(0, size.height * 0.52)
      ..cubicTo(size.width * 0.02, size.height * 0.52, size.width * 0.1, size.height * 0.46, size.width * 0.26, size.height / 5)
      ..cubicTo(size.width * 0.47, -0.11, size.width * 0.61, size.height * 0.22, size.width * 0.74, size.height * 0.52)
      ..cubicTo(size.width * 0.74, size.height * 0.52, size.width * 0.74, size.height * 0.52, size.width * 0.74, size.height * 0.52)
      ..cubicTo(size.width * 0.82, size.height * 0.7, size.width * 0.9, size.height * 0.89, size.width, size.height)
      ..lineTo(size.width, size.height * 0.83)
      ..cubicTo(size.width * 0.91, size.height * 0.73, size.width * 0.82, size.height * 0.57, size.width * 0.74, size.height * 0.41)
      ..cubicTo(size.width * 0.66, size.height * 0.26, size.width * 0.59, size.height * 0.11, size.width * 0.51, size.height * 0.04)
      ..cubicTo(size.width * 0.36, size.height * (-0.09), size.width * 0.15, size.height * 0.19, 0, size.height * 0.43)
      ..lineTo(0, size.height * 0.43);
  }
}
