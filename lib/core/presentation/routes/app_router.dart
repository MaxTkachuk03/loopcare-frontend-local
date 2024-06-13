import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/unlock_feature_guard.dart';

import 'app_router.gr.dart';

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

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      path: AppRoutes.splash,
      page: SplashRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.proxy,
      page: ProxyRoute.page,
      guards: const [ProxyGuard()],
    ), // added
    AutoRoute(
      path: AppRoutes.intro,
      page: IntroRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomeRoute.page,
      children: [
        AutoRoute(path: AppRoutes.dashboard, page: DashboardRoute.page),
        AutoRoute(path: AppRoutes.education, page: EducationRoute.page),
        AutoRoute(path: AppRoutes.groupChatTab, page: GroupChatRoute.page),
        AutoRoute(path: AppRoutes.account, page: AccountRoute.page),
      ],
    ),
    AutoRoute(
      path: AppRoutes.joinUs,
      page: JoinUsRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.successVerifiedEmail,
      page: SuccessVerifiedEmailRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.login,
      page: LoginRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.forgotPassword,
      page: ForgotPasswordRoute.page,
    ), // added

    // Onboarding
    AutoRoute(
      path: AppRoutes.onboardingIntro,
      page: OnboardingQuestionsRoute.page,
    ),

    // Legal statement
    AutoRoute(
      path: AppRoutes.legalStatement,
      page: LegalStatementRoute.page,
    ), // added

    // Create account
    AutoRoute(
      path: AppRoutes.signUpWelcome,
      page: SignUpWelcomeRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.name,
      page: NameRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.password,
      page: PasswordRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.emailAddress,
      page: EmailAddressRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.waitingForConfirmation,
      page: WaitingForConfirmationRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.changeEmail,
      page: ChangeEmailAddressRoute.page,
    ), // added

    // Barcode scanner
    AutoRoute(
      path: AppRoutes.barcodeScanner,
      page: BarcodeScannerRoute.page,
    ), // added

    // Nutrition
    AutoRoute(
      path: AppRoutes.selectFood,
      page: SelectFoodRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.selectServing,
      page: SelectServingRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.search,
      page: SearchRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.recipe,
      page: RecipeRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.meal,
      page: MealRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.logWeight,
      page: LogWeightRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.recipeDetails,
      page: RecipeDetailsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.chooseDate,
      page: ChooseDateCalendarRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.recommendations,
      page: RecommendationsRoute.page,
    ), // added

    // Education
    AutoRoute(
      path: AppRoutes.lesson,
      page: LessonRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.lessonComplete,
      page: LessonCompleteRoute.page,
      guards: const [UnlockFeatureGuard()],
    ), // added

    // Dish
    AutoRoute(
      path: AppRoutes.dishDetails,
      page: DishDetailsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.editDish,
      page: EditDishRoute.page,
    ), // added

    AutoRoute(
      path: AppRoutes.selectExercise,
      page: SelectExerciseRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.dailyIntake,
      page: DailyIntakeRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.programAssessment,
      page: ProgramAssessmentRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.chooseProgram,
      page: PhysicalProgramsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.programDetails,
      page: ProgramDetailsRoute.page,
    ), // added

    // User profile
    AutoRoute(
      path: AppRoutes.foodPreferences,
      page: FoodPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.lessonCompleteFoodPreferences,
      page: LessonCompleteFoodPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalPreferences,
      page: PhysicalPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.editFoodPreferences,
      page: EditFoodPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.joinGroupPreferences,
      page: JoinGroupPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.genderPreferences,
      page: GenderPreferencesRoute.page,
      guards: const [GenderPrefsGuard()],
    ), // added
    AutoRoute(
      path: AppRoutes.nicknamePreferences,
      page: NicknamePreferencesRoute.page,
    ), // added

    // Video
    AutoRoute(
      path: AppRoutes.video,
      page: VideoRoute.page,
    ), // added

    AutoRoute(
      path: AppRoutes.groupPreferences,
      page: GroupPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.timezone,
      page: TimezonePreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesOne,
      page: GroupRulesOneRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesTwo,
      page: GroupRulesTwoRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesThree,
      page: GroupRulesThreeRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesFour,
      page: GroupRulesFourRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesFive,
      page: GroupRulesFiveRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupRulesSix,
      page: GroupRulesSixRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.supportGroupIntro,
      page: SupportGroupIntroRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.consultDoctor,
      page: ConsultDoctorRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.needPaidSubscription,
      page: NeedPaidSubscriptionRoute.page,
    ), // added

    // Zoom video sessions
    AutoRoute(
      path: AppRoutes.sessionWaitingRoom,
      page: SessionWaitingRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.sessionCall,
      page: SessionCallRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.sessionRules,
      page: SessionRulesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.preparationMaterials,
      page: PreparationMaterialsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalPreferencesIntro,
      page: PhysicalPreferencesIntroRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesFrequency,
      page: PhysicalActivitiesFrequencyRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesActivityType,
      page: PhysicalActivitiesActivityTypeRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalActivitiesComplete,
      page: PhysicalActivitiesCompleteRoute.page,
    ), // added

    // Mind
    AutoRoute(
      path: AppRoutes.mindTechniques,
      page: TechniquesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.mindExplanation,
      page: ExplanationRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.techniqueExercises,
      page: TechniqueExercisesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.techniqueExplanation,
      page: ExplanationTechniqueRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.mindExercise,
      page: ExerciseRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.mindIntroExercise,
      page: IntroExerciseRoute.page,
    ), // added

    // Mood
    AutoRoute(
      path: AppRoutes.createMood,
      page: CreateMoodRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.moodOption,
      page: MoodOptionRoute.page,
    ), // added

    // Quizzes
    AutoRoute(
      path: AppRoutes.quizzes,
      page: QuizzesIntroRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.quizesQuestions,
      page: QuizzesQuestionsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsIntro,
      page: AssignmentsIntroRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsQuestions,
      page: AssignmentsQuestionsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.myAssignments,
      page: MyAssignmentsRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.assignmentsSaved,
      page: AssignmentsSavedRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupChat,
      page: GroupChatRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.groupChatUsers,
      page: GroupUsersRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.subscription,
      page: SubscriptionRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.manageSubscription,
      page: ManageSubscriptionRoute.page,
    ), // added

    // Buddy
    AutoRoute(
      path: AppRoutes.buddyIntro,
      page: BuddyIntroRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyDescription,
      page: BuddyDescriptionRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyPreferences,
      page: BuddyPreferencesRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyLiveTogether,
      page: BuddyLiveTogetherRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyRelation,
      page: BuddyRelationRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyEmail,
      page: BuddyEmailRoute.page,
    ), // added
    AutoRoute(
      path: AppRoutes.buddyCompleted,
      page: BuddyCompletedRoute.page,
    ), // added

    // Smart goals
    AutoRoute(
      path: AppRoutes.selectGoalsCategory,
      page: SelectGoalsCategoryRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.selectGoals,
      page: SelectGoalsRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.goalsStatistics,
      page: GoalsStatisticsRoute.page,
    ),
    AutoRoute(
      path: AppRoutes.goalReview,
      page: GoalReviewRoute.page,
    ),
  ];
}
