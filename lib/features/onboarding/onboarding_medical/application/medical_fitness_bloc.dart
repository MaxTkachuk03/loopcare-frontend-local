import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/domain/weight_loss_medication_answers.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/date_helpers.dart';

part 'medical_fitness_bloc.freezed.dart';

part 'medical_fitness_bloc.g.dart';

part 'medical_fitness_event.dart';

part 'medical_fitness_state.dart';

part 'medical_fitness_questions.dart';

@singleton
class MedicalFitnessBloc extends HydratedBloc<MedicalFitnessEvent, MedicalFitnessState> {
  final OnboardingBloc onboardingBloc;
  final AuthenticationCubit _authenticationCubit;

  late final StreamSubscription _authBlocStreamSubscription;

  MedicalFitnessBloc(this.onboardingBloc, this._authenticationCubit)
      : super(const MedicalFitnessState.initial(MedicalFitnessData())) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<PregnancyChanged>(_onPregnancyChanged);
    on<TreatmentByTheDoctorChanged>(_onTreatmentByTheDoctorChanged);
    on<MedicinesChanged>(_onMedicinesChanged);
    on<AddDisease>(_onAddDisease);
    on<RemoveDisease>(_onRemoveDisease);
    on<ResetData>(_onResetData);
    on<HandleSexType>(_onHandleSexType);
    on<HandleBirthday>(_onHandleBirthday);
    on<WeightLossMedicationChanged>(_onWeightLossMedicationChanged);

    _authBlocStreamSubscription = _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const MedicalFitnessEvent.resetData());
        },
      );
    });
  }

  void _handleQuestions() {
    final age = state.data.age ?? 0;
    if (state.data.sexType == SexType.female && age < 60) {
      _onAddPregnancyQuestion();
    } else {
      _onRemovePregnancyQuestion();
    }
  }

  void _onRemovePregnancyQuestion() {
    if (medicalFitnessQuestions.contains('pregnancy')) {
      medicalFitnessQuestions.removeAt(medicalFitnessQuestions.indexOf('pregnancy'));
    }
  }

  void _onAddPregnancyQuestion() {
    if (!medicalFitnessQuestions.contains('pregnancy')) {
      medicalFitnessQuestions.insert(1, 'pregnancy');
    }
  }

  FutureOr<void> _onHandleBirthday(
    HandleBirthday event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      MedicalFitnessState.updated(state.data.copyWith(age: DateHelpers.calculateAge(event.birthday))),
    );

    _handleQuestions();
  }

  FutureOr<void> _onHandleSexType(
    HandleSexType event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(sexType: event.sexType)));

    _handleQuestions();
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
    emit(const MedicalFitnessState.initial(MedicalFitnessData()));
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<MedicalFitnessState> emit,
  ) {
    final currentQuestion = state.data.currentQuestion;
    final nextQuestion = getNextQuestion(currentQuestion);

    final isCompleted = nextQuestion == medicalFitnessQuestions.last;

    if (isCompleted) {
      emit(
        MedicalFitnessState.updated(state.data.copyWith(
          isCompletedSuccessfully: true,
          currentQuestion: nextQuestion,
        )),
      );
    } else {
      emit(MedicalFitnessState.updated(state.data.copyWith(currentQuestion: nextQuestion)));
    }

    onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: _percentage(nextQuestion).toInt(),
        questionIndex: medicalFitnessQuestions.indexOf(nextQuestion),
      ),
    );
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<MedicalFitnessState> emit,
  ) {
    final currentQuestion = state.data.currentQuestion;
    final isFirstQuestion = currentQuestion == medicalFitnessQuestions.first;
    final previousQuestion = _getPreviousQuestion(currentQuestion);

    if (!isFirstQuestion) {
      emit(
        MedicalFitnessState.updated(state.data.copyWith(currentQuestion: previousQuestion)),
      );

      onboardingBloc.add(
        OnboardingEvent.currentStepChanged(
          progress: _percentage(previousQuestion).toInt(),
          questionIndex: medicalFitnessQuestions.indexOf(previousQuestion),
        ),
      );
    }
  }

  FutureOr<void> _onPregnancyChanged(
    PregnancyChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(pregnancy: event.value)));
  }

  FutureOr<void> _onTreatmentByTheDoctorChanged(
    TreatmentByTheDoctorChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(treatmentByTheDoctor: event.value)));
  }

  FutureOr<void> _onMedicinesChanged(
    MedicinesChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(medicines: event.medicines)));
  }

  FutureOr<void> _onWeightLossMedicationChanged(
    WeightLossMedicationChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(weightLossMedication: event.value)));
  }

  FutureOr<void> _onAddDisease(
    AddDisease event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(
      diseasesList: Set.of(state.data.diseasesList)..add(event.value),
    )));
  }

  FutureOr<void> _onRemoveDisease(
    RemoveDisease event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(MedicalFitnessState.updated(state.data.copyWith(
      diseasesList: Set.of(state.data.diseasesList)..remove(event.value),
    )));
  }

  @override
  MedicalFitnessState? fromJson(Map<String, dynamic> json) => MedicalFitnessState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedicalFitnessState state) {
    return state.toJson();
  }
}
