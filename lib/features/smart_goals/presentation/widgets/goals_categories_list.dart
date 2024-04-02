import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

class GoalsCategoriesList extends StatefulWidget {
  final void Function(SmartGoalCategory value) onPressed;

  const GoalsCategoriesList({super.key, required this.onPressed});

  @override
  State<GoalsCategoriesList> createState() => _GoalsCategoriesListState();
}

class _GoalsCategoriesListState extends State<GoalsCategoriesList> {
  @override
  void initState() {
    super.initState();

    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getGoalsCategories());
  }

  void _onErrorRetryHandler() {
    context.read<SmartGoalsBloc>().add(const SmartGoalsEvent.getGoalsCategories());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth / 2 - 5;

        return BlocBuilder<SmartGoalsBloc, SmartGoalsState>(
          builder: (context, state) {
            return state.maybeMap(
              goalsCategoriesLoading: (_) => const Loader(),
              goalsCategoriesError: (s) => ErrorScreen(
                error: s.data.error!,
                onButtonPressed: _onErrorRetryHandler,
              ),
              orElse: () {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: state.data.goalsCategories
                      .map(
                        (e) => SizedBox(
                          width: width,
                          child: CustomChoiceChip.emoji(
                            label: e.name,
                            avatar: Text(e.image),
                            selected: false,
                            value: e,
                            onSelected: e.isUnlocked ? widget.onPressed : null,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
