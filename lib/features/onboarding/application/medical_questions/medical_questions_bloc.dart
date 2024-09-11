import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/utils/date_helpers.dart';

part 'medical_questions_bloc.freezed.dart';

part 'medical_questions_bloc.g.dart';

part 'medical_questions_event.dart';

part 'medical_questions_state.dart';

@singleton
class MedicalQuestionsBloc extends HydratedBloc<MedicalQuestionsEvent, MedicalQuestionsState> {
  MedicalQuestionsBloc() : super(MedicalQuestionsState.initial()) {
    on<PregnancyChanged>(_onPregnancyChanged);
    on<TreatmentByTheDoctorChanged>(_onTreatmentByTheDoctorChanged);
    on<MedicinesChanged>(_onMedicinesChanged);
    on<UpdateDisease>(_onUpdateDisease);
    on<ResetData>(_onResetData);
    on<HandleSexType>(_onHandleSexType);
    on<HandleBirthday>(_onHandleBirthday);
    on<WeightLossMedicationChanged>(_onWeightLossMedicationChanged);
  }

  FutureOr<void> _onHandleBirthday(
    HandleBirthday event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    emit(
      state.copyWith(age: DateHelpers.calculateAge(event.birthday)),
    );
  }

  FutureOr<void> _onHandleSexType(
    HandleSexType event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    emit(
      state.copyWith(sexType: event.sexType),
    );
  }

  FutureOr<void> _onResetData(
    ResetData event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    emit(MedicalQuestionsState.initial());
  }

  FutureOr<void> _onPregnancyChanged(
    PregnancyChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingPregnancy,
      parameters: {
        AnalyticsParameters.value: event.value.toString(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingPregnancy,
      attributes: {
        CIOAttributes.pregnancy: event.value,
      },
    );

    emit(state.copyWith(pregnancy: event.value));
  }

  FutureOr<void> _onTreatmentByTheDoctorChanged(
    TreatmentByTheDoctorChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingPsychiatrist,
      parameters: {
        AnalyticsParameters.value: event.value.toString(),
      },
    );
    CustomerIoService.track(
      event: CIOEvents.onboardingPsychiatrist,
      attributes: {
        CIOAttributes.psychiatrist: event.value,
      },
    );

    emit(state.copyWith(treatmentByTheDoctor: event.value));
  }

  FutureOr<void> _onMedicinesChanged(
    MedicinesChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingMedicine,
      parameters: {
        AnalyticsParameters.value: event.medicines.toString(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingMedicine,
      attributes: {
        CIOAttributes.medicine: event.medicines.toString(),
      },
    );

    emit(state.copyWith(medicines: event.medicines));
  }

  FutureOr<void> _onWeightLossMedicationChanged(
    WeightLossMedicationChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.onboardingSemaglutide,
      parameters: {
        AnalyticsParameters.value: event.value.toString(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingSemaglutide,
      attributes: {
        CIOAttributes.semaglutide: event.value,
      },
    );

    emit(state.copyWith(weightLossMedication: event.value));
  }

  FutureOr<void> _onUpdateDisease(
    UpdateDisease event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    const AnalyticsEventService().logEvent(
      eventName: _analyticsEventFromDisease(event.diseases),
      parameters: {
        if (event.value && event.diseases.isDiabetes) AnalyticsParameters.type: event.diseases.name,
        AnalyticsParameters.value: event.value.toString(),
      },
    );

    CustomerIoService.track(
      event: _analyticsEventFromDisease(event.diseases),
      attributes: {
        if (event.value && event.diseases.isDiabetes) 'Diabetes Types': event.diseases.name,
        _cIOAttributesFromDisease(event.diseases): event.value,
      },
    );
    Map<Diseases, bool> map = Map.from(state.diseases);

    if (event.diseases.isDiabetes) {
      map = map..removeWhere((key, value) => key.isDiabetes);
    }

    final isContains = state.containsDisease(event.diseases);

    if (isContains ?? false) {
      map = map..removeWhere((key, value) => key == event.diseases);
    }

    emit(
      state.copyWith(
        diseases: map..addAll({event.diseases: event.value}),
      ),
    );
  }

  @override
  MedicalQuestionsState? fromJson(Map<String, dynamic> json) =>
      MedicalQuestionsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedicalQuestionsState state) => state.toJson();

  String _analyticsEventFromDisease(Diseases disease) => switch (disease) {
        Diseases.locomotorSystemDisease => AnalyticsEvents.onboardingLocomotor,
        Diseases.liverDisease => AnalyticsEvents.onboardingLiverDisease,
        Diseases.asthma => AnalyticsEvents.onboardingAsthma,
        Diseases.renalFailure => AnalyticsEvents.onboardingRenalFailure,
        Diseases.stomachReductionDisease => AnalyticsEvents.onboardingStomachReduction,
        Diseases.cardioVascularDisease => AnalyticsEvents.onboardingCardiovascularDisease,
        Diseases.hypertension => AnalyticsEvents.onboardingHypertension,
        Diseases.metabolicDisease => AnalyticsEvents.onboardingMetabolicDisease,
        Diseases.thyroidDisease => AnalyticsEvents.onboardingThyroidDisease,
        Diseases.obesity => AnalyticsEvents.onboardingSecondaryForm,
        Diseases.diabetesTypeI => AnalyticsEvents.onboardingDiabetes,
        Diseases.diabetesTypeII => AnalyticsEvents.onboardingDiabetes,
        Diseases.sleepApneaSyndrome => AnalyticsEvents.onboardingApnea,
      };

  String _cIOAttributesFromDisease(Diseases disease) => switch (disease) {
        Diseases.locomotorSystemDisease => CIOAttributes.locomotor,
        Diseases.liverDisease => CIOAttributes.liverDisease,
        Diseases.asthma => CIOAttributes.asthma,
        Diseases.renalFailure => CIOAttributes.renalFailure,
        Diseases.stomachReductionDisease => CIOAttributes.stomachReductionDisease,
        Diseases.cardioVascularDisease => CIOAttributes.cardiovascularDisease,
        Diseases.hypertension => CIOAttributes.hypertension,
        Diseases.metabolicDisease => CIOAttributes.metabolicDisease,
        Diseases.thyroidDisease => CIOAttributes.thyroidDisease,
        Diseases.obesity => CIOAttributes.secondaryForm,
        Diseases.diabetesTypeI => CIOAttributes.diabetes,
        Diseases.diabetesTypeII => CIOAttributes.diabetes,
        Diseases.sleepApneaSyndrome => CIOAttributes.apnea,
      };
}
