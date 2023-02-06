import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list_item.dart';

class Pref {
  final String title;
  final String completionTime;
  final bool isCompleted;

  Pref({
    required this.title,
    required this.completionTime,
    required this.isCompleted,
  });
}

class PreferencesList extends StatelessWidget {
  PreferencesList({Key? key}) : super(key: key);

  // TODO data will be aggregated from the bloc
  final List<Pref> preferences = [
    Pref(
        title: 'Dealing with stress',
        completionTime: '5 minutes',
        isCompleted: false),
    Pref(
        title: 'Food preferences',
        completionTime: '10 minutes',
        isCompleted: false),
    Pref(
        title: 'Food temptations',
        completionTime: '10 minutes',
        isCompleted: false),
    Pref(
        title: 'Household & eating habits',
        completionTime: '10 minutes',
        isCompleted: true),
    Pref(title: 'Diabetes', completionTime: '5 minutes', isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: preferences
          .map((Pref pref) => Column(
                children: [
                  PreferencesListItem(
                    item: pref,
                    onTapHandler: (Pref item) {},
                  ),
                  const SizedBox(height: 8.0),
                ],
              ))
          .toList(),
    );
  }
}
