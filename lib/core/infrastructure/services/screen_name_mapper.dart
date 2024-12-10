// Firebase analytics screens names mapper, added comment means that screen added to confluence doc with the screenshot
final _screenNames = {
  'ProxyRoute': 'Proxy Screen', // added
  'IntroRoute': 'Intro Screen', // added
  'HomeRoute': 'Calendar Screen', // added
  'DashboardRoute': 'Calendar Screen', // added
  'EducationRoute': 'Education Screen', // added
  'AccountRoute': 'User profile Screen', // added
  'JoinUsRoute': 'Onboarding Intro Screen', // added
  'LoginRoute': 'Login Screen', // added
  'ForgotPasswordRoute': 'Forgot Password Screen', // added
  'NameRoute': 'Onboarding Name Screen', // added
  'SuccessVerifiedEmailRoute': 'Success Verified Email Screen', // added
  'PhysicalIntroRoute': 'Basics Intro Screen', // added
  'LegalStatementRoute': 'Onboarding Legal Statement Screen', // added
  'SignUpWelcomeRoute': 'Register Intro Screen', // added
  'PasswordRoute': 'Register Password Screen', // added
  'EmailAddressRoute': 'Onboarding Email Screen', // added
  'WaitingForConfirmationRoute': 'Register Confirm Email Screen', // added
  'ChangeEmailAddressRoute': 'Register Change Email Screen', // added
  'BarcodeScannerRoute': 'Barcode Scanner Screen', // added
  'NutritionInstructionsRoute': 'Nutrition Instructions Screen', // added
  'SelectFoodRoute': 'Select Food Screen', // added
  'SelectServingRoute': 'Select Serving Screen', // added
  'SearchRoute': 'Search Screen', // added
  'RecipeRoute': 'Recipe Screen', // added
  'MealRoute': 'Meal Screen', // added
  'LogPlannedMealsRoute': 'Log Planned Meals Screen',
  'LogWeightRoute': 'Today\'s weight Screen', // added
  'RecipeDetailsRoute': 'Recipe Details Screen', // added
  'ChooseDateCalendarRoute': 'Plan Meal Choose Date Screen', // added
  'WeekPlannerRoute': 'Week Planner  Screen', // added
  'RecommendationsRoute': 'Recommendations Screen',
  'LessonRoute': 'Lesson Screen', // added
  'LessonCompleteRoute': 'Lesson Complete Screen', // added
  'DishDetailsRoute': 'Dish Details Screen', // added
  'EditDishRoute': 'Edit Dish Screen', // added
  'SelectExerciseRoute': 'Select Exercise Screen', // added
  'DailyIntakeRoute': 'Daily Intake Screen',
  'NutritionIntakeRoute': 'Nutrition Intake Screen',
  'ProgramAssessmentRoute': 'Program Assessment Screen', // added
  'PhysicalProgramsRoute': 'Physical Programs Screen', // added
  'ProgramDetailsRoute': 'Program Details Screen', // added
  'FoodPreferencesRoute': 'Food Preferences Screen', // added
  'LessonCompleteFoodPreferencesRoute': 'Lesson Complete Food Preferences Screen', // added
  'PhysicalPreferencesRoute': 'Physical Preferences Screen', // added
  'EditFoodPreferencesRoute': ' Edit Food Preferences Screen', // added
  'JoinGroupPreferencesRoute': 'Join Group Preferences Screen', // added
  'GenderPreferencesRoute': 'User Gender Preferences Screen', // added
  'NicknamePreferencesRoute': 'Nickname Preferences Screen', // added
  'VideoRoute': 'Video Screen', // added
  'GroupPreferencesRoute': 'Group Preferences Screen', // added
  'TimezonePreferencesRoute': 'Timezone Preferences Screen', // added
  'GroupRulesOneRoute': 'Group Rules One Screen', // added
  'GroupRulesTwoRoute': 'Group Rules Two Screen', // added
  'GroupRulesThreeRoute': 'Group Rules Three Screen', // added
  'GroupRulesFourRoute': 'Group Rules Four Screen', // added
  'GroupRulesFiveRoute': 'Group Rules Five Screen', // added
  'GroupRulesSixRoute': 'Group Rules Six Screen', // added
  'SupportGroupIntroRoute': 'Support Group Intro Screen',
  'SessionWaitingRoomRoute': 'Group Session Waiting Room Screen',
  'SessionCallRoute': 'Group Session Call Screen',
  'SessionRulesRoute': 'Group Session Rules Screen',
  'PreparationMaterialsRoute': 'Group Session Preparation Materials Screen',
  'PhysicalActivitiesPreferencesRoute': 'Physical Activities Preferences Screen',
  'PhysicalActivitiesFrequencyRoute': 'Physical Activities Frequency Screen',
  'PhysicalActivitiesActivityTypeRoute': 'Physical Activities Activity Type Screen',
  'PhysicalActivitiesCompleteRoute': 'Physical Activities Complete Screen',
  'CreateMoodRoute': 'Create Mood Screen',
  'MoodOptionRoute': 'Mood Option Screen',
  'QuizzesIntroRoute': 'Quiz Intro Screen',
  'QuizzesQuestionsRoute': 'Quiz Question Screen',
  'AssignmentsIntroRoute': 'Assignment Intro Screen',
  'AssignmentsQuestionsRoute': 'Assignment Question Screen',
  'MyAssignmentsRoute': 'My Assignments Screen',
  'AssignmentsSavedRoute': 'Assignments Saved Screen',
  'GroupChatRoute': 'Group Chat Screen', // added
  'GroupUsersRoute': 'Group Users Screen', // added
  'SubscriptionRoute': 'Subscription Screen',
  'ManageSubscriptionRoute': 'Manage Subscription Screen',
  'BuddyIntroRoute': 'Buddy Intro Screen',
  'BuddyDescriptionRoute': 'Buddy Description Screen',
  'BuddyPreferencesRoute': 'Buddy Preferences Screen',
  'BuddyLiveTogetherRoute': 'Buddy Live Together Screen',
  'BuddyRelationRoute': 'Buddy Relation Screen',
  'BuddyEmailRoute': 'Buddy Email Screen',
  'BuddyCompletedRoute': 'Buddy Completed Screen',
  'TechniquesRoute': 'Mind Techniques List Screen', // added
  'TechniqueExercisesRoute': 'Mind Technique Exercises List Screen', // added
  'IntroExerciseRoute': 'Mind Intro Screen', // added
  'ExplanationTechniqueRoute': 'Mind Technique Explanation Screen', // added
  'ExplanationRoute': 'Mind Explanation Screen', // added
  'ExerciseRoute': 'Mind Technique Exercise Screen', // added
};

String? getScreenName(String? value) =>
    value == null ? null : _screenNames[value] ?? value.replaceLast('Route', 'Screen').setSpaces();

extension _ScreenNameStringExtension on String {
  String setSpaces() => splitMapJoin(RegExp(r'[A-Z]'), onMatch: (s) => ' ${s[0]}').trim();

  String replaceLast(String from, String to) =>
      replaceFirstMapped(from, (match) => to, length - from.length);
}
