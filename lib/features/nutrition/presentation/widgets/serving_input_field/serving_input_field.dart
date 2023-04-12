import 'package:flutter/material.dart';

class ServingInputField extends StatelessWidget {
  final TextEditingController controller;
  final Color fillColor;
  final void Function(String) onChange;

  const ServingInputField({
    Key? key,
    required this.controller,
    required this.fillColor,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      height: 34.0,
      child: TextField(
        controller: controller,
        maxLength: 2,
        onChanged: onChange,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        ),
        keyboardType: TextInputType.number,
        style: Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
