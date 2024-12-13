import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/exercise_card.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/program_footer_overlay.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class ProgramDetailsPage extends StatelessWidget {
  final PhysicalProgram program;

  const ProgramDetailsPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final exercisesLength = program.exercises.length;

    return PopScope(
      onPopInvokedWithResult: (e, _) => _onWillPop(context),
      child: CustomScaffold.yellowLightest(
        appBar: CustomAppBar.yellow(
          title: program.name,
          leading: CustomFilledIconButton.leadingYellowLighter(),
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollableContainer(
                physics: const AlwaysScrollableScrollPhysics(),
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 28.0,
                          ),
                          CustomText.bitter600(
                            LocalizedTexts.selectYourProgram.tr(),
                            style: context.textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ProgramCard.onlyView(
                            program: program,
                            bgColor: AppColors.yellowRegular,
                            borderColor: AppColors.yellowRegular,
                            padding: const EdgeInsets.all(4.0),
                            size: const ProgramCardSize.small(),
                          ),
                          const SizedBox(height: 20.0),
                          CustomText(
                            LocalizedTexts.countExercises.plural(count: exercisesLength),
                            style: context.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: AppColors.yellowRegular,
                            width: 2.0,
                          ),
                        ),
                        color: AppColors.white,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: exercisesLength,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ExerciseCard(
                            index: index,
                            exercise: program.exercises[index],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ),
            const ProgramFooterOverlay(),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<PhysicalProgramsBloc>().add(const PhysicalProgramsEvent.setCurrentProgram(null));

    return Future.value(true);
  }
}
