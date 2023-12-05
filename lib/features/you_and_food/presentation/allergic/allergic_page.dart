import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/allergic/widgets/allergic_chips.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_question.dart';

class AllergicPage extends StatelessWidget {
  const AllergicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return YouAndFoodQuestion(
      subtitle: '2 ${LocalizedTexts.of.tr()} 3',
      question: Text(
        LocalizedTexts.allergicQuestion.tr(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      questionList: const AllergicChips(),
      onNextPressed: () => _onNextPressed(context),
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.doNotLike);
  }
}
