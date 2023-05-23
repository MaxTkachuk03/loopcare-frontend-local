import 'package:flutter/services.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/reg_exp_utils.dart';

class ServingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow digits, comma, and dot
    final RegExp regExp = RegExp(RegExpUtils.digitsWithDotOrComma);
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
