part of 'medical_fitness_bloc.dart';

enum MedicalFitnessQuestions {
  pregnancy,
  cardiovascularDisease,
  stomachReduction,
  painInChest,
  treatmentByTheDoctor,
  result
}

extension MedicalFitnessQuestionsX on MedicalFitnessQuestions {
  PageRouteInfo get route {
    switch (this) {
      case MedicalFitnessQuestions.pregnancy:
        return const PregnancyRoute();
      case MedicalFitnessQuestions.cardiovascularDisease:
        return const CardiovascularDiseaseRoute();
      case MedicalFitnessQuestions.stomachReduction:
        return const StomachReductionRoute();
      case MedicalFitnessQuestions.painInChest:
        return const PainInChestRoute();
      case MedicalFitnessQuestions.treatmentByTheDoctor:
        return const TreatmentByDoctorRoute();
      case MedicalFitnessQuestions.result:
        return const MedicalCheckPassedRoute();
    }
  }

  int get percentage {
    final valuesWithExclude = MedicalFitnessQuestions.values
        .where((element) => element != MedicalFitnessQuestions.result);

    final value = (index * 100) / valuesWithExclude.length;

    return value.toInt();
  }

  MedicalFitnessQuestions getNextQuestion() {
    if (index == MedicalFitnessQuestions.values.length - 1) {
      return this;
    }

    return MedicalFitnessQuestions.values[index + 1];
  }

  MedicalFitnessQuestions getPreviousQuestion() {
    if (index == 0) {
      return this;
    }

    return MedicalFitnessQuestions.values[index - 1];
  }
}
