import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/mental_health_service.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_question.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding_new/domain/timer_state.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/diabetes_disease/diabetes_disease_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medical_check_failed/medical_check_failed_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medical_check_passed/medical_check_passed_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medical_disease_question/medical_disease_question_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medical_intro/medical_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medication_explanation/medication_past_period_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medication_future_period/medication_future_period_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medication_past_period/medication_past_period_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/medicines/medicines_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/pregnancy/pregnancy_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/pregnancy_failed/pregnancy_failed_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/treatment_by_doctor/treatment_by_doctor_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/medical_questions/weight_loss_medication/weight_loss_medication_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/mental_check_final_result_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/mental_check_result_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/mental_health_intro/mental_health_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/mental_health_intro/mental_health_pre_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/mental_questions/mental_health_question_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/birthday/birthday_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/check_passed/check_passed_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/failed_age/failed_age_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/failed_bmi/failed_bmi_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/gender/gender_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/happiness/happiness_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/height/height_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/physical_intro/physical_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/sex/sex_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/weight/weight_content.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/enum_list_extension.dart';
import 'package:ntp/ntp.dart';

part 'general_onboarding_bloc.freezed.dart';
part 'general_onboarding_bloc.g.dart';
part 'general_onboarding_event.dart';
part 'general_onboarding_staps.dart';
part 'general_onboarding_state.dart';

@singleton
class GeneralOnboardingBloc extends HydratedBloc<GeneralOnboardingEvent, GeneralOnboardingState> {
  final MentalHealthService _mentalHealthService;

  GeneralOnboardingBloc(this._mentalHealthService) : super(const GeneralOnboardingState()) {
    on<Started>(_onStarted);
    on<StartTimer>(_onStartTimer);
    on<StopTimer>(_onStopTimer);
    on<ResumeTimer>(_onResumeTimer);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<ResetData>(_onResetData);
    on<UpdatePregnancyQuestion>(_onUpdatePregnancyQuestion);
    on<StartMentalTestFromBeginning>(_onStartMentalTestFromBeginning);
    on<ExcludeMentalQuestionsByGender>(_onExcludeMentalQuestions);
  }

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  @override
  GeneralOnboardingState? fromJson(Map<String, dynamic> json) => GeneralOnboardingState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(GeneralOnboardingState state) => state.toJson();

  FutureOr<void> _onResetData(ResetData event, Emitter<GeneralOnboardingState> emit) {
    emit(const GeneralOnboardingState());
  }

  FutureOr<void> _onStartMentalTestFromBeginning(
    StartMentalTestFromBeginning event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    final mentalStack = [MentalQuestionStep.introStepOne];
    final currentMentalTest = state.mentalTests.first;
    final currentQuestion = currentMentalTest.questions.first;

    emit(
      state.copyWith(
        mentalPassedStack: mentalStack,
        currentMentalTest: currentMentalTest,
        currentMentalQuestion: currentQuestion,
      ),
    );
  }

  FutureOr<void> _onStarted(Started event, Emitter<GeneralOnboardingState> emit) async {
    CustomerIoService.track(
      event: CIOEvents.onboardingBasicsIntro,
    );

    emit(
      state.copyWith(
        physicalPassedStack: [PhysicalQuestionStep.intro],
      ),
    );

    final response = await _mentalHealthService.mentalHealthQuestions();

    response.fold(
      (e) => null,
      (result) {
        final tests = result.data;

        final List<MentalQuestionStep> mentalSteps = [
          MentalQuestionStep.introStepOne,
          MentalQuestionStep.introStepTwo,
        ];

        mentalSteps.addAll(List.generate(tests.length * 2, (i) => (i + 1).isOdd ? MentalQuestionStep.test : MentalQuestionStep.testSummery));

        mentalSteps.add(MentalQuestionStep.result);

        emit(
          state.copyWith(
            mentalTests: tests,
            mentalQuestions: mentalSteps,
          ),
        );
      },
    );
  }

  FutureOr<void> _onStartTimer(
    StartTimer event,
    Emitter<GeneralOnboardingState> emit,
  ) async {
    final startedTime = event.startTime ?? await NTP.now();

    emit(
      state.copyWith(
        mentalStartTime: startedTime,
        mentalTimerState: TimerState.active,
      ),
    );

    final mentalHealthTime = int.parse(dotenv.env['MENTAL_HEALTH_TEST_TIME_IN_MINUTES']!) * 60;

    final localTime = await NTP.now();

    final durationTime = mentalHealthTime - localTime.difference(startedTime).inSeconds;

    _timer = Timer(
      Duration(seconds: durationTime),
      () {
        AnalyticsEventService.instance.logEvent(FirebaseEvents.showPopupAboutExceededTime);
        add(const GeneralOnboardingEvent.stopTimer(isTimeUp: true));
        _timer?.cancel();
      },
    );
  }

