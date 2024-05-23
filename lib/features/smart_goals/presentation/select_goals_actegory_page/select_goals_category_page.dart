import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_actegory_page/widgets/goals_categories_list.dart';

class SelectGoalsCategoryPage extends StatelessWidget {
  const SelectGoalsCategoryPage({super.key});

  void _onCategoryPressedHandler(BuildContext context, SmartGoalCategory value) =>
      context.router.push(SelectGoalsRoute(category: value));

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.myGoals.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28.0),
                    CustomText.bitter600(
                      LocalizedTexts.selectGoalsCategoryTitle.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 28.0),
                    GoalsCategoriesList(
                      onPressed: (SmartGoalCategory value) => _onCategoryPressedHandler(context, value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
