import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

class GoalReviewCard extends StatelessWidget {
  final WeeklySmartGoal item;

  const GoalReviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19.0),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1, color: AppColors.blueDarker)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryLabel(label: item.categoryName, color: AppColors.greenRegular),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomText.w600(item.title, style: context.textTheme.bodyLarge),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.w400('${LocalizedTexts.goal.tr()}:', style: context.textTheme.bodyMedium),
              CustomText.w400(
                LocalizedTexts.timesInDays.tr(args: ['${item.requiredCompletions}', '${item.requiredDays}']),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText.w400('${LocalizedTexts.yourCompletion.tr()}:', style: context.textTheme.bodyMedium),
              CustomText.w400(
                LocalizedTexts.timesInDays.tr(args: ['${item.requiredCompletions}', '${item.requiredDays}']),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
