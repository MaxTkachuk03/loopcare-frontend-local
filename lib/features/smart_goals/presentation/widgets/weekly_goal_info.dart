import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class WeeklyGoalInfo extends StatelessWidget {
  final Key key;
  final WeeklySmartGoal weeklyGoal;
  final void Function() onDone;

  const WeeklyGoalInfo({
    required this.key,
    required this.weeklyGoal,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        CustomText.bitter600(weeklyGoal.title, style: context.textTheme.displayMedium),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppColors.greenRegular,
                  child: Icon(Icons.emoji_objects_rounded),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CustomText.w400(
                    weeklyGoal.smartGoal.funFact,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
