import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';

class MealCategoryChips extends StatefulWidget {
  final MealCategory initialCategory;
  final Function(MealCategory category) onItemPressHandler;

  const MealCategoryChips({
    super.key,
    required this.onItemPressHandler,
    required this.initialCategory,
  });

  @override
  State<MealCategoryChips> createState() => _MealCategoryChipsState();
}

class _MealCategoryChipsState extends State<MealCategoryChips> with TickerProviderStateMixin {
  final _mealCategories = [MealCategory.breakfast, MealCategory.lunch, MealCategory.dinner];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: _mealCategories.length,
      animationDuration: Duration.zero,
      initialIndex: _mealCategories.indexOf(widget.initialCategory),
    )..addListener(_onTabsChanged);
  }

  void _onTabsChanged() {
    final selectedCategory = _mealCategories[_tabController.index];

    widget.onItemPressHandler(selectedCategory);
  }

  void _dishLoadedListener(BuildContext context, state) {
    if (state is DishInfo) {
      _tabController.index = _mealCategories.indexOf(state.data.currentDish!.mealCategories.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDishBloc, EditDishState>(
      listener: _dishLoadedListener,
      listenWhen: (prev, cur) => prev is Loading && cur is DishInfo,
      child: CustomTabBar.blue(
        tabs: _mealCategories.map((e) => Tab(text: e.name)).toList(),
        tabController: _tabController,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabsChanged);
    _tabController.dispose();

    super.dispose();
  }
}
