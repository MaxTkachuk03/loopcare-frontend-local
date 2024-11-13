import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class GoalAchievedWidget extends StatelessWidget {
  final WeeklySmartGoal item;

  const GoalAchievedWidget({super.key, required this.item});

  Color get bgColor => item.isAchieved ? AppColors.greenRegular : AppColors.blueLightest;

  Color get fgColor => item.isAchieved ? AppColors.white : AppColors.blueDarkest;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 22,
        ),
        Positioned(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              fgColor,
              BlendMode.srcIn,
            ),
            child: AppIcons.achieve,
          ),
        )
      ],
    );
  }
}
