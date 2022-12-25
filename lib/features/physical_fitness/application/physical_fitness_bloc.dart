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
    final currentQuestion = state.currentQuestion;
    if (currentQuestion == null) return null;

    final isLastQuestion =
        currentQuestion.index == PhysicalFitnessQuestions.values.length - 1;
    if (isLastQuestion) {
      emit(state.copyWith(isCompleted: true));
    } else {
      emit(state.copyWith(currentQuestion: currentQuestion.getNextQuestion()));
    }

    onboardingBloc.add(const OnboardingEvent.currentStepProgressChanged(90));
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    if (currentQuestion == null) return null;

    final isFirstQuestion = currentQuestion.index == 0;
    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: currentQuestion.getPreviousQuestion(),
      ));

      onboardingBloc.add(const OnboardingEvent.currentStepProgressChanged(90));
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
