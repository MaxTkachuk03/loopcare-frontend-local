import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class OutlinedRoundedButton extends StatelessWidget {
  final String text;
  final AssetImage? icon;
  final VoidCallback? onPressed;

  const OutlinedRoundedButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styles = OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      disabledBackgroundColor: AppColors.darkGreen.withOpacity(0.1),
      side: const BorderSide(width: 1.0, color: AppColors.darkGreen),
      minimumSize: const Size(0, 38.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      textStyle: Theme.of(context).textTheme.caption?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );

    if (icon == null) {
      return OutlinedButton(
        style: styles,
        onPressed: onPressed,
        child: Text(text),
      );
    }

    return OutlinedButton.icon(
      style: styles,
      onPressed: onPressed,
      icon: ImageIcon(icon),
      label: Text(text),
    );
  }
}
