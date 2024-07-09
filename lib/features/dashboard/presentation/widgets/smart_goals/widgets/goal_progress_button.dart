import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class GoalProgressButton extends StatelessWidget {
  final WeeklySmartGoal item;
  final int times;
  final VoidCallback? onPressed;
  final VoidCallback? onResetProgress;

  const GoalProgressButton({super.key, required this.item, required this.times, this.onPressed, this.onResetProgress});

  Color get bgColor => times > 0 ? AppColors.greenRegular : AppColors.blueLightest;

  Color get fgColor => times > 0 ? AppColors.white : AppColors.blueDarkest;

  @override
  Widget build(BuildContext context) {
    final child = InkWell(
      onLongPress: onResetProgress,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        width: 44.0,
        height: 44.0,
        child: Icon(
          Icons.check,
          color: onPressed == null ? AppColors.greyLight : fgColor,
          size: 22,
        ),
      ),
    );

    if (times > 0) {
      return badge.Badge(
        badgeStyle: const badge.BadgeStyle(
          padding: EdgeInsets.all(5),
          badgeColor: AppColors.blueRegular,
          elevation: 0,
        ),
        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
        position: badge.BadgePosition.topEnd(top: -8, end: -4),
        badgeContent: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: CustomText.w600(
            times.toString(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: ThemeConstants.fontSize10,
              color: AppColors.white,
            ),
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}
