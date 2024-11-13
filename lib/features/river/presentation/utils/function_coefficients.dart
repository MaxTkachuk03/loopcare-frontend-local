class FunctionCoefficientsValues {
  final List<double> green;
  final List<double> blue;
  final List<double> red;
  final List<double> orange;
  final List<double> yellow;

  const FunctionCoefficientsValues({
    required this.green,
    required this.blue,
    required this.red,
    required this.orange,
    required this.yellow,
  });

  const FunctionCoefficientsValues.one()
      : green = const [-0.07, -0.59, 0.13, 0.34],
        blue = const [-0.06, -0.55, 0.2, 0.46],
        red = const [-0.06, -0.56, 0.15, 0.55],
        orange = const [-0.07, -0.59, 0.16, 0.65],
        yellow = const [-0.07, -0.5, 0.24, 0.77];

  const FunctionCoefficientsValues.two()
      : green = const [-0.06, -0.57, 0.53, 0.24],
        blue = const [-0.06, -0.57, 0.6, 0.36],
        red = const [-0.07, -0.57, 0.62, 0.44],
        orange = const [-0.07, -0.57, 0.62, 0.53],
        yellow = const [0.045, -0.61, -0.15, 0.56];

  const FunctionCoefficientsValues.three()
      : green = const [0.05, 0.76, 0.8, 0.16],
        blue = const [0.04, 0.6, 0.82, 0.27],
        red = const [0.03, 0.55, 0.86, 0.36],
        orange = const [0.04, 0.55, 0.84, 0.45],
        yellow = const [0.04, 0.52, 0.82, 0.58];

  const FunctionCoefficientsValues.four()
      : green = const [-0.056, -0.5, 0.32, 0.37],
        blue = const [-0.1, -0.62, 0.304, 0.448],
        red = const [-0.104, -0.7, 0.34, 0.52],
        orange = const [-0.098, -0.7, 0.376, 0.6],
        yellow = const [-0.08, 0.72, 0.92, 0.68];

  const FunctionCoefficientsValues.five()
      : green = const [0.06, -0.63, 0.23, 0.15],
        blue = const [0.05, 0.6, 0.72, 0.28],
        red = const [0.08, 0.6, 0.73, 0.37],
        orange = const [0.06, 0.6, 0.76, 0.48],
        yellow = const [0.06, -0.7, 0.28, 0.6];

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

class FunctionCoefficients {
  final int index;

  const FunctionCoefficients(this.index);

  FunctionCoefficientsValues get values => switch (index) {
        1 => const FunctionCoefficientsValues.one(),
        2 => const FunctionCoefficientsValues.two(),
        3 => const FunctionCoefficientsValues.three(),
        4 => const FunctionCoefficientsValues.four(),
        _ => const FunctionCoefficientsValues.five(),
      };
}
