import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UnderlinedTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final TabAlignment tabAlignment;

  const UnderlinedTabBar({
    super.key,
    required this.tabs,
    required this.tabAlignment,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      labelPadding: const EdgeInsets.only(left: 8, right: 8),
      labelColor: AppColors.white,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      unselectedLabelColor: AppColors.white,
      indicatorColor: AppColors.blueMid,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: tabAlignment,
      automaticIndicatorColorAdjustment: false,
      indicator: const UnderlineTabIndicator(borderSide: BorderSide(width: 2.0, color: AppColors.white)),
      tabs: tabs,
    );
  }
}
