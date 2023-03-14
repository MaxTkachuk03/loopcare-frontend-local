import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/do_not_like/widgets/do_not_like_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class DoNotLikePage extends StatelessWidget {
  const DoNotLikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YouAndFoodQuestion(
      subtitle: '3 ${LocalizedTexts.of.tr()} 3',
      question: RichText(
        text: TextSpan(
          text: '${LocalizedTexts.doYou.tr()} ',
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
              text: ' ${LocalizedTexts.likeAnyOfTheFollowing.tr()}',
            ),
          ],
        ),
      ),
      questionList: const DoYouLikeChips(),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.youAndFoodReady);
  }
}
