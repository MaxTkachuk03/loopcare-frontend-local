import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_category_page/widgets/goals_categories_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../../../core/presentation/themes/themes.dart';

@RoutePage()
class SelectGoalsCategoryPage extends StatelessWidget {
  final String stream;
  const SelectGoalsCategoryPage({super.key, required this.stream});

  void _onCategoryPressedHandler(BuildContext context, SmartGoalCategory value) =>
      context.router.push(SelectGoalsRoute(category: value, stream: stream));

  @override
  Widget build(BuildContext context) {
    final streamStyles = {
      'psychology': {
        'scaffoldColor': AppColors.petrolLightest,
        'appBarColor': AppColors.petrolRegular,
        'leadingIcon': CustomFilledIconButton.leadingPetrolLighter(),
      },
      'nutrition': {
        'scaffoldColor': AppColors.greenLightest,
        'appBarColor': AppColors.greenRegular,
        'leadingIcon': CustomFilledIconButton.leadingGreenLighter(),
      },
      'physicalActivity': {
        'scaffoldColor': AppColors.yellowLightest,
        'appBarColor': AppColors.yellowRegular,
        'leadingIcon': CustomFilledIconButton.leadingYellowLighter(),
      },
      'community': {
        'scaffoldColor': AppColors.orangeLightest,
        'appBarColor': AppColors.orangeRegular,
        'leadingIcon': CustomFilledIconButton.leadingOrangeLighter(),
      },
      'medical': {
        'scaffoldColor': AppColors.coralLightest,
        'appBarColor': AppColors.coralRegular,
        'leadingIcon': CustomFilledIconButton.leadingCoralLighter(),
      },
    };
    final currentStyle = streamStyles[stream] ??
        {
          'scaffoldColor': AppColors.petrolLightest,
          'appBarColor': AppColors.petrolRegular,
          'leadingIcon': CustomFilledIconButton.leadingPetrolLighter(),
        };
    return CustomScaffold(
      color: currentStyle['scaffoldColor'] as Color,
      appBar: CustomAppBar(
        backgroundColor: currentStyle['appBarColor'] as Color,
        title: LocalizedTexts.smartGoalsMyGoals.tr(),
        leading: currentStyle['leadingIcon'] as Widget,
      ),
      body: CustomSafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 21.0),
                child: CustomText.bitter600(
                  LocalizedTexts.smartGoalsSelectGoalsCategoryTitle.tr(),
                  style: context.textTheme.displayMedium,
                ),
              ),
            ),
            GoalsCategoriesList(
              streamValue: stream,
              onPressed: (value) => _onCategoryPressedHandler(context, value),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 30)),
          ],
        ),
      ),
    );
  }
}
