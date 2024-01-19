import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

class MealCategoryChips extends StatefulWidget {
  final List<MealCategory> categories;
  final MealCategory selectedChips;
  final Function onItemPressHandler;

  const MealCategoryChips({
    super.key,
    required this.categories,
    required this.selectedChips,
    required this.onItemPressHandler,
  });

  @override
  State<MealCategoryChips> createState() => _MealCategoryChipsState();
}

class _MealCategoryChipsState extends State<MealCategoryChips> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.categories.length,
      animationDuration: Duration.zero,
      initialIndex: widget.selectedChips.index,
    )..addListener(_onTabsChanged);
  }

  void _onTabsChanged() => widget.onItemPressHandler(widget.categories[_tabController.index]);

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onTabsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabBar.blue(
      tabs: widget.categories.map((e) => Tab(text: e.name)).toList(),
      tabController: _tabController,
    );
  }
}
