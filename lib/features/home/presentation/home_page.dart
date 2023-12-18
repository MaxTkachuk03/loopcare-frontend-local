import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: AutoTabsScaffold(
        animationDuration: Duration.zero,
        routes: const [
          DashboardRoute(),
          EducationRoute(),
          AccountRoute(),
        ],
        appBarBuilder: (_, tabsRouter) => AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 0.0,
          backgroundColor: DashboardNavbarItems.getColorByIndex(tabsRouter.activeIndex),
        ),
        bottomNavigationBuilder: (_, tabsRouter) => BottomNavigationBar(
          onTap: tabsRouter.setActiveIndex,
          items: _getNavBarItems(context),
          currentIndex: tabsRouter.activeIndex,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems(BuildContext context) {
    final userName = context.read<AuthenticationCubit>().state.name;

    return DashboardNavbarItems.values
        .map((e) => BottomNavigationBarItem(
              icon: e.icon,
              activeIcon: e.activeIcon,
              label: e.label(userName),
            ))
        .toList();
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
