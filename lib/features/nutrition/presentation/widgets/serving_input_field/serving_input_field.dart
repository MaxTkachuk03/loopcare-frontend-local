import 'package:flutter/material.dart';

class ServingInputField extends StatelessWidget {
  final TextEditingController controller;
  final Color fillColor;

  const ServingInputField({
    Key? key,
    required this.controller,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      child: TextField(
        controller: controller,
        maxLength: 2,
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
            .caption!
            .copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
