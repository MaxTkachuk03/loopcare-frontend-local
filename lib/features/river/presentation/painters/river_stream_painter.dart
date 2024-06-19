import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const Color _green = Color(0xffAECA5F);
const Color _greenDark = Color(0xff93B23C);
const Color _petrol = Color(0xff3C9AA8);
const Color _petrolDark = Color(0xff2B7B87);
const Color _coral = Color(0xffFF7E78);
const Color _coralDark = Color(0xffEE6B65);
const Color _orange = Color(0xffFD9447);
const Color _orangeDark = Color(0xffE87F34);
const Color _yellow = Color(0xffFFCC58);
const Color _yellowDark = Color(0xffF1BD45);

const Color _blueLightest = Color(0xff4673A3);
const Color _blueLighter = Color(0xff3C6897);
const Color _blue = Color(0xff245284);
const Color _blueDark = Color(0xff1D4978);
const Color _blueDarker = Color(0xff163F6C);
const Color _blueDarkest = Color(0xff10355F);

abstract class FunctionCoefficientsValues {
  const FunctionCoefficientsValues();

  @mustBeOverridden
  List<double> get green => [];

  @mustBeOverridden
  List<double> get blue => [];

  @mustBeOverridden
  List<double> get red => [];

  @mustBeOverridden
  List<double> get orange => [];

  @mustBeOverridden
  List<double> get yellow => [];

  List<double> elementAt(int i) {
    assert(i < 5);

    return switch (i) {
      0 => yellow,
      1 => orange,
      2 => red,
      3 => blue,
      _ => green,
    };
  }
}

abstract class ItemsPositionValues {
  const ItemsPositionValues();

  @mustBeOverridden
  List<double> get green => [];

  @mustBeOverridden
  List<double> get blue => [];

  @mustBeOverridden
  List<double> get red => [];

  @mustBeOverridden
  List<double> get orange => [];

  @mustBeOverridden
  List<double> get yellow => [];

  double elementAt(int stream, int index) {
    assert(stream < 5);

    return switch (stream) {
      0 => yellow[index],
      1 => orange[index],
      2 => red[index],
      3 => blue[index],
      _ => green[index],
    };
  }
}

abstract class RenderRiverStreamPainter extends CustomPainter {

  final bool enableGradient;
  final bool fillColor;
  final double gradientPositionStart;
  final double gradientPositionEnd;

  const RenderRiverStreamPainter({
    required this.gradientPositionStart,
    required this.gradientPositionEnd,
    required this.enableGradient,
    required this.fillColor,
  });

  @mustBeOverridden
  final double greenHeightCoefficient = 0;

  @mustBeOverridden
  final double greenDarkHeightCoefficient = 0;

  @mustBeOverridden
  final double petrolHeightCoefficient = 0;

  @mustBeOverridden
  final double petrolDarkHeightCoefficient = 0;

  @mustBeOverridden
  final double coralHeightCoefficient = 0;

  @mustBeOverridden
  final double coralDarkHeightCoefficient = 0;

  @mustBeOverridden
  final double orangeHeightCoefficient = 0;

  @mustBeOverridden
  final double orangeDarkHeightCoefficient = 0;

  @mustBeOverridden
  final double yellowHeightCoefficient = 0;

  @mustBeOverridden
  final double yellowDarkHeightCoefficient = 0;

  @mustBeOverridden
  final double greenOffsetCoefficient = 0;

  @mustBeOverridden
  final double greenDarkOffsetCoefficient = 0;

  @mustBeOverridden
  final double petrolOffsetCoefficient = 0;

  @mustBeOverridden
  final double petrolDarkOffsetCoefficient = 0;

  @mustBeOverridden
  final double coralOffsetCoefficient = 0;

  @mustBeOverridden
  final double coralDarkOffsetCoefficient = 0;

  @mustBeOverridden
  final double orangeOffsetCoefficient = 0;

  @mustBeOverridden
  final double orangeDarkOffsetCoefficient = 0;

  @mustBeOverridden
  final double yellowOffsetCoefficient = 0;

  @mustBeOverridden
  final double yellowDarkOffsetCoefficient = 0;

  final double greenHorizontalOffsetCoefficient = 0;

  final double greenDarkHorizontalOffsetCoefficient = 0;

  final double petrolHorizontalOffsetCoefficient = 0;

  final double petrolDarkHorizontalOffsetCoefficient = 0;

  final double coralHorizontalOffsetCoefficient = 0;

  final double coralDarkHorizontalOffsetCoefficient = 0;

  final double orangeHorizontalOffsetCoefficient = 0;

  final double orangeDarkHorizontalOffsetCoefficient = 0;

  final double yellowHorizontalOffsetCoefficient = 0;

  final double yellowDarkHorizontalOffsetCoefficient = 0;

  Path green(Size size);

  Path greenDark(Size size);

  Path petrol(Size size);

  Path petrolDark(Size size);

  Path coral(Size size);

  Path coralDark(Size size);

  Path orange(Size size);

  Path orangeDark(Size size);

  Path yellow(Size size);

  Path yellowDark(Size size);

