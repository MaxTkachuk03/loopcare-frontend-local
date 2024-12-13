<<<<<<< HEAD
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/utils/date_helpers.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'medical_questions_bloc.freezed.dart';
part 'medical_questions_bloc.g.dart';
part 'medical_questions_event.dart';
part 'medical_questions_state.dart';

@singleton
class MedicalQuestionsBloc extends HydratedBloc<MedicalQuestionsEvent, MedicalQuestionsState> {
  final usageAnalytics = UsageAnalytics();

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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingPregnancy,
      attributes: {
        UsageAnalyticsAttributes.pregnancy: event.value,
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
    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingPsychiatrist,
      attributes: {
        UsageAnalyticsAttributes.psychiatrist: event.value,
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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingMedicine,
      attributes: {
        UsageAnalyticsAttributes.medicine: event.medicines.toString(),
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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingSemaglutide,
      attributes: {
        UsageAnalyticsAttributes.semaglutide: event.value,
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

    usageAnalytics.track(
      eventName: _analyticsEventFromDisease(event.diseases),
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
        Diseases.locomotorSystemDisease => UsageAnalyticsAttributes.locomotor,
        Diseases.liverDisease => UsageAnalyticsAttributes.liverDisease,
        Diseases.asthma => UsageAnalyticsAttributes.asthma,
        Diseases.renalFailure => UsageAnalyticsAttributes.renalFailure,
        Diseases.stomachReductionDisease => UsageAnalyticsAttributes.stomachReductionDisease,
        Diseases.cardioVascularDisease => UsageAnalyticsAttributes.cardiovascularDisease,
        Diseases.hypertension => UsageAnalyticsAttributes.hypertension,
        Diseases.metabolicDisease => UsageAnalyticsAttributes.metabolicDisease,
        Diseases.thyroidDisease => UsageAnalyticsAttributes.thyroidDisease,
        Diseases.obesity => UsageAnalyticsAttributes.secondaryForm,
        Diseases.diabetesTypeI => UsageAnalyticsAttributes.diabetes,
        Diseases.diabetesTypeII => UsageAnalyticsAttributes.diabetes,
        Diseases.sleepApneaSyndrome => UsageAnalyticsAttributes.apnea,
      };
}
=======
import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_attributes.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/utils/date_helpers.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

part 'medical_questions_bloc.freezed.dart';
part 'medical_questions_bloc.g.dart';
part 'medical_questions_event.dart';
part 'medical_questions_state.dart';

@singleton
class MedicalQuestionsBloc extends HydratedBloc<MedicalQuestionsEvent, MedicalQuestionsState> {
  final usageAnalytics = UsageAnalytics();

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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingPregnancy,
      attributes: {
        UsageAnalyticsAttributes.pregnancy: event.value,
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
    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingPsychiatrist,
      attributes: {
        UsageAnalyticsAttributes.psychiatrist: event.value,
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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingMedicine,
      attributes: {
        UsageAnalyticsAttributes.medicine: event.medicines.toString(),
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

    usageAnalytics.track(
      eventName: UsageAnalyticsEvents.onboardingSemaglutide,
      attributes: {
        UsageAnalyticsAttributes.semaglutide: event.value,
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

    usageAnalytics.track(
      eventName: _analyticsEventFromDisease(event.diseases),
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
        Diseases.locomotorSystemDisease => UsageAnalyticsAttributes.locomotor,
        Diseases.liverDisease => UsageAnalyticsAttributes.liverDisease,
        Diseases.asthma => UsageAnalyticsAttributes.asthma,
        Diseases.renalFailure => UsageAnalyticsAttributes.renalFailure,
        Diseases.stomachReductionDisease => UsageAnalyticsAttributes.stomachReductionDisease,
        Diseases.cardioVascularDisease => UsageAnalyticsAttributes.cardiovascularDisease,
        Diseases.hypertension => UsageAnalyticsAttributes.hypertension,
        Diseases.metabolicDisease => UsageAnalyticsAttributes.metabolicDisease,
        Diseases.thyroidDisease => UsageAnalyticsAttributes.thyroidDisease,
        Diseases.obesity => UsageAnalyticsAttributes.secondaryForm,
        Diseases.diabetesTypeI => UsageAnalyticsAttributes.diabetes,
        Diseases.diabetesTypeII => UsageAnalyticsAttributes.diabetes,
        Diseases.sleepApneaSyndrome => UsageAnalyticsAttributes.apnea,
      };
}
>>>>>>> feature-interactive-lessons
