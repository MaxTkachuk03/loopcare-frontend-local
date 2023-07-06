import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/account_page.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/dashboard_page.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/education_page.dart';
import 'package:loopcare_frontend/features/home/application/home_bottom_navigation_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: BlocBuilder<HomeBottomNavigationBloc, HomeBottomNavigationState>(
        builder: (context, tabsState) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
              backgroundColor: tabsState.activeTab.appBarColor,
            ),
            body: IndexedStack(
              sizing: StackFit.expand,
              index: tabsState.activeTab.index,
              children: const <Widget>[
                DashboardPage(),
                EducationPage(),
                AccountPage(),
              ],
            ),
            bottomNavigationBar: BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (BuildContext context, state) {
                return BottomNavigation(
                  onItemPress: (int index) => onNavigationPressed(index, context),
                  items: _getNavBarItems(state.name).values.toList(),
                  selectedItem: tabsState.activeTab,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Map<DashboardNavbarItems, BottomNavigationBarItem> _getNavBarItems(
    String userName,
  ) {
    return {
      DashboardNavbarItems.today: BottomNavigationBarItem(
        icon: AppIcons.calendar,
        activeIcon: AppIcons.calendarFull,
        label: DashboardNavbarItems.today.name.capitalize(),
      ),
      DashboardNavbarItems.education: BottomNavigationBarItem(
        icon: AppIcons.book,
        activeIcon: AppIcons.bookFull,
        label: DashboardNavbarItems.education.name.capitalize(),
      ),
      DashboardNavbarItems.account: BottomNavigationBarItem(
        icon: AppIcons.account,
        activeIcon: AppIcons.accountFull,
        label: userName.capitalize(),
      ),
    };
  }

  void onNavigationPressed(int index, BuildContext context) {
    final item = DashboardNavbarItems.values[index];
    context.read<HomeBottomNavigationBloc>().add(HomeBottomNavigationEvent.tabChanged(item));
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
