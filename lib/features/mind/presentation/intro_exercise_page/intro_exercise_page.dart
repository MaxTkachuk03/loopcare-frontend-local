import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

class IntroExercisePage extends StatelessWidget {
  const IntroExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final intro = bloc.state.data.currentExercise?.intro;
    final exerciseTitle = bloc.state.data.currentExercise?.title ?? '';

    return MindContentScreen.intro(
      title: title,
      steps: intro != null ? [intro] : [],
      contentTitle: exerciseTitle,
      onComplete: () => context.router.replaceNamed(AppRoutes.mindExercise),
    );
  }
}
