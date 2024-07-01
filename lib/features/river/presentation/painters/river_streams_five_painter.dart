import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class FunctionCoefficientsFive extends FunctionCoefficientsValues {
  const FunctionCoefficientsFive();

  @override
  List<double> get green => [-0.03, -0.57, 0.42, 0.27];

  @override
  List<double> get blue => [-0.03, -0.47, 0.47, 0.375];

  @override
  List<double> get red => [0.025, 0.38, 0.42, 0.435];

  @override
  List<double> get orange => [0.014, -0.36, 0.19, 0.52];

  @override
  List<double> get yellow => [0.015, 0.3, 0.4, 0.615];
}

class ItemsPositionsFive extends ItemsPositionValues {
  const ItemsPositionsFive();

  @override
  List<double> get green => [0.45, 0.84, 0.15];

  @override
  List<double> get blue => [0.73, 0.27];

  @override
  List<double> get red => [0.9, 0.11];

  @override
  List<double> get orange => [0.31, 0.71];

  @override
  List<double> get yellow => [0.83, 0.17, 0.45];
}

class RiverStreamsFivePainter extends RenderRiverStreamPainter {
  const RiverStreamsFivePainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.144;

  @override
  double get greenDarkHeightCoefficient => 0.101;

  @override
  double get petrolHeightCoefficient => 0.115;

  @override
  double get petrolDarkHeightCoefficient => 0.109;

  @override
  double get coralHeightCoefficient => 0.126;

  @override
  double get coralDarkHeightCoefficient => 0.117;

  @override
  double get orangeHeightCoefficient => 0.165;

  @override
  double get orangeDarkHeightCoefficient => 0.104;

  @override
  double get yellowHeightCoefficient => 0.176;

  @override
  double get yellowDarkHeightCoefficient => 0.11;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.681;

  @override
  double get greenDarkOffsetCoefficient => 0.642;

  @override
  double get petrolOffsetCoefficient => 0.584;

  @override
  double get petrolDarkOffsetCoefficient => 0.567;

  @override
  double get coralOffsetCoefficient => 0.451;

  @override
  double get coralDarkOffsetCoefficient => 0.511;

  @override
  double get orangeOffsetCoefficient => 0.369;

  @override
  double get orangeDarkOffsetCoefficient => 0.368;

  @override
  double get yellowOffsetCoefficient => 0.276;

  @override
  double get yellowDarkOffsetCoefficient => 0.343;

