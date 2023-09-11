import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
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
        BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
          builder: (context, state) {
            return Row(
              children: ProgramDifficulty.values
                  .map(
                    (e) => Row(
                      children: [
                        AppChoiceChip(
                          label: e.label,
                          selected: state.data.programDifficulty == e,
                          value: e,
                          padding: const EdgeInsets.all(0),
                          labelWidth: 96,
                          onSelected: (ProgramDifficulty value) =>
                              e.isAvailable ? _onSelected(context, value) : null,
                          available: e.isAvailable,
                        ),
                        const SizedBox(
                          width: 8.0,
                        )
                      ],
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  void _onSelected(BuildContext context, ProgramDifficulty value) {
    context.read<PhysicalProgramsBloc>().add(PhysicalProgramsEvent.setProgramDifficulty(value));
  }
}
