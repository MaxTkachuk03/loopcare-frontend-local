import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_value_tab.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_tabs/nutrition_value_tab_type.dart';

class NutritionTabs extends StatefulWidget {
  final int initialIndex;
  final List<Widget> tabBarViewChildren;

  const NutritionTabs({
    super.key,
    required this.tabBarViewChildren,
    required this.initialIndex,
  });

  @override
  State<NutritionTabs> createState() => _NutritionTabsState();
}

class _NutritionTabsState extends State<NutritionTabs> with TickerProviderStateMixin {
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
    )..addListener(_onTabsChanged);
  }

  void _onTabsChanged() {
    final tab = tabs[_tabController.index].type.name.toLowerCase();
    AnalyticsEventService.instance.logEvent('nutrition_values_screen_$tab');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onTabsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenLightest,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CustomTabBar.green(
            onTap: () => {},
            tabController: _tabController,
            tabs: tabs.map((e) => Tab(text: e.text)).toList(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: TabBarView(
          controller: _tabController,
          children: widget.tabBarViewChildren,
        ),
      ),
    );
  }
}
