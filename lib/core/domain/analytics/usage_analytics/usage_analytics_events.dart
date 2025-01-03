class UsageAnalyticsEvents {
  const UsageAnalyticsEvents._();

  // Authentication
  static const String auth = 'authentication';
  static const String bringAppToFront = 'bring_app_to_front';
  static const String appPaused = 'app_paused';
  static const String logout = 'logout';

  // Onboarding
  static const String onboardingBasicsIntro = 'onboarding_basics_intro';
  static const String onboardingBirthday = 'onboarding_birthday';
  static const String onboardingAgeExclusion = 'onboarding_age_exclusion';
  static const String onboardingGender = 'onboarding_gender';
  static const String onboardingSex = 'onboarding_sex';
  static const String onboardingBiological = 'onboarding_biological';
  static const String onboardingHappiness = 'onboarding_happiness';
  static const String onboardingHeight = 'onboarding_height';
  static const String onboardingHeightValidation = 'onboarding_height_validation';
  static const String onboardingWeight = 'onboarding_weight';
  static const String onboardingBmiExclusion = 'onboarding_bmi_exclusion';
  static const String onboardingBasicsCompleted = 'onboarding_basics_completed';
  static const String onboardingMedicalIntro = 'onboarding_medical_intro';
  static const String onboardingPregnancy = 'onboarding_pregnancy';
  static const String onboardingPregnancyExclusion = 'onboarding_pregnancy_exclusion';
  static const String onboardingMedicine = 'onboarding_medicine';
  static const String onboardingSemaglutide = 'onboarding_semaglutide';
  static const String onboardingTakingPeriod = 'onboarding_taking_period';
  static const String onboardingTreatmentPeriod = 'onboarding_treatment_period';
  static const String onboardingSemaglutideExplanation = 'onboarding_semaglutide_explanation';
  static const String onboardingSecondaryForm = 'onboarding_secondary_form';
  static const String onboardingThyroidDisease = 'onboarding_thyroid_disease';
  static const String onboardingMetabolicDisease = 'onboarding_metabolic_disease';
  static const String onboardingHypertension = 'onboarding_hypertension';
  static const String onboardingCardiovascularDisease = 'onboarding_cardiovascular_disease';
  static const String onboardingStomachReduction = 'onboarding_stomach_reduction';
  static const String onboardingDiabetes = 'onboarding_diabetes';
  static const String onboardingRenalFailure = 'onboarding_renal_failure';
  static const String onboardingAsthma = 'onboarding_asthma';
  static const String onboardingLiverDisease = 'onboarding_liver_disease';
  static const String onboardingApnea = 'onboarding_apnea';
  static const String onboardingLocomotor = 'onboarding_locomotor';
  static const String onboardingPsychiatrist = 'onboarding_psychiatrist';
  static const String onboardingMedicalCompletedDisease = 'onboarding_medical_completed_disease';
  static const String onboardingMedicalCompleted = 'onboarding_medical_completed';
  static const String onboardingMentalIntro = 'onboarding_mental_intro';
  static const String onboardingTestAnswer = 'onboarding_test_answer';
  static const String onboardingInterimResult = 'onboarding_interim_result';
  static const String onboardingFinalResult = 'onboarding_final_result';
  static const String onboardingFinalResultExclusion = 'onboarding_final_result_exclusion';
  static const String onboardingLegalStatement = 'onboarding_legal_statement';
  static const String onboardingRegisterIntro = 'onboarding_register_intro';
  static const String onboardingTermsAndConditionsPrivacyPolicyAccept =
      'onboarding_terms_and_conditions_privacy_policy_accepted';
  static const String onboardingPasswordCreated = 'onboarding_password_created';
  static const String onboardingNewUser = 'onboarding_new_user';
  static const String onboardingNewUserCreated = 'onboarding_new_user_created';
  static const String onboardingEmailConfirmed = 'onboarding_email_confirmed';
  static const String onboardingNewUserVerified = 'onboarding_new_user_verified';
  static const String onboardingEmailChanged = 'onboarding_email_changed';

  //Subscription
  static const String subscriptionPage = 'subscription_page';
  static const String subscriptionPageV2 = 'subscription_page_v2';
  static const String subscriptionSelected = 'subscription_selected';
  static const String subscriptionBought = 'subscription_bought';

  //Weight
  static const String weightWidget = 'weight_widget_opened';
  static const String weightLogged = 'weight_logged';

  //Mood
  static const String moodWidget = 'mood_widget_opened';
  static const String moodLogged = 'mood_logged';

  //Education
  static const String lessonOpened = 'lesson_opened';
  static const String lessonCompleted = 'lesson_completed';
  static const String educationArticleOpen = 'open_article_direct';

  // Profile
  static const String profilePage = 'account_settings_page';

  // Mind
  static const String mindCompletedExercise = 'mind_completed_exercise';
  static const String mindRepeatedExercise = 'mind_repeated_exercise';

  // Smart goals
  static const String goalNutritionSelected = 'goal_nutrition_selected';
  static const String goalNutritionCompleted = 'goal_nutrition_completed';
  static const String goalNutritionLogged = 'goal_nutrition_logged';
  static const String goalNutritionDeleted = 'goal_nutrition_deleted';

  // Nutrition
  static const String foodItemLogged = 'food_item_logged';
  static const String mealLogged = 'meal_logged';

  // Reflection
  static const String reflectionOpened = 'reflection_opened';
  static const String reflectionCompleted = 'reflection_completed';
}
