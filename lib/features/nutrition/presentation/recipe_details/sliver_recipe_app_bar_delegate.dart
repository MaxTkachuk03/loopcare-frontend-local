import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/single_underlined_tab_bar.dart';

const _padding = 28.0;

class SliverRecipeAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverRecipeAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + _padding;

  @override
  double get maxExtent => _tabBar.preferredSize.height + _padding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.darkGreen,
      child: MainContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 28,
              child: SingleUnderlinedTabBar(
                tabs: _tabBar.tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverRecipeAppBarDelegate oldDelegate) {
    return false;
  }
}
