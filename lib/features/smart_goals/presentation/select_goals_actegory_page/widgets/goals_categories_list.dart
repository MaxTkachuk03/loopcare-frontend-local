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
    return BlocBuilder<SmartGoalsCategoriesBloc, SmartGoalsCategoriesState>(
      builder: (context, state) {
        return state.maybeMap(
          goalsCategoriesLoading: (_) => const Loader(),
          goalsCategoriesError: (s) => ErrorScreen(
            error: s.data.error!,
            onButtonPressed: _onErrorRetryHandler,
          ),
          orElse: () {
            // TODO isNew will be a field in the category model
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              cacheExtent: 0,
              itemCount: state.data.goalsCategories.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.data.goalsCategories[index];

                return GoalCategoryCard(
                    key: UniqueKey(), onPressed: widget.onPressed, category: item, isNew: true);
              },
            );
          },
        );
      },
    );
  }
}
