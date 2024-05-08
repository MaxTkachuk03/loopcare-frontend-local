import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/app_navigation_bar.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';
import 'package:loopcare_frontend/injection.dart';

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
    isChatEnable.value = getIt<SharedStorageService>().account?.isUserGrouped ?? false;
  }

  @override
  void dispose() {
    isChatEnable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _logoutListener,
      buildWhen: (context, state) => isChatEnable.value != state.data.isUserGrouped,
      builder: (context, state) {
        _chatEnable(state);
        return AutoTabsScaffold(
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
            isChatEnable: isChatEnable,
          ),
        );
      },
    );
  }

  void _chatEnable(AuthenticationState state) => isChatEnable.value = state.data.isUserGrouped;

  void _logoutListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
        context.router.replaceAll([const IntroRoute()]);
      },
    );
  }
}
