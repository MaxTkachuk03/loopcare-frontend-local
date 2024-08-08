import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/presentation/painters/river_stream_painter.dart';

class FunctionCoefficientsFour extends FunctionCoefficientsValues {
  const FunctionCoefficientsFour();

  @override
  List<double>  get green => [-0.056, -0.5, 0.32, 0.37];

  @override
  List<double> get blue => [-0.1, -0.62, 0.304, 0.448];

  @override
  List<double> get red => [-0.104, -0.7, 0.34, 0.52];

  @override
  List<double> get orange => [-0.098, -0.7, 0.376, 0.6];

  @override
  List<double> get yellow => [-0.08, 0.72, 0.92, 0.68];
}

class ItemsPositionsFour extends ItemsPositionValues {
  const ItemsPositionsFour();

  @override
  List<double> get green => [0.21, 0.91, 0.55];

  @override
  List<double> get blue => [0.76, 0.35];

  @override
  List<double> get red => [0.89, 0.11];

  @override
  List<double> get orange => [0.76, 0.22];

  @override
  List<double> get yellow => [0.32, 0.61];
}

class RiverStreamsFourPainter extends RenderRiverStreamPainter {
  const RiverStreamsFourPainter({
    super.gradientPosition = 0,
    super.time = 0,
    super.enableGradient = false,
    super.fillColor = false,
  });

  // HEIGHT ==================================================================>
  @override
  double get greenHeightCoefficient => 0.254;

  @override
  double get greenDarkHeightCoefficient => 0.26;

  @override
  double get petrolHeightCoefficient => 0.291;

  @override
  double get petrolDarkHeightCoefficient => 0.271;

  @override
  double get coralHeightCoefficient => 0.264;

  @override
  double get coralDarkHeightCoefficient => 0.267;

  @override
  double get orangeHeightCoefficient => 0.251;

  @override
  double get orangeDarkHeightCoefficient => 0.216;

  @override
  double get yellowHeightCoefficient => 0.418;

  @override
  double get yellowDarkHeightCoefficient => 0.272;

  // OFFSET ==================================================================>
  @override
  double get greenOffsetCoefficient => 0.603;

  @override
  double get greenDarkOffsetCoefficient => 0.523;

  @override
  double get petrolOffsetCoefficient => 0.44;

  @override
  double get petrolDarkOffsetCoefficient => 0.412;

  @override
  double get coralOffsetCoefficient => 0.338;

  @override
  double get coralDarkOffsetCoefficient => 0.387;

  @override
  double get orangeOffsetCoefficient => 0.303;

  @override
  double get orangeDarkOffsetCoefficient => 0.282;

  @override
  double get yellowOffsetCoefficient => 0.089;

  @override
  double get yellowDarkOffsetCoefficient => 0.235;

