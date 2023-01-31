import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/cardiovascular_disease_answers.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

part 'medical_fitness_bloc.freezed.dart';

part 'medical_fitness_bloc.g.dart';

part 'medical_fitness_event.dart';

part 'medical_fitness_state.dart';

part 'medical_fitness_questions.dart';

@singleton
class MedicalFitnessBloc
    extends HydratedBloc<MedicalFitnessEvent, MedicalFitnessState> {
  final OnboardingBloc onboardingBloc;
  final AuthenticationCubit _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  MedicalFitnessBloc(this.onboardingBloc, this._authenticationCubit)
      : super(MedicalFitnessState.initial()) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<PregnancyChanged>(_onPregnancyChanged);
    on<CardiovascularDiseaseChanged>(_onCardiovascularDiseaseChanged);
    on<StomachReductionChanged>(_onStomachReductionChanged);
    on<TreatmentByTheDoctorChanged>(_onTreatmentByTheDoctorChanged);
    on<PainInChestChanged>(_onPainInChestChanged);
    on<ResetData>(_onResetData);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const MedicalFitnessEvent.resetData());
        },
      );
    });
  }

  @override
  Future<void> close() async {
    _authBlocStreamSubscription.cancel();

    return super.close();
  }

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.initial());
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<MedicalFitnessState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    final nextQuestion = currentQuestion.getNextQuestion();

    final isCompleted = nextQuestion == MedicalFitnessQuestions.result;

    if (isCompleted) {
      emit(state.copyWith(
        isCompletedSuccessfully: true,
        currentQuestion: nextQuestion,
      ));
    } else {
      emit(state.copyWith(currentQuestion: nextQuestion));
    }

    onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: nextQuestion.percentage.toInt(),
        questionIndex: nextQuestion.index,
      ),
    );
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<MedicalFitnessState> emit,
  ) {
    final isFirstQuestion = state.currentQuestion.index == 0;
    final previousQuestion = state.currentQuestion.getPreviousQuestion();

    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: previousQuestion,
      ));

      onboardingBloc.add(OnboardingEvent.currentStepChanged(
        progress: previousQuestion.percentage.toInt(),
        questionIndex: previousQuestion.index,
      ));
    }
  }

  FutureOr<void> _onPregnancyChanged(
    PregnancyChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      pregnancy: event.value,
    ));
  }

  FutureOr<void> _onCardiovascularDiseaseChanged(
    CardiovascularDiseaseChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      cardiovascularDisease: event.value,
    ));
  }

  FutureOr<void> _onStomachReductionChanged(
    StomachReductionChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      stomachReductionDisease: event.value,
    ));
  }

  FutureOr<void> _onTreatmentByTheDoctorChanged(
    TreatmentByTheDoctorChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      treatmentByTheDoctor: event.value,
    ));
  }

  FutureOr<void> _onPainInChestChanged(
    PainInChestChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      painInChest: event.value,
    ));
  }

  @override
  MedicalFitnessState? fromJson(Map<String, dynamic> json) =>
      MedicalFitnessState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedicalFitnessState state) {
    return state.toJson();
  }
}
