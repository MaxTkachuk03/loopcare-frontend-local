import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_underlined_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

const _padding = 10.0;

class SliverRecipeAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverRecipeAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height + _padding;

  @override
  double get maxExtent => _tabBar.preferredSize.height + _padding;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.greenRegular,
      height: maxExtent,
      alignment: Alignment.centerLeft,
      child: MainContainer(
        child: SizedBox(
          height: 35,
          child: CustomUnderlinedTabBar(
            tabs: _tabBar.tabs,
            labelColor: AppColors.blueDarker,
            unselectedLabelColor: AppColors.blueDarker,
            tabController: _tabBar.controller,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverRecipeAppBarDelegate oldDelegate) {
    return false;
  }
}