  FutureOr<void> _onStopTimer(
    StopTimer event,
    Emitter<GeneralOnboardingState> emit,
  ) async {
    emit(
      state.copyWith(
        mentalTimerState: event.isTimeUp ? TimerState.completed : TimerState.empty,
      ),
    );
  }

  FutureOr<void> _onResumeTimer(
    ResumeTimer event,
    Emitter<GeneralOnboardingState> emit,
  ) async {
    if (state.generalStep != GeneralOnboardingStep.mental
        || !state.currentMentalStep.isTests) {
      return;
    }

    final time = state.mentalStartTime;

    if (time == null) {
      add(const GeneralOnboardingEvent.startTimer());
      return;
    }

    final mentalHealthTime = int.parse(dotenv.env['MENTAL_HEALTH_TEST_TIME_IN_MINUTES']!);

    final localTime = await NTP.now();

    if (localTime.difference(time).inMinutes >= mentalHealthTime) {
      add(const GeneralOnboardingEvent.stopTimer(isTimeUp: true));
      return;
    }

    add(GeneralOnboardingEvent.startTimer(startTime: time));
  }

  FutureOr<void> _onUpdatePregnancyQuestion(
    UpdatePregnancyQuestion event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    
    final containsPregnancyStep = !state.medicalQuestions.contains(MedicalQuestionStep.pregnancy);
    
    if (event.enable && !containsPregnancyStep) {
      emit(
        state.copyWith(
          medicalQuestions: List.from(state.medicalQuestions).insertAfter(MedicalQuestionStep.intro, MedicalQuestionStep.pregnancy),
        ),
      );
    } else if (!event.enable && containsPregnancyStep) {
      emit(
        state.copyWith(
          medicalQuestions: List.from(state.medicalQuestions)..remove(MedicalQuestionStep.pregnancy),
        ),
      );
    }
  }

  FutureOr<void> _onExcludeMentalQuestions(
    ExcludeMentalQuestionsByGender event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    final testsWithGenderExclusions = state.mentalTests
        .map((element) => element.copyWith(
          questions: element.questions.where((e) => e.excludeGender != event.gender).toList(),
        ))
        .toList();

    emit(
      state.copyWith(
        mentalTests: testsWithGenderExclusions,
      ),
    );
  }

  FutureOr<void> _onNextStep(NextStep event, Emitter<GeneralOnboardingState> emit) {
    final nextStepState = _nextStepState(isExclude: event.excluded);

    emit(nextStepState);
  }

  GeneralOnboardingState _nextStepState({bool isExclude = false}) {
    if (state.generalStep == GeneralOnboardingStep.physical) {
      return _nextPhysicalStep(isExclude: isExclude);
    } else if (state.generalStep == GeneralOnboardingStep.medical) {
      return _nextMedicalStep(isExclude: isExclude);
    } else {
      return _nextMentalStep(isExclude: isExclude);
    }
  }

  GeneralOnboardingState _nextPhysicalStep({bool isExclude = false}) {
    GeneralOnboardingStep generalStep = state.generalStep;

    PhysicalQuestionStep physicalStep = state.currentPhysicalStep;

    List<PhysicalQuestionStep> physicalStack = state.physicalPassedStack;
    List<PhysicalQuestionStep> physicalQuestions = state.physicalQuestions;

    List<MedicalQuestionStep> medicalStack = [];

    if (physicalStep == PhysicalQuestionStep.result) {
      generalStep = GeneralOnboardingStep.medical;
      medicalStack = [MedicalQuestionStep.intro];

    } else if (isExclude) {
      if (physicalStep == PhysicalQuestionStep.birthday) {
        physicalQuestions = physicalQuestions.insertAfter(physicalStep, PhysicalQuestionStep.ageExclusion);
        physicalStack = [...physicalStack, PhysicalQuestionStep.ageExclusion];

        CustomerIoService.track(
          event: CIOEvents.onboardingAgeExclusion,
        );

      } else if (physicalStep == PhysicalQuestionStep.weight) {
        physicalQuestions = physicalQuestions.insertAfter(physicalStep, PhysicalQuestionStep.bmiExclusion);
        physicalStack = [...physicalStack, PhysicalQuestionStep.bmiExclusion];

        CustomerIoService.track(
          event: CIOEvents.onboardingBmiExclusion,
        );
      }
    } else {
      final nextStepIndex = state.physicalQuestions.indexWhere((e) => e == physicalStep) + 1;
      physicalStep = state.physicalQuestions[nextStepIndex];

      physicalStack = [...physicalStack, physicalStep];
    }

    return state.copyWith(
      generalStep: generalStep,
      physicalPassedStack: physicalStack,
      physicalQuestions: physicalQuestions,
      medicalPassedStack: medicalStack,
    );
  }

