import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UnderlinedTabBar extends StatelessWidget {
  final List<Widget> tabs;

  const UnderlinedTabBar({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      padding: const EdgeInsets.all(0),
      indicatorPadding: const EdgeInsets.only(right: 16),
      labelPadding: const EdgeInsets.only(right: 16),
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
    );
  }
}
