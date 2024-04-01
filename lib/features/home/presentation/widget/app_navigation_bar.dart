import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/application/chat_watcher_bloc/chat_watcher_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class AppNavigationBar extends StatelessWidget {
  final TabsRouter tabsRouter;
  final ValueNotifier<bool> isChatEnable;

  const AppNavigationBar({super.key, required this.tabsRouter, required this.isChatEnable});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isChatEnable,
        builder: (context, enable, _) {
          return BottomNavigationBar(
            onTap: (index) => _navigateTo(context, index, enable),
            items: _getNavBarItems(context, enable),
            currentIndex: getEffectiveTabIndex(enable),
          );
        });
  }

  List<BottomNavigationBarItem> _getNavBarItems(BuildContext context, bool enable) {
    return bottomTabs(enableChat: enable)
        .map((e) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BlocBuilder<ChatWatcherBloc, ChatWatcherState>(
                  buildWhen: (context, state) => e.isGroupChat,
                  builder: (context, state) {
                    if (state.data.amount > 0 && e.value == DashboardNavbarItems.chat.value) {
                      return badge.Badge(
                        badgeStyle: const badge.BadgeStyle(
                          badgeColor: AppColors.red,
                        ),
                        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
                        position: badge.BadgePosition.topEnd(
                          top: -11,
                        ),
                        badgeContent: Text(state.data.amount.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: ThemeConstants.fontSize10,
                            )),
                        child: e.icon,
                      );
                    } else {
                      return e.icon;
                    }
                  },
                ),
              ),
              activeIcon: e.activeIcon,
              label: e.label(context.watch<AuthenticationBloc>().state.data.accountName),
            ))
        .toList();
  }

  void _navigateTo(BuildContext context, int index, bool enable) {
    int tabIndex = index;
    if (!enable) {
      switch (index) {
        case 2:
          tabIndex = 3;
          break;
        default:
          tabIndex = index;
      }
    }
    _syncChatState(enable, tabIndex, context);
    context.tabsRouter.setActiveIndex(tabIndex);
  }

  void _syncChatState(bool enable, int tabIndex, BuildContext context) {
    if (enable && tabIndex == 2) {
      final messages = context.read<GroupChatBloc>().state.data.messages;
      if (messages.isNotEmpty) {
        context.read<GroupChatBloc>().add(GroupChatEvent.setReadPointer(fromMessageId: messages.first.id!));
      }
    }
  }

  int getEffectiveTabIndex(bool enable) {
    final activeIndex = tabsRouter.activeIndex;
    if (!enable) {
      switch (activeIndex) {
        case 3:
          return 2;
        default:
          return activeIndex;
      }
    } else {
      return activeIndex;
    }
  }
}
