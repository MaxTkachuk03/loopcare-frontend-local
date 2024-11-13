import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/weekly_activities_list.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText.bitter600(
          '${programsList.length} ${LocalizedTexts.activitiesForThisWeek.tr().toUpperCase()}',
          style: context.textTheme.bodySmall,
        ),
        if (programsList.isNotEmpty) const SizedBox(height: 16.0),
        WeeklyActivitiesList(data: programsList),
      ],
    );
  }
}
