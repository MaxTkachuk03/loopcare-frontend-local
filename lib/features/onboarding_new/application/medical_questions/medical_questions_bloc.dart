import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/medication_future_period_answer.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/medication_past_period_answer.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/weight_loss_medication_answers.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/date_helpers.dart';

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
    on<MedicationFuturePeriodChanged>(_onMedicationFuturePeriodChanged);
    on<MedicationPastPeriodChanged>(_onMedicationPastPeriodChanged);
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
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userPregnancy,
      parameters: {
        CustomDefinitions.value: event.value,
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
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userInTherapy,
      parameters: {
        CustomDefinitions.value: event.value.toString(),
      },
    );

    CustomerIoService.track(
      event: CIOEvents.onboardingTreatmentByTheDoctor,
      attributes: {
        CIOAttributes.pregnancy: event.value,
      },
    );

    emit(state.copyWith(treatmentByTheDoctor: event.value));
  }

  FutureOr<void> _onMedicinesChanged(
    MedicinesChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userMedicines,
      parameters: {
        CustomDefinitions.value: event.medicines.toString(),
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

  FutureOr<void> _onMedicationFuturePeriodChanged(
    MedicationFuturePeriodChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    CustomerIoService.track(
      event: CIOEvents.onboardingTreatmentPeriod,
      attributes: {
        CIOAttributes.medicine: event.value.name,
      },
    );

    emit(state.copyWith(howLongSemaglutideTreatmentLast: event.value));
  }

  FutureOr<void> _onMedicationPastPeriodChanged(
    MedicationPastPeriodChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    CustomerIoService.track(
      event: CIOEvents.onboardingTakingPeriod,
      attributes: {
        CIOAttributes.medicine: event.value.name
      },
    );

    emit(state.copyWith(howLongTakeSemaglutideMedication: event.value));
  }

  FutureOr<void> _onWeightLossMedicationChanged(
    WeightLossMedicationChanged event,
    Emitter<MedicalQuestionsState> emit,
  ) {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userSemaglutide,
      parameters: {
        CustomDefinitions.value: event.value.name,
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

    AnalyticsEventService.instance.logEvent(
      _firebaseEventsFromDisease(event.diseases),
      parameters: {
        if (event.value && event.diseases.isDiabetes)
          CustomDefinitions.type: event.diseases.name,
        CustomDefinitions.value: event.value.toString(),
      },
    );

    CustomerIoService.track(
      event: _cIOEventFromDisease(event.diseases),
      attributes: {
        if (event.value && event.diseases.isDiabetes)
          'Diabetes Types': event.diseases.name,
        _cIOAttributesFromDisease(event.diseases): event.value,
      },
    );

    final isContains = state.containsDisease(event.diseases);
    Map<Diseases, bool> map = Map.from(state.diseases);

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
  MedicalQuestionsState? fromJson(Map<String, dynamic> json) => MedicalQuestionsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MedicalQuestionsState state) => state.toJson();

  String _firebaseEventsFromDisease(Diseases disease) => switch(disease) {
    Diseases.locomotorSystemDisease => FirebaseEvents.userLocomotorSystem,
    Diseases.liverDisease => FirebaseEvents.userHepatitisLiverDisease,
    Diseases.asthma => FirebaseEvents.userAstmaCOPD,
    Diseases.renalFailure => FirebaseEvents.userRenalFailure,
    Diseases.stomachReductionDisease => FirebaseEvents.userStomachReduction,
    Diseases.cardioVascularDisease => FirebaseEvents.userHeartSurgery,
    Diseases.hypertension => FirebaseEvents.userHypertension,
    Diseases.metabolicDisease => FirebaseEvents.userMetabolicDisease,
    Diseases.thyroidDisease => FirebaseEvents.userThyroidDisease,
    Diseases.obesity => FirebaseEvents.userSecondaryFormOfObesity,
    Diseases.diabetesTypeI => FirebaseEvents.userDiabetes,
    Diseases.diabetesTypeII => FirebaseEvents.userDiabetes,
    Diseases.sleepApneaSyndrome => FirebaseEvents.userSleepApnea,
  };

  String _cIOEventFromDisease(Diseases disease) => switch(disease) {
    Diseases.locomotorSystemDisease => CIOEvents.onboardingLocomotor,
    Diseases.liverDisease => CIOEvents.onboardingLiverDisease,
    Diseases.asthma => CIOEvents.onboardingAsthma,
    Diseases.renalFailure => CIOEvents.onboardingRenalFailure,
    Diseases.stomachReductionDisease => CIOEvents.onboardingStomachReduction,
    Diseases.cardioVascularDisease => CIOEvents.onboardingCardiovascularDisease,
    Diseases.hypertension => CIOEvents.onboardingHypertension,
    Diseases.metabolicDisease => CIOEvents.onboardingMetabolicDisease,
    Diseases.thyroidDisease => CIOEvents.onboardingThyroidDisease,
    Diseases.obesity => CIOEvents.onboardingSecondaryForm,
    Diseases.diabetesTypeI => CIOEvents.onboardingDiabetes,
    Diseases.diabetesTypeII => CIOEvents.onboardingDiabetes,
    Diseases.sleepApneaSyndrome => CIOEvents.onboardingApnea,
  };

  String _cIOAttributesFromDisease(Diseases disease) => switch(disease) {
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
