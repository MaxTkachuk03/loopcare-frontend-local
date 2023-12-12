part of 'app_router.dart';

class AppRoutes {
  static const String preIntro = '/pre-intro'; //added
  static const String intro = '/intro'; // added
  static const String proxy = '/proxy'; // added
  static const String joinUs = '/join-us'; // added
  static const String login = '/login'; //added
  static const String height = '/height'; // added
  static const String weight = '/weight'; // added
  static const String birthday = '/birthday'; // added
  static const String sex = '/sex'; // added
  static const String biologicalGender = '/biological-gender'; // added
  static const String medicalIntro = '/medical-fitness-intro'; // added
  static const String pregnancy = '/pregnancy'; // added
  static const String pregnancyFailed = '/pregnancy-failed'; // added
  static const String cardiovascularDisease = '/cardiovascular-disease'; // added
  static const String cardiovascularDiseaseFailed = '/cardiovascular-disease-failed'; // added
  static const String stomachReduction = '/stomach-reduction'; // added
  static const String stomachReductionFailed = '/stomach-reduction-failed'; // added
  static const String medicalCheckPassed = '/medical-check-passed'; // added
  static const String painInChest = '/pain-in-chest'; // added
  static const String painInChestFailed = '/pain-in-chest-failed'; // added
  static const String treatmentByDoctor = '/treatment-by-doctor'; // added
  static const String treatmentByDoctorFailed = '/treatment-by-doctor-failed'; // added
  static const String weightLossMedication = '/weight-loss-medication'; // added
  static const String medicationPastPeriod = '/medication-past-period'; // added
  static const String medicationFuturePeriod = '/medication-future-period'; // added
  static const String physicalCheckResult = '/physical-check-result'; // added
  static const String consentNeeded = '/consent-needed'; // added
  static const String forgotPassword = '/forgot-password'; // added
  static const String resetPassword = '/reset-password'; // added
  static const String name = '/name'; // added
  static const String password = '/password'; // added
  static const String emailAddress = '/email-address'; // added
  static const String signUpWelcome = '/sign-up-welcome'; // added
  static const String waitingForConfirmation = '/waiting-for-confirmation'; // added
  static const String checkFailedByAge = '/failed-age'; // added
  static const String consentConfirmation = '/consent-confirmation'; // added
  static const String noConsent = '/no-consent'; // added
  static const String legalStatement = '/legal-statement'; // added
  static const String preferencesOverview = '/preferences-overview'; // added
  static const String youAndFoodIntro = '/you-and-food-intro'; // added
  static const String typesOfFood = '/types-of-food'; // added
  static const String meatPreferences = '/meat-preferences'; // added
  static const String allergic = '/allergic'; // added
  static const String youAndFoodReady = '/you-and-food-ready'; // added
  static const String doNotLike = '/do-not-like'; // added
  static const String mentalHealthIntro = '/mental-health-intro'; // added
  static const String mentalHealthQuestion = '/mental-health-question'; // added
  static const String mentalCheckResult = '/mental-check-result'; // added
  static const String preparationMaterials = '/preparation-materials'; // added

  // Self Help maybe deleted screens
  static const String householdIntro = '/household-intro';
  static const String shareMealWith = '/share-meal-with';
  static const String cooking = '/cooking';
  static const String healthierFood = '/healthier-food';
  static const String whereDoYouEat = '/where-do-you-eat';

  // Diabetes
  static const String diabetes = '/diabetes'; // added
  static const String diabetesDisclaimer = '/diabetes-disclaimer'; // added
  static const String diabetesSummary = '/diabetes-summary'; // added

  // Barcode Scanner
  static const String barcodeScanner = '/barcode-scanner'; // added

  // Nutrition
  static const String recommendations = 'recommendations'; //added
  static const String dashboard = 'dashboard'; // added
  static const String nutritionInstructions = '/nutrition-instructions'; // added
  static const String selectFood = '/select-food'; // added
  static const String selectServing = '/select-serving'; // added
  static const String search = '/search'; // added
  static const String logPlannedMeals = '/log-planned-meals'; // added
  static const String dailyIntake = '/daily-intake'; // added
  static const String recipe = '/recipe'; // added
  static const String recipeDetails = '/recipe-details'; // added
  static const String meal = '/meal'; // added
  static const String logWeight = '/log-weight'; // added
  static const String home = '/home'; // added
  static const String account = 'account'; // added
  static const String chooseDate = 'choose-date'; // added
  static const String weekPlanner = 'week-lanner'; // added

  // Dish
  static const String dishDetails = '/dish-details'; // added
  static const String editDish = '/edit-dish'; // added

  // Education
  static const String education = 'education'; // added
  static const String lesson = '/lesson/:lessonId/page/:pageIndex'; // added
  static const String supportGroupIntro = '/support-group-intro'; // added
  static const String lessonComplete = '/lesson-complete'; // added
  static const String lessonError = '/lesson-error'; // added

  // Physical activities
  static const String selectExercise = '/select-exercise'; // added
  static const String chooseProgram = '/choose-program'; // added
  static const String programAssessment = '/program-assessment'; // added
  static const String programDetails = '/program-details'; // added
  static const String physicalActivitiesPreferences = '/physical-activities-preferences'; // added
  static const String physicalActivitiesFrequency = '/physical-activities-frequency'; // added
  static const String physicalActivitiesActivityType = '/physical-activities-activity-type'; // added
  static const String physicalActivitiesComplete = '/physical-activities-complete'; // added

  // User profile
  static const String foodPreferences = '/food-preferences'; // added
  static const String editFoodPreferences = '/edit-food-preferences'; // added
  static const String joinGroupPreferences = '/join-group-preferences'; // added
  static const String genderPreferences = '/gender-preferences'; // added
  static const String nicknamePreferences = '/nickname-preferences'; // added

  // Video
  static const String video = '/video'; // added

  // Reflection
  static const String reflection = '/reflection'; // added
  static const String reflectionNutritionDetails = '/reflection-nutrition-details'; // added

  // Video session
  static const String sessionWaitingRoom = '/session-waiting-room'; // added
  static const String sessionCall = '/session-call'; // added
  static const String sessionRules = '/session-rules'; // added

  // Group preferences
  static const String groupPreferences = '/group-preferences'; // added
  static const String timezone = '/timezone_preferences_page'; // added
  static const String groupRulesOne = '/group-rules-one'; // added
  static const String groupRulesTwo = '/group-rules-two'; // added
  static const String groupRulesThree = '/group-rules-three'; // added
  static const String groupRulesFour = '/group-rules-four'; // added
  static const String groupRulesFive = '/group-rules-five'; // added
  static const String groupRulesSix = '/group-rules-six'; // added

  // Mood
  static const String createMood = '/create-mood';
  static const String moodOption = '/mood-option';

  // Quizzes & Assignments
  static const String quizzes = '/quizzes';
  static const String quizesQuestions = '/quizzes-questions';
  static const String assignmentsIntro = '/assignments-intro';
  static const String assignmentsQuestions = '/assignments-questions';
  static const String myAssignments = '/my-assignments';
  static const String assignmentsSaved = '/assignments-saved';

  AppRoutes._();
}
