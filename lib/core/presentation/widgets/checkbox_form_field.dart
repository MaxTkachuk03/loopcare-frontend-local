import 'package:flutter/material.dart';

class CheckboxFormField extends StatefulWidget {
  final Widget text;
  final String errorText;
  final Function(bool? value)? onChanged;

  const CheckboxFormField({
    Key? key,
    required this.text,
    required this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      validator: (newValue) {
        return newValue != null && !newValue ? widget.errorText : null;
      },
      initialValue: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        final errorText = state.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22,
                  width: 22,
                  child: Checkbox(
                    value: value,
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue ?? false;
                        widget.onChanged?.call(value);
                        state.didChange(value);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: widget.text,
                )
              ],
            ),
            if (errorText != null)
              Column(
                children: [
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    errorText,
                    style: Theme.of(context).inputDecorationTheme.errorStyle,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
