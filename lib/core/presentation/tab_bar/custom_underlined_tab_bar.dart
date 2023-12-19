import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomUnderlinedTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final TabAlignment? tabAlignment;

  const CustomUnderlinedTabBar({
    super.key,
    required this.tabs,
    this.tabController,
    this.tabAlignment = TabAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: tabs,
      isScrollable: tabAlignment != TabAlignment.fill,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: tabAlignment,
      labelStyle: TabBarTheme.of(context).labelStyle?.copyWith(color: AppColors.blueDarker),
      unselectedLabelStyle:
          TabBarTheme.of(context).unselectedLabelStyle?.copyWith(color: AppColors.blueDarker),
      dividerColor: AppColors.white.withOpacity(0.4),
      dividerHeight: ThemeConstants.tabBarDividerHeight,
      automaticIndicatorColorAdjustment: false,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColors.white),
      ),
    );
  }
}
