import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_tab_bar.dart';

const _padding = 16.0;

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + _padding;

  @override
  double get maxExtent => _tabBar.preferredSize.height + _padding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.orange,
      child: Column(
        children: [
          UnderlinedTabBar(
            tabs: _tabBar.tabs,
            tabController: _tabBar.controller,
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
