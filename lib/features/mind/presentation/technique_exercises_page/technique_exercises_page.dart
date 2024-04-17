import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/exercise_list_tile/exercise_list_tile.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_view_content/mind_view_content.dart';

class TechniqueExercisesPage extends StatefulWidget {
  const TechniqueExercisesPage({super.key});

  @override
  State<TechniqueExercisesPage> createState() => _TechniqueExercisesPageState();
}

class _TechniqueExercisesPageState extends State<TechniqueExercisesPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.mindTraining.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(
        child: BlocBuilder<MindBloc, MindState>(
          builder: (context, state) {

            final currentTechnique = state.data.currentTechnique;
            return MindViewContent(
              isLoading: state.data.isLoading,
              isVideoExplanation: currentTechnique?.explanation.type.isVideo ?? false,
              title: currentTechnique?.title ?? '',
              subtitle: currentTechnique?.subtitle ?? '',
              textColor: AppColors.blueDarker,
              description: currentTechnique?.shortIntroduction ?? '',
              onExplanationPressed: () {
                // state.data.currentTechnique?.explanation.src;
              },
              videoPreview: currentTechnique?.explanation.preview,
              listTitle: LocalizedTexts.chooseAnExercise.tr(),
              itemCount: state.data.exercises.length,
              itemBuilder: (context, index) {
                final exercise = state.data.exercises[index];

                return ExerciseListTile(
                  key: ValueKey('mind_exercise_${exercise.id}'),
                  exercise: exercise,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
