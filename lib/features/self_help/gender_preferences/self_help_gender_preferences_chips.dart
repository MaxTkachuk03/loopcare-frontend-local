import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class SelfHelpGenderPreferencesChips extends StatefulWidget {
  const SelfHelpGenderPreferencesChips({Key? key}) : super(key: key);

  @override
  State<SelfHelpGenderPreferencesChips> createState() =>
      _SelfHelpGenderPreferencesChipsState();
}

class _SelfHelpGenderPreferencesChipsState
    extends State<SelfHelpGenderPreferencesChips> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          SizedBox(
            child: AppChoiceChip(
              label: LocalizedTexts.selfHelpGenderPreferencesYesFemale.tr(),
              selected: false,
              value: 1,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            child: AppChoiceChip(
              label: LocalizedTexts.selfHelpGenderPreferencesYesMale.tr(),
              selected: false,
              value: 2,
              onSelected: (int value) {},
            ),
          ),
          SizedBox(
            child: AppChoiceChip(
              label: LocalizedTexts.selfHelpGenderPreferencesNo.tr(),
              selected: false,
              value: 3,
              onSelected: (int value) {},
            ),
          ),
        ],
      );
    });
  }
}
