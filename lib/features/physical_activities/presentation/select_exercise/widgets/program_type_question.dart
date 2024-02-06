import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';

class ProgramTypeQuestion extends StatelessWidget {
  const ProgramTypeQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.bitter600(
          LocalizedTexts.selectExerciseType.tr(),
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ProgramType.values
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomChoiceChip.yellow(
                          label: e.label,
                          textAlign: TextAlign.center,
                          selected: state.data.programType == e,
                          value: e,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          onSelected: e.isAvailable ? (ProgramType value) => _onSelected(context, value) : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  void _onSelected(BuildContext context, ProgramType value) {
    context.read<PhysicalProgramsBloc>().add(PhysicalProgramsEvent.setProgramType(value));
  }
}
