import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/routes/proxy_guard.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/account_page.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/account/presentation/food_preferences_page/food_preferences_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/email_address_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/forgot_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/login_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/name/name_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/password/password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/waiting_for_confirmation/waiting_for_confirmation_page.dart';
import 'package:loopcare_frontend/features/consent_confirmation/presentation/consent_confirmation_page.dart';
import 'package:loopcare_frontend/features/consent_confirmation/presentation/no_consent_page.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/dashboard_page.dart';
import 'package:loopcare_frontend/features/diabetes/presentation/diabetes/diabetes_page.dart';
import 'package:loopcare_frontend/features/diabetes/presentation/disclaimer/disclaimer_page.dart';
import 'package:loopcare_frontend/features/diabetes/presentation/summary/summary_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/lesson_complete_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_error_page/lesson_error_page.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_page/lesson_page.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/cooking/cooking_page.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/healthier_food/healthier_food_page.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/household_and_habits_intro/household_and_habits_intro_page.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/share_meal_with/share_meal_with_page.dart';
import 'package:loopcare_frontend/features/household_and_habits/presentation/where_do_you_eat/where_do_you_eat_page.dart';
import 'package:loopcare_frontend/features/intro/presentation/intro_page.dart';
import 'package:loopcare_frontend/features/join_us/presentation/join_us_page.dart';
import 'package:loopcare_frontend/features/legal_statement/presentation/legal_statement_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/cardiovascular_disease/presentation/cardiovascular_disease_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/cardiovascular_disease_failed/presentation/cardiovascular_disease_failed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/consent_needed/consent_needed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_check_passed/presentation/medical_check_passed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_intro/medical_intro_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medication_future_period/medication_future_period_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medication_past_period/medication_past_period_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pain_in_chest/presentation/pain_in_chest_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pain_in_chest_failled/presentation/pain_in_chest_failled_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pregnancy_failed/presentation/pregnancy_failed.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/pregnancy/pregnancy_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/stomach_reduction/stomach_reduction_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/stomach_reduction_failed/presentation/stomach_reduction_failed_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/treatment_by_doctor/presentation/treatment_by_doctor_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/treatment_by_doctor_failled/presentation/treatment_by_doctor_failled_page.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/weight_loss_medication/weight_loss_medication_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/edit_dish/edit_dish_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/search_page.dart';
import 'package:loopcare_frontend/features/home/presentation/home_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dish_details_page/dish_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/log_weight_page/log_weight_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe_details/recipe_details_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/meal_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/recipe/recipe_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/barcode_scanner/widgets/barcode_scanner_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/select_food_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/nutrition_instructions_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/program_assessment_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/physical_programs_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_details/program_details_page.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/select_exercise_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/biological_gender/biological_gender_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/birthday_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_failed_age/check_failed_age.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/height/height_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_check_result/presentation/physical_check_result_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/sex/sex_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/weight_page.dart';
import 'package:loopcare_frontend/features/authentication/presentation/welcome/sign_up_welcome_page.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/preferences_overview_page.dart';
import 'package:loopcare_frontend/features/proxy/proxy_page.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_serving_page/select_serving_page.dart';
import 'package:loopcare_frontend/features/reflection/presentation/nutrition_details_page.dart';
import 'package:loopcare_frontend/features/reflection/presentation/reflection_page.dart';
import 'package:loopcare_frontend/features/self_help/presentation/gender_preferences/self_help_gender_preferences_page.dart';
import 'package:loopcare_frontend/features/self_help/presentation/intro/self_help_intro_page.dart';
import 'package:loopcare_frontend/features/self_help/presentation/ready/self_help_ready_page.dart';
import 'package:loopcare_frontend/features/video_player/presentation/video_page.dart';
import 'package:loopcare_frontend/features/video_session/presentation/video_session_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/allergic/allergic_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/do_not_like/do_not_like_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/meat_preferences/meat_preferences_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/types_of_food/types_of_food_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_intro/you_and_food_intro_page.dart';
import 'package:loopcare_frontend/features/you_and_food/presentation/you_and_food_ready/you_and_food_ready_page.dart';