  GeneralOnboardingState _nextMedicalStep({bool isExclude = false}) {
    GeneralOnboardingStep generalStep = state.generalStep;

    MedicalQuestionStep medicalStep = state.currentMedicalStep;

    List<MedicalQuestionStep> medicalStack = state.medicalPassedStack;
    List<MedicalQuestionStep> medicalQuestions = state.medicalQuestions;

    List<MentalQuestionStep> mentalStack = [];

    if (medicalStep == MedicalQuestionStep.result) {
      generalStep = GeneralOnboardingStep.mental;
      mentalStack = [MentalQuestionStep.introStepOne];

      CustomerIoService.track(
        event: CIOEvents.onboardingMentalIntro,
      );
    } else if (isExclude) {
      if (medicalStep == MedicalQuestionStep.pregnancy) {
        medicalQuestions = medicalQuestions.insertAfter(medicalStep, MedicalQuestionStep.pregnancyExclusion);
        medicalStack = [...medicalStack, MedicalQuestionStep.pregnancyExclusion];

        CustomerIoService.track(
          event: CIOEvents.onboardingPregnancyExclusion,
        );
      } else if (medicalStep == MedicalQuestionStep.semaglutide) {
        medicalQuestions = medicalQuestions.insertAllAfter(
          [
            MedicalQuestionStep.semaglutideTakingPeriod,
            MedicalQuestionStep.semaglutideTreatmentPeriod,
            MedicalQuestionStep.semaglutideExplanation,
          ],
          medicalStep,
        );

        medicalStack = [
          ...medicalStack,
          MedicalQuestionStep.semaglutideTakingPeriod,
        ];
      } else if (medicalStep == MedicalQuestionStep.treatmentByTheDoctor) {
        medicalQuestions = medicalQuestions.insertAfter(medicalStep, MedicalQuestionStep.completedDisease);
        medicalStack = [...medicalStack, MedicalQuestionStep.completedDisease];
      }
    } else {
      final nextStepIndex = state.medicalQuestions.indexWhere((e) => e == medicalStep) + 1;
      medicalStep = state.medicalQuestions[nextStepIndex];

      medicalStack = [...medicalStack, medicalStep];
    }

    return state.copyWith(
      generalStep: generalStep,
      medicalPassedStack: medicalStack,
      medicalQuestions: medicalQuestions,
      mentalPassedStack: mentalStack,
    );
  }

  GeneralOnboardingState _nextMentalStep({bool isExclude = false}) {
    MentalQuestionStep mentalStep = state.currentMentalStep;

    List<MentalQuestionStep> mentalStack = state.mentalPassedStack;
    List<MentalQuestionStep> mentalQuestions = state.mentalQuestions;

    List<MentalHealthTest> mentalTests = state.mentalTests;

    MentalHealthTest currentMentalTest = state.currentMentalTest
        ?? mentalTests.first;
    MentalHealthQuestion currentQuestion = state.currentMentalQuestion
        ?? currentMentalTest.questions.first;

    if (mentalStep == MentalQuestionStep.result) {
      return state;

    } else if (mentalStep == MentalQuestionStep.test) {
      if (currentMentalTest.questions.isLast(currentQuestion)) {
        mentalStack = [...mentalStack, MentalQuestionStep.testSummery];
      } else {
        currentQuestion = currentMentalTest.questions[currentMentalTest.questions.indexOf(currentQuestion) + 1];
      }

    } else if (mentalStep == MentalQuestionStep.testSummery) {
      if (mentalTests.isLast(currentMentalTest)) {
        mentalStack = [...mentalStack, MentalQuestionStep.result];
      } else {
        mentalStack = [...mentalStack, MentalQuestionStep.test];
        currentMentalTest = mentalTests[mentalTests.indexOf(currentMentalTest) + 1];
        currentQuestion = currentMentalTest.questions.first;
      }
    } else {

      final nextStep = mentalQuestions[mentalQuestions.indexOf(mentalStack.last) + 1];
      mentalStack = [...mentalStack, nextStep];
    }

    return state.copyWith(
      mentalPassedStack: mentalStack,
      currentMentalTest: currentMentalTest,
      currentMentalQuestion: currentQuestion,
    );
  }

