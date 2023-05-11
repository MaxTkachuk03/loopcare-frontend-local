part of 'medical_fitness_bloc.dart';

List<String> medicalFitnessQuestions = [
  'intro',
  'pregnancy',
  'cardiovascularDisease',
  'stomachReduction',
  'painInChest',
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
  final valuesWithExclude =
      medicalFitnessQuestions.where((element) => _isQuestion(element));

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

  return medicalFitnessQuestions
      .get(medicalFitnessQuestions.indexOf(currentQuestion) - 1);
}

String getNextQuestion(String currentQuestion) {
  if (currentQuestion == medicalFitnessQuestions.last) {
    return currentQuestion;
  }

  return medicalFitnessQuestions
      .get(medicalFitnessQuestions.indexOf(currentQuestion) + 1);
}

PageRouteInfo getQuestionRoute(String question) {
  switch (question) {
    case 'intro':
      return const MedicalIntroRoute();
    case 'pregnancy':
      return const PregnancyRoute();
    case 'cardiovascularDisease':
      return const CardiovascularDiseaseRoute();
    case 'stomachReduction':
      return const StomachReductionRoute();
    case 'painInChest':
      return const PainInChestRoute();
    case 'treatmentByTheDoctor':
      return const TreatmentByDoctorRoute();
    case 'result':
      return const MedicalCheckPassedRoute();
  }
  return const MedicalIntroRoute();
}
