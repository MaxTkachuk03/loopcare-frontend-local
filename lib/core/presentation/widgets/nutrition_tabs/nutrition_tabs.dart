import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_value_tab.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_value_tab_type.dart';

class NutritionTabs extends StatefulWidget {
  final int initialIndex;
  final List<Widget> tabBarViewChildren;

  const NutritionTabs({
    Key? key,
    required this.tabBarViewChildren,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<NutritionTabs> createState() => _NutritionTabsState();
}

class _NutritionTabsState extends State<NutritionTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<NutritionValueTab> tabs = [
    NutritionValueTab(
      text: LocalizedTexts.calorieDensity.translation,
      type: NutritionValueTabType.calorieDensity,
    ),
    NutritionValueTab(
      text: LocalizedTexts.proteinDegree.translation,
      type: NutritionValueTabType.proteinDegree,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: tabs.length,
      animationDuration: Duration.zero,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: AppColors.yellowLight,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e.text)).toList(),
          ),
        ),
        const SizedBox(height: 32.0),
        SizedBox(
          height: 700,
          child: TabBarView(
            controller: _tabController,
            children: widget.tabBarViewChildren,
          ),
        ),
      ],
    );
  }
}
