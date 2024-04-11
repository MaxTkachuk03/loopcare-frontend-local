import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_button_with_icon.dart';

class WeeklyTimesCorrector extends StatelessWidget {
  final Function()? onIncrease;
  final Function()? onDecreased;

  const WeeklyTimesCorrector({super.key, required this.onIncrease, required this.onDecreased});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleButton(
          icon: AppIcons.plus,
          onTap: onIncrease,
        ),
        const SizedBox(
          width: 8.0,
        ),
        _CircleButton(
          icon: AppIcons.minus,
          onTap: onDecreased,
        )
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final AssetImage icon;
  final Function()? onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedRoundedButtonWithIcon(
      onPressed: onTap,
      icon: icon,
      bgColor: AppColors.blueLightest,
    );
  }
}
