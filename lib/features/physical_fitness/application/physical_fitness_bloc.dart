import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/dto/add_physical_survey.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/dto/registration_physical_fitness_data.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_service.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/biological_gender_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/bmi_validator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_helpers.dart';

part 'physical_fitness_bloc.freezed.dart';

part 'physical_fitness_bloc.g.dart';

part 'physical_fitness_event.dart';

part 'physical_fitness_state.dart';

part 'physical_fitness_questions.dart';

@singleton
class PhysicalFitnessBloc
    extends HydratedBloc<PhysicalFitnessEvent, PhysicalFitnessState> {
  final OnboardingBloc onboardingBloc;
  final AuthenticationCubit _authenticationCubit;
  final PhysicalService physicalService;

  late final StreamSubscription _authBlocStreamSubscription;

  PhysicalFitnessBloc(
    this.onboardingBloc,
    this._authenticationCubit,
    this.physicalService,
  ) : super(PhysicalFitnessState.initial()) {
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<HeightChanged>(_onHeightChanged);
    on<WeightChanged>(_onWeightChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<SexChanged>(_onSexChanged);
    on<BiologicalGenderChanged>(_onBiologicalGenderChanged);
    on<ResetData>(_onResetData);
    on<SavePhysicalData>(_onSavePhysicalData);

    _authBlocStreamSubscription =
        _authenticationCubit.stream.distinct().listen((s) {
      s.mapOrNull(
        authenticated: (_) {
          add(const PhysicalFitnessEvent.resetData());
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
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(PhysicalFitnessState.initial());
  }

  FutureOr<void> _onSavePhysicalData(
    SavePhysicalData event,
    Emitter<PhysicalFitnessState> emit,
  ) async {
    final data = AddPhysicalSurvey(
      birthDate: state.birthday ?? DateTime.now(),
      bmi: state.bmi as int,
      height: int.parse(state.heightInCm ?? '0'),
      weight: int.parse(state.weightInKg ?? '0'),
    );

    final response = await physicalService.savePhysicalSurvey(data);

    response.fold(
      (l) => emit(
        state.copyWith(isCompletedSuccessfully: false),
      ),
      (r) => emit(
        state.copyWith(isCompletedSuccessfully: true),
      ),
    );
  }

  FutureOr<void> _onNextQuestion(
    NextQuestion event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    final currentQuestion = state.currentQuestion;
    final nextQuestion = currentQuestion.getNextQuestion();

    final isCompleted = nextQuestion == PhysicalFitnessQuestions.result;

    if (isCompleted) {
      final bool isValidBmi =
          BmiValidator.isUserAllowToProceed(state.age!, state.bmi!);

      emit(
        state.copyWith(
          isCompletedSuccessfully: isValidBmi,
          currentQuestion: isValidBmi ? nextQuestion : currentQuestion,
        ),
      );

      if (isValidBmi) {
        onboardingBloc.add(
          OnboardingEvent.currentStepChanged(
            progress: nextQuestion.percentage.toInt(),
            questionIndex: nextQuestion.index,
          ),
        );
      }
    } else {
      emit(state.copyWith(currentQuestion: nextQuestion));

      onboardingBloc.add(
        OnboardingEvent.currentStepChanged(
          progress: nextQuestion.percentage.toInt(),
          questionIndex: nextQuestion.index,
        ),
      );
    }
  }

  FutureOr<void> _onPreviousQuestion(
    PreviousQuestion event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    final isFirstQuestion = state.currentQuestion.index == 0;
    final previousQuestion = state.currentQuestion.getPreviousQuestion();

    if (!isFirstQuestion) {
      emit(state.copyWith(
        currentQuestion: previousQuestion,
      ));
    }

    onboardingBloc.add(
      OnboardingEvent.currentStepChanged(
        progress: previousQuestion.percentage.toInt(),
        questionIndex: previousQuestion.index,
      ),
    );
  }

  FutureOr<void> _onHeightChanged(
    HeightChanged event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        heightInCm: event.height,
        heightMeasurementSystemType: event.measurementSystemType,
      ),
    );
  }

  FutureOr<void> _onWeightChanged(
    WeightChanged event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        weightInKg: event.weight,
        bmi: BmiCalculator.getUserBmiIndex(state.heightInCm, event.weight),
        weightMeasurementSystemType: event.measurementSystemType,
      ),
    );
  }

  FutureOr<void> _onBirthdayChanged(
    BirthdayChanged event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        birthday: event.birthday,
        age: DateHelpers.calculateAge(event.birthday),
      ),
    );
  }

  FutureOr<void> _onSexChanged(
    SexChanged event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(
      state.copyWith(
        sexType: event.sexType,
      ),
    );
  }

  FutureOr<void> _onBiologicalGenderChanged(
    BiologicalGenderChanged event,
    Emitter<PhysicalFitnessState> emit,
  ) {
    emit(state.copyWith(
      biologicalGenderType: event.biologicalGender,
    ));
  }

  @override
  PhysicalFitnessState? fromJson(Map<String, dynamic> json) =>
      PhysicalFitnessState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PhysicalFitnessState state) {
    return state.toJson();
  }
}
