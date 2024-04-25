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
  final List<SmartGoal> _selectedGoals = [];

  void _onAddGoalHandler(BuildContext context) => context
    ..read<SmartGoalsBloc>().add(SmartGoalsEvent.addGoals(goals: _selectedGoals))
    ..router.popUntilRouteWithName(SetWeeklyGoalsRoute.name);

  void _onGoalSelectHandler(SmartGoal goal, bool isSelected) {
    final otherCategoriesGoalsLength = context.read<SmartGoalsBloc>().state.data.selectedGoals.length;
    if (!isSelected && _selectedGoals.length + otherCategoriesGoalsLength >= 2) return;

    isSelected ? _selectedGoals.remove(goal) : _selectedGoals.add(goal);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(
        title: LocalizedTexts.addGoal.tr(),
        leading: CustomFilledIconButton.leadingGreenLighter(),
      ),
      body: CustomSafeArea(
        child: BottomPlacedButton.greenLightest(
          body: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28.0),
                CustomText.bitter600(
                  LocalizedTexts.selectGoalsTitle.tr(args: [widget.category.name]),
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 26.0),
                Expanded(
                  child: GoalsList(
                    categoryId: widget.category.id,
                    onGoalSelect: _onGoalSelectHandler,
                    selectedGoals: _selectedGoals,
                  ),
                ),
              ],
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.addGoal.tr(),
            onPressed: _selectedGoals.isNotEmpty ? () => _onAddGoalHandler(context) : null,
          ),
        ),
      ),
    );
  }
}
