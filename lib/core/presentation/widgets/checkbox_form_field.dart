import 'package:flutter/material.dart';

class CheckboxFormField extends StatefulWidget {
  final Widget text;
  final Function(bool? value)? onChanged;

  const CheckboxFormField({
    Key? key,
    required this.text,
    this.onChanged,
  }) : super(key: key);

  @override
  _CheckboxFormFieldState createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      builder: (state) {
        return Row(
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
        );
      },
    );
  }
}
