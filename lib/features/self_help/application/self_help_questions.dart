part of 'self_help_bloc.dart';

enum SelfHelpQuestions {
  genderPrefer,
  result,
}

extension SelfHelpQuestionsX on SelfHelpQuestions {
  PageRouteInfo get route {
    switch (this) {
      case SelfHelpQuestions.genderPrefer:
        return const HeightRoute();

      case SelfHelpQuestions.result:
        return const PhysicalCheckResultRoute();
    }
  }

  int get percentage {
    final valuesWithExclude = SelfHelpQuestions.values
        .where((element) => element != SelfHelpQuestions.result);

    final value = (index * 100) / valuesWithExclude.length;

    return value.toInt();
  }

  SelfHelpQuestions getNextQuestion() {
    if (index == SelfHelpQuestions.values.length - 1) {
      return this;
    }

    return SelfHelpQuestions.values[index + 1];
  }

  SelfHelpQuestions getPreviousQuestion() {
    if (index == 0) {
      return this;
    }

    return SelfHelpQuestions.values[index - 1];
  }
}
