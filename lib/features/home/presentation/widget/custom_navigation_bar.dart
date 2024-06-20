import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_items.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabsRouter tabsRouter;

  const CustomNavigationBar({super.key, required this.tabsRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        bool disableTab(NavigationBarItems tab) =>
            tab.isPractice && !state.data.isPracticeOpen ||
            tab.isProfile && !state.data.isProfileOpen;

        bool hasNotification(NavigationBarItems tab) =>
            tab.isPractice && state.data.hasPracticeNotification ||
            tab.isProfile && state.data.hasProfileNotification;

        return BottomNavigationBar(
          iconSize: 36.0,
          unselectedIconTheme: const IconThemeData(color: AppColors.blueLighter),
          selectedIconTheme: const IconThemeData(color: AppColors.blueLightest),
          onTap: state.data.isBeginningCompleted ? _navigateTo : null,
          items: bottomTabs.map((tab) => BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
              child: Builder(
                builder: (context) {
                  if (disableTab(tab)) {
                    return const SizedBox.shrink();
                  } else if (hasNotification(tab)) {
                    return badge.Badge(
                      badgeStyle: const badge.BadgeStyle(
                        badgeColor: AppColors.red,
                      ),
                      badgeAnimation: const badge.BadgeAnimation.slide(
                        toAnimate: false,
                      ),
                      position: badge.BadgePosition.topEnd(
                        top: -2,
                        end: -2
                      ),
                      child: Icon(tab.icon),
                    );
                  } else {
                    return Icon(tab.icon);
                  }
                }
              ),
            ),
            label: disableTab(tab) ? '' : tab.label,
          )).toList(),
          currentIndex: tabsRouter.activeIndex,
        );
      },
    );
  }

  void _navigateTo(int index) => tabsRouter.setActiveIndex(index);
}
