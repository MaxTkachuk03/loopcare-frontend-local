import 'package:flutter/material.dart';

class RiverModuleButton extends StatelessWidget {
  final IconData icon;
  final double elevation;
  final double radius;
  final Color? bgColor;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const RiverModuleButton({
    super.key,
    required this.icon,
    this.radius = 25,
    this.elevation = 4,
    this.bgColor,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        fixedSize: Size.square(radius * 2),
        padding: EdgeInsets.zero,
        elevation: elevation,
        shadowColor: Colors.black,
        highlightColor: iconColor?.withOpacity(0.16),
        disabledBackgroundColor: bgColor,
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: radius * 1.44,
      ),
    );
  }
}
