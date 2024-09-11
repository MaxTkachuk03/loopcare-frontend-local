import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/analytics_bloc.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bloc.dart';
import 'package:loopcare_frontend/core/application/connectivity_bloc/connectivity_bloc.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/application/user_states/user_states_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/chat/application/chat_watcher_bloc/chat_watcher_bloc.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/physical_activities_bloc.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/lesson_quiz/application/quizzes_bloc.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mood/application/mood_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/barcode_scanner_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/bmr/bmr_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/choose_date/choose_date_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dashboard_weight_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/edit_dish/edit_dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe_details/recipe_details_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_food/select_food_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/report_abuse/application/report_abuse_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_categories_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_statistics_bloc.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';
import 'package:loopcare_frontend/features/video_player/application/video_player_bloc.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class AppBlocProvider {
  AppBlocProvider._();

  static List<BlocProvider> get providers => [
        BlocProvider<ConnectivityBloc>(
          create: (_) => getIt<ConnectivityBloc>()..add(const ConnectivityEvent.init()),
        ),
        BlocProvider<NavigationBarBloc>(
          create: (_) => getIt<NavigationBarBloc>(),
        ),
        BlocProvider<GeneralOnboardingBloc>(
          create: (_) => getIt<GeneralOnboardingBloc>(),
        ),
        BlocProvider<PhysicalQuestionsBloc>(
          create: (_) => getIt<PhysicalQuestionsBloc>(),
        ),
        BlocProvider<MedicalQuestionsBloc>(
          create: (_) => getIt<MedicalQuestionsBloc>(),
        ),
        BlocProvider<MentalQuestionsBloc>(
          create: (_) => getIt<MentalQuestionsBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (_) => getIt<AuthenticationBloc>(),
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
          create: (_) => getIt<EducationLessonBloc>()..add(const EducationLessonEvent.init()),
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
        BlocProvider<ProgramsInProgressBloc>(
          create: (_) => getIt<ProgramsInProgressBloc>(),
        ),
        BlocProvider<GroupPreferencesBloc>(
          create: (_) => getIt<GroupPreferencesBloc>(),
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
        BlocProvider<ChooseDateBloc>(
          create: (_) => getIt<ChooseDateBloc>(),
        ),
        BlocProvider<MindBloc>(
          create: (_) => getIt<MindBloc>(),
        ),
        BlocProvider<MoodBloc>(
          create: (_) => getIt<MoodBloc>(),
        ),
        BlocProvider<SubscriptionBloc>(
          create: (_) => getIt<SubscriptionBloc>(),
        ),
        BlocProvider<QuizzesBloc>(
          create: (_) => getIt<QuizzesBloc>(),
        ),
        BlocProvider<ReflectionsBloc>(
          create: (_) => getIt<ReflectionsBloc>(),
        ),
        BlocProvider<ChatWatcherBloc>(
          create: (_) => getIt<ChatWatcherBloc>(),
        ),
        BlocProvider<GroupChatBloc>(
          create: (_) => getIt<GroupChatBloc>(),
        ),
        BlocProvider<AppUpdateBloc>(
          create: (_) => getIt<AppUpdateBloc>(),
        ),
        BlocProvider<BuddyBloc>(
          create: (_) => getIt<BuddyBloc>(),
        ),
        BlocProvider<SmartGoalsBloc>(
          create: (_) => getIt<SmartGoalsBloc>(),
        ),
        BlocProvider<SmartGoalsCategoriesBloc>(
          create: (_) => getIt<SmartGoalsCategoriesBloc>(),
        ),
        BlocProvider<SmartGoalsStatisticsBloc>(
          create: (_) => getIt<SmartGoalsStatisticsBloc>(),
        ),
        BlocProvider<BmrBloc>(
          create: (_) => getIt<BmrBloc>(),
        ),
        BlocProvider<RiverBloc>(
          create: (_) => getIt<RiverBloc>(),
        ),
        BlocProvider<UserStatesBloc>(
          create: (_) => getIt<UserStatesBloc>(),
        ),
      ];
}
