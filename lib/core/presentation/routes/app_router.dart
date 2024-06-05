import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/unlock_feature_guard.dart';
import 'package:loopcare_frontend/core/presentation/theme_components_theme/theme_components_theme.dart';
import 'package:loopcare_frontend/features/access_code/access_code_page.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/account_page.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/buddy_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/presentation/buddy_completed_page.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/presentation/buddy_email_page.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/presentation/buddy_live_together_page.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/presentation/buddy_relation_page.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/lesson_complete_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/gender_preferences_page/gender_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/group_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_five_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_four_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_one_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_six_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_three_page.dart';
import 'package:loopcare_frontend/features/account/presentation/group_rules_page/group_rules_two_page.dart';
import 'package:loopcare_frontend/features/account/presentation/join_group_preferences_page/join_group_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/nickname_preferences_page/nickname_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/subscription_page/manage_subscription_page.dart';
import 'package:loopcare_frontend/features/account/presentation/timezone_preferences_page/timezone_preferences_page.dart';
import 'package:loopcare_frontend/features/assignments/presentation/assignments_intro_page.dart';
import 'package:loopcare_frontend/features/assignments/presentation/assignments_questions_page.dart';
import 'package:loopcare_frontend/features/assignments/presentation/assignments_saved_page.dart';
import 'package:loopcare_frontend/features/assignments/presentation/my_assignments_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/change_email_address_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/email_address_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/forgot_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/login_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/name/name_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/password/password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/success_verified_email/success_verified_email_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/waiting_for_confirmation/waiting_for_confirmation_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/welcome/sign_up_welcome_page.dart';
import 'package:loopcare_frontend/features/buddy/presentation/buddy_description_page.dart';
import 'package:loopcare_frontend/features/buddy/presentation/buddy_intro_page.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_page.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_users_page.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/dashboard_page.dart';
import 'package:loopcare_frontend/features/education/presentation/consult_doctor_page.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/education_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/lesson_complete_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_page/lesson_page.dart';
import 'package:loopcare_frontend/features/education/presentation/need_paid_subscription_page.dart';
import 'package:loopcare_frontend/features/education/presentation/support_group_intro/support_group_intro_page.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/preparation_materials_page.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/legal_statement_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/exercise_page/exercise_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/explanation_page/explanation_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/explanation_technique_page/explanation_technique_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/intro_exercise_page/intro_exercise_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/technique_exercises_page/technique_exercises_page.dart';
import 'package:loopcare_frontend/features/mind/presentation/techniques_page/techniques_page.dart';
import 'package:loopcare_frontend/features/mood/presentation/create_mood_page.dart';
import 'package:loopcare_frontend/features/mood/presentation/mood_option_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/barcode_scanner_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/choose_date_calendar_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/daily_intake/daily_intake_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/dish_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_weight_page/log_weight_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/meal_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe/recipe_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/recipe_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recommendations/recommendations_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/search_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/select_food_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_serving_page/select_serving_page.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/inro/onboarding_intro_our_mission_page.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/inro/onboarding_intro_page.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/inro/onboarding_pacing_page.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/onboarding_questions.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/physical_programs_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_activities_activity_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_activities_completed_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_activities_frequency_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_preferences_intro_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_preferences_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/program_assessment_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/program_details_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/select_exercise_page.dart';
import 'package:loopcare_frontend/features/proxy/proxy_page.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/quizzes_intro_page.dart';
import 'package:loopcare_frontend/features/quizzes/presentation/quizzes_questions_page.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goal_review_page/goal_review_page.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/goals_statistics_page/goals_statistics_page.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_actegory_page/select_goals_category_page.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/select_goals_page/select_goals_page.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/set_weekly_goals_page/set_weekly_goals_page.dart';
import 'package:loopcare_frontend/features/splash_screen/presentation/splash_page.dart';
import 'package:loopcare_frontend/features/subscription/presentation/subscription_page.dart';
import 'package:loopcare_frontend/features/video_player/presentation/video_page.dart';
import 'package:loopcare_frontend/features/video_session/presentation/session_call_page.dart';
import 'package:loopcare_frontend/features/video_session/presentation/session_rules_page.dart';
import 'package:loopcare_frontend/features/video_session/presentation/session_waiting_page.dart';

part 'app_routes.dart';

