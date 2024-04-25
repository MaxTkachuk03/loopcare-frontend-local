import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/presentation/widgets/mind_content_screen/mind_content_screen.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  void _onExerciseCompleted(BuildContext context) {
    final bloc = context.read<MindBloc>();
    final data = bloc.state.data;

    final techniqueId = data.currentTechnique?.id;
    final exerciseId = data.currentExercise?.id;

    bloc.add(const MindEvent.completeCurrentExercise());

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.mindCompletedExercise,
      parameters: {
        CustomDefinitions.techniqueId: techniqueId,
        CustomDefinitions.exerciseId: exerciseId,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.mindCompletedExercise,
      attributes: {
        CIOAttributes.techniqueId: techniqueId,
        CIOAttributes.exerciseId: exerciseId,
      },
    );
  }

  void _onRepeat(BuildContext context) {
    final data = context.read<MindBloc>().state.data;

    final techniqueId = data.currentTechnique?.id;
    final exerciseId = data.currentExercise?.id;

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.mindRepeatedExercise,
      parameters: {
        CustomDefinitions.techniqueId: techniqueId,
        CustomDefinitions.exerciseId: exerciseId,
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.mindRepeatedExercise,
      attributes: {
        CIOAttributes.techniqueId: techniqueId,
        CIOAttributes.exerciseId: exerciseId,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.read<MindBloc>().state.data;
    final title = data.currentTechnique?.title ?? '';
    final exercise = data.currentExercise!.exercise;
    final exerciseTitle = data.currentExercise?.title ?? '';
    final difficulty = data.currentExercise?.difficulty;

    return MindContentScreen.exercise(
      title: title,
      steps: [exercise],
      contentTitle: exerciseTitle,
      difficulty: difficulty,
      onExerciseCompleted: () => _onExerciseCompleted(context),
      onRepeat: () => _onRepeat(context),
    );
  }
}
