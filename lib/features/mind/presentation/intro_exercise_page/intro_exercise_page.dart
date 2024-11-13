import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

@RoutePage()
class IntroExercisePage extends StatefulWidget {
  const IntroExercisePage({super.key});

  @override
  State<IntroExercisePage> createState() => _IntroExercisePageState();
}

class _IntroExercisePageState extends State<IntroExercisePage> with MindAnalyticsMixin {
  @override
  void initState() {
    super.initState();
    techniqueId = context.read<MindBloc>().state.data.currentTechnique!.id;
    exerciseId = context.read<MindBloc>().state.data.currentExercise!.id;

    track(AnalyticsEvents.mindExerciseIntro);
  }

  @override
  void dispose() {
    track(AnalyticsEvents.mindCloseExerciseIntro);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final exercise = bloc.state.data.currentExercise;
    final intro = exercise?.explanation;
    final exerciseTitle = exercise?.title ?? '';

    return MindContentScreen.intro(
      title: title,
      steps: [if (intro != null) intro],
      contentTitle: exerciseTitle,
      exercise: exercise,
      onComplete: () => context.router.replace(ExerciseRoute(step: 1)),
    );
  }
}
