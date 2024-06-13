import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

@RoutePage()
class ExercisePage extends StatefulWidget {
  const ExercisePage({
    super.key,
    @queryParam this.step = 1,
  });

  final int step;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> with MindAnalyticsMixin {

  @override
  void initState() {
    super.initState();
    techniqueId = context.read<MindBloc>().state.data.currentTechnique!.id;
    exerciseId = context.read<MindBloc>().state.data.currentExercise!.id;

    track(FirebaseEvents.mindOpenExercise);
  }

  void _onExerciseCompleted() {
    context.read<MindBloc>().add(const MindEvent.completeCurrentExercise());

    track(FirebaseEvents.mindCompletedExercise);
  }

  void _onRepeat() {
    final bloc = context.read<MindBloc>();

    bloc.add(MindEvent.selectExercise(exercise: bloc.state.data.currentExercise!));

    track(FirebaseEvents.mindRepeatedExercise);
  }

  @override
  Widget build(BuildContext context) {
    final data = context.read<MindBloc>().state.data;
    final title = data.currentTechnique?.title ?? '';
    final steps = data.exerciseSteps;
    final exerciseTitle = data.currentExercise?.title ?? '';
    final difficulty = data.currentExercise?.difficulty;

    return MindContentScreen.exercise(
      title: title,
      steps: steps,
      stepIndex: widget.step,
      contentTitle: exerciseTitle,
      difficulty: difficulty,
      onExerciseCompleted: _onExerciseCompleted,
      onRepeat: _onRepeat,
    );
  }
}
