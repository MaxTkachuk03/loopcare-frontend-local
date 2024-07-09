import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class FunctionCoefficientsThree extends FunctionCoefficientsValues  {
  const FunctionCoefficientsThree();

  @override
  List<double> get green => [0.04, 0.69, 0.77, 0.21];

  @override
  List<double> get blue => [0.06, 0.69, 0.84, 0.28];

  @override
  List<double> get red => [0.04, 0.65, 0.9, 0.35];

  @override
  List<double> get orange => [0.025, 0.45, 0.86, 0.42];

  @override
  List<double> get yellow => [0.036, 0.44, 0.8, 0.49];
}

class ItemsPositionsThree extends ItemsPositionValues {
  const ItemsPositionsThree();

  @override
  List<double> get green => [0.83, 0.41, 0.11];

  @override
  List<double> get blue => [0.17, 0.67, 0.93];

  @override
  List<double> get red => [0.27, 0.88];

  @override
  List<double> get orange => [0.34, 0.7];

  @override
  List<double> get yellow => [0.82, 0.13];
}

class RiverStreamsThreePainter extends RenderRiverStreamPainter {
  const RiverStreamsThreePainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.175;

  @override
  double get greenDarkHeightCoefficient => 0.143;

  @override
  double get petrolHeightCoefficient => 0.165;

  @override
  double get petrolDarkHeightCoefficient => 0.197;

  @override
  double get coralHeightCoefficient => 0.173;

  @override
  double get coralDarkHeightCoefficient => 0.202;

  @override
  double get orangeHeightCoefficient => 0.239;

  @override
  double get orangeDarkHeightCoefficient => 0.222;

  @override
  double get yellowHeightCoefficient => 0.246;

  @override
  double get yellowDarkHeightCoefficient => 0.185;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.716;

  @override
  double get greenDarkOffsetCoefficient => 0.677;

  @override
  double get petrolOffsetCoefficient => 0.613;

  @override
  double get petrolDarkOffsetCoefficient => 0.566;

  @override
  double get coralOffsetCoefficient => 0.488;

  @override
  double get coralDarkOffsetCoefficient => 0.524;

  @override
  double get orangeOffsetCoefficient => 0.382;

  @override
  double get orangeDarkOffsetCoefficient => 0.38;

  @override
  double get yellowOffsetCoefficient => 0.314;

  @override
  double get yellowDarkOffsetCoefficient => 0.375;

  // PATH ====================================================================>