part 'app_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      initial: true,
      path: AppRoutes.proxy,
      page: ProxyPage,
      guards: [ProxyGuard],
    ),
    AutoRoute(
      path: AppRoutes.intro,
      page: IntroPage,
      guards: [IntroGuard],
    ),
    AutoRoute(
      path: AppRoutes.joinUs,
      page: JoinUsPage,
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
      path: AppRoutes.pregnancyFailed,
      page: PregnancyFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.cardiovascularDisease,
      page: CardiovascularDiseasePage,
    ),
    AutoRoute(
      path: AppRoutes.cardiovascularDiseaseFailed,
      page: CardiovascularDiseaseFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.stomachReduction,
      page: StomachReductionPage,
    ),
    AutoRoute(
      path: AppRoutes.stomachReductionFailed,
      page: StomachReductionFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.medicalCheckPassed,
      page: MedicalCheckPassedPage,
    ),
    AutoRoute(
      path: AppRoutes.painInChest,
      page: PainInChestPage,
    ),
    AutoRoute(
      path: AppRoutes.painInChestFailed,
      page: PainInChestFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.treatmentByDoctor,
      page: TreatmentByDoctorPage,
    ),
    AutoRoute(
      path: AppRoutes.treatmentByDoctorFailed,
      page: TreatmentByDoctorFailedPage,
    ),
    AutoRoute(
      path: AppRoutes.weightLossMedication,
      page: WeightLossMedicationPage,
    ),
    AutoRoute(
      path: AppRoutes.medicationPastPeriod,
      page: MedicationPastPeriodPage,
    ),
    AutoRoute(
      path: AppRoutes.medicationFuturePeriod,
      page: MedicationFuturePeriodPage,
    ),
    AutoRoute(
      path: AppRoutes.physicalCheckResult,
      page: PhysicalCheckResultPage,
    ),
    AutoRoute(
      path: AppRoutes.consentNeeded,
      page: ConsentNeededPage,
    ),
    AutoRoute(
      path: AppRoutes.login,
      page: LoginPage,
    ),
    AutoRoute(
      path: AppRoutes.forgotPassword,
      page: ForgotPasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.resetPassword,
      page: ResetPasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.signUpWelcome,
      page: SignUpWelcomePage,
    ),
    AutoRoute(
      path: AppRoutes.name,
      page: NamePage,
    ),
    AutoRoute(
      path: AppRoutes.password,
      page: PasswordPage,
    ),
    AutoRoute(
      path: AppRoutes.emailAddress,
      page: EmailAddressPage,
    ),
    AutoRoute(
      path: AppRoutes.waitingForConfirmation,
      page: WaitingForConfirmationPage,
    ),
    AutoRoute(
      path: AppRoutes.checkFailedByAge,
      page: CheckFailedAgePage,
    ),
    AutoRoute(
      path: AppRoutes.consentConfirmation,
      page: ConsentConfirmationPage,
    ),
    AutoRoute(
      path: AppRoutes.noConsent,
      page: NoConsentPage,
    ),
    AutoRoute(
      path: AppRoutes.legalStatement,
      page: LegalStatementPage,
    ),
    AutoRoute(
      path: AppRoutes.preferencesOverview,
      page: PreferencesOverviewPage,
    ),
    AutoRoute(
      path: AppRoutes.youAndFoodIntro,
      page: YouAndFoodIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.typesOfFood,
      page: TypesOfFoodPage,
    ),
    AutoRoute(
      path: AppRoutes.meatPreferences,
      page: MeatPreferencesPage,
    ),
    AutoRoute(
      path: AppRoutes.allergic,
      page: AllergicPage,
    ),
    AutoRoute(
      path: AppRoutes.youAndFoodReady,
      page: YouAndFoodReadyPage,
    ),
    AutoRoute(
      path: AppRoutes.doNotLike,
      page: DoNotLikePage,
    ),
    AutoRoute(
      path: AppRoutes.selfHelpIntro,
      page: SelfHelpIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.selfHelpGenderPreferences,
      page: SelfHelpGenderPreferencesPage,
    ),
    AutoRoute(
      path: AppRoutes.selfHelpReady,
      page: SelfHelpReadyPage,
    ),
    AutoRoute(
      path: AppRoutes.householdIntro,
      page: HouseholdAndHabitsIntroPage,
    ),
    AutoRoute(
      path: AppRoutes.shareMealWith,
      page: ShareMealPage,
    ),
    AutoRoute(
      path: AppRoutes.cooking,
      page: CookingPage,
    ),
    AutoRoute(
      path: AppRoutes.healthierFood,
      page: HealthierFoodPage,
    ),
    AutoRoute(
      path: AppRoutes.whereDoYouEat,
      page: WhereDoYouEatPage,
    ),
    //Diabetes
    AutoRoute(
      path: AppRoutes.diabetes,
      page: DiabetesPage,
    ),
    AutoRoute(
      path: AppRoutes.diabetesDisclaimer,
      page: DisclaimerPage,
    ),
    AutoRoute(
      path: AppRoutes.diabetesSummary,
      page: SummaryPage,
    ),
    AutoRoute(
      path: AppRoutes.barcodeScanner,
      page: BarcodeScannerPage,
    ),
    //Nutrition
    AutoRoute(
      path: AppRoutes.nutritionDashboard,
      page: DashboardPage,
    ),
    AutoRoute(
      path: AppRoutes.nutritionInstructions,
      page: NutritionInstructionsPage,
    ),
    AutoRoute(
      path: AppRoutes.selectFood,
      page: SelectFoodPage,
    ),
    AutoRoute(
      path: AppRoutes.selectServing,
      page: SelectServingPage,
    ),
    AutoRoute(
      path: AppRoutes.search,
      page: SearchPage,
    ),
    AutoRoute(
      path: AppRoutes.recipe,
      page: RecipePage,
    ),
    AutoRoute(
      path: AppRoutes.meal,
      page: MealPage,
    ),
    AutoRoute(
      path: AppRoutes.logWeight,
      page: LogWeightPage,
    ),
    AutoRoute(
      path: AppRoutes.home,
      page: HomePage,
    ),
    AutoRoute(
      path: AppRoutes.account,
      page: AccountPage,
    ),
    AutoRoute(
      path: AppRoutes.recipeDetails,
      page: RecipeDetailsPage,
    ),
    // Dish
    AutoRoute(
      path: AppRoutes.dishDetails,
      page: DishDetailsPage,
    ),
    AutoRoute(
      path: AppRoutes.editDish,
      page: EditDishPage,
    ),
    AutoRoute(
      path: AppRoutes.lesson,
      page: LessonPage,
    ),
    AutoRoute(
      path: AppRoutes.lessonComplete,
      page: LessonCompletePage,
    ),
    AutoRoute(
      path: AppRoutes.lessonError,
      page: LessonErrorPage,
    ),
    AutoRoute(
      path: AppRoutes.selectExercise,
      page: SelectExercisePage,
    ),
    AutoRoute(
      path: AppRoutes.programAssessment,
      page: ProgramAssessmentPage,
    ),
    AutoRoute(
      path: AppRoutes.chooseProgram,
      page: PhysicalProgramsPage,
    ),
    AutoRoute(
      path: AppRoutes.programDetails,
      page: ProgramDetailsPage,
    ),
    // User profile
    AutoRoute(
      path: AppRoutes.foodPreferences,
      page: FoodPreferencesPage,
    ),
    AutoRoute(
      path: AppRoutes.editFoodPreferences,
      page: EditFoodPreferencesPage,
    ),
    // Video
    AutoRoute(
      path: AppRoutes.video,
      page: VideoPage,
    ),
    AutoRoute(
      path: AppRoutes.reflection,
      page: ReflectionPage,
    ),
    AutoRoute(
      path: AppRoutes.reflectionNutritionDetails,
      page: NutritionDetailsPage,
    ),
    AutoRoute(
      path: AppRoutes.videoSession,
      page: VideoSessionPage,
    ),
  ],
)
class $AppRouter {}
