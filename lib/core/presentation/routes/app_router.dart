import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/auth_guard.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/login/presentation/login_page.dart';
import 'package:loopcare_frontend/features/medical/presentation/medical_intro/medical_intro_page.dart';
import 'package:loopcare_frontend/features/medical/presentation/pregnancy/pregnancy_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/biological_gender/biological_gender_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/birthday_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_passed/check_passed_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/height_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/sex/sex_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/weight_page.dart';

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
      path: AppRoutes.joinUs,
      page: JoinUsPage,
    ),
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ),
    AutoRoute(
      path: AppRoutes.height,
      page: HeightPage,
    ),
    AutoRoute(
      path: AppRoutes.weight,
      page: WeightPage,
    ),
    AutoRoute(
      path: AppRoutes.birthday,
      page: BirthdayPage,
    ),
    AutoRoute(
      path: AppRoutes.sex,
      page: SexPage,
    ),
    AutoRoute(
      path: AppRoutes.biologicalGender,
      page: BiologicalGenderPage,
    ),
    AutoRoute(
      path: AppRoutes.medicalIntro,
      page: MedicalIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.pregnancy,
      page: PregnancyPage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
      guards: [AuthGuard],
    ),
    AutoRoute(
      path: AppRoutes.physicalCheckPassed,
      page: CheckPassedPage,
    ),
  ],
)
class $AppRouter {}
