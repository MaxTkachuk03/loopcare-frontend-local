import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/utils/reg_exp_utils.dart';

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
    }

    final text = newValue.text.replaceAll(',', '.');
    if ((double.tryParse(text) ?? 0) < 0) {
      return const TextEditingValue().copyWith(text: '0.1');
    }

    return double.parse(text) > 100 ? oldValue : newValue;
  }
}
