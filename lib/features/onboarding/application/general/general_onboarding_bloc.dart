import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/mental_health_service.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_question.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';
import 'package:loopcare_frontend/features/onboarding/domain/onboarding_screen_name.dart';
import 'package:loopcare_frontend/features/onboarding/domain/timer_state.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/diabetes_disease/diabetes_disease_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medical_check_failed/medical_check_failed_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medical_check_passed/medical_check_passed_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medical_disease_question/medical_disease_question_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medical_intro/medical_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/medicines/medicines_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/pregnancy/pregnancy_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/pregnancy_failed/pregnancy_failed_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/treatment_by_doctor/treatment_by_doctor_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/medical_questions/weight_loss_medication/weight_loss_medication_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/mental_check_final_result_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/mental_check_result_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/mental_health_intro/mental_health_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/mental_health_intro/mental_health_pre_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/mental_questions/mental_health_question_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/birthday/birthday_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/check_passed/check_passed_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/failed_age/failed_age_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/failed_bmi/failed_bmi_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/gender/gender_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/happiness/happiness_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/height/height_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/physical_intro/physical_intro_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/sex/sex_content.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/weight/weight_content.dart';
import 'package:loopcare_frontend/features/onboarding/utils/enum_list_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
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
  GeneralOnboardingState? fromJson(Map<String, dynamic> json) =>
      GeneralOnboardingState.fromJson(json);

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

        mentalSteps.addAll(List.generate(tests.length * 2,
            (i) => (i + 1).isOdd ? MentalQuestionStep.test : MentalQuestionStep.testSummery));

        mentalSteps.add(MentalQuestionStep.result);

        emit(
          state.copyWith(
            allMentalTests: tests,
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

    _startTimer(startedTime);
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
    if (state.generalStep != GeneralOnboardingStep.mental || !state.currentMentalStep.isTests) {
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
    final containsPregnancyStep = state.medicalQuestions.contains(MedicalQuestionStep.pregnancy);

    if (event.enable && !containsPregnancyStep) {
      emit(
        state.copyWith(
          medicalQuestions: List.from(state.medicalQuestions)
              .insertAfter(MedicalQuestionStep.intro, MedicalQuestionStep.pregnancy),
        ),
      );
    } else if (!event.enable && containsPregnancyStep) {
      emit(
        state.copyWith(
          medicalQuestions: List.from(state.medicalQuestions)
            ..remove(MedicalQuestionStep.pregnancy),
        ),
      );
    }
  }

  FutureOr<void> _onExcludeMentalQuestions(
    ExcludeMentalQuestionsByGender event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    final testsWithGenderExclusions = state.allMentalTests
        .map((element) => element.copyWith(
              questions: element.questions.where((e) => e.excludeSex != event.sex).toList(),
            ))
        .toList();

    final mentalTest = testsWithGenderExclusions.first;
    final question = mentalTest.questions.first;

    emit(
      state.copyWith(
        mentalTests: testsWithGenderExclusions,
        currentMentalTest: mentalTest,
        currentMentalQuestion: question,
      ),
    );
  }

  FutureOr<void> _onNextStep(NextStep event, Emitter<GeneralOnboardingState> emit) {
    emit(_nextStepState(isExclude: event.excluded));
  }

  FutureOr<void> _onPreviousStep(
    PreviousStep event,
    Emitter<GeneralOnboardingState> emit,
  ) {
    final previousStepState = _previousStepState();

    emit(previousStepState);
  }

  // METHODS ==================================================================>

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
    if (state.currentPhysicalStep == PhysicalQuestionStep.result) {
      return _handlePhysicalResultStep();
    } else if (isExclude) {
      return _handlePhysicalExclusionStep();
    } else {
      return _handlePhysicalNextStep();
    }
  }

  GeneralOnboardingState _handlePhysicalResultStep() {
    CustomerIoService.track(
      event: CIOEvents.onboardingMedicalIntro,
    );

    _sendScreenView(MedicalQuestionStep.intro.screenName);

    return state.copyWith(
      generalStep: GeneralOnboardingStep.medical,
      medicalPassedStack: [MedicalQuestionStep.intro],
    );
  }

  GeneralOnboardingState _handlePhysicalExclusionStep() {
    PhysicalQuestionStep step = state.currentPhysicalStep;
    List<PhysicalQuestionStep> questions = state.physicalQuestions;
    List<PhysicalQuestionStep> stack = state.physicalPassedStack;

    if (step == PhysicalQuestionStep.birthday) {
      questions = questions.insertAfter(step, PhysicalQuestionStep.ageExclusion);
      stack = [...stack, PhysicalQuestionStep.ageExclusion];

      _trackExclusion(AnalyticsEvents.onboardingAgeExclusion);
    } else if (step == PhysicalQuestionStep.weight) {
      questions = questions.insertAfter(step, PhysicalQuestionStep.bmiExclusion);
      stack = [...stack, PhysicalQuestionStep.bmiExclusion];

      _trackExclusion(AnalyticsEvents.onboardingBmiExclusion);
    }

    _sendScreenView(stack.last.screenName);

    return state.copyWith(
      physicalPassedStack: stack,
      physicalQuestions: questions,
    );
  }

  GeneralOnboardingState _handlePhysicalNextStep() {
    PhysicalQuestionStep step = state.currentPhysicalStep;
    List<PhysicalQuestionStep> stack = state.physicalPassedStack;

    final nextStepIndex = state.physicalQuestions.indexWhere((e) => e == step) + 1;
    step = state.physicalQuestions[nextStepIndex];
    stack = [...stack, step];

    if (step == PhysicalQuestionStep.result) {
      CustomerIoService.track(
        event: CIOEvents.onboardingBasicsCompleted,
      );
    }

    _sendScreenView(stack.last.screenName);

    return state.copyWith(
      physicalPassedStack: stack,
    );
  }

  GeneralOnboardingState _nextMedicalStep({bool isExclude = false}) {
    if (state.currentMedicalStep == MedicalQuestionStep.result) {
      return _handleMedicalResultStep();
    } else if (isExclude) {
      return _handleMedicalExclusionStep();
    } else {
      return _handleMedicalNextStep();
    }
  }

  GeneralOnboardingState _handleMedicalResultStep() {
    CustomerIoService.track(
      event: CIOEvents.onboardingMentalIntro,
    );

    _sendScreenView(MentalQuestionStep.introStepOne
        .getScreenName(state.mentalTests.first.type.name.toUpperCase()));

    return state.copyWith(
      generalStep: GeneralOnboardingStep.mental,
      mentalPassedStack: [MentalQuestionStep.introStepOne],
    );
  }

  GeneralOnboardingState _handleMedicalExclusionStep() {
    MedicalQuestionStep step = state.currentMedicalStep;
    List<MedicalQuestionStep> stack = state.medicalPassedStack;
    List<MedicalQuestionStep> questions = state.medicalQuestions;

    if (step == MedicalQuestionStep.pregnancy) {
      questions = questions.insertAfter(step, MedicalQuestionStep.pregnancyExclusion);
      stack = [...stack, MedicalQuestionStep.pregnancyExclusion];

      _trackExclusion(AnalyticsEvents.onboardingPregnancyExclusion);
    } else if (step == MedicalQuestionStep.treatmentByTheDoctor) {
      questions = questions.insertAfter(step, MedicalQuestionStep.completedDisease);
      stack = [...stack, MedicalQuestionStep.completedDisease];
    }

    _sendScreenView(stack.last.screenName);

    return state.copyWith(
      medicalPassedStack: stack,
      medicalQuestions: questions,
    );
  }

  GeneralOnboardingState _handleMedicalNextStep() {
    MedicalQuestionStep step = state.currentMedicalStep;
    List<MedicalQuestionStep> stack = state.medicalPassedStack;

    final nextStepIndex = state.medicalQuestions.indexWhere((e) => e == step) + 1;
    step = state.medicalQuestions[nextStepIndex];
    stack = [...stack, step];

    if (step == MedicalQuestionStep.result) {
      CustomerIoService.track(
        event: CIOEvents.onboardingMedicalCompleted,
      );
    }

    _sendScreenView(stack.last.screenName);

    return state.copyWith(
      medicalPassedStack: stack,
    );
  }

  GeneralOnboardingState _nextMentalStep({bool isExclude = false}) {
    final mentalStep = state.currentMentalStep;

    if (mentalStep == MentalQuestionStep.result) {
      return state;
    } else if (mentalStep == MentalQuestionStep.test) {
      return _handleMentalTestStep();
    } else if (mentalStep == MentalQuestionStep.testSummery) {
      return _handleMentalTestSummeryStep(isExclude: isExclude);
    } else {
      return _handleMentalNextStep();
    }
  }

  GeneralOnboardingState _handleMentalTestStep() {
    List<MentalQuestionStep> stack = state.mentalPassedStack;
    List<MentalHealthTest> tests = state.mentalTests;
    MentalHealthTest test = state.currentMentalTest ?? tests.first;
    MentalHealthQuestion question = state.currentMentalQuestion ?? test.questions.first;

    if (test.questions.last.id == question.id) {
      stack = [...stack, MentalQuestionStep.testSummery];
    } else {
      question = test.questions[test.questions.indexOf(question) + 1];
    }

    _sendScreenView(stack.last.getScreenName(test.type.name.toUpperCase()));

    return state.copyWith(
      mentalPassedStack: stack,
      currentMentalTest: test,
      currentMentalQuestion: question,
    );
  }

  GeneralOnboardingState _handleMentalTestSummeryStep({bool isExclude = false}) {
    List<MentalQuestionStep> stack = state.mentalPassedStack;
    List<MentalHealthTest> tests = state.mentalTests;
    MentalHealthTest currentTest = state.currentMentalTest ?? tests.first;
    MentalHealthQuestion question = state.currentMentalQuestion ?? currentTest.questions.first;

    if (tests.last.id == currentTest.id) {
      add(const GeneralOnboardingEvent.stopTimer());

      if (isExclude) {
        stack = [...stack, MentalQuestionStep.resultFailed];
      } else {
        stack = [...stack, MentalQuestionStep.result];
      }
    } else {
      stack = [...stack, MentalQuestionStep.test];
      currentTest = tests[tests.indexOf(currentTest) + 1];
      question = currentTest.questions.first;
    }

    _sendScreenView(stack.last.getScreenName(currentTest.type.name.toUpperCase()));

    return state.copyWith(
      mentalPassedStack: stack,
      currentMentalTest: currentTest,
      currentMentalQuestion: question,
    );
  }

  GeneralOnboardingState _handleMentalNextStep() {
    List<MentalQuestionStep> stack = state.mentalPassedStack;
    List<MentalHealthTest> tests = state.mentalTests;
    MentalHealthTest test = state.currentMentalTest ?? tests.first;
    List<MentalQuestionStep> questions = state.mentalQuestions;

    final nextStep = questions[questions.indexOf(stack.last) + 1];
    stack = [...stack, nextStep];

    _sendScreenView(stack.last.getScreenName(test.type.name.toUpperCase()));

    return state.copyWith(
      mentalPassedStack: stack,
    );
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
    List<PhysicalQuestionStep> questions = state.physicalQuestions;

    if (state.currentPhysicalStep == PhysicalQuestionStep.ageExclusion) {
      questions = List.from(state.physicalQuestions)..remove(PhysicalQuestionStep.ageExclusion);
    } else if (state.currentPhysicalStep == PhysicalQuestionStep.bmiExclusion) {
      questions = List.from(state.physicalQuestions)..remove(PhysicalQuestionStep.bmiExclusion);
    }

    final List<PhysicalQuestionStep> stack = List.from(state.physicalPassedStack)..removeLast();
    _sendScreenView(stack.last.screenName);

    return state.copyWith(
      physicalPassedStack: stack,
      physicalQuestions: questions,
    );
  }

  GeneralOnboardingState _previousMedicalStepState() {
    GeneralOnboardingStep generalStep = state.generalStep;
    List<MedicalQuestionStep> medicalQuestions = state.medicalQuestions;
    List<MedicalQuestionStep> medicalStack = state.medicalPassedStack;

    if (state.currentMedicalStep == MedicalQuestionStep.intro) {
      generalStep = GeneralOnboardingStep.physical;

      _sendScreenView(state.physicalPassedStack.last.screenName);
    } else {
      medicalStack = List.from(state.medicalPassedStack)..removeLast();

      _sendScreenView(medicalStack.last.screenName);
    }

    if (state.currentMedicalStep == MedicalQuestionStep.pregnancyExclusion) {
      medicalQuestions = List.from(state.medicalQuestions)
        ..remove(MedicalQuestionStep.pregnancyExclusion);
    } else if (state.currentMedicalStep == MedicalQuestionStep.completedDisease) {
      medicalQuestions = List.from(state.medicalQuestions)
        ..remove(MedicalQuestionStep.completedDisease);
    }

    return state.copyWith(
      generalStep: generalStep,
      medicalPassedStack: medicalStack,
      medicalQuestions: medicalQuestions,
    );
  }

  GeneralOnboardingState _previousMentalStepState() {
    final mentalStep = state.currentMentalStep;
    final test = state.currentMentalTest ?? state.mentalTests.first;

    if (mentalStep == MentalQuestionStep.testSummery && state.mentalTests.last == test) {
      add(const GeneralOnboardingEvent.resumeTimer());
    }

    if (mentalStep == MentalQuestionStep.introStepOne) {
      return _handleMentalPreviousIntroStep();
    } else if (mentalStep == MentalQuestionStep.test) {
      return _handleMentalPreviousTestStep();
    } else {
      return _handleMentalPreviousStep();
    }
  }

  GeneralOnboardingState _handleMentalPreviousIntroStep() {
    add(const GeneralOnboardingEvent.stopTimer());

    _sendScreenView(state.medicalPassedStack.last.screenName);

    return state.copyWith(
      generalStep: GeneralOnboardingStep.medical,
    );
  }

  GeneralOnboardingState _handleMentalPreviousTestStep() {
    List<MentalQuestionStep> stack = state.mentalPassedStack;
    List<MentalHealthTest> mentalTests = state.mentalTests;
    MentalHealthTest test = state.currentMentalTest ?? mentalTests.first;
    MentalHealthQuestion question = state.currentMentalQuestion ?? test.questions.first;

    if (test.questions.first.id == question.id) {
      if (mentalTests.first.id != test.id) {
        test = mentalTests[mentalTests.indexOf(test) - 1];
        question = test.questions.last;
      }

      stack = List.from(stack)..removeLast();
    } else {
      question = test.questions[test.questions.indexOf(question) - 1];
    }

    _sendScreenView(stack.last.getScreenName(test.type.name.toUpperCase()));

    return state.copyWith(
      mentalPassedStack: stack,
      currentMentalTest: test,
      currentMentalQuestion: question,
    );
  }

  GeneralOnboardingState _handleMentalPreviousStep() {
    final test = state.currentMentalTest ?? state.mentalTests.first;
    final stack = List<MentalQuestionStep>.from(state.mentalPassedStack)..removeLast();

    _sendScreenView(stack.last.getScreenName(test.type.name.toUpperCase()));

    return state.copyWith(
      mentalPassedStack: stack,
    );
  }

  Future<void> _startTimer(DateTime startedTime) async {
    final mentalHealthTime = int.parse(dotenv.env['MENTAL_HEALTH_TEST_TIME_IN_MINUTES']!) * 60;
    final localTime = await NTP.now();
    final durationTime = mentalHealthTime - localTime.difference(startedTime).inSeconds;

    _timer = Timer(Duration(seconds: durationTime), _stopTimer);
  }

  void _stopTimer() {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.showPopupAboutExceededTime,
    );

    add(const GeneralOnboardingEvent.stopTimer(isTimeUp: true));
    _timer?.cancel();
  }

  void _sendScreenView(String screenName) {
    const AnalyticsEventService().logScreenEvent(screenName);
  }

  void _trackExclusion(String eventName) {
    const AnalyticsEventService().logEvent(eventName: eventName);
    CustomerIoService.track(event: eventName);
  }
}
