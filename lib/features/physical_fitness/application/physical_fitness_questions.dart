part of 'physical_fitness_bloc.dart';

enum PhysicalFitnessQuestions {
  intro,
  birthday,
  height,
  weight,
  sex,
  result,
}

extension PhysicalFitnessQuestionsX on PhysicalFitnessQuestions {
  PageRouteInfo get route {
    switch (this) {
      case PhysicalFitnessQuestions.intro:
        return const PhysicalIntroRoute();
      case PhysicalFitnessQuestions.birthday:
        return const BirthdayRoute();
      case PhysicalFitnessQuestions.height:
        return const HeightRoute();
      case PhysicalFitnessQuestions.weight:
        return const WeightRoute();
      case PhysicalFitnessQuestions.sex:
        return const SexRoute();
      case PhysicalFitnessQuestions.result:
        return const PhysicalCheckResultRoute();
    }
  }

  int get percentage {
    final valuesWithExclude =
        PhysicalFitnessQuestions.values.where((element) => element != PhysicalFitnessQuestions.result);

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
