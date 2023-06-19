import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_place.dart';

class ProgramPlaceQuestion extends StatelessWidget {
  const ProgramPlaceQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizedTexts.whereAreYou,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ).tr(),
        const SizedBox(
          height: 8.0,
        ),
        BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
          builder: (context, state) {
            return Row(
              children: ProgramPlace.values
                  .map(
                    (e) => Row(
                      children: [
                        AppChoiceChip(
                          label: e.label,
                          selected: state.data.programPlace == e,
                          value: e,
                          padding: const EdgeInsets.all(0),
                          width: 96,
                          onSelected: (ProgramPlace value) => _onSelected(context, value),
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

  void _onSelected(BuildContext context, ProgramPlace value) {
    context.read<PhysicalProgramsBloc>().add(PhysicalProgramsEvent.setProgramPlace(value));
  }
}
