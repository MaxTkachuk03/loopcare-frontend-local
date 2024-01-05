import 'package:flutter/services.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/reg_exp_utils.dart';

class ServingFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow digits, comma, and dot
    final RegExp regExp = RegExp(RegExpUtils.digitsWithDotOrComma);
    if (regExp.hasMatch(newValue.text) || newValue.text.isEmpty) {
      return newValue;
    }
    return oldValue;
  }
}
