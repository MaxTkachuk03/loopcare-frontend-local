import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Key? key,
    required this.unit,
    required this.controller,
    required this.maxLength,
    required this.counterText,
    this.onChanged,
    this.isDecimal,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextFormField(
              maxLength: maxLength,
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: isDecimal ?? false,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(_getRegexString()))
              ],
              style: Theme.of(context).textTheme.displayLarge,
              decoration: InputDecoration(
                counterText: counterText,
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.transparent,
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
          child: Text(
            unit,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  String _getRegexString() {
    final isDecimal = this.isDecimal;

    return isDecimal != null && isDecimal
        ? RegExpUtils.withDecimals
        : RegExpUtils.onlyDigits;
  }
}
