import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopcare_frontend/core/domain/input_formatters/serving_formatter.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

import '../../../../../core/presentation/themes/themes.dart';

class ServingInputField extends StatefulWidget {
  final TextEditingController controller;
  final Color fillColor;
  final void Function(String) onChange;
  final FocusNode? focusNode;
  final TextInputFormatter? inputFormatter;
  final bool isReadOnly;

  const ServingInputField({
    super.key,
    required this.controller,
    required this.fillColor,
    required this.onChange,
    this.focusNode,
    this.inputFormatter,
    required this.isReadOnly,
  });

  @override
  State<ServingInputField> createState() => _ServingInputFieldState();
}

class _ServingInputFieldState extends State<ServingInputField> {
  int _valueLength = 0;

  @override
  void initState() {
    _valueLength = widget.controller.text.length;
    super.initState();
  }

  void _onValueChangeHandler(String val) {
    setState(() {
      _valueLength = val.length;
    });

    final formattedValue = val.replaceAll(',', '.');
    if (formattedValue.endsWith('.')) formattedValue.replaceAll('.', '');

    widget.onChange(formattedValue);
  }

  double get _fontSizeDependsOnValueLength {
    if (_valueLength <= 4) return 14.0;
    if (_valueLength > 4 && _valueLength <= 6) return 10.0;
    if (_valueLength > 6) return 8.0;
    return 14.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      height: 34.0,
      child: CustomTextField(
        readOnly: widget.isReadOnly,
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLength: 7,
        textAlign: TextAlign.center,
        onChanged: _onValueChangeHandler,
        inputFormatters: [
          ServingFormatter(),
          if (widget.inputFormatter != null) widget.inputFormatter!,
        ],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: _fontSizeDependsOnValueLength,
        ),
        hintText: '',
      ),
    );
  }
}
