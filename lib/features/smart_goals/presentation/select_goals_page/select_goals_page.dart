import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_page/widgets/goals_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../../../core/presentation/themes/themes.dart';

@RoutePage()
class SelectGoalsPage extends StatefulWidget {
  final SmartGoalCategory category;
  final String stream;

  const SelectGoalsPage({super.key, required this.category, required this.stream});

  @override
  State<SelectGoalsPage> createState() => _SelectGoalsPageState();
}

class _SelectGoalsPageState extends State<SelectGoalsPage> {
  SmartGoal? _selectedGoal;

  @override
  void initState() {
    super.initState();
  }

  void _onSetGoalHandler(BuildContext context) => context
    ..read<SmartGoalsBloc>().add(SmartGoalsEvent.setGoal(_selectedGoal!))
    ..router.popUntilRouteWithName(HomeRoute.name);

  void _onGoalSelectHandler(SmartGoal goal, bool isSelected) => setState(() {
        _selectedGoal = goal;
      });

  @override
  Widget build(BuildContext context) {
    final streamStyles = {
      'psychology': {
        'scaffoldColor': AppColors.petrolLightest,
        'appBarColor': AppColors.petrolRegular,
        'leadingIcon': CustomFilledIconButton.leadingPetrolLighter(),
        'button': BottomPlacedButton.petrolLightest,
      },
      'nutrition': {
        'scaffoldColor': AppColors.greenLightest,
        'appBarColor': AppColors.greenRegular,
        'leadingIcon': CustomFilledIconButton.leadingGreenLighter(),
        'button': BottomPlacedButton.greenLightest,
      },
      'physicalActivity': {
        'scaffoldColor': AppColors.yellowLightest,
        'appBarColor': AppColors.yellowRegular,
        'leadingIcon': CustomFilledIconButton.leadingYellowLighter(),
        'button': BottomPlacedButton.yellowLightest,
      },
      'community': {
        'scaffoldColor': AppColors.orangeLightest,
        'appBarColor': AppColors.orangeRegular,
        'leadingIcon': CustomFilledIconButton.leadingOrangeLighter(),
        'button': BottomPlacedButton.orangeLightest,
      },
      'medical': {
        'scaffoldColor': AppColors.coralLightest,
        'appBarColor': AppColors.coralRegular,
        'leadingIcon': CustomFilledIconButton.leadingCoralLighter(),
        'button': BottomPlacedButton.coralLightest,
      },
    };

    final currentStyle = streamStyles[widget.stream] ??
        {
          'scaffoldColor': AppColors.petrolLightest,
          'appBarColor': AppColors.petrolRegular,
          'leadingIcon': CustomFilledIconButton.leadingPetrolLighter(),
          'button': BottomPlacedButton.petrolLightest,
        };

    return CustomScaffold(
      color: currentStyle['scaffoldColor'] as Color,
      appBar: CustomAppBar(
        backgroundColor: currentStyle['appBarColor'] as Color,
        title: widget.category.name,
        leading: currentStyle['leadingIcon'] as Widget,
      ),
      body: CustomSafeArea(
        child: (currentStyle['button'] as Function({
          required Widget body,
          required Widget button,
        }))(
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  left: 20.0,
                  right: 20.0,
                ),
                sliver: SliverToBoxAdapter(
                  child: CustomText.bitter600(
                    LocalizedTexts.smartGoalsSelectGoalsTitle.tr(),
                    style: context.textTheme.displayMedium,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                  bottom: 32.0,
                  left: 20.0,
                  right: 20.0,
                ),
                sliver: SliverToBoxAdapter(
                  child: CustomText.w400(
                    LocalizedTexts.smartGoalsSelectGoalsSubtitle.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
              GoalsList(
                stream: widget.stream,
                categoryId: widget.category.id,
                onGoalSelect: _onGoalSelectHandler,
                selectedGoal: _selectedGoal,
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
          button: BlocConsumer<SmartGoalsBloc, SmartGoalsState>(
            listener: _onSetGoalsListener,
            listenWhen: (prev, cur) =>
                cur is SmartGoalsStateErrorSaveGoals || cur is SmartGoalsStateWeeklySessionSaved,
            builder: (BuildContext context, SmartGoalsState state) {
              return CustomElevatedButton.blueFullWidth(
                label: LocalizedTexts.smartGoalsSetGoal.tr(),
                onPressed: _selectedGoal != null ? () => _onSetGoalHandler(context) : null,
              );
            },
          ),
        ),
      ),
    );
  }

  void _onSetGoalsListener(BuildContext context, SmartGoalsState state) {
    state.mapOrNull(
      errorSaveGoals: (s) => _onErrorSaveWeeklyGoals(context, s),
      weeklySessionSaved: (s) => _onSetWeeklyGoals(context, s),
    );
  }

  void _onErrorSaveWeeklyGoals(BuildContext context, SmartGoalsState state) =>
      context.showError(content: CustomText.w400(state.data.errorKey.tr()));

  void _onSetWeeklyGoals(BuildContext context, SmartGoalsState state) => context
    ..showSuccessBar(
        content: CustomText.w400(LocalizedTexts.smartGoalsSaveWeeklyGoalsSuccessMessage.tr()))
    ..router.maybePop();
}
