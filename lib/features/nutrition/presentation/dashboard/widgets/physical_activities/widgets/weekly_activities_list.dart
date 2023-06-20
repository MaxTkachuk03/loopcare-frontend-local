import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/physical_activities/widgets/physical_activities_list_item.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class WeeklyActivitiesList extends StatelessWidget {
  final List<PhysicalProgram> data;

  const WeeklyActivitiesList({Key? key, required this.data}) : super(key: key);

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