  FutureOr<void> _onPreviousStep(
    PreviousStep event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    final previousStepState = _previousStepState();

    emit(previousStepState);
  }

  GeneralOnboardingState _previousStepState() {
    if (state.generalStep == GeneralOnboardingStep.physical) {
      return _previousPhysicalStepState();
    } else if (state.generalStep == GeneralOnboardingStep.medical) {
      return _previousMedicalStepState();
    } else {
      return _previousMentalStepState();
    }
  }

  GeneralOnboardingState _previousPhysicalStepState() {
    List<PhysicalQuestionStep> physicalQuestions = state.physicalQuestions;
    if (state.currentPhysicalStep == PhysicalQuestionStep.ageExclusion) {
      physicalQuestions = List.from(state.physicalQuestions)..remove(PhysicalQuestionStep.ageExclusion);
    } else if (state.currentPhysicalStep == PhysicalQuestionStep.bmiExclusion) {
      physicalQuestions = List.from(state.physicalQuestions)..remove(PhysicalQuestionStep.bmiExclusion);
    }

    return state.copyWith(
      physicalPassedStack: List.from(state.physicalPassedStack)..removeLast(),
      physicalQuestions: physicalQuestions,
    );
  }

  GeneralOnboardingState _previousMedicalStepState() {
    GeneralOnboardingStep generalStep = state.generalStep;
    List<MedicalQuestionStep> medicalQuestions = state.medicalQuestions;
    List<MedicalQuestionStep> medicalStack = state.medicalPassedStack;

    if (state.currentMedicalStep == MedicalQuestionStep.intro) {
      generalStep = GeneralOnboardingStep.physical;
    } else {
      medicalStack = List.from(state.medicalPassedStack)..removeLast();
    }


    if (state.currentMedicalStep == MedicalQuestionStep.pregnancyExclusion) {
      medicalQuestions = List.from(state.medicalQuestions)..remove(MedicalQuestionStep.pregnancyExclusion);
    } else if (state.currentMedicalStep == MedicalQuestionStep.semaglutideTakingPeriod) {
      medicalQuestions = List.from(state.medicalQuestions)
        ..remove(MedicalQuestionStep.semaglutideTakingPeriod)
        ..remove(MedicalQuestionStep.semaglutideTreatmentPeriod)
        ..remove(MedicalQuestionStep.semaglutideExplanation);
    } else if (state.currentMedicalStep == MedicalQuestionStep.completedDisease) {
      medicalQuestions = List.from(state.medicalQuestions)..remove(MedicalQuestionStep.completedDisease);
    }

    return state.copyWith(
      generalStep: generalStep,
      medicalPassedStack: medicalStack,
      medicalQuestions: medicalQuestions,
    );
  }

  GeneralOnboardingState _previousMentalStepState() {
    GeneralOnboardingStep generalStep = state.generalStep;
    MentalQuestionStep mentalStep = state.currentMentalStep;
    List<MentalQuestionStep> mentalStack = state.mentalPassedStack;
    List<MentalHealthTest> mentalTests = state.mentalTests;
    MentalHealthTest currentMentalTest = state.currentMentalTest
        ?? mentalTests.first;
    MentalHealthQuestion currentQuestion = state.currentMentalQuestion
        ?? currentMentalTest.questions.first;

    if (mentalStep == MentalQuestionStep.introStepOne) {
      generalStep = GeneralOnboardingStep.medical;
    } else if (mentalStep == MentalQuestionStep.test) {
      if (currentMentalTest.questions.first == currentQuestion) {
        if (mentalTests.first != currentMentalTest) {
          currentMentalTest = mentalTests[mentalTests.indexOf(currentMentalTest) - 1];
          currentQuestion = currentMentalTest.questions.last;
        }

        mentalStack = List.from(mentalStack)..removeLast();
      } else {
        currentQuestion = currentMentalTest.questions[currentMentalTest.questions.indexOf(currentQuestion) - 1];
      }

    } else {
      mentalStack = List.from(mentalStack)..removeLast();
    }

    return state.copyWith(
      generalStep: generalStep,
      mentalPassedStack: mentalStack,
      currentMentalTest: currentMentalTest,
      currentMentalQuestion: currentQuestion,
    );
  }
}
