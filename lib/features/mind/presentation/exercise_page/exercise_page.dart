import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_view/mind_content_view.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final title = bloc.state.data.currentTechnique?.title ?? '';
    final steps = bloc.state.data.currentExercise?.steps ?? [];

    return MindContentView(
      title: title,
      steps: steps,
      onComplete: () => bloc.add(const MindEvent.completeCurrentExercise()),
    );
  }
}
