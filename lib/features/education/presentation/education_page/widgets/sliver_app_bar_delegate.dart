import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const _padding = 16.0;

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height + _padding;

  @override
  double get maxExtent => tabBar.preferredSize.height + _padding;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      color: AppColors.petrolRegular,
      child: Column(
        children: [
          CustomUnderlinedTabBar(
            tabAlignment: TabAlignment.center,
            tabs: tabBar.tabs,
            tabController: tabBar.controller,
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
