import 'dart:math' as math;
import 'dart:ui';

import 'function_coefficients.dart';

const List<Offset> _zeroPagePositions = [
  Offset(0.76, 0.62),
  Offset(0.88, 0.45),
];

const Offset _startButtonPosition = Offset(0.39, 0.31);

class ModuleItemsUtils {
  static get zeroPagePositions => _zeroPagePositions;

  static get startButtonPosition => _startButtonPosition;

  static Offset getOffset(int page, int itemIndex, int stream) {
    final dx = ItemsPositions(page).values.elementAt(stream, itemIndex);
    return _getOffset(dx, page, stream);
  }

  static Offset getRootOffset(int page) {
    const dx = 0.5;
    return _getOffset(dx, page, 2);
  }

  static Offset _getOffset(double dx, int page, int stream) {
    final dy = (1 - _g(FunctionCoefficients(page).values.elementAt(stream), dx));
    return Offset(dx, dy);
  }

  static double _f(double x) => (math.pow(x, 2)) + math.sin(3 * x);

  static double _g(List<double> constants, double x) {
    assert(constants.length == 4);

    final a = constants[0];
    final b = constants[1];
    final c = constants[2];
    final d = constants[3];

    return d + a * _f((x - c) / b);
  }
}