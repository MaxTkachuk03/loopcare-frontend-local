import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

// TODO dead code
class SmallFilledButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const SmallFilledButton({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              const Size(
                0,
                38,
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(width: 1.0, color: AppColors.bgGreen),
            ),
            backgroundColor: MaterialStateProperty.all(backgroundColor ?? AppColors.bgGreen),
            foregroundColor: MaterialStateProperty.all(AppColors.darkGreen),
            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
          ),
      child: Text(text),
    );
  }
}