const groupLessonRoutes = [
  'SupportGroupIntroRoute',
  'GenderPreferencesRoute',
  'TimezonePreferencesRoute',
  'NicknamePreferencesRoute',
  'GroupRulesOneRoute',
  'GroupRulesTwoRoute',
  'GroupRulesThreeRoute',
  'GroupRulesFourRoute',
  'GroupRulesFiveRoute',
  'GroupRulesSixRoute',
];

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      path: AppRoutes.splash,
      page: SplashPage,
    ),
    AutoRoute(
      path: AppRoutes.proxy,
      page: ProxyPage,
      guards: [ProxyGuard],
    ), // added
    AutoRoute(
      path: AppRoutes.intro,
      page: IntroPage,
    ),
    AutoRoute(
      path: AppRoutes.accessCode,
      page: AccessCodePage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
      children: [
        AutoRoute(path: AppRoutes.dashboard, page: DashboardPage),
        AutoRoute(path: AppRoutes.education, page: EducationPage),
        AutoRoute(path: AppRoutes.groupChat, page: GroupChatPage),
        AutoRoute(path: AppRoutes.account, page: AccountPage),
      ],
    ),
    AutoRoute(
      path: AppRoutes.joinUs,
      page: JoinUsPage,
    ),
    AutoRoute(
      path: AppRoutes.successVerifiedEmail,
      page: SuccessVerifiedEmailPage,
    ), // added
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ), // added
    AutoRoute(
      path: AppRoutes.forgotPassword,
      page: ForgotPasswordPage,
    ), // added

    // Onboarding
    AutoRoute(
      path: AppRoutes.onboardingIntro,
      page: OnboardingIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.onboardingIntroMission,
      page: OnboardingIntroOurMissionPage,
    ),
    AutoRoute(
      path: AppRoutes.onboardingPacing,
      page: OnboardingPacingPage,
    ),
    AutoRoute(
      path: AppRoutes.onboardingQuestions,
      page: OnboardingQuestionsPage,
    ),

    // Legal statement
    AutoRoute(
      path: AppRoutes.legalStatement,
      page: LegalStatementPage,
    ), // added

    // Create account
    AutoRoute(
      path: AppRoutes.signUpWelcome,
      page: SignUpWelcomePage,
    ), // added
    AutoRoute(
      path: AppRoutes.name,
      page: NamePage,
    ), // added
    AutoRoute(
      path: AppRoutes.password,
      page: PasswordPage,
    ), // added
    AutoRoute(
      path: AppRoutes.emailAddress,
      page: EmailAddressPage,
    ), // added
    AutoRoute(
      path: AppRoutes.waitingForConfirmation,
      page: WaitingForConfirmationPage,
    ), // added
    AutoRoute(
      path: AppRoutes.changeEmail,
      page: ChangeEmailAddressPage,
    ), // added

    // Barcode scanner
    AutoRoute(
      path: AppRoutes.barcodeScanner,
      page: BarcodeScannerPage,
    ), // added

    // Nutrition
    AutoRoute(
      path: AppRoutes.selectFood,
      page: SelectFoodPage,
    ), // added
    AutoRoute(
      path: AppRoutes.selectServing,
      page: SelectServingPage,
    ), // added
    AutoRoute(
      path: AppRoutes.search,
      page: SearchPage,
    ), // added
    AutoRoute(
      path: AppRoutes.recipe,
      page: RecipePage,
    ), // added
    AutoRoute(
      path: AppRoutes.meal,
      page: MealPage,
    ), // added
    // AutoRoute(
    //   path: AppRoutes.logPlannedMeals,
    //   page: LogPlannedMealsPage,
    // ), // added
    AutoRoute(
      path: AppRoutes.logWeight,
      page: LogWeightPage,
    ), // added
    AutoRoute(
      path: AppRoutes.recipeDetails,
      page: RecipeDetailsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.chooseDate,
      page: ChooseDateCalendarPage,
    ), // added
    // AutoRoute(
    //   path: AppRoutes.weekPlanner,
    //   page: WeekPlannerPage,
    // ), // added
    AutoRoute(
      path: AppRoutes.recommendations,
      page: RecommendationsPage,
    ), // added

    // Education
    AutoRoute(
      path: AppRoutes.lesson,
      page: LessonPage,
    ), // added
    AutoRoute(
      path: AppRoutes.lessonComplete,
      page: LessonCompletePage,
      guards: [UnlockFeatureGuard],
    ), // added

    // Dish
    AutoRoute(
      path: AppRoutes.dishDetails,
      page: DishDetailsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.editDish,
      page: EditDishPage,
    ), // added

    AutoRoute(
      path: AppRoutes.selectExercise,
      page: SelectExercisePage,
    ), // added
    AutoRoute(
      path: AppRoutes.dailyIntake,
      page: DailyIntakePage,
    ), // added
    AutoRoute(
      path: AppRoutes.programAssessment,
      page: ProgramAssessmentPage,
    ), // added
    AutoRoute(
      path: AppRoutes.chooseProgram,
      page: PhysicalProgramsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.programDetails,
      page: ProgramDetailsPage,
    ), // added

    // User profile
    AutoRoute(
      path: AppRoutes.foodPreferences,
      page: FoodPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.lessonCompleteFoodPreferences,
      page: LessonCompleteFoodPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalPreferences,
      page: PhysicalPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.editFoodPreferences,
      page: EditFoodPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.joinGroupPreferences,
      page: JoinGroupPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.genderPreferences,
      page: GenderPreferencesPage,
      guards: [GenderPrefsGuard],
    ), // added
    AutoRoute(
      path: AppRoutes.nicknamePreferences,
      page: NicknamePreferencesPage,
    ), // added

    // Video
    AutoRoute(
      path: AppRoutes.video,
      page: VideoPage,
    ), // added

    AutoRoute(
      path: AppRoutes.groupPreferences,
      page: GroupPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.timezone,
      page: TimezonePreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesOne,
      page: GroupRulesOnePage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesTwo,
      page: GroupRulesTwoPage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesThree,
      page: GroupRulesThreePage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesFour,
      page: GroupRulesFourPage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesFive,
      page: GroupRulesFivePage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesSix,
      page: GroupRulesSixPage,
    ), // added
    AutoRoute(
      path: AppRoutes.supportGroupIntro,
      page: SupportGroupIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.consultDoctor,
      page: ConsultDoctorPage,
    ),
    AutoRoute(
      path: AppRoutes.needPaidSubscription,
      page: NeedPaidSubscriptionPage,
    ), // added

    // Zoom video sessions
    AutoRoute(
      path: AppRoutes.sessionWaitingRoom,
      page: SessionWaitingPage,
    ), // added
    AutoRoute(
      path: AppRoutes.sessionCall,
      page: SessionCallPage,
    ), // added
    AutoRoute(
      path: AppRoutes.sessionRules,
      page: SessionRulesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.preparationMaterials,
      page: PreparationMaterialsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalPreferencesIntro,
      page: PhysicalPreferencesIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesFrequency,
      page: PhysicalActivitiesFrequencyPage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesActivityType,
      page: PhysicalActivitiesActivityTypePage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesComplete,
      page: PhysicalActivitiesCompletePage,
    ), // added

    // Mind
    AutoRoute(
      path: AppRoutes.mindTechniques,
      page: TechniquesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.mindExplanation,
      page: ExplanationPage,
    ), // added
    AutoRoute(
      path: AppRoutes.techniqueExercises,
      page: TechniqueExercisesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.techniqueExplanation,
      page: ExplanationTechniquePage,
    ), // added
    AutoRoute(
      path: AppRoutes.mindExercise,
      page: ExercisePage,
    ), // added
    AutoRoute(
      path: AppRoutes.mindIntroExercise,
      page: IntroExercisePage,
    ), // added

    // Mood
    AutoRoute(
      path: AppRoutes.createMood,
      page: CreateMoodPage,
    ), // added
    AutoRoute(
      path: AppRoutes.moodOption,
      page: MoodOptionPage,
    ), // added

    // Quizzes
    AutoRoute(
      path: AppRoutes.quizzes,
      page: QuizzesIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.quizesQuestions,
      page: QuizzesQuestionsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsIntro,
      page: AssignmentsIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsQuestions,
      page: AssignmentsQuestionsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.myAssignments,
      page: MyAssignmentsPage,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsSaved,
      page: AssignmentsSavedPage,
    ), // added
    AutoRoute(
      path: AppRoutes.theme,
      page: ThemeComponentsPage,
    ), // dont need to add to firebase mapper
    AutoRoute(
      path: AppRoutes.groupChat,
      page: GroupChatPage,
    ), // added
    AutoRoute(
      path: AppRoutes.groupChatUsers,
      page: GroupUsersPage,
    ),
    AutoRoute(
      path: AppRoutes.subscription,
      page: SubscriptionPage,
    ),
    AutoRoute(
      path: AppRoutes.manageSubscription,
      page: ManageSubscriptionPage,
    ), // added

    // Buddy
    AutoRoute(
      path: AppRoutes.buddyIntro,
      page: BuddyIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyDescription,
      page: BuddyDescriptionPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyPreferences,
      page: BuddyPreferencesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyLiveTogether,
      page: BuddyLiveTogetherPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyRelation,
      page: BuddyRelationPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyEmail,
      page: BuddyEmailPage,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyCompleted,
      page: BuddyCompletedPage,
    ), // added

    // Smart goals
    AutoRoute(
      path: AppRoutes.setWeeklyGoals,
      page: SetWeeklyGoalsPage,
    ),
    AutoRoute(
      path: AppRoutes.selectGoalsCategory,
      page: SelectGoalsCategoryPage,
    ),
    AutoRoute(
      path: AppRoutes.selectGoals,
      page: SelectGoalsPage,
    ),
    AutoRoute(
      path: AppRoutes.goalsStatistics,
      page: GoalsStatisticsPage,
    ),
    AutoRoute(
      path: AppRoutes.goalReview,
      page: GoalReviewPage,
    ),
  ],
)
class $AppRouter {}
