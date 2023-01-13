part of 'physical_fitness_bloc.dart';

enum PhysicalFitnessQuestions {
  height,
  birthday,
  weight,
  sex,
  result,
}

extension PhysicalFitnessQuestionsX on PhysicalFitnessQuestions {
  String? get route {
    switch (this) {
      case PhysicalFitnessQuestions.height:
        return AppRoutes.height;
      case PhysicalFitnessQuestions.birthday:
        return AppRoutes.birthday;
      case PhysicalFitnessQuestions.weight:
        return AppRoutes.weight;
      case PhysicalFitnessQuestions.sex:
        return AppRoutes.sex;
      case PhysicalFitnessQuestions.result:
        return AppRoutes.physicalCheckResult;
      default:
        return null;
    }
  }

  int get percentage {
    final valuesWithExclude = PhysicalFitnessQuestions.values
        .where((element) => element != PhysicalFitnessQuestions.result);

    final value = (index * 100) / valuesWithExclude.length;

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
