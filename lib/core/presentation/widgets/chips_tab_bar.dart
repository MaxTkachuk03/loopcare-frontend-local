import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ChipsTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;
  final VoidCallback? onTap;

  const ChipsTabBar({
    super.key,
    required this.tabs,
    this.tabController,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.0,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: AppColors.yellowLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
        onTap: (_) => onTap?.call(),
        controller: tabController,
        tabs: tabs,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
      ),
    );
  }
}
