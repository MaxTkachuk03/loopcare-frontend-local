part of 'physical_fitness_bloc.dart';

enum PhysicalFitnessQuestions {
  height,
  birthday,
  weight,
  sex,
}

extension PhysicalFitnessQuestionsX on PhysicalFitnessQuestions {
  String get currentRoute {
    switch (this) {
      case PhysicalFitnessQuestions.height:
        return AppRoutes.height;
      case PhysicalFitnessQuestions.weight:
        return AppRoutes.weight;
      default:
        return AppRoutes.weight;
    }
  }

  PhysicalFitnessQuestions getNextQuestion() {
    if (index == PhysicalFitnessQuestions.values.length - 1) {
      return this;
    }

    return PhysicalFitnessQuestions.values[index + 1];
  }

  PhysicalFitnessQuestions getPreviousQuestion() {
    if (index == 0) {
      return this;
    }

    return PhysicalFitnessQuestions.values[index - 1];
  }
}
