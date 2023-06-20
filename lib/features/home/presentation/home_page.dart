import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/account_page.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/dashboard_page.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/education_page.dart';
import 'package:loopcare_frontend/features/home/presentation/tabs_state.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashboardNavbarItems _selectedNavigationItem = DashboardNavbarItems.today;
  Color _appBarColor = AppColors.blueMid;

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

  void onNavigationPressed(int index) {
    // TODO do navigation
    final item = DashboardNavbarItems.values[index];

    setState(() {
      _appBarColor = item.appBarColor;
      _selectedNavigationItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: _appBarColor,
        ),
        body: TabsState(
          selectedNavigationItem: _selectedNavigationItem,
          onNavigationPressed: onNavigationPressed,
          child: IndexedStack(
            sizing: StackFit.expand,
            index: _selectedNavigationItem.index,
            children: const <Widget>[
              DashboardPage(),
              EducationPage(),
              AccountPage(),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (BuildContext context, state) {
            return BottomNavigation(
              onItemPress: onNavigationPressed,
              items: _getNavBarItems(state.name).values.toList(),
              selectedItem: _selectedNavigationItem,
            );
          },
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
