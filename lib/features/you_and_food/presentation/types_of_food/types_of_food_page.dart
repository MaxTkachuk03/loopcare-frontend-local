import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/types_of_food/widgets/types_of_food_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class TypesOfFoodPage extends StatelessWidget {
  const TypesOfFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return YouAndFoodQuestion(
      subtitle: '1 ${LocalizedTexts.of.tr()} 3',
      question: RichText(
        text: TextSpan(
          text: '${LocalizedTexts.whichTypesOfFoodDoYou.tr()} ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          children: [
            TextSpan(
              text: LocalizedTexts.not.tr().toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
      onNextPressed: () => _onNextPressed(context),
    );
  }

  _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.allergic);

    // decided to hide periods screen

    // final youAndFoodState = context.read<YouAndFoodBloc>().state;
    // if (youAndFoodState.userDoesNotEatFish &&
    //     youAndFoodState.userDoesNotEatMeat) {
    //   context.router.pushNamed(AppRoutes.allergic);
    // } else {
    //   context.router.pushNamed(AppRoutes.meatPreferences);
    // }
  }
}
