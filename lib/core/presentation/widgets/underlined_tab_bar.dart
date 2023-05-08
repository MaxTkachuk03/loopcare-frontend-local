import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UnderlinedTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;

  const UnderlinedTabBar({
    Key? key,
    required this.tabs,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: AppColors.white.withOpacity(0.3),
          ),
        ),
      ),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        labelColor: AppColors.white,
        labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w600,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
        unselectedLabelColor: AppColors.white,
        indicatorColor: AppColors.blueMid,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: AppColors.white)),
        tabs: tabs,
      ),
    );
  }
}
