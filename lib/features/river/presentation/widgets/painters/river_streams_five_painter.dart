import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/painters/river_stream_painter.dart';

class FunctionCoefficientsFive extends FunctionCoefficientsValues {
  const FunctionCoefficientsFive();

  @override
  List<double> get green => [0.06, -0.63, 0.23, 0.15];

  @override
  List<double> get blue => [0.05, 0.6, 0.72, 0.28];

  @override
  List<double> get red => [0.08, 0.6, 0.73, 0.37];

  @override
  List<double> get orange => [0.06, 0.6, 0.76, 0.48];

  @override
  List<double> get yellow => [0.06, -0.7, 0.28, 0.6];
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
  double get greenHeightCoefficient => 0.252;

  @override
  double get greenDarkHeightCoefficient => 0.196;

  @override
  double get petrolHeightCoefficient => 0.208;

  @override
  double get petrolDarkHeightCoefficient => 0.256;

  @override
  double get coralHeightCoefficient => 0.284;

  @override
  double get coralDarkHeightCoefficient => 0.308;

  @override
  double get orangeHeightCoefficient => 0.303;

  @override
  double get orangeDarkHeightCoefficient => 0.198;

  @override
  double get yellowHeightCoefficient => 0.227;

  @override
  double get yellowDarkHeightCoefficient => 0.227;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.733;

  @override
  double get greenDarkOffsetCoefficient => 0.688;

  @override
  double get petrolOffsetCoefficient => 0.586;

  @override
  double get petrolDarkOffsetCoefficient => 0.526;

  @override
  double get coralOffsetCoefficient => 0.44;

  @override
  double get coralDarkOffsetCoefficient => 0.476;

  @override
  double get orangeOffsetCoefficient => 0.372;

  @override
  double get orangeDarkOffsetCoefficient => 0.358;

  @override
  double get yellowOffsetCoefficient => 0.276;

  @override
  double get yellowDarkOffsetCoefficient => 0.313;

  // PATH ====================================================================>
  @override
  Path green(Size size) => Path()
      ..moveTo(0, size.height * 0.49)
      ..lineTo(0, size.height * 0.07)
      ..cubicTo(size.width * 0.13, size.height * 0.31, size.width * 0.27, size.height * 0.52, size.width * 0.43, size.height * 0.52)
      ..cubicTo(size.width * 0.7, size.height * 0.52, size.width * 0.84, size.height * 0.29, size.width, size.height * 0.01)
      ..lineTo(size.width, size.height * 0.1)
      ..cubicTo(size.width * 0.98, size.height * 0.16, size.width * 0.95, size.height * 0.24, size.width * 0.92, size.height * 0.31)
      ..cubicTo(size.width * 0.78, size.height * 0.68, size.width * 0.59, size.height * 1.18, size.width * 0.35, size.height * 0.94)
      ..cubicTo(size.width * 0.23, size.height * 0.82, size.width * 0.11, size.height * 0.65, 0, size.height * 0.49)
      ..close();

  @override
  Path greenDark(Size size) => Path()
      ..moveTo(0, size.height * 0.49)
      ..lineTo(0, size.height * 0.05)
      ..cubicTo(size.width * 0.01, size.height * 0.08, size.width * 0.03, size.height * 0.1, size.width * 0.04, size.height * 0.13)
      ..cubicTo(size.width / 3, size.height * 0.67, size.width * 0.71, size.height * 0.57, size.width, size.height * (-0.01))
      ..lineTo(size.width, size.height * 0.24)
      ..cubicTo(size.width * 0.95, size.height * 0.4, size.width * 0.81, size.height * 0.78, size.width * 0.81, size.height * 0.78)
      ..cubicTo(size.width * 0.81, size.height * 0.78, size.width * 0.51, size.height * 1.05, size.width * 0.34, size.height)
      ..cubicTo(size.width * 0.23, size.height * 0.95, size.width * 0.11, size.height * 0.73, 0, size.height * 0.49)
      ..close();

