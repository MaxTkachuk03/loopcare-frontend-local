part of 'medical_fitness_bloc.dart';

List<String> medicalFitnessQuestions = [
  'intro',
  'pregnancy',
  'medicines',
  'weightLossMedication',
  'obesityDisease',
  'thyroidDisease',
  'metabolicDisease',
  'hypertension',
  'cardiovascularDisease',
  'stomachReduction',
  'diabetesDisease',
  'renalFailure',
  'asthma',
  'liverDisease',
  'sleepApneaSyndrome',
  'locomotorSystemDisease',
  'treatmentByTheDoctor',
  'result'
];

bool _isQuestion(String question) {
  switch (question) {
    case 'intro':
      return false;
    case 'result':
      return false;
    default:
      return true;
  }
}

int _percentage(String currentQuestion) {
  final valuesWithExclude = medicalFitnessQuestions.where((element) => _isQuestion(element));

  final elIndex = medicalFitnessQuestions.indexOf(currentQuestion) == 0
      ? 0
      : medicalFitnessQuestions.indexOf(currentQuestion) - 1;

  final value = (elIndex * 100) / valuesWithExclude.length;

  return value.toInt();
}

String _getPreviousQuestion(String currentQuestion) {
  if (currentQuestion == medicalFitnessQuestions.first) {
    return currentQuestion;
  }

  return medicalFitnessQuestions.get(medicalFitnessQuestions.indexOf(currentQuestion) - 1);
}

String getNextQuestion(String currentQuestion) {
  if (currentQuestion == medicalFitnessQuestions.last) {
    return currentQuestion;
  }

  return medicalFitnessQuestions.get(medicalFitnessQuestions.indexOf(currentQuestion) + 1);
}

PageRouteInfo getQuestionRoute(String question) {
  switch (question) {
    case 'intro':
      return const MedicalIntroRoute();
    case 'pregnancy':
      return const PregnancyRoute();
    case 'medicines':
      return const MedicinesRoute();
    case 'weightLossMedication':
      return const WeightLossMedicationRoute();
    case 'obesityDisease':
      return const ObesityRoute();
    case 'thyroidDisease':
      return const ThyroidDiseaseRoute();
    case 'metabolicDisease':
      return const MetabolicDiseaseRoute();
    case 'hypertension':
      return const HypertensionRoute();
    case 'cardiovascularDisease':
      return const CardiovascularDiseaseRoute();
    case 'stomachReduction':
      return const StomachReductionRoute();
    case 'diabetesDisease':
      return const DiabetesDiseaseRoute();
    case 'renalFailure':
      return const RenalFailureRoute();
    case 'asthma':
      return const AsthmaRoute();
    case 'liverDisease':
      return const LiverDiseaseRoute();
    case 'sleepApneaSyndrome':
      return const SleepApneaSyndromeRoute();
    case 'locomotorSystemDisease':
      return const LocomotorSystemDiseaseRoute();
    case 'treatmentByTheDoctor':
      return const TreatmentByDoctorRoute();
    case 'result':
      return const MedicalCheckPassedRoute();
  }
  return const MedicalIntroRoute();
}
