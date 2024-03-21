part of 'general_onboarding_bloc.dart';

@freezed
class GeneralOnboardingState with _$GeneralOnboardingState {
  const GeneralOnboardingState._();

  const factory GeneralOnboardingState({
    @Default(GeneralOnboardingStep.physical) GeneralOnboardingStep generalStep,
    @Default([]) List<PhysicalQuestionStep> physicalPassedStack,
    @Default(_defaultPhysicalQuestions) List<PhysicalQuestionStep> physicalQuestions,
    @Default([]) List<MedicalQuestionStep> medicalPassedStack,
    @Default(_defaultMedicalQuestions) List<MedicalQuestionStep> medicalQuestions,
    @Default([]) List<MentalQuestionStep> mentalPassedStack,
    @Default(_defaultMentalQuestions) List<MentalQuestionStep> mentalQuestions,
    @Default([]) List<MentalHealthTest> mentalTests,
    DateTime? mentalStartTime,
    @Default(TimerState.empty) TimerState mentalTimerState,
    MentalHealthTest? currentMentalTest,
    MentalHealthQuestion? currentMentalQuestion,
  }) = _GeneralOnboardingState;

  factory GeneralOnboardingState.fromJson(Map<String, dynamic> json) => _$GeneralOnboardingStateFromJson(json);

  PhysicalQuestionStep get currentPhysicalStep => physicalPassedStack.isNotEmpty
      ? physicalPassedStack.last
      : PhysicalQuestionStep.intro;

  MedicalQuestionStep get currentMedicalStep => medicalPassedStack.isNotEmpty
      ? medicalPassedStack.last
      : MedicalQuestionStep.intro;

  MentalQuestionStep get currentMentalStep => mentalPassedStack.isNotEmpty
      ? mentalPassedStack.last
      : MentalQuestionStep.introStepOne;

  int get stepCount => switch(generalStep) {
    GeneralOnboardingStep.physical => PhysicalQuestionStep.result.progress,
    GeneralOnboardingStep.medical => _medicalStepCount,
    GeneralOnboardingStep.mental => _mentalStepCount,
  };

  int get _medicalStepCount {
    if (!medicalQuestions.contains(MedicalQuestionStep.pregnancy)) {
      return MedicalQuestionStep.result.progress - 1;
    } else {
      return MedicalQuestionStep.result.progress;
    }
  }


  int get _mentalStepCount {
    int progress = 0;
    for (final test in mentalTests) {
      progress += test.questions.length;
    }

    return progress;
  }

  int get stepIndex => switch(generalStep) {
    GeneralOnboardingStep.physical => currentPhysicalStep.progress,
    GeneralOnboardingStep.medical => _medicalStepIndex,
    GeneralOnboardingStep.mental => _mentalStepIndex,
  };

  int get _medicalStepIndex {
    if (!medicalQuestions.contains(MedicalQuestionStep.pregnancy) && !currentMedicalStep.isIntro) {
      return currentMedicalStep.progress - 1;
    } else {
      return currentMedicalStep.progress;
    }
  }


  int get _mentalStepIndex {
    final testIndex = mentalTests.indexOf(currentMentalTest ?? mentalTests.first);
    final questionIndex = currentMentalTest?.questions.indexOf(currentMentalQuestion ?? mentalTests.first.questions.first) ?? 0;

    int progress = 1;
    for (int i = 0; i <= testIndex; i++) {
      if (i < testIndex) {
        progress += mentalTests[i].questions.length;
      } else if (i == testIndex) {
        progress += questionIndex;
        break;
      }
    }

    return progress;
  }

  int get progress => ((stepIndex / stepCount) * 100).round();

  Color get backgroundColor => switch(generalStep) {
    GeneralOnboardingStep.physical => _physicalStepBackgroundColor,
    GeneralOnboardingStep.medical => _medicalStepBackgroundColor,
    GeneralOnboardingStep.mental => _mentalStepBackgroundColor,
  };

  Color get _physicalStepBackgroundColor {
    if (currentPhysicalStep.isIntro) {
      return generalStep.primaryColor;
    } else if (currentPhysicalStep.isExclusionOrResult) {
      return generalStep.alternativeBackgroundColor;
    } else {
      return generalStep.background;
    }
  }

  Color get _medicalStepBackgroundColor {
    if (currentMedicalStep.isIntro) {
      return generalStep.primaryColor;
    } else if (currentMedicalStep.isExclusionOrResult) {
      return generalStep.alternativeBackgroundColor;
    } else {
      return generalStep.background;
    }
  }

  Color get _mentalStepBackgroundColor {
    if (currentMentalStep.isIntro) {
      return generalStep.primaryColor;
    } else if (currentMentalStep.isResult) {
      return generalStep.alternativeBackgroundColor;
    } else {
      return generalStep.background;
    }
  }

  bool get hasAppBar => switch(generalStep) {
    GeneralOnboardingStep.physical => currentPhysicalStep.hasProgressBar,
    GeneralOnboardingStep.medical => currentMedicalStep.hasProgressBar,
    GeneralOnboardingStep.mental => currentMentalStep.hasProgressBar,
  };

  Widget get currentStepContent => switch(generalStep) {
    GeneralOnboardingStep.physical => currentPhysicalStep.content,
    GeneralOnboardingStep.medical => currentMedicalStep.content,
    GeneralOnboardingStep.mental => currentMentalStep.content,
  };

  bool get hasBackButton => switch(generalStep) {
    GeneralOnboardingStep.physical => true,
    GeneralOnboardingStep.medical => !currentMedicalStep.isIntro,
    GeneralOnboardingStep.mental => !currentMentalStep.isIntro,
  };

  bool get hasSubtitle => switch(generalStep) {
    GeneralOnboardingStep.physical => !currentPhysicalStep.isExclusionOrResult,
    GeneralOnboardingStep.medical => !currentMedicalStep.isExclusionOrResult,
    GeneralOnboardingStep.mental => !currentMentalStep.isResult,
  };

  bool get isLastMentalQuestion => currentMentalTest != null
      ? currentMentalTest!.questions.isLast(currentMentalQuestion!)
      : false;

  bool get isLastMentalTest => mentalTests.isNotEmpty
      ? mentalTests.isLast(currentMentalTest!)
      : false;

  bool get isStarted => generalStep != GeneralOnboardingStep.physical ||
      !currentPhysicalStep.isIntro;

  bool get isCompleted => generalStep == GeneralOnboardingStep.mental &&
      currentMentalStep == MentalQuestionStep.result;
}
