import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_categories_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_category_page/widgets/goal_category_card.dart';

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

  void _onUnlockCategory(SmartGoalCategory category) {
    context.read<SmartGoalsCategoriesBloc>().add(SmartGoalsCategoriesEvent.unlockCategory(id: category.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartGoalsCategoriesBloc, SmartGoalsCategoriesState>(
      builder: (context, state) {
        return state.maybeMap(
          goalsCategoriesLoading: (_) => const SliverFillRemaining(child: Loader()),
          goalsCategoriesError: (s) => SliverFillRemaining(
            child: ErrorScreen(
              error: s.data.error!,
              onButtonPressed: _onErrorRetryHandler,
            ),
          ),
          orElse: () {
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 170.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = state.data.goalsCategories[index];

                    return GoalCategoryCard(
                      key: UniqueKey(),
                      onPressed: widget.onPressed,
                      category: item,
                      onUnlocked: () => _onUnlockCategory(item) ,
                    );
                  },
                  childCount: state.data.goalsCategories.length,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
