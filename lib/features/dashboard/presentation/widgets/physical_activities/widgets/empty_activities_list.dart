import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class EmptyActivitiesList extends StatelessWidget {
  const EmptyActivitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '0 ${LocalizedTexts.activitiesForThisWeek.translation.toUpperCase()}',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          LocalizedTexts.physicalActivitiesFrequencyZero.translation,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreen,
          ),
        ),
      ],
    );
  }
}
