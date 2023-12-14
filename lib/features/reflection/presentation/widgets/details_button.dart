import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class DetailsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const DetailsButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
          side: MaterialStateProperty.all(
            const BorderSide(width: 1.0, color: AppColors.blueDark),
          ),
          minimumSize: MaterialStateProperty.all(const Size(0, 34.0)),
          foregroundColor: MaterialStateProperty.all(AppColors.blueDark)),
      onPressed: onPressed,
      child: const Text('Details'),
    );
  }
}
