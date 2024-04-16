import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

class WeeklyGoalListItem extends StatelessWidget {
  final SmartGoal item;

  const WeeklyGoalListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryLabel.smartGoals(label: item.category.name),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                style: context.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: '${item.shortTitle}: ',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: item.description,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomText.w400(
            LocalizedTexts.completeCounter.tr(
              args: [item.requiredCompletions.toString(), item.requiredDays.toString()],
            ),
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
