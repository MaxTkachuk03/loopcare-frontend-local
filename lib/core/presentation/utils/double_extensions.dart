extension DoubleExtension on double {
  String removeDecimalZeroFormat() {
    final regex = RegExp(r'([.]*0)(?!.*\d)');

    return toString().replaceAll(regex, '');
  }

  String toStringWithRounded(int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits)).removeDecimalZeroFormat();
  }
}

