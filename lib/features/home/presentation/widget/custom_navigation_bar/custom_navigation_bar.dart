import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/custom_navigation_bar/animated_bottom_bar.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_items.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabsRouter tabsRouter;

  const CustomNavigationBar({super.key, required this.tabsRouter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        final items = [
          if (state.data.isPracticeOpen) NavigationBarItems.practice,
          NavigationBarItems.river,
          if (state.data.isProfileOpen) NavigationBarItems.account,
        ];

        final notifications = [
          if (state.data.hasPracticeNotification) NavigationBarItems.practice,
          if (state.data.hasProfileNotification) NavigationBarItems.account,
        ];

        return CustomBottomNavigationBar(
          items: items,
          selectedItem: context.tabsRouter.activeIndex,
          badges: notifications,
          onTap: (index) => _navigateTo(context, index),
        );
      },
    );
  }

  void _navigateTo(BuildContext context, int index) {
    final isSamePage = tabsRouter.activeIndex == index;
    tabsRouter.setActiveIndex(index);

    if (isSamePage) return;

    if (index == 0) {
      context.read<NavigationBarBloc>().add(const NavigationBarEvent.removePractiseNotification());
    } else if (index == 2 && !context.read<AuthenticationBloc>().state.data.showBuddyNews) {
      context.read<NavigationBarBloc>().add(const NavigationBarEvent.removeProfileNotification());
    } else if (index == 1) {
      context.read<RiverBloc>().add(const RiverEvent.getActualModule());
    }
  }
}
