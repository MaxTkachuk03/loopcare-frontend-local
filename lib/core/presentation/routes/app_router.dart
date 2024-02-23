import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/gender_prefs_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/core/presentation/theme_components_theme/theme_components_theme.dart';
import 'package:loopcare_frontend/features/access_code/access_code_page.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/account_page.dart';
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
import 'package:loopcare_frontend/features/authentication/presentation/email_address/email_address_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/forgot_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/login_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/name/name_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/password/password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/waiting_for_confirmation/waiting_for_confirmation_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/welcome/sign_up_welcome_page.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_chat_page.dart';
import 'package:loopcare_frontend/features/chat/presentation/group_users_page.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/dashboard_page.dart';
import 'package:loopcare_frontend/features/education/presentation/consult_doctor_page.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/education_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/lesson_complete_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_page/lesson_page.dart';
import 'package:loopcare_frontend/features/education/presentation/support_group_intro/support_group_intro_page.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/preparation_materials_page.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/pre_intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/legal_statement_page.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_check_result_page.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_intro_page.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_pre_intro_page.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_question_page.dart';
import 'package:loopcare_frontend/features/mood/presentation/create_mood_page.dart';
import 'package:loopcare_frontend/features/mood/presentation/mood_option_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/barcode_scanner_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/choose_date_calendar_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/daily_intake/daily_intake_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/dish_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_planned_meals/log_planned_meals_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_weight_page/log_weight_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/meal_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/nutrition_instructions_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe/recipe_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/recipe_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recommendations/recommendations_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/search_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/select_food_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_serving_page/select_serving_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/week_planner_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/asthma/asthma_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/cardiovascular_disease/cardiovascular_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/diabetes_disease/diabetes_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/hypertension/hypertension_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/liver_disease/liver_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/locomotor_system_disease/locomotor_system_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_check_failed/medical_check_failed_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_check_passed/medical_check_passed_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_intro/medical_intro_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medication_future_period/medication_future_period_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medication_past_period/medication_past_period_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medicines/medicines_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/metabolic_disease/metabolic_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/obesity/obesity_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/pregnancy/pregnancy_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/pregnancy_failed/pregnancy_failed.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/renal_failure/renal_failure_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/sleep_apnea_syndrome/sleep_apnea_syndrome_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/stomach_reduction/stomach_reduction_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/thyroid_disease/thyroid_disease_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/treatment_by_doctor/treatment_by_doctor_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/weight_loss_medication/weight_loss_medication_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/biological_gender/biological_gender_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/birthday/birthday_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/check_failed_age/check_failed_age.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/height/height_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/physical_check_result/presentation/physical_check_result_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/sex/sex_page.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/weight/weight_page.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_intro/physical_intro_page.dart';
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
      path: AppRoutes.proxy,
      page: ProxyPage,
      guards: [ProxyGuard],
    ), // added
    AutoRoute(
      path: AppRoutes.preIntro,
      page: PreIntroPage,
      guards: [IntroGuard],
    ), // dont need to add to firebase mapper
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
    ), // added
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ), // added
    AutoRoute(
      path: AppRoutes.forgotPassword,
      page: ForgotPasswordPage,
    ), // added

    // Onboarding Physical
    AutoRoute(
      path: AppRoutes.physicalIntro,
      page: PhysicalIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.birthday,
      page: BirthdayPage,
    ), // added
    AutoRoute(
      path: AppRoutes.checkFailedByAge,
      page: CheckFailedAgePage,
    ), // added
    AutoRoute(
      path: AppRoutes.sex,
      page: SexPage,
    ), // added
    AutoRoute(
      path: AppRoutes.biologicalGender,
      page: BiologicalGenderPage,
    ), // added
    AutoRoute(
      path: AppRoutes.height,
      page: HeightPage,
    ), // added
    AutoRoute(
      path: AppRoutes.weight,
      page: WeightPage,
    ), // added
    AutoRoute(
      path: AppRoutes.physicalCheckResult,
      page: PhysicalCheckResultPage,
    ), // added

    // Onboarding Medical
    AutoRoute(
      path: AppRoutes.medicalIntro,
      page: MedicalIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.pregnancy,
      page: PregnancyPage,
    ), // added
    AutoRoute(
      path: AppRoutes.pregnancyFailed,
      page: PregnancyFailedPage,
    ), // added
    AutoRoute(
      path: AppRoutes.medicines,
      page: MedicinesPage,
    ), // added
    AutoRoute(
      path: AppRoutes.weightLossMedication,
      page: WeightLossMedicationPage,
    ), // added
    AutoRoute(
      path: AppRoutes.medicationPastPeriod,
      page: MedicationPastPeriodPage,
    ), // added
    AutoRoute(
      path: AppRoutes.medicationFuturePeriod,
      page: MedicationFuturePeriodPage,
    ), // added
    AutoRoute(
      path: AppRoutes.obesity,
      page: ObesityPage,
    ), // added
    AutoRoute(
      path: AppRoutes.thyroidDisease,
      page: ThyroidDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.metabolicDisease,
      page: MetabolicDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.hypertension,
      page: HypertensionPage,
    ), // added
    AutoRoute(
      path: AppRoutes.cardiovascularDisease,
      page: CardiovascularDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.stomachReduction,
      page: StomachReductionPage,
    ), // added
    AutoRoute(
      path: AppRoutes.diabetesDisease,
      page: DiabetesDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.renalFailure,
      page: RenalFailurePage,
    ), // added
    AutoRoute(
      path: AppRoutes.asthma,
      page: AsthmaPage,
    ), // added
    AutoRoute(
      path: AppRoutes.liverDisease,
      page: LiverDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.sleepApneaSyndrome,
      page: SleepApneaSyndromePage,
    ), // added
    AutoRoute(
      path: AppRoutes.locomotorSystemDisease,
      page: LocomotorSystemDiseasePage,
    ), // added
    AutoRoute(
      path: AppRoutes.treatmentByDoctor,
      page: TreatmentByDoctorPage,
    ), // added
    AutoRoute(
      path: AppRoutes.medicalCheckPassed,
      page: MedicalCheckPassedPage,
    ), // added
    AutoRoute(
      path: AppRoutes.medicalCheckFailed,
      page: MedicalCheckFailedPage,
    ), // added

    // Onboarding Mental
    AutoRoute(
      path: AppRoutes.mentalHealthPreIntro,
      page: MentalHealthPreIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.mentalHealthIntro,
      page: MentalHealthIntroPage,
    ), // added
    AutoRoute(
      path: AppRoutes.mentalHealthQuestion,
      page: MentalHealthQuestionPage,
    ), // added
    AutoRoute(
      path: AppRoutes.mentalCheckResult,
      page: MentalCheckResultPage,
    ), // added

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

    // Barcode scanner
    AutoRoute(
      path: AppRoutes.barcodeScanner,
      page: BarcodeScannerPage,
    ), // added

    // Nutrition
    AutoRoute(
      path: AppRoutes.nutritionInstructions,
      page: NutritionInstructionsPage,
    ), // added
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
    AutoRoute(
      path: AppRoutes.logPlannedMeals,
      page: LogPlannedMealsPage,
    ), // added
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
    AutoRoute(
      path: AppRoutes.weekPlanner,
      page: WeekPlannerPage,
    ), // added
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
  ],
)
class $AppRouter {}
