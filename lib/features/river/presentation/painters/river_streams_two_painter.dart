import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class FunctionCoefficientsTwo extends FunctionCoefficientsValues {
  const FunctionCoefficientsTwo();

  @override
  List<double> get green => [-0.06, -0.5, 0.55, 0.28];

  @override
  List<double> get blue => [-0.065, -0.54, 0.6, 0.36];

  @override
  List<double> get red => [-0.07, -0.58, 0.62, 0.44];

  @override
  List<double> get orange => [-0.08, -0.58, 0.63, 0.53];

  @override
  List<double> get yellow => [-0.08, -0.63, 0.63, 0.61];
}

class ItemsPositionsTwo extends ItemsPositionValues {
  const ItemsPositionsTwo();

  @override
  List<double> get green => [0.1, 0.68, 0.48];

  @override
  List<double> get blue => [0.28, 0.92, 0.6];

  @override
  List<double> get red => [0.79, 0.14, 0.98];

  @override
  List<double> get orange => [0.64, 0.16, 0.91];

  @override
  List<double> get yellow => [0.3, 0.77];
}

class RiverStreamsTwoPainter extends RenderRiverStreamPainter {
  const RiverStreamsTwoPainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.168;

  @override
  double get greenDarkHeightCoefficient => 0.169;

  @override
  double get petrolHeightCoefficient => 0.165;

  @override
  double get petrolDarkHeightCoefficient => 0.201;

  @override
  double get coralHeightCoefficient => 0.2;

  @override
  double get coralDarkHeightCoefficient => 0.195;

  @override
  double get orangeHeightCoefficient => 0.221;

  @override
  double get orangeDarkHeightCoefficient => 0.208;

  @override
  double get yellowHeightCoefficient => 0.242;

  @override
  double get yellowDarkHeightCoefficient => 0.179;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.66;

  @override
  double get greenDarkOffsetCoefficient => 0.634;

  @override
  double get petrolOffsetCoefficient => 0.584;

  @override
  double get petrolDarkOffsetCoefficient => 0.534;

  @override
  double get coralOffsetCoefficient => 0.472;

  @override
  double get coralDarkOffsetCoefficient => 0.503;

  @override
  double get orangeOffsetCoefficient => 0.373;

  @override
  double get orangeDarkOffsetCoefficient => 0.372;

  @override
  double get yellowOffsetCoefficient => 0.298;

  @override
  double get yellowDarkOffsetCoefficient => 0.361;

  // PATH ====================================================================>

