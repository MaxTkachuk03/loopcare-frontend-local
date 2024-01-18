import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomOutlinedRoundedButtonWithIcon extends StatelessWidget {
  final AssetImage? icon;
  final VoidCallback? onPressed;
  final double? radius;
  final Color? bgColor;
  final Color? iconColor;

  const CustomOutlinedRoundedButtonWithIcon({
    super.key,
    this.icon,
    this.onPressed,
    this.radius,
    this.bgColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.blueLightest,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 32.0)),
      ),
      width: 44.0,
      height: 44.0,
      child: IconButton(
        icon: ImageIcon(
          icon ?? AppIcons.plus,
          color: onPressed == null ? AppColors.greyLight : iconColor ?? AppColors.blueDarker,
          size: 22,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
