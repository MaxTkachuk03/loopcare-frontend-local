import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MealPortionsInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const MealPortionsInput({
    super.key,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      height: 34.0,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 2,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.bgGreen,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
        ),
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