  @override
  Path petrol(Size size) => Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.02, size.height * 0.07, size.width * 0.04, size.height * 0.13, size.width * 0.06, size.height * 0.19)
      ..cubicTo(size.width * 0.08, size.height * 0.25, size.width * 0.1, size.height * 0.31, size.width * 0.12, size.height * 0.36)
      ..cubicTo(size.width * 0.23, size.height * 0.73, size.width / 2, size.height * 0.93, size.width * 0.75, size.height * 0.66)
      ..cubicTo(size.width * 0.87, size.height * 0.53, size.width * 0.93, size.height * 0.42, size.width, size.height / 4)
      ..lineTo(size.width, size.height * 0.55)
      ..cubicTo(size.width * 0.71, size.height, size.width * 0.54, size.height, size.width * 0.32, size.height)
      ..cubicTo(size.width * 0.3, size.height, size.width * 0.28, size.height, size.width * 0.26, size.height)
      ..cubicTo(size.width * 0.17, size.height, size.width * 0.08, size.height * 0.88, 0, size.height * 0.7)
      ..close();

  @override
  Path petrolDark(Size size) => Path()
      ..moveTo(0, size.height * 0.58)
      ..lineTo(0, size.height * 0.01)
      ..cubicTo(size.width * 0.02, size.height * 0.07, size.width * 0.05, size.height * 0.15, size.width * 0.08, size.height * 0.23)
      ..cubicTo(size.width * 0.11, size.height * 0.31, size.width * 0.14, size.height * 0.41, size.width * 0.17, size.height / 2)
      ..cubicTo(size.width / 3, size.height * 0.95, size.width * 0.55, size.height * 0.88, size.width * 0.75, size.height * 0.57)
      ..cubicTo(size.width * 0.85, size.height * 0.43, size.width * 0.92, size.height * 0.31, size.width * 0.98, size.height / 5)
      ..lineTo(size.width, size.height * 0.17)
      ..lineTo(size.width, size.height * 0.44)
      ..cubicTo(size.width * 0.94, size.height * 0.69, size.width * 0.61, size.height, size.width * 0.37, size.height)
      ..cubicTo(size.width * 0.26, size.height, size.width * 0.13, size.height * 0.81, 0, size.height * 0.58)
      ..close();

  @override
  Path coral(Size size) => Path()
      ..moveTo(0, size.height * 0.28)
      ..lineTo(0, size.height * 0.005)
      ..cubicTo(size.width * 0.01, size.height * 0.02, size.width * 0.02, size.height * 0.04, size.width * 0.03, size.height * 0.06)
      ..cubicTo(size.width * 0.08, size.height * 0.16, size.width * 0.13, size.height * 0.26, size.width * 0.19, size.height * 0.36)
      ..cubicTo(size.width * 0.34, size.height * 0.65, size.width * 0.52, size.height * 0.66, size.width * 0.66, size.height * 0.6)
      ..cubicTo(size.width * 0.73, size.height * 0.57, size.width * 0.93, size.height * 0.24, size.width, size.height * 0.12)
      ..lineTo(size.width, size.height * 0.28)
      ..cubicTo(size.width * 0.97, size.height * 0.31, size.width * 0.94, size.height * 0.4, size.width * 0.91, size.height * 0.5)
      ..cubicTo(size.width * 0.82, size.height * 0.72, size.width * 0.69, size.height * 1.05, size.width * 0.52, size.height)
      ..cubicTo(size.width * 0.38, size.height * 0.95, size.width / 5, size.height * 0.64, size.width * 0.04, size.height * 0.36)
      ..cubicTo(size.width * 0.03, size.height / 3, size.width * 0.01, size.height * 0.3, 0, size.height * 0.28)
      ..close();

  @override
  Path coralDark(Size size) => Path()
      ..moveTo(0, size.height * 0.57)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.06, size.height * 0.11, size.width * 0.13, size.height / 4, size.width / 5, size.height * 0.41)
      ..cubicTo(size.width * 0.31, size.height * 0.64, size.width * 0.43, size.height * 0.72, size.width * 0.56, size.height * 0.71)
      ..cubicTo(size.width * 0.7, size.height * 0.71, size.width * 0.81, size.height * 0.49, size.width * 0.9, size.height * 0.3)
      ..cubicTo(size.width * 0.94, size.height * 0.24, size.width * 0.97, size.height * 0.17, size.width, size.height * 0.13)
      ..lineTo(size.width, size.height * 0.32)
      ..cubicTo(size.width, size.height * 0.34, size.width * 0.97, size.height * 0.37, size.width * 0.95, size.height * 0.42)
      ..cubicTo(size.width * 0.84, size.height * 0.61, size.width * 0.63, size.height, size.width * 0.43, size.height)
      ..cubicTo(size.width * 0.29, size.height, size.width * 0.14, size.height * 0.8, 0, size.height * 0.57)
      ..close();

  @override
  Path orange(Size size) => Path()
      ..moveTo(0, size.height / 3)
      ..lineTo(0, size.height * 0.02)
      ..cubicTo(size.width * 0.04, size.height * 0.08, size.width * 0.09, size.height * 0.14, size.width * 0.13, size.height * 0.19)
      ..cubicTo(size.width * 0.27, size.height * 0.38, size.width * 0.4, size.height * 0.56, size.width * 0.54, size.height * 0.56)
      ..cubicTo(size.width * 0.71, size.height * 0.56, size.width * 0.81, size.height * 0.38, size.width * 0.9, size.height * 0.18)
      ..cubicTo(size.width * 0.93, size.height * 0.12, size.width * 0.97, size.height * 0.06, size.width, 0)
      ..lineTo(size.width, size.height * 0.42)
      ..cubicTo(size.width * 0.71, size.height * 0.83, size.width * 0.62, size.height, size.width * 0.53, size.height)
      ..cubicTo(size.width * 0.48, size.height, size.width * 0.43, size.height * 0.95, size.width * 0.34, size.height * 0.86)
      ..cubicTo(size.width * 0.22, size.height * 0.74, size.width * 0.12, size.height * 0.55, size.width * 0.02, size.height * 0.37)
      ..cubicTo(size.width * 0.01, size.height * 0.36, size.width * 0.01, size.height * 0.35, 0, size.height / 3)
      ..close();

  @override
  Path orangeDark(Size size) => Path()
      ..moveTo(0, size.height * 0.16)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.09, size.height * 0.15, size.width * 0.18, size.height / 3, size.width * 0.27, size.height * 0.51)
      ..cubicTo(size.width * 0.32, size.height * 0.59, size.width * 0.36, size.height * 0.68, size.width * 0.4, size.height * 0.76)
      ..cubicTo(size.width * 0.57, size.height * 1.08, size.width * 0.7, size.height * 0.77, size.width * 0.84, size.height * 0.42)
      ..cubicTo(size.width * 0.89, size.height * 0.29, size.width * 0.94, size.height * 0.16, size.width, size.height * 0.06)
      ..lineTo(size.width, size.height * 0.38)
      ..cubicTo(size.width * 0.76, size.height * 0.86, size.width * 0.53, size.height * 1.28, size.width * 0.28, size.height * 0.76)
      ..cubicTo(size.width * 0.24, size.height * 0.68, size.width / 5, size.height * 0.59, size.width * 0.17, size.height * 0.51)
      ..cubicTo(size.width * 0.11, size.height * 0.38, size.width * 0.05, size.height * 0.26, 0, size.height * 0.16)
      ..close();

  @override
  Path yellow(Size size) => Path()
      ..moveTo(0, size.height * 0.46)
      ..lineTo(0, size.height * 0.03)
      ..cubicTo(size.width * 0.06, size.height * 0.15, size.width * 0.12, size.height * 0.24, size.width * 0.18, size.height * 0.28)
      ..cubicTo(size.width * 0.51, size.height * 0.52, size.width * 0.77, size.height * 0.4, size.width, 0)
      ..lineTo(size.width, size.height * 0.41)
      ..cubicTo(size.width * 0.96, size.height * 0.42, size.width * 0.92, size.height * 0.49, size.width * 0.88, size.height * 0.59)
      ..cubicTo(size.width * 0.82, size.height * 0.72, size.width * 0.75, size.height * 0.88, size.width * 0.62, size.height * 0.98)
      ..cubicTo(size.width * 0.46, size.height * 1.09, size.width * 0.23, size.height * 0.78, size.width * 0.03, size.height / 2)
      ..cubicTo(size.width * 0.02, size.height * 0.49, size.width * 0.01, size.height * 0.48, 0, size.height * 0.46)
      ..close();

  @override
  Path yellowDark(Size size) => Path()
      ..moveTo(0, size.height * 0.37)
      ..lineTo(0, 0)
      ..cubicTo(size.width * 0.03, size.height * 0.04, size.width * 0.05, size.height * 0.09, size.width * 0.07, size.height * 0.13)
      ..cubicTo(size.width * 0.3, size.height * 0.58, size.width * 0.65, size.height * 0.96, size.width, size.height * 0.13)
      ..lineTo(size.width, size.height / 4)
      ..cubicTo(size.width * 0.97, size.height / 3, size.width * 0.94, size.height * 0.4, size.width * 0.91, size.height * 0.48)
      ..cubicTo(size.width * 0.81, size.height * 0.76, size.width * 0.74, size.height * 0.97, size.width * 0.55, size.height)
      ..cubicTo(size.width * 0.4, size.height * 1.02, size.width / 5, size.height * 0.71, size.width * 0.03, size.height * 0.41)
      ..cubicTo(size.width * 0.02, size.height * 0.4, size.width * 0.01, size.height * 0.38, 0, size.height * 0.37)
      ..close();
}
