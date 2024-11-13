import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/checkbox/custom_checkbox.dart';

class CheckboxFormField extends StatefulWidget {
  final Widget text;
  final String errorText;
  final Function(bool? value)? onChanged;

  const CheckboxFormField({
    super.key,
    required this.text,
    required this.errorText,
    this.onChanged,
  });

  @override
  State<CheckboxFormField> createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      validator: (newValue) => newValue != null && !newValue ? widget.errorText : null,
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
                  child: CustomCheckbox.green(
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
                const SizedBox(width: 16.0),
                Expanded(child: widget.text)
              ],
            ),
            if (errorText?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  errorText!,
                  style: Theme.of(context).inputDecorationTheme.errorStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}
