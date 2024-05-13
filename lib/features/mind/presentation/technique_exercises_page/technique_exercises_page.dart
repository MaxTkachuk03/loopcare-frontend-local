import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/exercise_list_tile/exercise_list_tile.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_list_content/mind_list_content.dart';

class TechniqueExercisesPage extends StatefulWidget {
  const TechniqueExercisesPage({super.key});

  @override
  State<TechniqueExercisesPage> createState() => _TechniqueExercisesPageState();
}

class _TechniqueExercisesPageState extends State<TechniqueExercisesPage> with MindAnalyticsMixin {

  @override
  void initState() {
    super.initState();
    techniqueId = context.read<MindBloc>().state.data.currentTechnique!.id;

    track(FirebaseEvents.mindSelectTechnique);
  }

  @override
  void dispose() {
    track(FirebaseEvents.mindCloseTechnique);
    super.dispose();
  }

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

            return MindListContent(
              isLoading: state.data.isLoading,
              isVideoExplanation: currentTechnique?.explanation.type.isVideo ?? false,
              title: currentTechnique?.title ?? '',
              subtitle: currentTechnique?.subtitle ?? '',
              textColor: AppColors.blueDarker,
              description: currentTechnique?.shortIntroduction ?? '',
              onExplanationPressed: () => context.router.pushNamed(AppRoutes.techniqueExplanation),
              videoPreview: currentTechnique?.explanation.image,
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
