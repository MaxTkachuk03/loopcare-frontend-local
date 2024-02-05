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

class ServingRangeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (double.parse(newValue.text) <= 0) {
      return const TextEditingValue().copyWith(text: '0.1');
    }

    return double.parse(newValue.text) > 100 ? oldValue : newValue;
  }
}