  @override
  Path green(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.36)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.02, size.height * 0.03, size.width * 0.03, size.height * 0.05, size.width * 0.05, size.height * 0.1)
      ..cubicTo(size.width * 0.06, size.height * 0.12, size.width * 0.1, size.height * 0.18, size.width * 0.12, size.height * 0.22)
      ..cubicTo(size.width * 0.24, size.height * 0.45, size.width * 0.42, size.height * 0.8, size.width * 0.78, size.height * 0.44)
      ..cubicTo(size.width * 0.87, size.height * 0.35, size.width * 0.94, size.height * 0.26, size.width, size.height * 0.15)
      ..lineTo(size.width, size.height * 0.29)
      ..cubicTo(size.width * 0.87, size.height * 0.51, size.width * 0.74, size.height * 0.73, size.width * 0.6, size.height * 0.91)
      ..cubicTo(size.width * 0.36, size.height * 1.2, size.width * 0.16, size.height * 0.75, 0, size.height * 0.36)
      ..lineTo(0, size.height * 0.36);
  }

  @override
  Path greenDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.27)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.01, size.height * 0.02, size.width * 0.02, size.height * 0.05, size.width * 0.04, size.height * 0.07)
      ..cubicTo(size.width * 0.26, size.height * 0.48, size.width * 0.56, size.height, size.width * 0.8, size.height * 0.51)
      ..cubicTo(size.width * 0.89, size.height * 0.34, size.width * 0.95, size.height / 5, size.width, size.height * 0.12)
      ..lineTo(size.width, size.height * 0.47)
      ..cubicTo(size.width * 0.94, size.height * 0.59, size.width * 0.87, size.height * 0.7, size.width * 0.78, size.height * 0.81)
      ..cubicTo(size.width * 0.42, size.height * 1.26, size.width * 0.24, size.height * 0.83, size.width * 0.09, size.height * 0.5)
      ..cubicTo(size.width * 0.07, size.height * 0.46, size.width * 0.06, size.height * 0.43, size.width * 0.05, size.height * 0.41)
      ..cubicTo(size.width * 0.03, size.height * 0.36, size.width * 0.02, size.height * 0.32, 0, size.height * 0.27)
      ..lineTo(0, size.height * 0.27);
  }

  @override
  Path petrol(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.39)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.02, size.height * 0.03, size.width * 0.04, size.height * 0.07, size.width * 0.07, size.height * 0.13)
      ..cubicTo(size.width * 0.08, size.height * 0.15, size.width * 0.09, size.height * 0.17, size.width * 0.1, size.height * 0.19)
      ..cubicTo(size.width * 0.13, size.height * 0.26, size.width * 0.16, size.height * 0.34, size.width / 5, size.height * 0.43)
      ..cubicTo(size.width * 0.31, size.height * 0.75, size.width * 0.44, size.height * 1.11, size.width * 0.75, size.height * 0.78)
      ..cubicTo(size.width * 0.85, size.height * 0.68, size.width * 0.93, size.height * 0.56, size.width, size.height * 0.42)
      ..lineTo(size.width, size.height * 0.5)
      ..cubicTo(size.width * 0.95, size.height * 0.57, size.width * 0.89, size.height * 0.68, size.width * 0.8, size.height * 0.83)
      ..cubicTo(size.width * 0.56, size.height * 1.26, size.width * 0.26, size.height * 0.8, size.width * 0.04, size.height * 0.45)
      ..cubicTo(size.width * 0.02, size.height * 0.43, size.width * 0.01, size.height * 0.41, 0, size.height * 0.39)
      ..lineTo(0, size.height * 0.39);
  }

  @override
  Path petrolDark(Size size) {
    return Path()
      ..moveTo(0, size.height / 4)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.04, size.height * 0.07, size.width * 0.08, size.height * 0.14, size.width * 0.12, size.height / 5)
      ..cubicTo(size.width * 0.34, size.height * 0.58, size.width * 0.62, size.height * 1.05, size.width * 0.86, size.height * 0.7)
      ..cubicTo(size.width * 0.91, size.height * 0.62, size.width * 0.95, size.height * 0.54, size.width, size.height * 0.45)
      ..lineTo(size.width, size.height * 0.6)
      ..cubicTo(size.width * 0.93, size.height * 0.71, size.width * 0.85, size.height * 0.82, size.width * 0.75, size.height * 0.9)
      ..cubicTo(size.width * 0.44, size.height * 1.18, size.width * 0.31, size.height * 0.88, size.width / 5, size.height * 0.61)
      ..cubicTo(size.width * 0.16, size.height * 0.54, size.width * 0.13, size.height * 0.46, size.width * 0.1, size.height * 0.41)
      ..cubicTo(size.width * 0.09, size.height * 0.39, size.width * 0.08, size.height * 0.37, size.width * 0.07, size.height * 0.36)
      ..cubicTo(size.width * 0.04, size.height * 0.32, size.width * 0.02, size.height * 0.28, 0, size.height / 4)
      ..lineTo(0, size.height / 4);
  }

  @override
  Path coral(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.22)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.05, size.height * 0.06, size.width * 0.1, size.height * 0.15, size.width * 0.15, size.height * 0.24)
      ..cubicTo(size.width * 0.36, size.height * 0.58, size.width * 0.63, size.height, size.width * 0.87, size.height * 0.61)
      ..cubicTo(size.width * 0.92, size.height * 0.53, size.width * 0.96, size.height * 0.46, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height * 0.68)
      ..cubicTo(size.width * 0.95, size.height * 0.73, size.width * 0.9, size.height * 0.79, size.width * 0.84, size.height * 0.85)
      ..cubicTo(size.width * 0.49, size.height * 1.2, size.width * 0.34, size.height * 0.88, size.width / 5, size.height * 0.6)
      ..cubicTo(size.width * 0.18, size.height * 0.57, size.width * 0.16, size.height * 0.53, size.width * 0.14, size.height / 2)
      ..cubicTo(size.width * 0.12, size.height * 0.45, size.width * 0.09, size.height * 0.4, size.width * 0.07, size.height * 0.35)
      ..cubicTo(size.width * 0.04, size.height * 0.3, size.width * 0.02, size.height * 0.26, 0, size.height * 0.22)
      ..lineTo(0, size.height * 0.22);
  }

  @override
  Path coralDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.22)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.02, size.height * 0.04, size.width * 0.09, size.height * 0.15, size.width * 0.14, size.height * 0.24)
      ..cubicTo(size.width * 0.16, size.height * 0.27, size.width * 0.18, size.height * 0.3, size.width / 5, size.height * 0.33)
      ..cubicTo(size.width * 0.34, size.height * 0.57, size.width * 0.49, size.height * 0.85, size.width * 0.84, size.height * 0.54)
      ..cubicTo(size.width * 0.9, size.height * 0.5, size.width * 0.95, size.height * 0.44, size.width, size.height * 0.4)
      ..lineTo(size.width, size.height * 0.65)
      ..cubicTo(size.width * 0.95, size.height * 0.74, size.width * 0.91, size.height * 0.81, size.width * 0.86, size.height * 0.89)
      ..cubicTo(size.width * 0.62, size.height * 1.23, size.width * 0.34, size.height * 0.77, size.width * 0.12, size.height * 0.42)
      ..cubicTo(size.width * 0.08, size.height * 0.36, size.width * 0.04, size.height * 0.29, 0, size.height * 0.22)
      ..lineTo(0, size.height * 0.22);
  }

  @override
  Path orange(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.45)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.08, size.height * 0.06, size.width * 0.14, size.height * 0.16, size.width * 0.19, size.height * 0.28)
      ..cubicTo(size.width / 5, size.height * 0.29, size.width / 5, size.height * 0.3, size.width / 5, size.height * 0.31)
      ..cubicTo(size.width * 0.35, size.height * 0.62, size.width * 0.48, size.height * 0.92, size.width * 0.87, size.height * 0.65)
      ..cubicTo(size.width * 0.92, size.height * 0.61, size.width * 0.96, size.height * 0.57, size.width, size.height * 0.53)
      ..lineTo(size.width, size.height * 0.74)
      ..cubicTo(size.width * 0.96, size.height * 0.78, size.width * 0.92, size.height * 0.83, size.width * 0.87, size.height * 0.89)
      ..cubicTo(size.width * 0.63, size.height * 1.18, size.width * 0.36, size.height * 0.87, size.width * 0.15, size.height * 0.62)
      ..cubicTo(size.width * 0.1, size.height * 0.56, size.width * 0.05, size.height / 2, 0, size.height * 0.45)
      ..lineTo(0, size.height * 0.45);
  }

  @override
  Path orangeDark(Size size) {
    return Path()
      ..moveTo(0, size.height / 5)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.08, size.height * 0.07, size.width * 0.18, size.height * 0.23, size.width * 0.3, size.height * 0.52)
      ..cubicTo(size.width * 0.35, size.height * 0.6, size.width * 0.48, size.height, size.width * 0.87, size.height * 0.7)
      ..cubicTo(size.width * 0.92, size.height * 0.66, size.width * 0.96, size.height * 0.62, size.width, size.height * 0.57)
      ..lineTo(size.width, size.height * 0.73)
      ..cubicTo(size.width * 0.96, size.height * 0.78, size.width * 0.92, size.height * 0.84, size.width * 0.87, size.height * 0.9)
      ..cubicTo(size.width * 0.63, size.height * 1.21, size.width * 0.37, size.height * 0.78, size.width * 0.16, size.height * 0.45)
      ..cubicTo(size.width * 0.1, size.height * 0.35, size.width * 0.05, size.height * 0.27, 0, size.height / 5)
      ..lineTo(0, size.height / 5);
  }

  @override
  Path yellow(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.28)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.05, size.height * 0.06, size.width * 0.11, size.height * 0.15, size.width * 0.17, size.height / 4)
      ..cubicTo(size.width * 0.38, size.height * 0.58, size.width * 0.63, size.height, size.width * 0.85, size.height * 0.58)
      ..cubicTo(size.width * 0.91, size.height * 0.47, size.width * 0.96, size.height * 0.38, size.width, size.height * 0.29)
      ..lineTo(size.width, size.height * 0.79)
      ..cubicTo(size.width * 0.96, size.height * 0.83, size.width * 0.92, size.height * 0.86, size.width * 0.87, size.height * 0.9)
      ..cubicTo(size.width * 0.48, size.height * 1.17, size.width * 0.35, size.height * 0.87, size.width / 5, size.height * 0.57)
      ..cubicTo(size.width / 5, size.height * 0.56, size.width / 5, size.height * 0.55, size.width * 0.19, size.height * 0.54)
      ..cubicTo(size.width * 0.14, size.height * 0.43, size.width * 0.08, size.height / 3, 0, size.height * 0.28)
      ..lineTo(0, size.height * 0.28);
  }

  @override
  Path yellowDark(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.04)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.12, size.height * 0.1, size.width / 5, size.height * 0.29, size.width * 0.3, size.height * 0.46)
      ..cubicTo(size.width * 0.42, size.height * 0.72, size.width * 0.54, size.height * 0.95, size.width * 0.72, size.height * 0.82)
      ..cubicTo(size.width * 0.84, size.height * 0.74, size.width * 0.92, size.height * 0.66, size.width, size.height * 0.56)
      ..lineTo(size.width, size.height * 0.72)
      ..cubicTo(size.width * 0.96, size.height * 0.77, size.width * 0.92, size.height * 0.82, size.width * 0.87, size.height * 0.86)
      ..cubicTo(size.width * 0.48, size.height * 1.22, size.width * 0.35, size.height * 0.82, size.width / 5, size.height * 0.42)
      ..cubicTo(size.width / 5, size.height * 0.41, size.width / 5, size.height * 0.4, size.width * 0.19, size.height * 0.38)
      ..cubicTo(size.width * 0.14, size.height * 0.24, size.width * 0.08, size.height * 0.11, 0, size.height * 0.04)
      ..lineTo(0, size.height * 0.04);
  }
}
