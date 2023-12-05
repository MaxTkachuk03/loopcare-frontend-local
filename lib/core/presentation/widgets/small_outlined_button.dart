import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SmallOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SmallOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: OutlinedButton(
        onPressed: onPressed,
        style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
              minimumSize: MaterialStateProperty.all(
                const Size(
                  0,
                  32,
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(width: 1.0, color: AppColors.yellowLight),
              ),
              textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
            ),
        child: Text(text),
      ),
    );
  }
}
