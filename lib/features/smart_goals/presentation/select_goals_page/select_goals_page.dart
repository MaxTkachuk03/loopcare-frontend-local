import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_page/widgets/goals_list.dart';

class SelectGoalsPage extends StatefulWidget {
  final SmartGoalCategory category;

  const SelectGoalsPage({super.key, required this.category});

  @override
  State<SelectGoalsPage> createState() => _SelectGoalsPageState();
}

class _SelectGoalsPageState extends State<SelectGoalsPage> {
  List<SmartGoal> _selectedGoals = [];

  @override
  void initState() {
    super.initState();
    _selectedGoals = [...context.read<SmartGoalsBloc>().state.data.selectedGoals];
  }

  void _onAddGoalHandler(BuildContext context) => context
    ..read<SmartGoalsBloc>().add(SmartGoalsEvent.addGoals(goals: _selectedGoals))
    ..router.popUntilRouteWithName(SetWeeklyGoalsRoute.name);

  void _onGoalSelectHandler(SmartGoal goal, bool isSelected) {
    if (!isSelected && _selectedGoals.length >= 2) return;

    if (isSelected) {
      _selectedGoals.remove(goal);
      if (context.read<SmartGoalsBloc>().state.data.selectedGoals.contains(goal)) {
        context.read<SmartGoalsBloc>().add(SmartGoalsEvent.removeGoal(goal: goal));
      }
    } else {
      _selectedGoals.add(goal);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.calorieDensity.tr().capitalizeEachWordFirstLetter(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: BottomPlacedButton.greenLightest(
          body: MainContainer(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 24.0),
                  sliver: SliverToBoxAdapter(
                    child: CustomText.bitter600(
                      LocalizedTexts.selectGoalsTitle.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  sliver: SliverToBoxAdapter(
                    child: CustomText.w400(
                      LocalizedTexts.selectGoalsSubtitle.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
                GoalsList(
                  categoryId: widget.category.id,
                  onGoalSelect: _onGoalSelectHandler,
                  selectedGoals: _selectedGoals,
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
              ],
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.setGoal.tr(),
            onPressed: _selectedGoals.isNotEmpty ? () => _onAddGoalHandler(context) : null,
          ),
        ),
      ),
    );
  }
}