  Paint _pathPaint(Size size, Color fill, Color empty, double horizontalOffset) {
    if (enableGradient) {
      final delta = gradientPositionEnd - gradientPositionStart;
      final step = horizontalOffset + gradientPositionStart * (1 - horizontalOffset);

      return Paint()..shader = LinearGradient(
        colors: [fill, empty],
        stops: [step, step + delta],
      ).createShader(Rect.fromLTRB(0, 0, size.width / (1 - horizontalOffset), size.height));
    } else if (fillColor) {
      return Paint()..color = fill;
    } else {
      return Paint()..color = empty;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final greenSize = Size(size.width * (1 - greenHorizontalOffsetCoefficient), size.height * greenHeightCoefficient);
    final greenOffset = Offset(size.width * greenHorizontalOffsetCoefficient, size.height * greenOffsetCoefficient);
    final greenPaint = _pathPaint(greenSize, _green, _blueDarkest, greenHorizontalOffsetCoefficient);
    final greenPath = Path()..addPath(green(greenSize), greenOffset);

    final greenDarkSize = Size(size.width * (1 - greenDarkHorizontalOffsetCoefficient), size.height * greenDarkHeightCoefficient);
    final greenDarkOffset = Offset(size.width * greenDarkHorizontalOffsetCoefficient, size.height * greenDarkOffsetCoefficient);
    final greenDarkPaint = _pathPaint(greenDarkSize, _greenDark, _blueDarker, greenDarkHorizontalOffsetCoefficient);
    final greenDarkPath = Path()..addPath(greenDark(greenDarkSize), greenDarkOffset);

    final petrolSize = Size(size.width * (1 - petrolHorizontalOffsetCoefficient), size.height * petrolHeightCoefficient);
    final petrolOffset = Offset(size.width * petrolHorizontalOffsetCoefficient, size.height * petrolOffsetCoefficient);
    final petrolPaint = _pathPaint(petrolSize, _petrol, _blueDark, petrolHorizontalOffsetCoefficient);
    final petrolPath = Path()..addPath(petrol(petrolSize), petrolOffset);

    final petrolDarkSize = Size(size.width * (1 - petrolDarkHorizontalOffsetCoefficient), size.height * petrolDarkHeightCoefficient);
    final petrolDarkOffset = Offset(size.width * petrolDarkHorizontalOffsetCoefficient, size.height * petrolDarkOffsetCoefficient);
    final petrolDarkPaint = _pathPaint(petrolDarkSize, _petrolDark, _blue, petrolDarkHorizontalOffsetCoefficient);
    final petrolDarkPath = Path()..addPath(petrolDark(petrolDarkSize), petrolDarkOffset);

    final coralSize = Size(size.width * (1 - coralHorizontalOffsetCoefficient), size.height * coralHeightCoefficient);
    final coralOffset = Offset(size.width * coralHorizontalOffsetCoefficient, size.height * coralOffsetCoefficient);
    final coralPaint = _pathPaint(coralSize, _coral, _blueLightest, coralHorizontalOffsetCoefficient);
    final coralPath = Path()..addPath(coral(coralSize), coralOffset);

    final coralDarkSize = Size(size.width * (1 - coralDarkHorizontalOffsetCoefficient), size.height * coralDarkHeightCoefficient);
    final coralDarkOffset = Offset(size.width * coralDarkHorizontalOffsetCoefficient, size.height * coralDarkOffsetCoefficient);
    final coralDarkPaint = _pathPaint(coralDarkSize, _coralDark, _blueLighter, coralDarkHorizontalOffsetCoefficient);
    final coralDarkPath = Path()..addPath(coralDark(coralDarkSize), coralDarkOffset);

    final orangeSize = Size(size.width * (1 - orangeHorizontalOffsetCoefficient), size.height * orangeHeightCoefficient);
    final orangeOffset = Offset(size.width * orangeHorizontalOffsetCoefficient, size.height * orangeOffsetCoefficient);
    final orangePaint = _pathPaint(orangeSize, _orange, _blue, orangeHorizontalOffsetCoefficient);
    final orangePath = Path()..addPath(orange(orangeSize), orangeOffset);

    final orangeDarkSize = Size(size.width * (1 - orangeDarkHorizontalOffsetCoefficient), size.height * orangeDarkHeightCoefficient);
    final orangeDarkOffset = Offset(size.width * orangeDarkHorizontalOffsetCoefficient, size.height * orangeDarkOffsetCoefficient);
    final orangeDarkPaint = _pathPaint(orangeDarkSize, _orangeDark, _blueDark, orangeDarkHorizontalOffsetCoefficient);
    final orangeDarkPath = Path()..addPath(orangeDark(orangeDarkSize), orangeDarkOffset);

    final yellowSize = Size(size.width * (1 - yellowHorizontalOffsetCoefficient), size.height * yellowHeightCoefficient);
    final yellowOffset = Offset(size.width * yellowHorizontalOffsetCoefficient, size.height * yellowOffsetCoefficient);
    final yellowPaint = _pathPaint(yellowSize, _yellow, _blueDarkest, yellowHorizontalOffsetCoefficient);
    final yellowPath = Path()..addPath(yellow(yellowSize), yellowOffset);

    final yellowDarkSize = Size(size.width * (1 - yellowDarkHorizontalOffsetCoefficient), size.height * yellowDarkHeightCoefficient);
    final yellowDarkOffset = Offset(size.width * yellowDarkHorizontalOffsetCoefficient, size.height * yellowDarkOffsetCoefficient);
    final yellowDarkPaint = _pathPaint(yellowDarkSize, _yellowDark, _blueDarker, yellowDarkHorizontalOffsetCoefficient);
    final yellowDarkPath = Path()..addPath(yellowDark(yellowDarkSize), yellowDarkOffset);

    canvas.drawPath(yellowPath, yellowPaint);
    canvas.drawPath(yellowDarkPath, yellowDarkPaint);
    canvas.drawPath(orangePath, orangePaint);
    canvas.drawPath(orangeDarkPath, orangeDarkPaint);
    canvas.drawPath(coralPath, coralPaint);
    canvas.drawPath(coralDarkPath, coralDarkPaint);
    canvas.drawPath(petrolDarkPath, petrolDarkPaint);
    canvas.drawPath(petrolPath, petrolPaint);
    canvas.drawPath(greenDarkPath, greenDarkPaint);
    canvas.drawPath(greenPath, greenPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
