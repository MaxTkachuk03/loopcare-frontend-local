import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

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

    track(FirebaseEvents.mindExerciseIntro);
  }

  @override
  void dispose() {
    track(FirebaseEvents.mindCloseExerciseIntro);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final intro = bloc.state.data.currentExercise?.explanation;
    final exerciseTitle = bloc.state.data.currentExercise?.title ?? '';

    return MindContentScreen.intro(
      title: title,
      steps: [if (intro != null) intro],
      contentTitle: exerciseTitle,
      onComplete: () => context.router.replaceNamed(AppRoutes.mindExercise),
    );
  }
}
