import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class CaloriesTracker extends StatelessWidget {
  final double? totalCalories;

  const CaloriesTracker({super.key, this.totalCalories});

  String get _caloriesValue => (totalCalories ?? 0).toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 15,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(color: AppColors.white, style: BorderStyle.solid),
              ),
            ),
            const LinearProgressIndicator(
              minHeight: 15.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueRegular),
              backgroundColor: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              value: 0.3,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        CustomText.w600(
          '$_caloriesValue ${LocalizedTexts.calories.tr().toLowerCase()}',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
