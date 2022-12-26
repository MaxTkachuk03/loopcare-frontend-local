part of 'physical_fitness_bloc.dart';

enum PhysicalFitnessQuestions {
  height,
  birthday,
  weight,
  sex,
  biologicalGender,
}

extension PhysicalFitnessQuestionsX on PhysicalFitnessQuestions {
  String? get currentRoute {
    switch (this) {
      case PhysicalFitnessQuestions.height:
        return AppRoutes.height;
      case PhysicalFitnessQuestions.weight:
        return AppRoutes.weight;
      case PhysicalFitnessQuestions.sex:
        return AppRoutes.sex;
      case PhysicalFitnessQuestions.biologicalGender:
        return AppRoutes.biologicalGender;
      default:
        return null;
    }
  }

  int get percentage {
    final value = ((index + 1) * 100) / PhysicalFitnessQuestions.values.length;

    return value.toInt();
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
