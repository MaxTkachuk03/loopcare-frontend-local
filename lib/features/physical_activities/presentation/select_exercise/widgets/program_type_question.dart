import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';

class ProgramTypeQuestion extends StatelessWidget {
  const ProgramTypeQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizedTexts.whatWouldYouLikeToWorkOn,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ).tr(),
        const SizedBox(height: 8.0),
        BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ProgramType.values
                  .map(
                    (e) => AppChoiceChip(
                      label: e.label,
                      selected: state.data.programType == e,
                      value: e,
                      padding: const EdgeInsets.all(0),
                      labelWidth: 96,
                      onSelected: (ProgramType value) => e.isAvailable ? _onSelected(context, value) : null,
                      available: e.isAvailable,
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
