import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_difficulty.dart';

class ProgramDifficultyQuestion extends StatelessWidget {
  const ProgramDifficultyQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizedTexts.desiredDifficulty,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ).tr(),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: ProgramDifficulty.values
              .map(
                (e) => Row(
                  children: [
                    AppChoiceChip(
                      label: e.label,
                      selected: false,
                      value: e,
                      padding: const EdgeInsets.all(0),
                      width: 96,
                      onSelected: _onSelected,
                    ),
                    const SizedBox(
                      width: 8.0,
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void _onSelected(ProgramDifficulty value) {}
}
