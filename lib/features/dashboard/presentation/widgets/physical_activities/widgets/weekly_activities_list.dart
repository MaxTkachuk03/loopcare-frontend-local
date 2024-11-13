import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/physical_activities/widgets/physical_activities_list_item.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class WeeklyActivitiesList extends StatelessWidget {
  final List<PhysicalProgram> data;

  const WeeklyActivitiesList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) => PhysicalActivitiesListItem(item: data[index]),
    );
  }
}
