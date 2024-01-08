import 'package:flutter/material.dart';

typedef OnPressed = void Function();

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.padding,
  });

  factory CustomIconButton.close({OnPressed? onPressed}) => CustomIconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.close),
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
