import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/types_of_food/widgets/types_of_food_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class TypesOfFoodPage extends StatelessWidget {
  const TypesOfFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YouAndFoodQuestion(
      question: RichText(
        text: TextSpan(
          text: '${LocalizedTexts.whichTypesOfFoodDoYou.tr()} ',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          children: [
            TextSpan(
              text: LocalizedTexts.not.tr().toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            TextSpan(
              text: ' ${LocalizedTexts.eatOrDrink.tr()}',
            ),
          ],
        ),
      ),
      questionList: const TypesOfFoodChips(),
    );
  }
}
