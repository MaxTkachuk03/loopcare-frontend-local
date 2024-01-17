import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';

class CategoryLabel extends StatelessWidget {
  final String label;
  final Color color;

  const CategoryLabel({super.key, required this.label, required this.color});

  factory CategoryLabel.general() =>
      CategoryLabel(label: LessonCategory.general.label, color: AppColors.petrolRegular);

  factory CategoryLabel.nutrition() =>
      CategoryLabel(label: LessonCategory.nutrition.label, color: AppColors.greenRegular);

  factory CategoryLabel.mind() =>
      CategoryLabel(label: LessonCategory.mind.label, color: AppColors.orangeRegular);

  factory CategoryLabel.activity() =>
      CategoryLabel(label: LessonCategory.activity.label, color: AppColors.yellowRegular);

  factory CategoryLabel.assignment() =>
      CategoryLabel(label: LocalizedTexts.assignment.tr(), color: AppColors.petrolRegular);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), color: color),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: CustomText.w600(
        label.toUpperCase(),
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: ThemeConstants.fontSize10,
          color: AppColors.white,
        ),
      ),
    );
  }
}
