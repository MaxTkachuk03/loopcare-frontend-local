part of 'app_router.dart';

class AppRoutes {
  static const String preIntro = '/pre-intro';
  static const String intro = '/intro';
  static const String proxy = '/proxy';
  static const String joinUs = '/join-us';
  static const String login = '/login';
  static const String height = '/height';
  static const String weight = '/weight';
  static const String birthday = '/birthday';
  static const String sex = '/sex';
  static const String biologicalGender = '/biological-gender';
  static const String medicalIntro = '/medical-fitness-intro';
  static const String pregnancy = '/pregnancy';
  static const String pregnancyFailed = '/pregnancy-failed';
  static const String cardiovascularDisease = '/cardiovascular-disease';
  static const String cardiovascularDiseaseFailed = '/cardiovascular-disease-failed';
  static const String stomachReduction = '/stomach-reduction';
  static const String stomachReductionFailed = '/stomach-reduction-failed';
  static const String medicalCheckPassed = '/medical-check-passed';
  static const String painInChest = '/pain-in-chest';
  static const String painInChestFailed = '/pain-in-chest-failed';
  static const String treatmentByDoctor = '/treatment-by-doctor';
  static const String treatmentByDoctorFailed = '/treatment-by-doctor-failed';
  static const String weightLossMedication = '/weight-loss-medication';
  static const String medicationPastPeriod = '/medication-past-period';
  static const String medicationFuturePeriod = '/medication-future-period';
  static const String physicalCheckResult = '/physical-check-result';
  static const String consentNeeded = '/consent-needed';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String name = '/name';
  static const String password = '/password';
  static const String emailAddress = '/email-address';
  static const String signUpWelcome = '/sign-up-welcome';
  static const String waitingForConfirmation = '/waiting-for-confirmation';
  static const String checkFailedByAge = '/failed-age';
  static const String consentConfirmation = '/consent-confirmation';
  static const String noConsent = '/no-consent';
  static const String legalStatement = '/legal-statement';
  static const String preferencesOverview = '/preferences-overview';
  static const String youAndFoodIntro = '/you-and-food-intro';
  static const String typesOfFood = '/types-of-food';
  static const String meatPreferences = '/meat-preferences';
  static const String allergic = '/allergic';
  static const String youAndFoodReady = '/you-and-food-ready';
  static const String doNotLike = '/do-not-like';
  static const String mentalHealthIntro = '/mental-health-intro';
  static const String mentalHealthQuestion = '/mental-health-question';
  static const String mentalCheckResult = '/mental-check-result';
  static const String preparationMaterials = '/preparation-materials';

  //Self Help
  static const String householdIntro = '/household-intro';
  static const String shareMealWith = '/share-meal-with';
  static const String cooking = '/cooking';
  static const String healthierFood = '/healthier-food';
  static const String whereDoYouEat = '/where-do-you-eat';
  // Diabetes
  static const String diabetes = '/diabetes';
  static const String diabetesDisclaimer = '/diabetes-disclaimer';
  static const String diabetesSummary = '/diabetes-summary';
  //Barcode Scanner
  static const String barcodeScanner = '/barcode-scanner';

  // Nutrition
  static const String nutritionDashboard = 'nutrition-dashboard';
  static const String nutritionInstructions = '/nutrition-instructions';
  static const String selectFood = '/select-food';
  static const String selectServing = '/select-serving';
  static const String search = '/search';
  static const String logPlannedMeals = '/log-planned-meals';
  static const String dailyIntake = '/daily-intake';

  static const String recipe = '/recipe';
  static const String recipeDetails = '/recipe-details';
  static const String meal = '/meal';
  static const String logWeight = '/log-weight';
  static const String home = '/home';
  static const String account = 'account';

  // Dish
  static const String dish = '/dish';
  static const String dishDetails = '/dish-details';
  static const String editDish = '/edit-dish';

  // Education
  static const String education = 'education';
  static const String lesson = '/lesson/:lessonId/page/:pageIndex';
  static const String educationAudioTextVersion = '/education-audio-text_version';
  static const String supportGroupIntro = '/support-group-intro';

  static const String lessonComplete = '/lesson-complete';
  static const String lessonError = '/lesson-error';

  // Physical activities
  static const String selectExercise = '/select-exercise';
  static const String chooseProgram = '/choose-program';
  static const String programAssessment = '/program-assessment';
  static const String programDetails = '/program-details';

  // User profile
  static const String foodPreferences = '/food-preferences';
  static const String editFoodPreferences = '/edit-food-preferences';
  static const String joinGroupPreferences = '/join-group-preferences';
  static const String genderPreferences = '/gender-preferences';
  static const String nicknamePreferences = '/nickname-preferences';

  // Video
  static const String video = '/video';

  // Reflection
  static const String reflection = '/reflection';
  static const String reflectionNutritionDetails = '/reflection-nutrition-details';

  // Video session
  static const String sessionWaitingRoom = '/session-waiting-room';
  static const String sessionCall = '/session-call';
  static const String sessionRules = '/session-rules';

  // group preferences
  static const String groupPreferences = '/group-preferences';
  static const String timezone = '/timezone_preferences_page';
  static const String groupRulesOne = '/group-rules-one';
  static const String groupRulesTwo = '/group-rules-two';
  static const String groupRulesThree = '/group-rules-three';
  static const String groupRulesFour = '/group-rules-four';
  static const String groupRulesFive = '/group-rules-five';
  static const String groupRulesSix = '/group-rules-six';

  AppRoutes._();
}
