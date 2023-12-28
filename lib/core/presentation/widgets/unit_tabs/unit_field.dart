import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/reg_exp_utils.dart';

class UnitField extends StatelessWidget {
  final TextEditingController controller;
  final String unit;
  final bool? isDecimal;
  final FocusNode? focusNode;
  final int maxLength;
  final String counterText;
  final ValueChanged<String>? onChanged;

  const UnitField({
    super.key,
    required this.unit,
    required this.controller,
    required this.maxLength,
    required this.counterText,
    this.onChanged,
    this.isDecimal,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: CustomTextField.unit(
              controller: controller,
              maxLength: maxLength,
              focusNode: focusNode,
              isDecimal: isDecimal,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(_getRegexString()))
              ],
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: ThemeConstants.fontSize48,
                fontFamily: ThemeConstants.bitterFontFamily,
              ),
              decoration: InputDecoration(
                counterText: counterText,
                contentPadding: EdgeInsets.zero,
                filled: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: CustomText.w600(unit, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }

  String _getRegexString() {
    final isDecimal = this.isDecimal;
    return isDecimal != null && isDecimal ? RegExpUtils.withDecimals : RegExpUtils.onlyDigits;
  }
}
