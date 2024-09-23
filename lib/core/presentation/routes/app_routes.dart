part of 'app_router.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String proxy = '/proxy'; // added
  static const String intro = '/intro'; // added
  static const String accessCode = '/access-code'; // added

  static const String login = '/login'; //added
  static const String forgotPassword = '/forgot-password';

  // Onboarding
  static const String onboardingIntro = '/onboarding-intro';
  static const String onboardingIntroMission = '/onboarding-intro-mission';
  static const String onboardingPacing = '/onboarding-intro-pacing';
  static const String onboardingQuestions = '/onboarding-questions';

  // Subscription
  static const String subscription = '/subscription';
  static const String manageSubscription = '/manage-subscription';

  // Create account
  static const String signUpWelcome = '/sign-up-welcome'; // added
  static const String name = '/name'; // added
  static const String password = '/password'; // added
  static const String emailAddress = '/email-address'; // added
  static const String waitingForConfirmation = '/waiting-for-confirmation'; // added
  static const String changeEmail = '/change-email-address'; // added
  static const String selectAvatar = '/select-avatar';

  static const String legalStatement = '/legal-statement'; // added
  static const String preparationMaterials = '/preparation-materials'; // added

  // Barcode Scanner
  static const String barcodeScanner = '/barcode-scanner'; // added

  // Home
  static const String dashboard = 'dashboard'; // added
  static const String riverOverview = '/river-overview';
  static const String river = 'river'; // added
  static const String home = '/home'; // added
  static const String account = 'account'; // added

  // Nutrition
  static const String selectFood = '/select-food'; // added
  static const String selectServing = '/select-serving'; // added
  static const String search = '/search'; // added
  static const String logPlannedMeals = '/log-planned-meals'; // added
  static const String dailyIntake = '/daily-intake'; // added
  static const String recipe = '/recipe'; // added
  static const String recipeDetails = '/recipe-details'; // added
  static const String meal = '/meal'; // added
  static const String logWeight = '/log-weight'; // added
  static const String chooseDate = '/choose-date'; // added

  // Dish
  static const String dishDetails = '/dish-details'; // added
  static const String editDish = '/edit-dish'; // added

  // Education
  static const String education = 'education'; // added
  static const String lesson = '/lesson/:lessonId'; // added
  static const String consultDoctor = '/consult-doctor'; // added
  static const String needPaidSubscription = '/need-paid-subscription'; // added
  static const String lessonComplete = '/lesson-complete'; // added
  static const String interactiveLesson = '/interactive-lesson';

  // Physical activities
  static const String selectExercise = '/select-exercise'; // added
  static const String chooseProgram = '/choose-program'; // added
  static const String programAssessment = '/program-assessment'; // added
  static const String programDetails = '/program-details'; // added
  static const String physicalPreferencesIntro = '/physical-preferences-intro'; // added
  static const String physicalActivitiesFrequency = '/physical-activities-frequency'; // added
  static const String physicalActivitiesActivityType =
      '/physical-activities-activity-type'; // added
  static const String physicalActivitiesComplete = '/physical-activities-complete'; // added

  // User profile
  static const String foodPreferences = '/food-preferences'; // added
  static const String lessonCompleteFoodPreferences = '/lesson-complete-food-preferences';

  static const String physicalPreferences = '/physical-preferences';
  static const String editFoodPreferences = '/edit-food-preferences'; // added
  static const String joinGroupPreferences = '/join-group-preferences'; // added
  static const String genderPreferences = '/gender-preferences'; // added
  static const String nicknamePreferences = '/nickname-preferences'; // added
  static const String updateEmail = '/update-email';

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
  static const String mindExplanation = '/mind-explanation';
  static const String techniqueExplanation = '/mind-technique-explanation';
  static const String techniqueExercises = '/exercises';
  static const String mindExercise = '/mind-exercise';
  static const String mindIntroExercise = '/mind-intro-exercise';

  // Mood
  static const String createMood = '/create-mood';
  static const String moodOption = '/mood-option';

  // Quizzes
  static const String quizIntro = '/quiz-intro';
  static const String quizQuestion = '/quiz-question';

  // Reflections
  static const String myReflections = '/my-reflections';
  static const String reflectionsIntro = '/reflections-intro';
  static const String reflectionQuestion = '/reflection-question';
  static const String reflectionComplete = '/reflection-complete';

  // New theme
  static const String theme = '/theme';

  // Group chat
  static const String groupChat = '/chat';
  static const String groupChatTab = 'chat';
  static const String groupChatUsers = '/chat_users';

  // Buddy
  static const String buddyIntro = '/buddy-intro';
  static const String buddyDescription = '/buddy-description';
  static const String buddyPreferences = '/buddy-preferences';
  static const String buddyLiveTogether = '/buddy-together';
  static const String buddyRelation = '/buddy-relation';
  static const String buddyEmail = '/buddy-email';
  static const String buddyCompleted = '/buddy-completed';

  // Smart goals
  static const String setWeeklyGoals = '/set-weekly-goals';
  static const String selectGoalsCategory = '/select-goals-category';
  static const String selectGoals = '/select-goals';
  static const String goalsStatistics = '/goals-statistics';
  static const String goalReview = '/goal-review';

  // Maintenance
  static const String maintenance = '/maintenance';

  AppRoutes._();
}