  // PATH ====================================================================>
  @override
  Path green(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.74)
      ..lineTo(0, size.height * 0.17)
      ..cubicTo(size.width * 0.09, size.height * 0.31, size.width * 0.18, size.height * 0.38, size.width * 0.27, size.height * 0.28)
      ..cubicTo(size.width * 0.3, size.height * 0.24, size.width / 3, size.height * 0.19, size.width * 0.36, size.height * 0.16)
      ..cubicTo(size.width * 0.47, size.height * 0.01, size.width * 0.54, size.height * (-0.09), size.width * 0.65, size.height * 0.16)
      ..cubicTo(size.width * 0.78, size.height * 0.43, size.width * 0.96, size.height / 2, size.width, size.height * 0.37)
      ..lineTo(size.width, size.height * 0.55)
      ..cubicTo(size.width * 0.95, size.height * 0.72, size.width * 0.9, size.height * 0.69, size.width * 0.85, size.height * 0.65)
      ..cubicTo(size.width * 0.83, size.height * 0.63, size.width * 0.81, size.height * 0.62, size.width * 0.79, size.height * 0.61)
      ..cubicTo(size.width * 0.7, size.height * 0.59, size.width * 0.6, size.height * 0.7, size.width / 2, size.height * 0.81)
      ..cubicTo(size.width * 0.4, size.height * 0.91, size.width * 0.31, size.height, size.width * 0.22, size.height)
      ..cubicTo(size.width * 0.14, size.height, size.width * 0.07, size.height * 0.9, 0, size.height * 0.74)
      ..lineTo(0, size.height * 0.74);
  }

  @override
  Path greenDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.83)
      ..lineTo(0, size.height * 0.45)
      ..cubicTo(size.width * 0.04, size.height * 0.51, size.width * 0.08, size.height * 0.55, size.width * 0.12, size.height * 0.55)
      ..cubicTo(size.width / 5, size.height * 0.55, size.width * 0.28, size.height * 0.43, size.width * 0.36, size.height * 0.31)
      ..cubicTo(size.width * 0.48, size.height * 0.12, size.width * 0.61, size.height * (-0.08), size.width * 0.78, size.height * 0.06)
      ..cubicTo(size.width * 0.81, size.height * 0.08, size.width * 0.84, size.height * 0.17, size.width * 0.87, size.height * 0.27)
      ..cubicTo(size.width * 0.91, size.height * 0.44, size.width * 0.96, size.height * 0.6, size.width, size.height * 0.47)
      ..lineTo(size.width, size.height * 0.92)
      ..cubicTo(size.width * 0.95, size.height * 1.07, size.width * 0.89, size.height, size.width * 0.83, size.height * 0.95)
      ..cubicTo(size.width * 0.81, size.height * 0.93, size.width * 0.8, size.height * 0.92, size.width * 0.78, size.height * 0.91)
      ..cubicTo(size.width * 0.59, size.height * 0.77, size.width * 0.39, size.height * 0.63, size.width * 0.22, size.height * 0.91)
      ..cubicTo(size.width * 0.15, size.height * 1.03, size.width * 0.07, size.height * 0.98, 0, size.height * 0.83)
      ..lineTo(0, size.height * 0.83);
  }

  @override
  Path petrol(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.9)
      ..lineTo(0, size.height * 0.58)
      ..cubicTo(size.width * 0.08, size.height * 0.78, size.width * 0.16, size.height * 0.87, size.width * 0.24, size.height * 0.75)
      ..cubicTo(size.width * 0.3, size.height * 0.68, size.width * 0.36, size.height * 0.56, size.width * 0.42, size.height * 0.43)
      ..cubicTo(size.width * 0.49, size.height * 0.28, size.width * 0.56, size.height * 0.12, size.width * 0.64, size.height * 0.03)
      ..cubicTo(size.width * 0.69, size.height * (-0.04), size.width * 0.77, size.height * 0.14, size.width * 0.83, size.height * 0.31)
      ..cubicTo(size.width * 0.9, size.height * 0.48, size.width * 0.97, size.height * 0.63, size.width, size.height * 0.47)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width * 0.81, size.height * 0.81, size.width * 0.58, size.height * 0.88, size.width * 0.37, size.height * 0.94)
      ..cubicTo(size.width * 0.28, size.height * 0.97, size.width * 0.19, size.height, size.width * 0.12, size.height)
      ..cubicTo(size.width * 0.08, size.height, size.width * 0.04, size.height * 0.96, 0, size.height * 0.9)
      ..lineTo(0, size.height * 0.9);
  }

  @override
  Path petrolDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.78)
      ..lineTo(0, size.height * 0.26)
      ..cubicTo(size.width * 0.07, size.height * 0.44, size.width * 0.15, size.height * 0.56, size.width * 0.23, size.height * 0.56)
      ..cubicTo(size.width / 3, size.height * 0.56, size.width * 0.4, size.height * 0.43, size.width * 0.48, size.height * 0.29)
      ..cubicTo(size.width * 0.54, size.height * 0.19, size.width * 0.59, size.height * 0.08, size.width * 0.66, size.height * 0.02)
      ..cubicTo(size.width * 0.7, size.height * (-0.02), size.width * 0.75, size.height * 0.02, size.width * 0.8, size.height * 0.07)
      ..cubicTo(size.width * 0.88, size.height * 0.13, size.width * 0.96, size.height * 0.19, size.width, size.height * 0.04)
      ..lineTo(size.width, size.height * 0.77)
      ..cubicTo(size.width, size.height * 0.77, size.width * 0.88, size.height * 0.77, size.width * 0.74, size.height * 0.76)
      ..cubicTo(size.width * 0.57, size.height * 0.76, size.width * 0.37, size.height * 0.75, size.width * 0.24, size.height * 0.95)
      ..cubicTo(size.width * 0.16, size.height * 1.08, size.width * 0.08, size.height * 0.98, 0, size.height * 0.78)
      ..lineTo(0, size.height * 0.78);
  }

  @override
  Path coral(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.58)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.11, size.height * 0.35, size.width * 0.22, size.height * 0.66, size.width * 0.35, size.height * 0.65)
      ..cubicTo(size.width * 0.45, size.height * 0.62, size.width * 0.51, size.height * 0.52, size.width * 0.57, size.height * 0.42)
      ..cubicTo(size.width * 0.61, size.height / 3, size.width * 0.65, size.height * 0.24, size.width * 0.7, size.height * 0.19)
      ..cubicTo(size.width * 0.73, size.height * 0.16, size.width * 0.77, size.height / 5, size.width * 0.81, size.height * 0.23)
      ..cubicTo(size.width * 0.88, size.height * 0.29, size.width * 0.96, size.height * 0.36, size.width, size.height * 0.19)
      ..lineTo(size.width, size.height * 0.53)
      ..cubicTo(size.width * 0.96, size.height * 0.66, size.width * 0.84, size.height * 0.69, size.width * 0.71, size.height * 0.73)
      ..cubicTo(size.width * 0.58, size.height * 0.77, size.width * 0.42, size.height * 0.81, size.width * 0.31, size.height * 0.97)
      ..cubicTo(size.width * 0.19, size.height * 1.12, size.width * 0.09, size.height * 0.89, 0, size.height * 0.58)
      ..lineTo(0, size.height * 0.58);
  }

  @override
  Path coralDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.74)
      ..lineTo(0, size.height * 0.1)
      ..cubicTo(size.width * 0.09, size.height * 0.44, size.width * 0.19, size.height * 0.68, size.width * 0.31, size.height * 0.52)
      ..cubicTo(size.width * 0.37, size.height * 0.43, size.width * 0.41, size.height * 0.35, size.width * 0.44, size.height * 0.27)
      ..cubicTo(size.width * 0.49, size.height * 0.18, size.width * 0.53, size.height * 0.09, size.width * 0.61, size.height * 0.02)
      ..cubicTo(size.width * 0.64, size.height * (-0.02), size.width * 0.69, size.height * 0.02, size.width * 0.75, size.height * 0.06)
      ..cubicTo(size.width * 0.84, size.height * 0.13, size.width * 0.95, size.height / 5, size.width, size.height * 0.02)
      ..cubicTo(size.width, size.height * 0.02, size.width, size.height * 0.55, size.width, size.height * 0.55)
      ..cubicTo(size.width * 0.94, size.height * 0.8, size.width * 0.48, size.height, size.width * 0.23, size.height)
      ..cubicTo(size.width * 0.15, size.height, size.width * 0.07, size.height * 0.9, 0, size.height * 0.74)
      ..lineTo(0, size.height * 0.74);
  }

  @override
  Path orange(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.52)
      ..lineTo(0, size.height * 0.13)
      ..cubicTo(size.width * 0.13, size.height * 0.39, size.width * 0.27, size.height * 0.61, size.width * 0.41, size.height * 0.48)
      ..cubicTo(size.width * 0.51, size.height * 0.37, size.width * 0.62, size.height * 0.3, size.width * 0.72, size.height * 0.24)
      ..cubicTo(size.width * 0.83, size.height * 0.18, size.width * 0.93, size.height * 0.12, size.width, size.height * 0.01)
      ..lineTo(size.width, size.height * 0.8)
      ..cubicTo(size.width * 0.74, size.height * 0.67, size.width * 0.65, size.height * 0.78, size.width * 0.56, size.height * 0.88)
      ..cubicTo(size.width * 0.51, size.height * 0.95, size.width * 0.45, size.height, size.width * 0.35, size.height)
      ..cubicTo(size.width * 0.22, size.height, size.width * 0.11, size.height * 0.77, 0, size.height * 0.52)
      ..lineTo(0, size.height * 0.52);
  }

  @override
  Path orangeDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.38)
      ..lineTo(0, size.height / 5)
      ..cubicTo(size.width * 0.13, size.height * 0.62, size.width * 0.27, size.height * 0.98, size.width * 0.41, size.height * 0.76)
      ..cubicTo(size.width * 0.45, size.height * 0.69, size.width * 0.48, size.height * 0.62, size.width * 0.52, size.height * 0.54)
      ..cubicTo(size.width * 0.58, size.height * 0.4, size.width * 0.64, size.height * 0.27, size.width * 0.73, size.height * 0.27)
      ..cubicTo(size.width * 0.81, size.height * 0.27, size.width * 0.88, size.height * 0.17, size.width * 0.94, size.height * 0.09)
      ..cubicTo(size.width * 0.96, size.height * 0.06, size.width * 0.98, size.height * 0.03, size.width, size.height * 0.02)
      ..lineTo(size.width, size.height * 0.62)
      ..cubicTo(size.width * 0.94, size.height * 0.85, size.width * 0.91, size.height * 0.76, size.width * 0.87, size.height * 0.66)
      ..cubicTo(size.width * 0.83, size.height * 0.56, size.width * 0.78, size.height * 0.45, size.width * 0.71, size.height * 0.61)
      ..cubicTo(size.width * 0.61, size.height * 0.85, size.width * 0.48, size.height * 1.02, size.width * 0.36, size.height * 1.02)
      ..cubicTo(size.width * 0.23, size.height * 1.02, size.width * 0.11, size.height * 0.71, 0, size.height * 0.38)
      ..lineTo(0, size.height * 0.38);
  }

  @override
  Path yellow(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.65)
      ..lineTo(0, size.height * 0.4)
      ..cubicTo(size.width * 0.12, size.height * 0.53, size.width * 0.24, size.height * 0.58, size.width * 0.35, size.height * 0.4)
      ..cubicTo(size.width * 0.48, size.height * 0.19, size.width * 0.59, size.height * 0.18, size.width * 0.69, size.height * 0.18)
      ..cubicTo(size.width * 0.79, size.height * 0.18, size.width * 0.89, size.height * 0.18, size.width, size.height * 0.01)
      ..lineTo(size.width, size.height * 0.54)
      ..cubicTo(size.width * 0.9, size.height * 0.56, size.width * 0.64, size.height * 0.75, size.width * 0.41, size.height * 0.97)
      ..cubicTo(size.width * 0.27, size.height * 1.1, size.width * 0.13, size.height * 0.89, 0, size.height * 0.65)
      ..lineTo(0, size.height * 0.65);
  }

  @override
  Path yellowDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.44)
      ..lineTo(0, size.height * 0.34)
      ..cubicTo(size.width * 0.14, size.height * 0.75, size.width * 0.28, size.height * 1.07, size.width * 0.42, size.height * 0.71)
      ..cubicTo(size.width * 0.54, size.height * 0.39, size.width * 0.62, size.height * 0.4, size.width * 0.69, size.height * 0.41)
      ..cubicTo(size.width * 0.77, size.height * 0.42, size.width * 0.86, size.height * 0.43, size.width, size.height * 0.02)
      ..lineTo(size.width, size.height / 4)
      ..cubicTo(size.width * 0.92, size.height * 0.43, size.width * 0.82, size.height * 0.51, size.width * 0.71, size.height * 0.61)
      ..cubicTo(size.width * 0.62, size.height * 0.7, size.width * 0.51, size.height * 0.79, size.width * 0.41, size.height * 0.95)
      ..cubicTo(size.width * 0.27, size.height * 1.16, size.width * 0.13, size.height * 0.82, 0, size.height * 0.44)
      ..lineTo(0, size.height * 0.44);
  }
}