  @override
  Path green(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.95)
      ..lineTo(0, size.height * 0.7)
      ..cubicTo(size.width * 0.17, size.height * 0.9, size.width * 0.34, size.height * 0.92, size.width * 0.49, size.height * 0.52)
      ..cubicTo(size.width * 0.77, size.height * (-0.18), size.width * 0.84, size.height * (-0.01), size.width * 0.96, size.height / 4)
      ..cubicTo(size.width * 0.97, size.height * 0.28, size.width, size.height * 0.31, size.width, size.height * 0.34)
      ..lineTo(size.width, size.height * 0.71)
      ..cubicTo(size.width * 0.89, size.height * 0.45, size.width * 0.81, size.height * 0.24, size.width * 0.74, size.height * 0.24)
      ..cubicTo(size.width * 0.66, size.height * 0.24, size.width * 0.61, size.height * 0.37, size.width * 0.54, size.height * 0.53)
      ..cubicTo(size.width * 0.44, size.height * 0.77, size.width * 0.32, size.height * 1.06, size.width * 0.07, size.height * 0.99)
      ..cubicTo(size.width * 0.05, size.height * 0.98, size.width * 0.02, size.height * 0.96, 0, size.height * 0.95)
      ..lineTo(0, size.height * 0.95);
  }

  @override
  Path greenDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.86)
      ..lineTo(0, size.height * 0.63)
      ..cubicTo(size.width * 0.02, size.height * 0.65, size.width * 0.04, size.height * 0.67, size.width * 0.06, size.height * 0.68)
      ..cubicTo(size.width * 0.31, size.height * 0.74, size.width * 0.45, size.height * 0.48, size.width * 0.56, size.height * 0.26)
      ..cubicTo(size.width * 0.63, size.height * 0.12, size.width * 0.69, 0, size.width * 0.77, 0)
      ..cubicTo(size.width * 0.82, 0, size.width * 0.9, size.height * 0.12, size.width, size.height * 0.26)
      ..lineTo(size.width, size.height * 0.48)
      ..cubicTo(size.width, size.height * 0.48, size.width * 0.97, size.height * 0.43, size.width * 0.96, size.height * 0.42)
      ..cubicTo(size.width * 0.84, size.height * 0.2, size.width * 0.77, size.height * 0.08, size.width * 0.49, size.height * 0.68)
      ..cubicTo(size.width * 0.34, size.height * 1.09, size.width * 0.17, size.height * 1.06, 0, size.height * 0.86)
      ..lineTo(0, size.height * 0.86);
  }

  @override
  Path petrol(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.97)
      ..lineTo(0, size.height * 0.69)
      ..cubicTo(size.width * 0.14, size.height * 0.96, size.width * 0.29, size.height * 1.05, size.width * 0.46, size.height * 0.6)
      ..cubicTo(size.width * 0.72, size.height * (-0.15), size.width * 0.86, size.height * (-0.1), size.width, size.height * 0.18)
      ..lineTo(size.width, size.height * 0.58)
      ..cubicTo(size.width * 0.9, size.height * 0.43, size.width * 0.82, size.height * 0.31, size.width * 0.77, size.height * 0.31)
      ..cubicTo(size.width * 0.69, size.height * 0.31, size.width * 0.63, size.height * 0.43, size.width * 0.56, size.height * 0.58)
      ..cubicTo(size.width * 0.45, size.height * 0.8, size.width * 0.31, size.height * 1.06, size.width * 0.06, size.height)
      ..cubicTo(size.width * 0.04, size.height, size.width * 0.02, size.height, 0, size.height * 0.97)
      ..lineTo(0, size.height * 0.97);
  }

  @override
  Path petrolDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.82)
      ..lineTo(0, size.height * 0.69)
      ..cubicTo(size.width * 0.04, size.height * 0.75, size.width * 0.09, size.height * 0.8, size.width * 0.15, size.height * 0.81)
      ..cubicTo(size.width * 0.4, size.height * 0.86, size.width * 0.53, size.height * 0.55, size.width * 0.63, size.height * 0.3)
      ..cubicTo(size.width * 0.7, size.height * 0.14, size.width * 0.76, 0, size.width * 0.84, 0)
      ..cubicTo(size.width * 0.88, 0, size.width * 0.94, size.height * 0.07, size.width, size.height * 0.17)
      ..lineTo(size.width, size.height * 0.4)
      ..cubicTo(size.width * 0.86, size.height * 0.19, size.width * 0.73, size.height * 0.12, size.width * 0.46, size.height * 0.74)
      ..cubicTo(size.width * 0.29, size.height * 1.11, size.width * 0.14, size.height * 1.04, 0, size.height * 0.82)
      ..lineTo(0, size.height * 0.82);
  }

  @override
  Path coral(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.85)
      ..lineTo(0, size.height * 0.49)
      ..cubicTo(size.width * 0.05, size.height * 0.55, size.width * 0.1, size.height * 0.6, size.width * 0.15, size.height * 0.61)
      ..cubicTo(size.width * 0.4, size.height * 0.66, size.width * 0.55, size.height * 0.42, size.width * 0.67, size.height * 0.23)
      ..cubicTo(size.width * 0.75, size.height * 0.11, size.width * 0.82, 0, size.width * 0.89, 0)
      ..cubicTo(size.width * 0.92, 0, size.width * 0.96, size.height * 0.03, size.width, size.height * 0.08)
      ..lineTo(size.width, size.height * 0.27)
      ..cubicTo(size.width * 0.89, size.height * 0.1, size.width * 0.78, size.height * 0.06, size.width * 0.54, size.height * 0.61)
      ..cubicTo(size.width / 3, size.height * 1.1, size.width * 0.15, size.height * 1.08, 0, size.height * 0.85)
      ..lineTo(0, size.height * 0.85);
  }

  @override
  Path coralDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.87)
      ..lineTo(0, size.height * 0.71)
      ..cubicTo(size.width * 0.15, size.height * 0.95, size.width / 3, size.height * 0.97, size.width * 0.54, size.height * 0.46)
      ..cubicTo(size.width * 0.78, size.height * (-0.09), size.width * 0.89, size.height * (-0.06), size.width, size.height * 0.115)
      ..lineTo(size.width, size.height * 0.34)
      ..cubicTo(size.width * 0.94, size.height * 0.23, size.width * 0.88, size.height * 0.16, size.width * 0.84, size.height * 0.16)
      ..cubicTo(size.width * 0.76, size.height * 0.16, size.width * 0.7, size.height * 0.3, size.width * 0.63, size.height * 0.47)
      ..cubicTo(size.width * 0.53, size.height * 0.73, size.width * 0.4, size.height * 1.05, size.width * 0.15, size.height)
      ..cubicTo(size.width * 0.09, size.height * 0.98, size.width * 0.04, size.height * 0.94, 0, size.height * 0.87)
      ..lineTo(0, size.height * 0.87);
  }

  @override
  Path orange(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.9)
      ..lineTo(0, size.height * 0.62)
      ..cubicTo(size.width * 0.13, size.height * 0.81, size.width * 0.28, size.height * 0.84, size.width * 0.47, size.height * 0.45)
      ..cubicTo(size.width * 0.69, size.height * 0.01, size.width * 0.86, size.height * (-0.05), size.width, size.height * 0.05)
      ..lineTo(size.width, size.height * 0.52)
      ..cubicTo(size.width * 0.96, size.height * 0.48, size.width * 0.92, size.height * 0.45, size.width * 0.89, size.height * 0.45)
      ..cubicTo(size.width * 0.82, size.height * 0.45, size.width * 0.75, size.height * 0.55, size.width * 0.67, size.height * 0.66)
      ..cubicTo(size.width * 0.55, size.height * 0.83, size.width * 0.4, size.height * 1.05, size.width * 0.15, size.height)
      ..cubicTo(size.width * 0.1, size.height, size.width * 0.05, size.height * 0.95, 0, size.height * 0.9)
      ..lineTo(0, size.height * 0.9);
  }

  @override
  Path orangeDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.86)
      ..lineTo(0, size.height * 0.65)
      ..cubicTo(size.width * 0.13, size.height * 0.86, size.width * 0.28, size.height * 0.9, size.width * 0.47, size.height * 0.48)
      ..cubicTo(size.width * 0.69, size.height * 0.01, size.width * 0.86, size.height * (-0.06), size.width, size.height * 0.05)
      ..lineTo(size.width, size.height * 0.25)
      ..cubicTo(size.width * 0.95, size.height * 0.19, size.width * 0.91, size.height * 0.15, size.width * 0.88, size.height * 0.15)
      ..cubicTo(size.width * 0.81, size.height * 0.15, size.width * 0.74, size.height * 0.3, size.width * 0.66, size.height * 0.47)
      ..cubicTo(size.width * 0.55, size.height * 0.73, size.width * 0.4, size.height * 1.05, size.width * 0.15, size.height)
      ..cubicTo(size.width * 0.1, size.height, size.width * 0.05, size.height * 0.94, 0, size.height * 0.86)
      ..lineTo(0, size.height * 0.86);
  }

  @override
  Path yellow(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.87)
      ..lineTo(0, size.height * 0.57)
      ..cubicTo(size.width * 0.02, size.height * 0.59, size.width * 0.05, size.height * 0.61, size.width * 0.08, size.height * 0.61)
      ..cubicTo(size.width / 3, size.height * 0.65, size.width * 0.51, size.height * 0.42, size.width * 0.66, size.height * 0.23)
      ..cubicTo(size.width * 0.75, size.height * 0.1, size.width * 0.83, 0, size.width * 0.91, 0)
      ..cubicTo(size.width * 0.93, 0, size.width * 0.97, size.height * 0.03, size.width, size.height * 0.07)
      ..lineTo(size.width, size.height * 0.35)
      ..cubicTo(size.width * 0.86, size.height * 0.26, size.width * 0.69, size.height * 0.32, size.width * 0.47, size.height * 0.72)
      ..cubicTo(size.width * 0.28, size.height * 1.08, size.width * 0.13, size.height * 1.05, 0, size.height * 0.87)
      ..lineTo(0, size.height * 0.87);
  }

  @override
  Path yellowDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.83)
      ..lineTo(0, size.height * 0.55)
      ..cubicTo(size.width * 0.05, size.height * 0.63, size.width * 0.1, size.height * 0.69, size.width * 0.15, size.height * 0.7)
      ..cubicTo(size.width * 0.4, size.height * 0.76, size.width * 0.52, size.height * 0.49, size.width * 0.61, size.height * 0.27)
      ..cubicTo(size.width * 0.68, size.height * 0.13, size.width * 0.73, size.height * 0.02, size.width * 0.81, size.height * 0.01)
      ..cubicTo(size.width * 0.88, 0, size.width * 0.94, size.height * 0.03, size.width, size.height * 0.07)
      ..lineTo(size.width, size.height * 0.13)
      ..cubicTo(size.width * 0.86, 0, size.width * 0.69, size.height * 0.09, size.width * 0.47, size.height * 0.63)
      ..cubicTo(size.width * 0.28, size.height * 1.12, size.width * 0.13, size.height * 1.08, 0, size.height * 0.83)
      ..lineTo(0, size.height * 0.83);
  }
}
