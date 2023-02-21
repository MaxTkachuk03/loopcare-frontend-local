import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/household_and_habits_question.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/share_meal_with/widgets/share_meal_with_chips.dart';

class ShareMealPage extends StatelessWidget {
  const ShareMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HouseholdAndHabitsQuestion(
      subtitle: '1 ${LocalizedTexts.of.tr()} 6',
      question: Text(
        LocalizedTexts.shareMealWithQuestion.tr(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      questionList: const ShareMealWithChips(),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {

  }
}
