import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class OutlinedRoundedButton extends StatelessWidget {
  final String text;
  final AssetImage? icon;
  final VoidCallback? onPressed;
  final double? radius;
  final double? textPadding;
  final BorderRadius? borderRadius;

  const OutlinedRoundedButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
    this.radius,
    this.textPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 38.0),
          disabledForegroundColor: AppColors.darkGreen.withOpacity(0.4),
          disabledBackgroundColor: AppColors.darkGreen.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                const BorderRadius.all(
                  Radius.circular(5.0),
                ),
          ),
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        onPressed: onPressed,
        icon: ImageIcon(icon),
        label: Text(text),
      );
    }

    final styles = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 5.0),
        ),
      ),
      side: const BorderSide(width: 1.0, color: AppColors.darkGreen),
      minimumSize: const Size(0, 38.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );

    if (icon == null) {
      return OutlinedButton(
        style: styles,
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: textPadding ?? 0),
          child: Text(text),
        ),
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
