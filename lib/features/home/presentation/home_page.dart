import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/app_navigation_bar.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> isChatEnable = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    isChatEnable.value = context.read<AuthenticationCubit>().state.isUserGrouped;
    debugPrint('devcpp initState isUserGrouped: ${isChatEnable.value}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: _logoutListener,
        buildWhen: (context, state) => isChatEnable.value != state.isUserGrouped,
        builder: (context, state) {
          _chatEnable(state);
          return MaterialApp(
            theme: appThemeData.copyWith(
                bottomNavigationBarTheme:
                    appThemeData.bottomNavigationBarTheme.copyWith(backgroundColor: AppColors.blueDarker)),
            home: AutoTabsScaffold(
              animationDuration: Duration.zero,
              routes: const [
                DashboardRoute(),
                EducationRoute(),
                GroupChatRoute(),
                AccountRoute(),
              ],
              appBarBuilder: (_, tabsRouter) => AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                toolbarHeight: 0.0,
                backgroundColor: DashboardNavbarItems.getColorByIndex(tabsRouter.activeIndex),
              ),
              bottomNavigationBuilder: (_, tabsRouter) => AppNavigationBar(
                tabsRouter: tabsRouter,
                userName: state.name,
                isChatEnable: isChatEnable,
              ),
            ),
          );
        });
  }

  void _chatEnable(AuthenticationState state) {
    debugPrint('devcpp _chatEnable: ${state.isUserGrouped}');
    //Todo change impl

    isChatEnable.value = state.isUserGrouped;
  }

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
