import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/medical_fitness/domain/cardiovascular_disease_answers.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_helpers.dart';

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
    on<HandleSexType>(_onHandleSexType);
    on<HandleBirthday>(_onHandleBirthday);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const MedicalFitnessEvent.resetData());
        },
      );
    });
  }

  void _handleQuestions() {
    final age = state.age ?? 0;
    if (state.sexType == SexType.female && age < 60) {
      _onAddPregnancyQuestion();
    } else {
      _onRemovePregnancyQuestion();
    }
  }

  void _onRemovePregnancyQuestion() {
    if (medicalFitnessQuestions.contains('pregnancy')) {
      medicalFitnessQuestions
          .removeAt(medicalFitnessQuestions.indexOf('pregnancy'));
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
      state.copyWith(
        age: DateHelpers.calculateAge(event.birthday),
      ),
    );

    _handleQuestions();
  }

  FutureOr<void> _onHandleSexType(
    HandleSexType event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        sexType: event.sexType,
      ),
    );

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
    emit(MedicalFitnessState.initial());
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<MedicalFitnessState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    final nextQuestion = getNextQuestion(currentQuestion);

    final isCompleted = nextQuestion == medicalFitnessQuestions.last;

    if (isCompleted) {
      emit(
        state.copyWith(
          isCompletedSuccessfully: true,
          currentQuestion: nextQuestion,
        ),
      );
    } else {
      emit(state.copyWith(currentQuestion: nextQuestion));
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
    final currentQuestion = state.currentQuestion;
    final isFirstQuestion = currentQuestion == medicalFitnessQuestions.first;
    final previousQuestion = _getPreviousQuestion(currentQuestion);

    if (!isFirstQuestion) {
      emit(
        state.copyWith(
          currentQuestion: previousQuestion,
        ),
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
    emit(
      state.copyWith(
        pregnancy: event.value,
      ),
    );
  }

  FutureOr<void> _onCardiovascularDiseaseChanged(
    CardiovascularDiseaseChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        cardiovascularDisease: event.value,
      ),
    );
  }

  FutureOr<void> _onStomachReductionChanged(
    StomachReductionChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        stomachReductionDisease: event.value,
      ),
    );
  }

  FutureOr<void> _onTreatmentByTheDoctorChanged(
    TreatmentByTheDoctorChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        treatmentByTheDoctor: event.value,
      ),
    );
  }

  FutureOr<void> _onPainInChestChanged(
    PainInChestChanged event,
    Emitter<MedicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        painInChest: event.value,
      ),
    );
  }

  @override
  MedicalFitnessState? fromJson(Map<String, dynamic> json) =>
      MedicalFitnessState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedicalFitnessState state) {
    return state.toJson();
  }
}
