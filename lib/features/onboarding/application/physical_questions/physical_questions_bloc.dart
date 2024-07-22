import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/add_physical_survey.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/registration_physical_fitness_data.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/physical_service.dart';
import 'package:loopcare_frontend/features/onboarding/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/features/onboarding/utils/date_helpers.dart';

part 'physical_questions_bloc.freezed.dart';

part 'physical_questions_bloc.g.dart';

part 'physical_questions_event.dart';

part 'physical_questions_state.dart';

@singleton
class PhysicalQuestionsBloc extends HydratedBloc<PhysicalQuestionsEvent, PhysicalQuestionsState> {
  final PhysicalService physicalService;

  PhysicalQuestionsBloc(
    this.physicalService,
  ) : super(PhysicalQuestionsState.initial()) {
    on<HeightChanged>(_onHeightChanged);
    on<WeightChanged>(_onWeightChanged);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<SexChanged>(_onSexChanged);
    on<GenderChanged>(_onGenderChanged);
    on<HappinessChanged>(_onHappinessChanged);
    on<ResetData>(_onResetData);
    on<SavePhysicalData>(_onSavePhysicalData);
  }

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    emit(PhysicalQuestionsState.initial());
  }

  FutureOr<void> _onSavePhysicalData(
    SavePhysicalData event,
    Emitter<PhysicalQuestionsState> emit,
  ) async {
    final data = AddPhysicalSurvey(
      birthDate: state.birthday ?? DateTime.now(),
      bmi: state.bmi as double,
      height: int.parse(state.heightInCm!),
      weight: int.parse(state.weightInKg!),
    );

    final response = await physicalService.savePhysicalSurvey(data);

    response.fold(
      (l) => emit(state.copyWith(isCompletedSuccessfully: false)),
      (r) => emit(state.copyWith(isCompletedSuccessfully: true)),
    );
  }

  FutureOr<void> _onHappinessChanged(
    HappinessChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingHappiness,
      parameters: {
        AnalyticsParameters.value: event.happiness,
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingHappiness,
      attributes: {
        CIOAttributes.happiness: event.happiness,
      },
    );

    emit(
      state.copyWith(
        happiness: event.happiness,
      ),
    );
  }

  FutureOr<void> _onHeightChanged(
    HeightChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingHeight,
      parameters: {
        AnalyticsParameters.value: event.height,
        AnalyticsParameters.measurementSystem: event.measurementSystemType.name,
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingHeight,
      attributes: {
        CIOAttributes.height: event.height,
        CIOAttributes.measurementSystem: event.measurementSystemType.name,
      },
    );

    emit(
      state.copyWith(
        heightInCm: event.height,
        heightMeasurementSystemType: event.measurementSystemType,
      ),
    );
  }

  FutureOr<void> _onWeightChanged(
    WeightChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    final bmi = BmiCalculator.getUserBmiIndex(state.heightInCm, event.weight);

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingWeight,
      parameters: {
        AnalyticsParameters.value: event.weight,
        AnalyticsParameters.measurementSystem: event.measurementSystemType.name,
      },
    );

    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userBmi,
      parameters: {
        AnalyticsParameters.value: bmi.toString(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingWeight,
      attributes: {
        CIOAttributes.weight: event.weight,
        CIOAttributes.measurementSystem: event.measurementSystemType.name,
        CIOAttributes.bmi: bmi,
      },
    );

    emit(
      state.copyWith(
        weightInKg: event.weight,
        bmi: bmi,
        weightMeasurementSystemType: event.measurementSystemType,
      ),
    );
  }

  FutureOr<void> _onBirthdayChanged(
    BirthdayChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingBirthday,
      parameters: {
        AnalyticsParameters.value: event.birthday.toIso8601String(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingBirthday,
      attributes: {
        CIOAttributes.birthday: event.birthday.toIso8601String(),
      },
    );

    emit(
      state.copyWith(
        birthday: event.birthday,
        age: DateHelpers.calculateAge(event.birthday),
      ),
    );
  }

  FutureOr<void> _onSexChanged(
    SexChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    const  AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingSex,
      parameters: {
        AnalyticsParameters.value: event.sexType.name,
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingSex,
      attributes: {
        CIOAttributes.sex: event.sexType.name,
      },
    );

    emit(
      state.copyWith(
        sexType: event.sexType,
      ),
    );
  }

  FutureOr<void> _onGenderChanged(
    GenderChanged event,
    Emitter<PhysicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingGender,
      parameters: {
        AnalyticsParameters.value: event.gender.name,
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingGender,
      attributes: {
        CIOAttributes.gender: event.gender.name,
      },
    );

    emit(
      state.copyWith(
        genderType: event.gender,
      ),
    );
  }

  @override
  PhysicalQuestionsState? fromJson(Map<String, dynamic> json) =>
      PhysicalQuestionsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PhysicalQuestionsState state) {
    return state.toJson();
  }
}
