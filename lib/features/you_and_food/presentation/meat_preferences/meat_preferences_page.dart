import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/meat_preferences/widgets/meat_preferences_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class MeatPreferencesPage extends StatelessWidget {
  const MeatPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YouAndFoodQuestion(
      question: RichText(
        text: TextSpan(
            text: LocalizedTexts.meatPreferencesQuestion.tr(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
      ),
      questionList: const MeatPreferencesChips(),
    );
  }
}
