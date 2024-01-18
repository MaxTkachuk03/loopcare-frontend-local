import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';

class ProgramFooterOverlay extends StatelessWidget {
  const ProgramFooterOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: AppColors.yellowRegular,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: CustomElevatedButton.blueFullWidth(
          onPressed: () => _onGetStarted(context),
          label: LocalizedTexts.getStarted.translation,
        ),
      ),
    );
  }

  void _onGetStarted(BuildContext context) {
    final program = context.read<PhysicalProgramsBloc>().state.data.currentProgram;

    if (program == null) return;

    context.read<ProgramsInProgressBloc>().add(ProgramsInProgressEvent.setProgram(program));

    context.router.push(VideoRoute(program: program));
  }
}
