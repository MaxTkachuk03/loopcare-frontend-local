import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';

class ProgramFooterOverlay extends StatelessWidget {
  const ProgramFooterOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, bottom: 28.0),
      decoration: BoxDecoration(
        color: AppColors.bgGreen,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: MainContainer(
          child: Column(
            children: [
              const Text(
                LocalizedTexts.programNote,
                textAlign: TextAlign.center,
              ).tr(),
              const SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                onPressed: () => _onGetStarted(context),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                    ),
                child: const Text(LocalizedTexts.getStarted).tr(),
              ),
            ],
          ),
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
