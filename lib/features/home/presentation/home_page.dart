import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/custom_navigation_bar/custom_navigation_bar.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_items.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _logoutListener,
      child: AutoTabsScaffold(
        animationDuration: Duration.zero,
        routes: const [
          DashboardRoute(),
          RiverRoute(),
          AccountRoute(),
        ],
        appBarBuilder: (_, tabsRouter) => AppBar(
          surfaceTintColor: NavigationBarItems.getColorByIndex(tabsRouter.activeIndex),
          systemOverlayStyle: NavigationBarItems.getOverlayStyleByIndex(tabsRouter.activeIndex),
          toolbarHeight: 0.0,
          backgroundColor: NavigationBarItems.getColorByIndex(tabsRouter.activeIndex),
        ),
        bottomNavigationBuilder: (_, tabsRouter) => CustomNavigationBar(
          tabsRouter: tabsRouter,
        ),
      ),
    );
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
