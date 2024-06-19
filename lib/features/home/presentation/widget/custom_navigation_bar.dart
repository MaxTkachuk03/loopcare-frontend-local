import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/application/chat_watcher_bloc/chat_watcher_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_items.dart';
import 'package:loopcare_frontend/injection.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabsRouter tabsRouter;

  const CustomNavigationBar({super.key, required this.tabsRouter});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 36,
      unselectedIconTheme: const IconThemeData(
        color: AppColors.blueLighter,
      ),
      selectedIconTheme: const IconThemeData(
        color: AppColors.blueLightest,
      ),
      onTap: (index) => _navigateTo(context, index),
      items: _getNavBarItems(context),
      currentIndex: tabsRouter.activeIndex,
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems(BuildContext context) {
    return bottomTabs
        .map((e) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
                child: Icon(e.icon), // todo add bloc
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
              //   child: BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
              //     buildWhen: (context, state) => e.isGroupChat,
              //     builder: (context, state) {
              //       if (state.data.amount > 0 && e.value == DashboardNavbarItems.chat.value) {
              //         return badge.Badge(
              //           badgeStyle: const badge.BadgeStyle(
              //             badgeColor: AppColors.red,
              //           ),
              //           badgeAnimation: const badge.BadgeAnimation.slide(
              //             toAnimate: false,
              //           ),
              //           position: badge.BadgePosition.topEnd(
              //             top: -11,
              //           ),
              //           badgeContent: Text(
              //             state.data.amount.toString(),
              //             textAlign: TextAlign.center,
              //             style: const TextStyle(
              //               color: AppColors.white,
              //               fontWeight: FontWeight.w400,
              //               fontSize: ThemeConstants.fontSize10,
              //             ),
              //           ),
              //           child: e.icon,
              //         );
              //       } else {
              //         return e.icon;
              //       }
              //     },
              //   ),
              // ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
                child: Icon(e.icon),
              ),
              label: e.label,
            ))
        .toList();
  }

  void _navigateTo(BuildContext context, int index) {
    context.tabsRouter.setActiveIndex(index);
  }
}
