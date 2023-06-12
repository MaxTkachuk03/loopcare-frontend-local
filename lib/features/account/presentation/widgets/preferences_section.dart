import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/widgets/section_title.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: LocalizedTexts.preferences),
        SectionItem(title: LocalizedTexts.food, onPressHandler: () {}),
        SectionItem(title: LocalizedTexts.physicalExercise, onPressHandler: () {}),
        SectionItem(title: LocalizedTexts.groupSessions, onPressHandler: () {}),
        SectionItem(title: LocalizedTexts.diabetes, onPressHandler: () {}),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
