import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

part 'physical_fitness_bloc.freezed.dart';

part 'physical_fitness_bloc.g.dart';

part 'physical_fitness_event.dart';

part 'physical_fitness_state.dart';

part 'physical_fitness_questions.dart';

@injectable
class PhysicalFitnessBloc
    extends HydratedBloc<PhysicalFitnessEvent, PhysicalFitnessState> {
  final OnboardingBloc onboardingBloc;

  PhysicalFitnessBloc(this.onboardingBloc)
      : super(PhysicalFitnessState.initial()) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    final isLastQuestion = state.currentQuestion.index ==
        PhysicalFitnessQuestions.values.length - 1;

    final progress = state.currentQuestion.percentage;

    if (isLastQuestion) {
      emit(state.copyWith(isCompleted: true));
    } else {
      emit(state.copyWith(
          currentQuestion: state.currentQuestion.getNextQuestion()));
    }

    onboardingBloc.add(
      OnboardingEvent.currentStepProgressChanged(progress.toInt()),
    );
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    final isFirstQuestion = state.currentQuestion.index == 0;
    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: state.currentQuestion.getPreviousQuestion(),
      ));

      final progress = state.currentQuestion.percentage;

      onboardingBloc
          .add(OnboardingEvent.currentStepProgressChanged(progress.toInt()));
    }
  }

  @override
  PhysicalFitnessState? fromJson(Map<String, dynamic> json) =>
      PhysicalFitnessState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PhysicalFitnessState state) {
    return state.toJson();
  }
}
