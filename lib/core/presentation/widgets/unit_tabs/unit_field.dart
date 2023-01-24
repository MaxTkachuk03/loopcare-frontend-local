import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/reg_exp_utils.dart';

class UnitField extends StatelessWidget {
  final TextEditingController controller;
  final String unit;
  final bool? isDecimal;
  final FocusNode? focusNode;

  const UnitField({
    Key? key,
    required this.unit,
    required this.controller,
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
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: isDecimal ?? false,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(_getRegexString()))
              ],
              autofocus: true,
              style: Theme.of(context).textTheme.headline1,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 6.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            unit,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
