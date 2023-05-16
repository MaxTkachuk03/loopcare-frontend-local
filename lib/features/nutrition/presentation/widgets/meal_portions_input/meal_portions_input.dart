import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MealPortionsInput extends StatelessWidget {
  final TextEditingController? controller;

  const MealPortionsInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      height: 34.0,
      child: TextField(
        controller: controller,
        maxLength: 2,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: '',
          filled: true,
          fillColor: AppColors.bgGreen,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
