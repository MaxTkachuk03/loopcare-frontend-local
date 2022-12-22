import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/auth_guard.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/login/presentation/login_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/height_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/weight_page.dart';

part 'app_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: AppRoutes.intro,
      page: IntroPage,
    ),
    AutoRoute(
      path: AppRoutes.joinUs,
      page: JoinUsPage,
    ),
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ),
    AutoRoute(
      initial: true,
      path: AppRoutes.height,
      page: HeightPage,
    ),
    AutoRoute(
      path: AppRoutes.weight,
      page: WeightPage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
      guards: [AuthGuard],
    ),
  ],
)
class $AppRouter {}
