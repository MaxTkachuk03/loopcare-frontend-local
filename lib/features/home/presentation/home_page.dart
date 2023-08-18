import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/home/application/home_bottom_navigation_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<AuthenticationCubit>().getAccount();
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.fetchFoodPreferences());

    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons(LessonCategory.all));
    context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _logoutListener,
      child: BlocBuilder<HomeBottomNavigationBloc, HomeBottomNavigationState>(
        builder: (context, tabsState) {
          return AutoTabsScaffold(
            animationDuration: Duration.zero,
            routes: const [
              DashboardRoute(),
              EducationRoute(),
              AccountRoute(),
            ],
            appBarBuilder: (_, tabsRouter) => AppBar(
              toolbarHeight: 0.0,
              backgroundColor: tabsState.activeTab.appBarColor,
            ),
            bottomNavigationBuilder: (_, tabsRouter) {
              return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (BuildContext context, state) {
                  return BottomNavigationBar(
                    onTap: (int index) {
                      tabsRouter.setActiveIndex(index);
                      onNavigationPressed(index, context);
                    },
                    items: _getNavBarItems(state.name).values.toList(),
                    currentIndex: tabsState.activeTab.index,
                  );
                },
              );
            },
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
