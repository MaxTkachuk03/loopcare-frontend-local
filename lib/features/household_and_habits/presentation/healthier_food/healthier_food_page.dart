import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/healthier_food/widgets/healthier_food_chips.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/household_and_habits_question.dart';

class HealthierFoodPage extends StatelessWidget {
  const HealthierFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HouseholdAndHabitsQuestion(
      subtitle: '3 ${LocalizedTexts.of.tr()} 6',
      question: Text(
        LocalizedTexts.healthierFood.tr(),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      questionList: const HealthierFoodChips(),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {

  }
}
