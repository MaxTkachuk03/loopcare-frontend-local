import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';

enum BuddyQuestions {
  liveTogether,
  relation,
  email,
  completed,
}

extension BuddyQuestionsX on BuddyQuestions {
  PageRouteInfo get route {
    switch (this) {
      case BuddyQuestions.liveTogether:
        return const BuddyLiveTogetherRoute();
      case BuddyQuestions.relation:
        return const BuddyRelationRoute();
      case BuddyQuestions.email:
        return const BuddyEmailRoute();
      case BuddyQuestions.completed:
        return const BuddyCompletedRoute();
    }
  }

  int get percentage {
    final valuesWithExclude = BuddyQuestions.values.where((element) => element != BuddyQuestions.completed);

    final value = (index * 100) / valuesWithExclude.length;

    return value.toInt();
  }

  BuddyQuestions getPreviousQuestion() {
    if (index == 0) {
      return this;
    }

    return BuddyQuestions.values[index - 1];
  }

  BuddyQuestions getNextQuestion() {
    if (index == BuddyQuestions.values.length - 1) {
      return this;
    }

    return BuddyQuestions.values[index + 1];
  }
}
