import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ChipsTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? tabController;

  const ChipsTabBar({
    Key? key,
    required this.tabs,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.0,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: AppColors.yellowLight,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TabBar(
        controller: tabController,
        tabs: tabs,
      ),
    );
  }
}
