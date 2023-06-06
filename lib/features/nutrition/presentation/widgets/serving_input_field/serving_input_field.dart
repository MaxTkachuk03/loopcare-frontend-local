import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/input_formatters/serving_formatter.dart';

class ServingInputField extends StatefulWidget {
  final TextEditingController controller;
  final Color fillColor;
  final void Function(String) onChange;
  final FocusNode? focusNode;

  const ServingInputField({
    Key? key,
    required this.controller,
    required this.fillColor,
    required this.onChange,
    this.focusNode,
  }) : super(key: key);

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
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLength: 7,
        onChanged: _onValueChangeHandler,
        textAlign: TextAlign.center,
        inputFormatters: [ServingFormatter()],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: _fontSizeDependsOnValueLength),
      ),
    );
  }
}