  // PATH ====================================================================>
  @override
  Path green(Size size) => Path()
      ..moveTo(0, size.height * 0.73)
      ..lineTo(0, size.height * 0.45)
      ..cubicTo(size.width * 0.18, size.height * 0.26, size.width / 3, size.height * 0.12, size.width * 0.44, size.height * 0.04)
      ..cubicTo(size.width * 0.62, size.height * (-0.09), size.width * 0.78, size.height * 0.19, size.width * 0.95, size.height * 0.49)
      ..cubicTo(size.width * 0.96, size.height * 0.52, size.width * 0.98, size.height * 0.55, size.width, size.height * 0.58)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width * 0.98, size.height * 0.97, size.width * 0.95, size.height * 0.93, size.width * 0.93, size.height * 0.9)
      ..cubicTo(size.width * 0.79, size.height * 0.71, size.width * 0.68, size.height * 0.54, size.width * 0.6, size.height * 0.51)
      ..cubicTo(size.width * 0.4, size.height * 0.44, size.width / 5, size.height * 0.51, 0, size.height * 0.73)
      ..close();

  @override
  Path greenDark(Size size) => Path()
      ..moveTo(0, size.height * 0.92)
      ..lineTo(0, size.height * 0.66)
      ..cubicTo(size.width * 0.17, size.height * 0.48, size.width / 5, size.height * 0.44, size.width * 0.46, size.height * 0.09)
      ..cubicTo(size.width * 0.61, size.height * (-0.13), size.width * 0.71, size.height * 0.08, size.width * 0.83, size.height * 0.35)
      ..cubicTo(size.width * 0.88, size.height * 0.46, size.width * 0.94, size.height * 0.57, size.width, size.height * 0.67)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width * 0.97, size.height * 0.95, size.width * 0.94, size.height * 0.89, size.width * 0.9, size.height * 0.84)
      ..cubicTo(size.width * 0.75, size.height * 0.59, size.width * 0.62, size.height * 0.36, size.width * 0.52, size.height * 0.43)
      ..cubicTo(size.width * 0.4, size.height * 0.51, size.width * 0.22, size.height * 0.68, 0, size.height * 0.92)
      ..close();

  @override
  Path petrol(Size size) => Path()
      ..moveTo(0, size.height * 0.88)
      ..lineTo(0, size.height * 0.82)
      ..cubicTo(size.width * 0.12, size.height * 0.68, size.width * 0.22, size.height * 0.52, size.width * 0.3, size.height * 0.37)
      ..cubicTo(size.width * 0.4, size.height / 5, size.width * 0.48, size.height * 0.07, size.width * 0.56, size.height * 0.02)
      ..cubicTo(size.width * 0.72, size.height * (-0.07), size.width * 0.85, size.height * 0.17, size.width, size.height / 2)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width * 0.94, size.height * 0.92, size.width * 0.89, size.height * 0.81, size.width * 0.83, size.height * 0.71)
      ..cubicTo(size.width * 0.7, size.height * 0.45, size.width * 0.57, size.height * 0.22, size.width * 0.46, size.height * 0.37)
      ..cubicTo(size.width / 5, size.height * 0.68, size.width * 0.17, size.height * 0.72, size.width * 0.05, size.height * 0.83)
      ..cubicTo(size.width * 0.03, size.height * 0.85, size.width * 0.02, size.height * 0.86, 0, size.height * 0.88)
      ..close();

  @override
  Path petrolDark(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.89)
      ..cubicTo(size.width * 0.12, size.height * 0.73, size.width * 0.23, size.height * 0.55, size.width * 0.32, size.height * 0.4)
      ..cubicTo(size.width * 0.44, size.height / 5, size.width * 0.53, size.height * 0.06, size.width * 0.6, size.height * 0.03)
      ..cubicTo(size.width * 0.79, size.height * (-0.05), size.width * 0.87, size.height * 0.07, size.width, size.height * 0.43)
      ..lineTo(size.width, size.height * 0.98)
      ..cubicTo(size.width * 0.96, size.height * 0.92, size.width * 0.92, size.height * 0.85, size.width * 0.88, size.height * 0.78)
      ..cubicTo(size.width * 0.72, size.height * 0.51, size.width * 0.58, size.height * 0.27, size.width * 0.49, size.height / 3)
      ..cubicTo(size.width * 0.41, size.height * 0.38, size.width * 0.34, size.height / 2, size.width / 4, size.height * 0.63)
      ..cubicTo(size.width * 0.18, size.height * 0.75, size.width * 0.1, size.height * 0.88, 0, size.height)
      ..close();

  @override
  Path coral(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.82)
      ..cubicTo(size.width * 0.01, size.height * 0.81, size.width * 0.02, size.height * 0.8, size.width * 0.03, size.height * 0.79)
      ..cubicTo(size.width * 0.24, size.height * 0.56, size.width * 0.28, size.height * 0.52, size.width * 0.57, size.height * 0.11)
      ..cubicTo(size.width * 0.74, size.height * (-0.13), size.width * 0.84, size.height * 0.04, size.width, size.height * 0.39)
      ..lineTo(size.width, size.height * 0.68)
      ..cubicTo(size.width * 0.85, size.height * 0.4, size.width * 0.71, size.height * 0.16, size.width * 0.63, size.height * 0.22)
      ..cubicTo(size.width * 0.55, size.height * 0.27, size.width * 0.47, size.height * 0.39, size.width * 0.38, size.height * 0.52)
      ..cubicTo(size.width * 0.28, size.height * 0.68, size.width * 0.16, size.height * 0.86, 0, size.height)
      ..close();

  @override
  Path coralDark(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.805)
      ..cubicTo(size.width * 0.16, size.height * 0.66, size.width * 0.28, size.height * 0.48, size.width * 0.38, size.height * 0.33)
      ..cubicTo(size.width * 0.47, size.height * 0.19, size.width * 0.55, size.height * 0.09, size.width * 0.63, size.height * 0.03)
      ..cubicTo(size.width * 0.76, size.height * (-0.06), size.width * 0.87, size.height * 0.05, size.width, size.height / 3)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width * 0.92, size.height * 0.84, size.width * 0.85, size.height * 0.69, size.width * 0.79, size.height * 0.55)
      ..cubicTo(size.width * 0.69, size.height * 0.34, size.width * 0.62, size.height * 0.18, size.width * 0.58, size.height * 0.16)
      ..cubicTo(size.width * 0.54, size.height * 0.15, size.width * 0.46, size.height * 0.29, size.width * 0.34, size.height * 0.48)
      ..cubicTo(size.width / 4, size.height * 0.64, size.width * 0.13, size.height * 0.83, 0, size.height)
      ..close();

  @override
  Path orange(Size size) => Path()
      ..moveTo(0, size.height * 1.01)
      ..lineTo(0, size.height * 0.7)
      ..cubicTo(size.width * 0.14, size.height * 0.57, size.width * 0.24, size.height * 0.43, size.width / 3, size.height * 0.3)
      ..cubicTo(size.width * 0.44, size.height * 0.14, size.width * 0.52, size.height * 0.02, size.width * 0.61, 0)
      ..cubicTo(size.width * 0.75, -0.02, size.width * 0.88, size.height * 0.12, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height * 0.67)
      ..cubicTo(size.width * 0.84, size.height / 3, size.width * 0.71, size.height * 0.06, size.width * 0.57, size.height * 0.26)
      ..cubicTo(size.width * 0.28, size.height * 0.69, size.width * 0.24, size.height * 0.73, size.width * 0.03, size.height * 0.97)
      ..cubicTo(size.width * 0.02, size.height * 0.98, size.width * 0.01, size.height, 0, size.height * 1.01)
      ..close();

  @override
  Path orangeDark(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.89)
      ..cubicTo(size.width * 0.02, size.height * 0.85, size.width * 0.05, size.height * 0.81, size.width * 0.07, size.height * 0.76)
      ..cubicTo(size.width * 0.41, size.height * 0.05, size.width * 0.44, 0, size.width * 0.61, 0)
      ..cubicTo(size.width * 0.73, 0, size.width * 0.87, size.height * 0.15, size.width, size.height * 0.35)
      ..lineTo(size.width, size.height / 2)
      ..cubicTo(size.width * 0.84, size.height * 0.22, size.width * 0.71, size.height * 0.07, size.width * 0.56, size.height * 0.24)
      ..cubicTo(size.width * 0.37, size.height * 0.44, size.width * 0.3, size.height * 0.56, size.width * 0.09, size.height * 0.87)
      ..cubicTo(size.width * 0.06, size.height * 0.91, size.width * 0.03, size.height * 0.95, 0, size.height)
      ..close();

  @override
  Path yellow(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.285)
      ..cubicTo(size.width / 5, size.height * 0.07, size.width * 0.41, size.height * (-0.1), size.width * 0.61, size.height * 0.07)
      ..cubicTo(size.width * 0.72, size.height * 0.15, size.width * 0.81, size.height * 0.25, size.width * 0.89, size.height * 0.34)
      ..cubicTo(size.width * 0.93, size.height * 0.38, size.width * 0.96, size.height * 0.42, size.width, size.height * 0.46)
      ..lineTo(size.width, size.height * 0.7)
      ..cubicTo(size.width * 0.84, size.height * 0.58, size.width * 0.7, size.height * 0.48, size.width * 0.61, size.height * 0.52)
      ..cubicTo(size.width * 0.54, size.height * 0.55, size.width * 0.46, size.height * 0.62, size.width * 0.38, size.height * 0.7)
      ..cubicTo(size.width * 0.28, size.height * 0.8, size.width * 0.16, size.height * 0.91, 0, size.height)
      ..close();

  @override
  Path yellowDark(Size size) => Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.4)
      ..cubicTo(size.width * 0.1, size.height / 4, size.width / 5, size.height * 0.11, size.width * 0.39, size.height * 0.03)
      ..cubicTo(size.width * 0.63, size.height * (-0.07), size.width * 0.85, size.height * 0.09, size.width, size.height * 0.29)
      ..lineTo(size.width, size.height * 0.6)
      ..cubicTo(size.width * 0.84, size.height * 0.38, size.width * 0.7, size.height * 0.19, size.width * 0.61, size.height / 4)
      ..cubicTo(size.width * 0.54, size.height * 0.31, size.width * 0.46, size.height * 0.41, size.width * 0.38, size.height * 0.54)
      ..cubicTo(size.width * 0.28, size.height * 0.69, size.width * 0.16, size.height * 0.86, 0, size.height)
      ..close();
}
