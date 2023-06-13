import 'package:flutter/material.dart';

class CustomExerciseField extends StatelessWidget {
  final Function(String value) onChanged;

  const CustomExerciseField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      enableSuggestions: false,
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: const InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.only(top: 20.0, right: 22.0, left: 22.0, bottom: 28.0),
      ),
      onChanged: onChanged,
    );
  }
}
