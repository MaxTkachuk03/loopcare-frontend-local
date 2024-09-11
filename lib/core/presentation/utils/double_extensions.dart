extension DoubleExtension on double {
  String removeDecimalZeroFormat() {
    final regex = RegExp(r'([.]*0)(?!.*\d)');

    return toString().replaceAll(regex, '');
  }
}
