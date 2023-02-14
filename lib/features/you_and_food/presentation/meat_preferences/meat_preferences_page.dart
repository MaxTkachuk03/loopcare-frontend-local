import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/meat_preferences/widgets/meat_preferences_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class MeatPreferencesPage extends StatelessWidget {
  const MeatPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meatOrFishText = getMeatOrFishText(context);

    return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
      builder: (BuildContext context, state) {
        return YouAndFoodQuestion(
          subtitle: '2 ${LocalizedTexts.of.tr()} 4',
          question: Text(
            '${LocalizedTexts.meatPreferencesQuestion.tr()} $meatOrFishText?',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          questionList: const MeatPreferencesChips(),
          onNextPressed: state.selectedPeriod != null
              ? () => _onNextPressed(context)
              : null,
        );
      },
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.allergic);
  }

  String getMeatOrFishText(BuildContext context) {
    final youAndFoodState = context.read<YouAndFoodBloc>().state;

    String text = '${LocalizedTexts.meat.tr()} / ${LocalizedTexts.fish.tr()}';

    if (youAndFoodState.userDoesNotEatMeat) {
      text = LocalizedTexts.fish.tr();
    }

    if (youAndFoodState.userDoesNotEatFish) {
      text = LocalizedTexts.meat.tr();
    }

    return text;
  }
}
