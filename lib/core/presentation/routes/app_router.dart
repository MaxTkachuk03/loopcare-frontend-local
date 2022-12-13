import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/auth_guard.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/login/presentation/login_page.dart';

part 'app_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      path: AppRoutes.intro,
      page: IntroPage,
    ),
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
      guards: [AuthGuard],
    ),
  ],
)
class $AppRouter {}
