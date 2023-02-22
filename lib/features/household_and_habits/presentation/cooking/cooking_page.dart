import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/cooking/widgets/cooking_chips.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/household_and_habits_question.dart';

class CookingPage extends StatelessWidget {
  const CookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HouseholdAndHabitsQuestion(
      subtitle: '2 ${LocalizedTexts.of.tr()} 6',
      question: Text(
        LocalizedTexts.cookingQuestion.tr(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      questionList: const CookingChips(),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.healthierFood);
  }
}
