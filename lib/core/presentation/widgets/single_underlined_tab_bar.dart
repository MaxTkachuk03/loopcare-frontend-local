import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SingleUnderlinedTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;

  const SingleUnderlinedTabBar({
    super.key,
    required this.tabs,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      padding: const EdgeInsets.all(0),
      labelPadding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      labelColor: AppColors.white,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      unselectedLabelColor: AppColors.white,
      indicatorColor: AppColors.blueMid,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 1.0, color: AppColors.white),
      ),
      tabs: tabs,
    );
  }
}
