import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_categories_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_actegory_page/widgets/goal_category_card.dart';

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

    context.read<SmartGoalsCategoriesBloc>().add(const SmartGoalsCategoriesEvent.getCategories());
  }

  void _onErrorRetryHandler() {
    context.read<SmartGoalsCategoriesBloc>().add(const SmartGoalsCategoriesEvent.getCategories());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth / 2 - 5;

        return BlocBuilder<SmartGoalsCategoriesBloc, SmartGoalsCategoriesState>(
          builder: (context, state) {
            return state.maybeMap(
              goalsCategoriesLoading: (_) => const Loader(),
              goalsCategoriesError: (s) => ErrorScreen(
                error: s.data.error!,
                onButtonPressed: _onErrorRetryHandler,
              ),
              orElse: () {
                // TODO calc isNew prop when new backend will be available
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: state.data.goalsCategories
                      .map(
                        (c) => SizedBox(
                          width: width,
                          child: GoalCategoryCard(onPressed: widget.onPressed, category: c, isNew: true),
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
