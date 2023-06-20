import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/exercise_card.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/widgets/program_footer_overlay.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/widgets/difficulty_label.dart';

const cardWidth = 166;
const cardHeight = 214;

class ProgramDetailsPage extends StatelessWidget {
  final PhysicalProgram program;

  const ProgramDetailsPage({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercisesLength = program.exercises.length;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: OrangeAppBar(title: program.name),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 32.0,
                      ),
                      Row(
                        children: [
                          DifficultyLabel(
                            text: program.difficultyName,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Image(
                            image: AppImages.clock,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            formatDuration(program.duration),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            program.placeName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: ThemeConstants.fontSize12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            program.typeName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: ThemeConstants.fontSize12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        exercisesLength > 1 ? LocalizedTexts.exercises : LocalizedTexts.exercise,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ).tr(namedArgs: {
                        'length': exercisesLength.toString(),
                      }),
                      const Text(LocalizedTexts.equipment).tr(namedArgs: {
                        'equipment': program.equipment,
                      }),
                      const Text(LocalizedTexts.targetMuscles).tr(namedArgs: {
                        'targetMuscles': program.targetMuscles,
                      }),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: cardWidth / cardHeight,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 16.0,
                            ),
                            itemCount: exercisesLength,
                            itemBuilder: (BuildContext context, int index) {
                              return ExerciseCard(
                                index: index + 1,
                                exercise: program.exercises[index],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              const ProgramFooterOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<PhysicalProgramsBloc>().add(const PhysicalProgramsEvent.setCurrentProgram(null));

    return Future.value(true);
  }
}
