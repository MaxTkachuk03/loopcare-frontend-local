import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LockedWidget extends StatelessWidget {
  const LockedWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.actionIcon = AppIcons.arrow,
    this.onTap,
    this.highlightColor = AppColors.blueLightest,
    this.editable = true,
    this.circleButton = true,
  });

  final void Function()? onTap;
  final Color highlightColor;
  final Widget leadingIcon;
  final Widget title;
  final bool editable;
  final bool circleButton;
  final AssetImage actionIcon;

  @override
  Widget build(BuildContext context) {
    Widget action = SizedBox.square(
      dimension: 44.0,
      child: Center(
        child: Image(
          image: actionIcon,
        ),
      ),
    );

    if (circleButton) {
      action = DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blueLightest,
        ),
        child: action,
      );
    }

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: editable ? onTap : null,
        highlightColor: highlightColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Row(
            children: [
              leadingIcon,
              const SizedBox(width: 24.0),
              title,
              const Spacer(),
              if (editable) action,
            ],
          ),
        ),
      ),
    );
  }
}
