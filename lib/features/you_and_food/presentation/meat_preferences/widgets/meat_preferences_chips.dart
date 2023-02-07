import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';

class MeatPreferencesChips extends StatefulWidget {
  const MeatPreferencesChips({Key? key}) : super(key: key);

  @override
  State<MeatPreferencesChips> createState() => _MeatPreferencesChipsState();
}

class _MeatPreferencesChipsState extends State<MeatPreferencesChips> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppChoiceChip(
          label: 'Every day',
          selected: false,
          value: 2,
          onSelected: (int value) {},
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8.0),
        AppChoiceChip(
          label: '6 times a week',
          selected: false,
          value: 2,
          onSelected: (int value) {},
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8.0),
        AppChoiceChip(
          label: '5 times a week',
          selected: false,
          value: 2,
          onSelected: (int value) {},
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
