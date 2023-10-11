import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_navigator_observer.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/physical_activities_bloc.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/home/application/home_bottom_navigation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/barcode_scanner_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

final autoRouteObserver = AutoRouteObserver();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<PhysicalFitnessBloc>(
          create: (_) => getIt<PhysicalFitnessBloc>(),
        ),
        BlocProvider<MedicalFitnessBloc>(
          create: (_) => getIt<MedicalFitnessBloc>(),
        ),
        BlocProvider<OnboardingBloc>(
          create: (_) => getIt<OnboardingBloc>(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (_) => getIt<AuthenticationCubit>(),
        ),
        BlocProvider<LegalStatementBloc>(
          create: (_) => getIt<LegalStatementBloc>(),
        ),
        BlocProvider<ConsentConfirmationBloc>(
          create: (_) => getIt<ConsentConfirmationBloc>(),
        ),
        BlocProvider<YouAndFoodBloc>(
          create: (_) => getIt<YouAndFoodBloc>(),
        ),
        BlocProvider<DiabetesBloc>(
          create: (_) => getIt<DiabetesBloc>(),
        ),
        BlocProvider<NutritionInstructionsBloc>(
          create: (_) => getIt<NutritionInstructionsBloc>(),
        ),
        BlocProvider<SelectFoodBloc>(
          create: (_) => getIt<SelectFoodBloc>(),
        ),
        BlocProvider<FoodItemServingsBloc>(
          create: (_) => getIt<FoodItemServingsBloc>(),
        ),
        BlocProvider<BarcodeScannerBloc>(
          create: (_) => getIt<BarcodeScannerBloc>(),
        ),
        BlocProvider<RecipeBloc>(
          create: (_) => getIt<RecipeBloc>(),
        ),
        BlocProvider<MealsBloc>(
          create: (_) => getIt<MealsBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => getIt<SearchBloc>(),
        ),
        BlocProvider<DashboardWeightBloc>(
          create: (_) => getIt<DashboardWeightBloc>(),
        ),
        BlocProvider<RecipeDetailsBloc>(
          create: (_) => getIt<RecipeDetailsBloc>(),
        ),
        BlocProvider<DishBloc>(
          create: (_) => getIt<DishBloc>(),
        ),
        BlocProvider<EditDishBloc>(
          create: (_) => getIt<EditDishBloc>(),
        ),
        BlocProvider<EducationProgramBloc>(
          create: (_) => getIt<EducationProgramBloc>(),
        ),
        BlocProvider<EducationLessonBloc>(
          create: (_) => getIt<EducationLessonBloc>(),
        ),
        BlocProvider<DashboardEducationBloc>(
          create: (_) => getIt<DashboardEducationBloc>(),
        ),
        BlocProvider<PhysicalProgramsBloc>(
          create: (_) => getIt<PhysicalProgramsBloc>(),
        ),
        BlocProvider<PhysicalActivitiesBloc>(
          create: (_) => getIt<PhysicalActivitiesBloc>(),
        ),
        BlocProvider<VideoPlayerBloc>(
          create: (_) => getIt<VideoPlayerBloc>(),
        ),
        BlocProvider<HomeBottomNavigationBloc>(
          create: (_) => getIt<HomeBottomNavigationBloc>(),
        ),
        BlocProvider<ProgramsInProgressBloc>(
          create: (_) => getIt<ProgramsInProgressBloc>(),
        ),
        BlocProvider<GroupPreferencesBloc>(
          create: (_) => getIt<GroupPreferencesBloc>(),
        ),
        BlocProvider<MentalHealthBloc>(
          create: (_) => getIt<MentalHealthBloc>(),
        ),
        BlocProvider<TopicsBloc>(
          create: (_) => getIt<TopicsBloc>(),
        ),
        BlocProvider<SessionCallBloc>(
          create: (_) => getIt<SessionCallBloc>(),
        ),
        BlocProvider<PhysicalActivitiesPreferencesBloc>(
          create: (_) => getIt<PhysicalActivitiesPreferencesBloc>(),
        ),
        BlocProvider<ReportAbuseBloc>(
          create: (_) => getIt<ReportAbuseBloc>(),
        ),
        BlocProvider<AnalyticsBloc>(
          create: (_) => getIt<AnalyticsBloc>(),
        ),
      ],
      child: const _App(),
    );
  }
}

class _App extends StatefulWidget {
  const _App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  late final AppRouter _appRouter;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final SocketService _socketService = SocketService();
  static final FirebaseAnalyticsObserver _analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthenticationCubit>();
    final onboardingBloc = context.read<OnboardingBloc>();
    final legalStatementBloc = context.read<LegalStatementBloc>();
    final consentConfirmationBloc = context.read<ConsentConfirmationBloc>();
    final mentalHealthBloc = context.read<MentalHealthBloc>();

    _socketService.startListen();

    _appRouter = AppRouter(
      proxyGuard: ProxyGuard(authBloc),
      introGuard: IntroGuard(
        authBloc,
        onboardingBloc,
        consentConfirmationBloc,
        legalStatementBloc,
        mentalHealthBloc,
      ),
      genderPrefsGuard: GenderPrefsGuard(authBloc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Loop care',
      theme: appThemeData,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [
          FirebaseNavigatorObserver(analytics: analytics),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
