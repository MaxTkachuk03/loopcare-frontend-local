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
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        onTap: onPressed,
        child: CircleAvatar(
          backgroundColor: bgColor,
          radius: radius,
          child: Icon(
            icon,
            color: iconColor,
            size: radius * 1.44,
          ),
        ),
      ),
    );
  }
}
