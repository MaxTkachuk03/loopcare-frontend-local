part of 'app_router.dart';

class AppRoutes {
  static const String proxy = '/proxy'; // added
  static const String preIntro = '/pre-intro'; //added
  static const String intro = '/intro'; // added
  static const String accessCode = '/access-code'; // added
  static const String joinUs = '/join-us'; // added
  static const String successVerifiedEmail = '/success-verified-email'; // added
  static const String login = '/login'; //added
  static const String forgotPassword = '/forgot-password';

  // Onboarding Physical
  static const String onboardingIntro = '/physical-intro';
  static const String subscription = '/subscription';
  static const String manageSubscription = '/manage-subscription';
  static const String birthday = '/birthday'; // added
  static const String checkFailedByAge = '/failed-age'; // added
  static const String sex = '/sex'; // added
  static const String biologicalGender = '/biological-gender'; // added
  static const String height = '/height'; // added
  static const String weight = '/weight'; // added
  static const String physicalCheckResult = '/physical-check-result'; // added

  // Onboarding Medical
  static const String medicalIntro = '/medical-fitness-intro'; // added
  static const String pregnancy = '/pregnancy'; // added
  static const String pregnancyFailed = '/pregnancy-failed'; // added
  static const String medicines = '/medicines';
  static const String weightLossMedication = '/weight-loss-medication'; // added
  static const String medicationPastPeriod = '/medication-past-period'; // added
  static const String medicationFuturePeriod = '/medication-future-period'; // added
  static const String obesity = '/obesity';
  static const String thyroidDisease = '/thyroid-disease';
  static const String metabolicDisease = '/metabolic-disease';
  static const String hypertension = '/hypertension';
  static const String cardiovascularDisease = '/cardiovascular-disease'; // added
  static const String cardiovascularDiseaseFailed = '/cardiovascular-disease-failed'; // added
  static const String stomachReduction = '/stomach-reduction'; // added
  static const String stomachReductionFailed = '/stomach-reduction-failed'; // added
  static const String diabetesDisease = '/diabetes-disease';
  static const String renalFailure = '/renal-failure';
  static const String asthma = '/asthma';
  static const String liverDisease = '/liver-disease';
  static const String sleepApneaSyndrome = '/sleep-apnea-syndrome';
  static const String locomotorSystemDisease = '/locomotor-system-disease';
  static const String treatmentByDoctor = '/treatment-by-doctor'; // added
  static const String medicalCheckPassed = '/medical-check-passed'; // added
  static const String medicalCheckFailed = '/medical-check-failed';

  // Onboarding Mental
  static const String mentalHealthPreIntro = '/mental-health-pre-intro';
  static const String mentalHealthIntro = '/mental-health-intro'; // added
  static const String mentalHealthQuestion = '/mental-health-question'; // added
  static const String mentalCheckResult = '/mental-check-result'; // added

  // Create account
  static const String signUpWelcome = '/sign-up-welcome'; // added
  static const String name = '/name'; // added
  static const String password = '/password'; // added
  static const String emailAddress = '/email-address'; // added
  static const String waitingForConfirmation = '/waiting-for-confirmation'; // added
  static const String changeEmail = '/change-email-address'; // added

  static const String legalStatement = '/legal-statement'; // added
  static const String preparationMaterials = '/preparation-materials'; // added

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
  static const String consultDoctor = '/consult-doctor'; // added
  static const String needPaidSubscription = '/need-paid-subscription'; // added
  static const String lessonComplete = '/lesson-complete'; // added

  // Physical activities
  static const String selectExercise = '/select-exercise'; // added
  static const String chooseProgram = '/choose-program'; // added
  static const String programAssessment = '/program-assessment'; // added
  static const String programDetails = '/program-details'; // added
  static const String physicalPreferencesIntro = '/physical-preferences-intro'; // added
  static const String physicalActivitiesFrequency = '/physical-activities-frequency'; // added
  static const String physicalActivitiesActivityType = '/physical-activities-activity-type'; // added
  static const String physicalActivitiesComplete = '/physical-activities-complete'; // added

  // User profile
  static const String foodPreferences = '/food-preferences'; // added
  static const String lessonCompleteFoodPreferences = '/lesson-complete-food-preferences';

  static const String physicalPreferences = '/physical-preferences';
  static const String editFoodPreferences = '/edit-food-preferences'; // added
  static const String joinGroupPreferences = '/join-group-preferences'; // added
  static const String genderPreferences = '/gender-preferences'; // added
  static const String nicknamePreferences = '/nickname-preferences'; // added

  // Video
  static const String video = '/video'; // added

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

  // Mind
  static const String mindTechniques = '/mind-techniques';
  static const String techniqueExercises = '/exercises';

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

  // New theme
  static const String theme = '/theme';

  // Group chat
  static const String groupChat = 'chat';
  static const String groupChatUsers = '/chat_users';

  // Buddy
  static const String buddyIntro = '/buddy-intro';
  static const String buddyDescription = '/buddy-description';
  static const String buddyPreferences = '/buddy-preferences';
  static const String buddyLiveTogether = '/buddy-together';
  static const String buddyRelation = '/buddy-relation';
  static const String buddyEmail = '/buddy-email';
  static const String buddyCompleted = '/buddy-completed';

  AppRoutes._();
}
