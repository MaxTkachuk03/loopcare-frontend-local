import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/weekly_activities_list.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class FilledActivitiesList extends StatelessWidget {
  final List<PhysicalProgram> programsList;

  const FilledActivitiesList({
    super.key,
    required this.programsList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${programsList.length} ${LocalizedTexts.activitiesForThisWeek.translation.toUpperCase()}',
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 16.0),
        WeeklyActivitiesList(data: [...programsList]),
      ],
    );
  }
}
