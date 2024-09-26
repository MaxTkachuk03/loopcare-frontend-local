import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get interactiveLessonsScaleLabel => 'Rate on a scale';

  @override
  String get interactiveLessonsSingleSelectLabel => 'Single answer';

  @override
  String get interactiveLessonsMultipleSelectLabel => 'Choose All That Apply';

  @override
  String get interactiveLessonsCorrectFeedbackTitle => 'This is correct';

  @override
  String get interactiveLessonsIncorrectFeedbackTitle => 'This is incorrect';

  @override
  String get interactiveLessonsScaleFeedbackTitle => 'Scale selection feedback';

  @override
  String get interactiveLessonsOrderingLabel => 'Arrange in order';

  @override
  String get interactiveLessonsOrderingCheck => 'Check';

  @override
  String get interactiveLessonsOrderingShowAnswer => 'Show answer';

  @override
  String get errorValidationIosMinVersionNotANumber => 'iOS minimum version must be a number.';

  @override
  String get errorValidationIosMinVersionNotAnInteger => 'iOS minimum version must be an integer.';

  @override
  String get errorValidationIosMinVersionNotAPositiveNumber =>
      'iOS minimum version must be a positive number.';

  @override
  String get errorValidationAndroidMinVersionNotANumber =>
      'Android minimum version must be a number.';

  @override
  String get errorValidationAndroidMinVersionNotAnInteger =>
      'Android minimum version must be an integer.';

  @override
  String get errorValidationAndroidMinVersionNotAPositiveNumber =>
      'Android minimum version must be a positive number.';

  @override
  String get errorValidationTermsAndConditionsVersionNotANumber =>
      'Terms and conditions version must be a number.';

  @override
  String get errorValidationTermsAndConditionsVersionNotAnInteger =>
      'Terms and conditions version must be an integer.';

  @override
  String get errorValidationTermsAndConditionsVersionNotAPositiveNumber =>
      'Terms and conditions version must be a positive number.';

  @override
  String get errorValidationPrivacyPolicyVersionNotANumber =>
      'Privacy policy version must be a number.';

  @override
  String get errorValidationPrivacyPolicyVersionNotAnInteger =>
      'Privacy policy version must be an integer.';

  @override
  String get errorValidationPrivacyPolicyVersionNotAPositiveNumber =>
      'Privacy policy version must be a positive number.';

  @override
  String get errorValidationRefreshTokenNotAJwt => 'Refresh token must be a valid JWT.';

  @override
  String get errorValidationVersionEmpty => 'Version cannot be empty.';

  @override
  String get errorValidationVersionNotAString => 'Version must be a string.';

  @override
  String get errorValidationNotificationTypeInvalidEnum => 'Notification type is invalid.';

  @override
  String get errorValidationPurchaseTokenEmpty => 'Purchase token cannot be empty.';

  @override
  String get errorValidationPurchaseTokenNotAString => 'Purchase token must be a string.';

  @override
  String get errorValidationSubscriptionIdEmpty => 'Subscription ID cannot be empty.';

  @override
  String get errorValidationSubscriptionIdNotAString => 'Subscription ID must be a string.';

  @override
  String get errorValidationPackageNameEmpty => 'Package name cannot be empty.';

  @override
  String get errorValidationPackageNameNotAString => 'Package name must be a string.';

  @override
  String get errorValidationEventTimeMillisNotANumberString =>
      'Event time must be a valid number string.';

  @override
  String get errorValidationSubscriptionNotificationEmptyObject =>
      'Subscription notification cannot be an empty object.';

  @override
  String get errorValidationFilenameStringTooShort => 'Filename is too short.';

  @override
  String get errorValidationFilenameNotAString => 'Filename must be a string.';

  @override
  String get errorValidationFilenameEmpty => 'Filename cannot be empty.';

  @override
  String get errorValidationMimetypeInvalidEnum => 'MIME type is invalid.';

  @override
  String get errorValidationMimetypeNotAString => 'MIME type must be a string.';

  @override
  String get errorValidationMimetypeEmpty => 'MIME type cannot be empty.';

  @override
  String get errorValidationFieldnameInvalidEnum => 'Field name is invalid.';

  @override
  String get errorValidationFieldnameEmpty => 'Field name cannot be empty.';

  @override
  String get errorValidationFieldnameNotAString => 'Field name must be a string.';

  @override
  String get errorValidationPasswordPasswordTooWeak =>
      'We were unable to update your email address. Please check your credentials and try again';

  @override
  String get errorValidationPasswordEmpty => 'Password cannot be empty.';

  @override
  String get errorValidationPasswordNotAString => 'Password must be a string.';

  @override
  String get errorValidationEmailStringTooLong => 'Email is too long.';

  @override
  String get errorValidationEmailStringTooShort => 'Email is too short.';

  @override
  String get errorValidationEmailInvalidEmail => 'Email is invalid.';

  @override
  String get errorValidationEmailNotAString => 'Email must be a string.';

  @override
  String get errorValidationNameStringTooLong => 'Name is too long.';

  @override
  String get errorValidationNameStringTooShort => 'Name is too short.';

  @override
  String get errorValidationNameEmpty => 'Name cannot be empty.';

  @override
  String get errorValidationNameNotAString => 'Name must be a string.';

  @override
  String get errorValidationInvitationTokenEmpty => 'Invitation token cannot be empty.';

  @override
  String get errorValidationInvitationTokenNotAString => 'Invitation token must be a string.';

  @override
  String get errorValidationInvitationTokenNotAJwt => 'Invitation token must be a valid JWT.';

  @override
  String get errorValidationNumberOfUnitsEmpty => 'Number of units cannot be empty.';

  @override
  String get errorValidationNumberOfUnitsNotANumber => 'Number of units must be a number.';

  @override
  String get errorValidationNumberOfUnitsNotAPositiveNumber =>
      'Number of units must be a positive number.';

  @override
  String get errorValidationNumberOfUnitsNumberTooBig => 'Number of units is too big.';

  @override
  String get errorValidationNumberOfUnitsNumberTooSmall => 'Number of units is too small.';

  @override
  String get errorValidationFoodItemIdEmpty => 'Food item ID cannot be empty.';

  @override
  String get errorValidationFoodItemIdNotANumberString =>
      'Food item ID must be a valid number string.';

  @override
  String get errorValidationServingIdEmpty => 'Serving ID cannot be empty.';

  @override
  String get errorValidationServingIdNotANumberString =>
      'Serving ID must be a valid number string.';

  @override
  String get errorValidationMealCategoriesEmpty => 'Meal categories cannot be empty.';

  @override
  String get errorValidationMealCategoriesNotAnArray => 'Meal categories must be an array.';

  @override
  String get errorValidationMealCategoriesEmptyArray => 'Meal categories cannot be an empty array.';

  @override
  String get errorValidationMealCategoriesInvalidEnum =>
      'Meal categories contain an invalid value.';

  @override
  String get errorValidationNicknameEmpty => 'Nickname cannot be empty.';

  @override
  String get errorValidationNicknameNotAString => 'Nickname must be a string.';

  @override
  String get errorValidationNicknameStringTooLong => 'Nickname is too long.';

  @override
  String get errorValidationNicknameStringTooShort => 'Nickname is too short.';

  @override
  String get errorValidationGenderPreferenceEmpty => 'Gender preference cannot be empty.';

  @override
  String get errorValidationGenderPreferenceInvalidEnum => 'Gender preference is invalid.';

  @override
  String get errorValidationTimezoneEmpty => 'Timezone cannot be empty.';

  @override
  String get errorValidationTimezoneNotAString => 'Timezone must be a string.';

  @override
  String get errorValidationRulesAcceptedNotABoolean => 'Rules accepted must be a boolean.';

  @override
  String get errorValidationMealIdEmpty => 'Meal ID cannot be empty.';

  @override
  String get errorValidationMealIdNotANumber => 'Meal ID must be a number.';

  @override
  String get errorValidationMealIdNotAnInteger => 'Meal ID must be an integer.';

  @override
  String get errorValidationMealIdNotAPositiveNumber => 'Meal ID must be a positive number.';

  @override
  String get errorValidationMealRecipeIdEmpty => 'Meal recipe ID cannot be empty.';

  @override
  String get errorValidationMealRecipeIdNotANumber => 'Meal recipe ID must be a number.';

  @override
  String get errorValidationMealRecipeIdNotAnInteger => 'Meal recipe ID must be an integer.';

  @override
  String get errorValidationMealRecipeIdNotAPositiveNumber =>
      'Meal recipe ID must be a positive number.';

  @override
  String get errorValidationTypeInvalidEnum => 'Type is invalid.';

  @override
  String get errorValidationMealCategoryInvalidEnum => 'Meal category is invalid.';

  @override
  String get errorValidationStartDateNotAString => 'Start date must be a string.';

  @override
  String get errorValidationStartDateNotADateString => 'Start date must be a valid date string.';

  @override
  String get errorValidationEndDateNotAString => 'End date must be a string.';

  @override
  String get errorValidationEndDateNotADateString => 'End date must be a valid date string.';

  @override
  String get errorValidationPregnantEmpty => 'Pregnant field cannot be empty.';

  @override
  String get errorValidationPregnantNotABoolean => 'Pregnant field must be a boolean.';

  @override
  String get errorValidationMedicinesNotAnArray => 'Medicines must be an array.';

  @override
  String get errorValidationMedicinesEmptyArray => 'Medicines cannot be an empty array.';

  @override
  String get errorValidationUseSemaglutideMedicationNotAString =>
      'Use of semaglutide medication must be a string.';

  @override
  String get errorValidationHowLongTakeSemaglutideMedicationNotAString =>
      'Duration of taking semaglutide medication must be a string.';

  @override
  String get errorValidationHowLongSemaglutideTreatmentLastNotAString =>
      'Duration of semaglutide treatment must be a string.';

  @override
  String get errorValidationIsUseSemaglutideMedicationNotABoolean =>
      'Use of semaglutide medication must be a boolean.';

  @override
  String get errorValidationObesityNotABoolean => 'Obesity field must be a boolean.';

  @override
  String get errorValidationObesityEmpty => 'Obesity field cannot be empty.';

  @override
  String get errorValidationThyroidDiseaseEmpty => 'Thyroid disease field cannot be empty.';

  @override
  String get errorValidationThyroidDiseaseNotABoolean => 'Thyroid disease field must be a boolean.';

  @override
  String get errorValidationMetabolicDiseaseEmpty => 'Metabolic disease field cannot be empty.';

  @override
  String get errorValidationMetabolicDiseaseNotABoolean =>
      'Metabolic disease field must be a boolean.';

  @override
  String get errorValidationHypertensionEmpty => 'Hypertension field cannot be empty.';

  @override
  String get errorValidationHypertensionNotABoolean => 'Hypertension field must be a boolean.';

  @override
  String get errorValidationCardiovascularDiseaseEmpty =>
      'Cardiovascular disease field cannot be empty.';

  @override
  String get errorValidationCardiovascularDiseaseNotABoolean =>
      'Cardiovascular disease field must be a boolean.';

  @override
  String get errorValidationStomachReductionEmpty => 'Stomach reduction field cannot be empty.';

  @override
  String get errorValidationStomachReductionNotABoolean =>
      'Stomach reduction field must be a boolean.';

  @override
  String get errorValidationDiabetesEmpty => 'Diabetes field cannot be empty.';

  @override
  String get errorValidationDiabetesNotAString => 'Diabetes field must be a string.';

  @override
  String get errorValidationRenalFailureEmpty => 'Renal failure field cannot be empty.';

  @override
  String get errorValidationRenalFailureNotABoolean => 'Renal failure field must be a boolean.';

  @override
  String get errorValidationAsthmaEmpty => 'Asthma field cannot be empty.';

  @override
  String get errorValidationAsthmaNotABoolean => 'Asthma field must be a boolean.';

  @override
  String get errorValidationLiverDiseaseEmpty => 'Liver disease field cannot be empty.';

  @override
  String get errorValidationLiverDiseaseNotABoolean => 'Liver disease field must be a boolean.';

  @override
  String get errorValidationSleepApneaSyndromeEmpty =>
      'Sleep apnea syndrome field cannot be empty.';

  @override
  String get errorValidationSleepApneaSyndromeNotABoolean =>
      'Sleep apnea syndrome field must be a boolean.';

  @override
  String get errorValidationLocomotorSystemDiseaseEmpty =>
      'Locomotor system disease field cannot be empty.';

  @override
  String get errorValidationLocomotorSystemDiseaseNotABoolean =>
      'Locomotor system disease field must be a boolean.';

  @override
  String get errorValidationTreatedByPsychiatristEmpty =>
      'Treated by psychiatrist field cannot be empty.';

  @override
  String get errorValidationTreatedByPsychiatristNotABoolean =>
      'Treated by psychiatrist field must be a boolean.';

  @override
  String get errorValidationItemStateNotFromDefinedList =>
      'Item state must be from the defined list.';

  @override
  String get errorValidationItemStateNotAString => 'Item state must be a string.';

  @override
  String get errorValidationHatesEmpty => 'Hates field cannot be empty.';

  @override
  String get errorValidationHatesNotAnArray => 'Hates field must be an array.';

  @override
  String get errorValidationHatesNotANumber => 'Hates field must be a number.';

  @override
  String get errorValidationHatesNotAnInteger => 'Hates field must be an integer.';

  @override
  String get errorValidationHatesNotAPositiveNumber => 'Hates field must be a positive number.';

  @override
  String get errorValidationAllergicEmpty => 'Allergic field cannot be empty.';

  @override
  String get errorValidationAllergicNotAnArray => 'Allergic field must be an array.';

  @override
  String get errorValidationAllergicNotANumber => 'Allergic field must be a number.';

  @override
  String get errorValidationAllergicNotAnInteger => 'Allergic field must be an integer.';

  @override
  String get errorValidationAllergicNotAPositiveNumber =>
      'Allergic field must be a positive number.';

  @override
  String get errorValidationDislikeEmpty => 'Dislike field cannot be empty.';

  @override
  String get errorValidationDislikeNotAnArray => 'Dislike field must be an array.';

  @override
  String get errorValidationDislikeNotANumber => 'Dislike field must be a number.';

  @override
  String get errorValidationDislikeNotAnInteger => 'Dislike field must be an integer.';

  @override
  String get errorValidationDislikeNotAPositiveNumber => 'Dislike field must be a positive number.';

  @override
  String get errorValidationQuestionIdEmpty => 'Question ID cannot be empty.';

  @override
  String get errorValidationQuestionIdNotANumber => 'Question ID must be a number.';

  @override
  String get errorValidationQuestionIdNotAnInteger => 'Question ID must be an integer.';

  @override
  String get errorValidationQuestionIdNotAPositiveNumber =>
      'Question ID must be a positive number.';

  @override
  String get errorValidationOptionIdEmpty => 'Option ID cannot be empty.';

  @override
  String get errorValidationOptionIdNotANumber => 'Option ID must be a number.';

  @override
  String get errorValidationOptionIdNotAnInteger => 'Option ID must be an integer.';

  @override
  String get errorValidationOptionIdNotAPositiveNumber => 'Option ID must be a positive number.';

  @override
  String get errorValidationAnswersEmpty => 'Answers field cannot be empty.';

  @override
  String get errorValidationAnswersNotAnArray => 'Answers field must be an array.';

  @override
  String get errorValidationAnswersEmptyArray => 'Answers field cannot be an empty array.';

  @override
  String get errorValidationIsConsentApprovedEmpty => 'Consent approved field cannot be empty.';

  @override
  String get errorValidationIsConsentApprovedNotABoolean =>
      'Consent approved field must be a boolean.';

  @override
  String get errorValidationIsLegalApprovedEmpty => 'Legal approved field cannot be empty.';

  @override
  String get errorValidationIsLegalApprovedNotABoolean => 'Legal approved field must be a boolean.';

  @override
  String get errorValidationHeightEmpty => 'Height field cannot be empty.';

  @override
  String get errorValidationHeightNotANumber => 'Height field must be a number.';

  @override
  String get errorValidationHeightNumberTooBig => 'Height field is too big.';

  @override
  String get errorValidationHeightNumberTooSmall => 'Height field is too small.';

  @override
  String get errorValidationBirthDateEmpty => 'Birth date cannot be empty.';

  @override
  String get errorValidationBirthDateNotADateString => 'Birth date must be a valid date string.';

  @override
  String get errorValidationWeightEmpty => 'Weight field cannot be empty.';

  @override
  String get errorValidationWeightNotANumber => 'Weight field must be a number.';

  @override
  String get errorValidationWeightNotAPositiveNumber => 'Weight field must be a positive number.';

  @override
  String get errorValidationBmiEmpty => 'BMI field cannot be empty.';

  @override
  String get errorValidationBmiNotANumber => 'BMI field must be a number.';

  @override
  String get errorValidationBmiNotAPositiveNumber => 'BMI field must be a positive number.';

  @override
  String get errorValidationGenderEmpty => 'Gender field cannot be empty.';

  @override
  String get errorValidationGenderNotAString => 'Gender field must be a string.';

  @override
  String get errorValidationGenderInvalidEnum => 'Gender field is invalid.';

  @override
  String get errorValidationSexEmpty => 'Sex field cannot be empty.';

  @override
  String get errorValidationSexNotAString => 'Sex field must be a string.';

  @override
  String get errorValidationSexInvalidEnum => 'Sex field is invalid.';

  @override
  String get errorValidationHappinessEmpty => 'Happiness field cannot be empty.';

  @override
  String get errorValidationHappinessInvalidEnum => 'Happiness field is invalid.';

  @override
  String get errorValidationMentalHealthTestEmptyObject =>
      'Mental health test field cannot be an empty object.';

  @override
  String get errorValidationMedicalOnboardingEmptyObject =>
      'Medical onboarding field cannot be an empty object.';

  @override
  String get errorValidationCustomerIoIdEmpty => 'Customer IO ID cannot be empty.';

  @override
  String get errorValidationCustomerIoIdNotAString => 'Customer IO ID must be a string.';

  @override
  String get errorValidationNameLettersAndNumbersRequired =>
      'Name must contain letters and numbers.';

  @override
  String get errorValidationBucketStringTooShort => 'Bucket string is too short.';

  @override
  String get errorValidationBucketLettersAndNumbersRequired =>
      'Bucket must contain letters and numbers.';

  @override
  String get errorValidationBucketEmpty => 'Bucket field cannot be empty.';

  @override
  String get errorValidationBucketNotAString => 'Bucket field must be a string.';

  @override
  String get errorValidationDistributionUrlNotUrlAddress =>
      'Distribution URL must be a valid URL address.';

  @override
  String get errorValidationDistributionUrlEmpty => 'Distribution URL cannot be empty.';

  @override
  String get errorValidationDistributionUrlNotAString => 'Distribution URL must be a string.';

  @override
  String get errorValidationTypeNotAString => 'Type field must be a string.';

  @override
  String get errorValidationAccountIdEmpty => 'Account ID cannot be empty.';

  @override
  String get errorValidationAccountIdNotANumber => 'Account ID must be a number.';

  @override
  String get errorValidationAccountIdNotAnInteger => 'Account ID must be an integer.';

  @override
  String get errorValidationAccountIdNotAPositiveNumber => 'Account ID must be a positive number.';

  @override
  String get errorValidationProductIdEmpty => 'Product ID cannot be empty.';

  @override
  String get errorValidationProductIdNotANumber => 'Product ID must be a number.';

  @override
  String get errorValidationProductIdNotAnInteger => 'Product ID must be an integer.';

  @override
  String get errorValidationProductIdNotAPositiveNumber => 'Product ID must be a positive number.';

  @override
  String get errorValidationStateInvalidEnum => 'State field is invalid.';

  @override
  String get errorValidationExpiresAtEmpty => 'Expiration date cannot be empty.';

  @override
  String get errorValidationExpiresAtNotADate => 'Expiration date must be a valid date.';

  @override
  String get errorValidationCreatedAtEmpty => 'Creation date cannot be empty.';

  @override
  String get errorValidationCreatedAtNotADate => 'Creation date must be a valid date.';

  @override
  String get errorValidationReceiptEmpty => 'Receipt field cannot be empty.';

  @override
  String get errorValidationReceiptNotAString => 'Receipt field must be a string.';

  @override
  String get errorValidationTransactionIdEmpty => 'Transaction ID cannot be empty.';

  @override
  String get errorValidationTransactionIdNotANumberString =>
      'Transaction ID must be a valid number string.';

  @override
  String get errorValidationBaseTransactionIdEmpty => 'Base transaction ID cannot be empty.';

  @override
  String get errorValidationBaseTransactionIdNotANumberString =>
      'Base transaction ID must be a valid number string.';

  @override
  String get errorValidationLinkedPurchaseTokenEmpty => 'Linked purchase token cannot be empty.';

  @override
  String get errorValidationLinkedPurchaseTokenNotAString =>
      'Linked purchase token must be a string.';

  @override
  String get errorValidationDataEmptyObject => 'Data cannot be an empty object.';

  @override
  String get errorValidationSignedPayloadNotAJwt => 'Signed payload must be a valid JWT.';

  @override
  String get errorValidationSignedPayloadEmpty => 'Signed payload cannot be empty.';

  @override
  String get errorValidationMessageIdEmpty => 'Message ID cannot be empty.';

  @override
  String get errorValidationMessageIdNotANumberString =>
      'Message ID must be a valid number string.';

  @override
  String get errorValidationDataEmpty => 'Data cannot be empty.';

  @override
  String get errorValidationDataNotBase64Encoded => 'Data must be base64 encoded.';

  @override
  String get errorValidationDataNotAString => 'Data must be a string.';

  @override
  String get errorValidationMessageEmptyObject => 'Message cannot be an empty object.';

  @override
  String get errorValidationSubscriptionEmpty => 'Subscription cannot be empty.';

  @override
  String get errorValidationSubscriptionNotAString => 'Subscription must be a string.';

  @override
  String get errorValidationProductIdNotAString => 'Product ID must be a string.';

  @override
  String get errorValidationOfferIdEmpty => 'Offer ID cannot be empty.';

  @override
  String get errorValidationOfferIdNotAString => 'Offer ID must be a string.';

  @override
  String get errorValidationAccountTokenEmpty => 'Account token cannot be empty.';

  @override
  String get errorValidationAccountTokenNotAString => 'Account token must be a string.';

  @override
  String get errorValidationAccountTokenNotUuidV4 => 'Account token must be a valid UUID v4.';

  @override
  String get errorValidationVendorInvalidEnum => 'Vendor is invalid.';

  @override
  String get errorValidationLiveTogetherEmpty => 'Live together field cannot be empty.';

  @override
  String get errorValidationLiveTogetherNotABoolean => 'Live together field must be a boolean.';

  @override
  String get errorValidationRelationEmpty => 'Relation field cannot be empty.';

  @override
  String get errorValidationRelationNotAString => 'Relation field must be a string.';

  @override
  String get errorValidationRelationInvalidEnum => 'Relation field is invalid.';

  @override
  String get errorValidationEmailEmpty => 'Email cannot be empty.';

  @override
  String get errorValidationRegistrationTokenEmpty => 'Registration token cannot be empty.';

  @override
  String get errorValidationRegistrationTokenNotAString => 'Registration token must be a string.';

  @override
  String get errorValidationRegistrationTokenNotAJwt => 'Registration token must be a valid JWT.';

  @override
  String get errorValidationPasswordTokenEmpty => 'Password token cannot be empty.';

  @override
  String get errorValidationPasswordTokenNotAString => 'Password token must be a string.';

  @override
  String get errorValidationPasswordTokenNotAJwt => 'Password token must be a valid JWT.';

  @override
  String get errorValidationBuddyIdEmpty => 'Buddy ID cannot be empty.';

  @override
  String get errorValidationBuddyIdNotANumber => 'Buddy ID must be a number.';

  @override
  String get errorValidationBuddyIdNotAnInteger => 'Buddy ID must be an integer.';

  @override
  String get errorValidationBuddyIdNotAPositiveNumber => 'Buddy ID must be a positive number.';

  @override
  String get errorValidationIdEmpty => 'ID cannot be empty.';

  @override
  String get errorValidationIdNotANumber => 'ID must be a number.';

  @override
  String get errorValidationIdNotAnInteger => 'ID must be an integer.';

  @override
  String get errorValidationIdNotAPositiveNumber => 'ID must be a positive number.';

  @override
  String get errorValidationDishIdEmpty => 'Dish ID cannot be empty.';

  @override
  String get errorValidationDishIdNotANumber => 'Dish ID must be a number.';

  @override
  String get errorValidationDishIdNotAnInteger => 'Dish ID must be an integer.';

  @override
  String get errorValidationDishIdNotAPositiveNumber => 'Dish ID must be a positive number.';

  @override
  String get errorValidationMealCategoriesNotAString => 'Meal categories must be a string.';

  @override
  String get errorValidationNumberOfServingsEmpty => 'Number of servings cannot be empty.';

  @override
  String get errorValidationNumberOfServingsNotANumber => 'Number of servings must be a number.';

  @override
  String get errorValidationNumberOfServingsNotAPositiveNumber =>
      'Number of servings must be a positive number.';

  @override
  String get errorValidationExternalFoodItemIdEmpty => 'External food item ID cannot be empty.';

  @override
  String get errorValidationExternalFoodItemIdNotANumberString =>
      'External food item ID must be a valid number string.';

  @override
  String get errorValidationFoodItemsEmpty => 'Food items cannot be empty.';

  @override
  String get errorValidationFoodItemsNotAnArray => 'Food items must be an array.';

  @override
  String get errorValidationFoodItemsEmptyArray => 'Food items cannot be an empty array.';

  @override
  String get errorValidationInternalFoodItemIdEmpty => 'Internal food item ID cannot be empty.';

  @override
  String get errorValidationInternalFoodItemIdNotANumber =>
      'Internal food item ID must be a number.';

  @override
  String get errorValidationInternalFoodItemIdNotAnInteger =>
      'Internal food item ID must be an integer.';

  @override
  String get errorValidationInternalFoodItemIdNotAPositiveNumber =>
      'Internal food item ID must be a positive number.';

  @override
  String get errorValidationMealRecipeIdNumberTooBig => 'Meal recipe ID number is too big.';

  @override
  String get errorValidationMealRecipeIdNumberTooSmall => 'Meal recipe ID number is too small.';

  @override
  String get errorValidationRecipeIdNotANumber => 'Recipe ID must be a number.';

  @override
  String get errorValidationRecipeIdNotAnInteger => 'Recipe ID must be an integer.';

  @override
  String get errorValidationRecipeIdNotAPositiveNumber => 'Recipe ID must be a positive number.';

  @override
  String get errorValidationRecipeIdNumberTooBig => 'Recipe ID number is too big.';

  @override
  String get errorValidationRecipeIdNumberTooSmall => 'Recipe ID number is too small.';

  @override
  String get errorValidationRegionInvalidEnum => 'Region is invalid.';

  @override
  String get errorValidationBarcodeEmpty => 'Barcode cannot be empty.';

  @override
  String get errorValidationBarcodeNotAString => 'Barcode must be a string.';

  @override
  String get errorValidationBarcodeStringTooLong => 'Barcode string is too long.';

  @override
  String get errorValidationBarcodeStringTooShort => 'Barcode string is too short.';

  @override
  String get errorValidationExternalFoodItemIdNotAString =>
      'External food item ID must be a string.';

  @override
  String get errorValidationServingIdNotAString => 'Serving ID must be a string.';

  @override
  String get errorValidationFoodItemsArraySizeTooSmall => 'Food items array size is too small.';

  @override
  String get errorValidationInternalRecipeIdEmpty => 'Internal recipe ID cannot be empty.';

  @override
  String get errorValidationInternalRecipeIdNotANumber => 'Internal recipe ID must be a number.';

  @override
  String get errorValidationInternalRecipeIdNotAnInteger =>
      'Internal recipe ID must be an integer.';

  @override
  String get errorValidationInternalRecipeIdNotAPositiveNumber =>
      'Internal recipe ID must be a positive number.';

  @override
  String get errorValidationLoggingDateEmpty => 'Logging date cannot be empty.';

  @override
  String get errorValidationLoggingDateNotADateString =>
      'Logging date must be a valid date string.';

  @override
  String get errorValidationMealCategoryEmpty => 'Meal category cannot be empty.';

  @override
  String get errorValidationInternalFoodItemIdNotANumberString =>
      'Internal food item ID must be a valid number string.';

  @override
  String get errorValidationDateEmpty => 'Date cannot be empty.';

  @override
  String get errorValidationDateNotADateString => 'Date must be a valid date string.';

  @override
  String get errorValidationQueryEmpty => 'Query cannot be empty.';

  @override
  String get errorValidationQueryNotAString => 'Query must be a string.';

  @override
  String get errorValidationQueryStringTooShort => 'Query string is too short.';

  @override
  String get errorValidationModesEmpty => 'Modes cannot be empty.';

  @override
  String get errorValidationModesNotFromDefinedList => 'Modes must be from the defined list.';

  @override
  String get errorValidationPageNotANumber => 'Page must be a number.';

  @override
  String get errorValidationPageNotAnInteger => 'Page must be an integer.';

  @override
  String get errorValidationPageNotAPositiveNumber => 'Page must be a positive number.';

  @override
  String get errorValidationPageSizeNotANumber => 'Page size must be a number.';

  @override
  String get errorValidationPageSizeNotAnInteger => 'Page size must be an integer.';

  @override
  String get errorValidationPageSizeNotAPositiveNumber => 'Page size must be a positive number.';

  @override
  String get errorValidationPageSizeNumberTooBig => 'Page size number is too big.';

  @override
  String get errorValidationPlanningDatesDateTooSmall => 'Planning dates date is too small.';

  @override
  String get errorValidationPlanningDatesDateTooBig => 'Planning dates date is too big.';

  @override
  String get errorValidationPlanningDatesEmpty => 'Planning dates cannot be empty.';

  @override
  String get errorValidationPlanningDatesEmptyArray => 'Planning dates cannot be an empty array.';

  @override
  String get errorValidationPlanningDatesNotADateString =>
      'Planning dates must be a valid date string.';

  @override
  String get errorValidationStartDateDateEmptyPeriod => 'Start date cannot be empty or invalid.';

  @override
  String get errorValidationPlannedMealIdEmpty => 'Planned meal ID cannot be empty.';

  @override
  String get errorValidationPlannedMealIdNotANumber => 'Planned meal ID must be a number.';

  @override
  String get errorValidationPlannedMealIdNotAnInteger => 'Planned meal ID must be an integer.';

  @override
  String get errorValidationPlannedMealIdNotAPositiveNumber =>
      'Planned meal ID must be a positive number.';

  @override
  String get errorValidationLoggingDateDateTooBig => 'Logging date is too big.';

  @override
  String get errorValidationLoggingDateDateTooSmall => 'Logging date is too small.';

  @override
  String get errorValidationLimitNumberTooSmall => 'Limit number is too small.';

  @override
  String get errorValidationLimitNotAnInteger => 'Limit must be an integer.';

  @override
  String get errorValidationLimitNotAPositiveNumber => 'Limit must be a positive number.';

  @override
  String get errorValidationLimitNotANumber => 'Limit must be a number.';

  @override
  String get errorValidationUrlNotAString => 'URL must be a string.';

  @override
  String get errorValidationUrlNotUrlAddress => 'URL must be a valid URL address.';

  @override
  String get errorValidationDataArraySizeTooSmall => 'Data array size is too small.';

  @override
  String get errorValidationDataNotAnArray => 'Data must be an array.';

  @override
  String get errorValidationDateNotAString => 'Date must be a string.';

  @override
  String get errorValidationDateDateTooSmall => 'Date is too small.';

  @override
  String get errorValidationDateDateTooBig => 'Date is too big.';

  @override
  String get errorValidationWeightNumberTooBig => 'Weight number is too big.';

  @override
  String get errorValidationStartDateDateTooBig => 'Start date is too big.';

  @override
  String get errorValidationEndDateDateTooBig => 'End date is too big.';

  @override
  String get errorValidationStateNotAString => 'State must be a string.';

  @override
  String get errorValidationGenderPreferenceIdEmpty => 'Gender preference ID cannot be empty.';

  @override
  String get errorValidationGenderPreferenceIdNotANumber =>
      'Gender preference ID must be a number.';

  @override
  String get errorValidationGenderPreferenceIdNotAnInteger =>
      'Gender preference ID must be an integer.';

  @override
  String get errorValidationGenderPreferenceIdNotAPositiveNumber =>
      'Gender preference ID must be a positive number.';

  @override
  String get errorValidationTypeIdEmpty => 'Type ID cannot be empty.';

  @override
  String get errorValidationTypeIdNotANumber => 'Type ID must be a number.';

  @override
  String get errorValidationTypeIdNotAnInteger => 'Type ID must be an integer.';

  @override
  String get errorValidationTypeIdNotAPositiveNumber => 'Type ID must be a positive number.';

  @override
  String get errorValidationBmiRangeNotAString => 'BMI range must be a string.';

  @override
  String get errorValidationBmiRangeInvalidEnum => 'BMI range is invalid.';

  @override
  String get errorValidationAgeRangeNotAString => 'Age range must be a string.';

  @override
  String get errorValidationAgeRangeInvalidEnum => 'Age range is invalid.';

  @override
  String get errorValidationTimezoneStringTooShort => 'Timezone string is too short.';

  @override
  String get errorValidationGroupIdEmpty => 'Group ID cannot be empty.';

  @override
  String get errorValidationGroupIdNotANumber => 'Group ID must be a number.';

  @override
  String get errorValidationGroupIdNotAnInteger => 'Group ID must be an integer.';

  @override
  String get errorValidationGroupIdNotAPositiveNumber => 'Group ID must be a positive number.';

  @override
  String get errorValidationGroupSessionIdEmpty => 'Group session ID cannot be empty.';

  @override
  String get errorValidationGroupSessionIdNotANumber => 'Group session ID must be a number.';

  @override
  String get errorValidationGroupSessionIdNotAnInteger => 'Group session ID must be an integer.';

  @override
  String get errorValidationGroupSessionIdNotAPositiveNumber =>
      'Group session ID must be a positive number.';

  @override
  String get errorValidationEventInvalidEnum => 'Event is invalid.';

  @override
  String get errorValidationEventNotAString => 'Event must be a string.';

  @override
  String get errorValidationEventEmpty => 'Event cannot be empty.';

  @override
  String get errorValidationStartDateNotAnIsoDateString =>
      'Start date must be a valid ISO date string.';

  @override
  String get errorValidationEndDateNotAnIsoDateString =>
      'End date must be a valid ISO date string.';

  @override
  String get errorValidationStatusEmpty => 'Status cannot be empty.';

  @override
  String get errorValidationStatusNotAString => 'Status must be a string.';

  @override
  String get errorValidationStatusInvalidEnum => 'Status is invalid.';

  @override
  String get errorValidationTopicStringTooLong => 'Topic string is too long.';

  @override
  String get errorValidationTopicStringTooShort => 'Topic string is too short.';

  @override
  String get errorValidationTopicNotAString => 'Topic must be a string.';

  @override
  String get errorValidationPasswordStringTooLong => 'Password string is too long.';

  @override
  String get errorValidationPasswordStringTooShort => 'Password string is too short.';

  @override
  String get errorValidationGroupSessionProgramIdNotAPositiveNumber =>
      'Group session program ID must be a positive number.';

  @override
  String get errorValidationGroupSessionProgramIdNotAnInteger =>
      'Group session program ID must be an integer.';

  @override
  String get errorValidationGroupSessionProgramIdNotANumber =>
      'Group session program ID must be a number.';

  @override
  String get errorValidationPreparationNotAString => 'Preparation must be a string.';

  @override
  String get errorValidationPreparationEmpty => 'Preparation cannot be empty.';

  @override
  String get errorValidationTitleNotAString => 'Title must be a string.';

  @override
  String get errorValidationTitleEmpty => 'Title cannot be empty.';

  @override
  String get errorValidationEventsNotAnArray => 'Events must be an array.';

  @override
  String get errorValidationImageNotAString => 'Image must be a string.';

  @override
  String get errorValidationImageEmpty => 'Image cannot be empty.';

  @override
  String get errorValidationStartNotAString => 'Start must be a string.';

  @override
  String get errorValidationStartEmpty => 'Start cannot be empty.';

  @override
  String get errorValidationPromptNotAString => 'Prompt must be a string.';

  @override
  String get errorValidationVideoNotAString => 'Video must be a string.';

  @override
  String get errorValidationDurationNotAnInteger => 'Duration must be an integer.';

  @override
  String get errorValidationDurationNotAPositiveNumber => 'Duration must be a positive number.';

  @override
  String get errorValidationDurationNotANumber => 'Duration must be a number.';

  @override
  String get errorValidationSessionIdNotAnInteger => 'Session ID must be an integer.';

  @override
  String get errorValidationSessionIdNotAPositiveNumber => 'Session ID must be a positive number.';

  @override
  String get errorValidationSessionIdNotANumber => 'Session ID must be a number.';

  @override
  String get errorValidationTypeEmpty => 'Type cannot be empty.';

  @override
  String get errorValidationImagePathStringTooShort => 'Image path string is too short.';

  @override
  String get errorValidationImagePathNotAString => 'Image path must be a string.';

  @override
  String get errorValidationImagePathEmpty => 'Image path cannot be empty.';

  @override
  String get errorValidationDifficultyNotAString => 'Difficulty must be a string.';

  @override
  String get errorValidationDifficultyInvalidEnum => 'Difficulty is invalid.';

  @override
  String get errorValidationPlaceNotAString => 'Place must be a string.';

  @override
  String get errorValidationPlaceInvalidEnum => 'Place is invalid.';

  @override
  String get errorValidationPhysicalProgramIdEmpty => 'Physical program ID cannot be empty.';

  @override
  String get errorValidationPhysicalProgramIdNotANumber => 'Physical program ID must be a number.';

  @override
  String get errorValidationPhysicalProgramIdNotAnInteger =>
      'Physical program ID must be an integer.';

  @override
  String get errorValidationPhysicalProgramIdNotAPositiveNumber =>
      'Physical program ID must be a positive number.';

  @override
  String get errorValidationScoreEmpty => 'Score cannot be empty.';

  @override
  String get errorValidationScoreNotANumber => 'Score must be a number.';

  @override
  String get errorValidationScoreNumberTooBig => 'Score number is too big.';

  @override
  String get errorValidationScoreNumberTooSmall => 'Score number is too small.';

  @override
  String get errorValidationLikeEmpty => 'Like cannot be empty.';

  @override
  String get errorValidationLikeNotABoolean => 'Like must be a boolean.';

  @override
  String get errorValidationTrainingFrequencyEmpty => 'Training frequency cannot be empty.';

  @override
  String get errorValidationTrainingFrequencyNotAString => 'Training frequency must be a string.';

  @override
  String get errorValidationTrainingFrequencyInvalidEnum => 'Training frequency is invalid.';

  @override
  String get errorValidationTrainingTargetsEmpty => 'Training targets cannot be empty.';

  @override
  String get errorValidationTrainingTargetsNotAString => 'Training targets must be a string.';

  @override
  String get errorValidationTrainingTargetsInvalidEnum => 'Training targets are invalid.';

  @override
  String get errorValidationFlexibleEmpty => 'Flexible cannot be empty.';

  @override
  String get errorValidationFlexibleNotABoolean => 'Flexible must be a boolean.';

  @override
  String get errorValidationImageStringTooShort => 'Image string is too short.';

  @override
  String get errorValidationVideoStringTooShort => 'Video string is too short.';

  @override
  String get errorValidationVideoEmpty => 'Video cannot be empty.';

  @override
  String get errorValidationDurationNotAString => 'Duration must be a string.';

  @override
  String get errorValidationDurationEmpty => 'Duration cannot be empty.';

  @override
  String get errorValidationSkipToNotAString => 'Skip to must be a string.';

  @override
  String get errorValidationSkipToEmpty => 'Skip to cannot be empty.';

  @override
  String get errorValidationExerciseIdEmpty => 'Exercise ID cannot be empty.';

  @override
  String get errorValidationExerciseIdNotANumber => 'Exercise ID must be a number.';

  @override
  String get errorValidationExerciseIdNotAnInteger => 'Exercise ID must be an integer.';

  @override
  String get errorValidationExerciseIdNotAPositiveNumber =>
      'Exercise ID must be a positive number.';

  @override
  String get errorValidationCategoryInvalidEnum => 'Category is invalid.';

  @override
  String get errorValidationLocationInvalidEnum => 'Location is invalid.';

  @override
  String get errorValidationEquipmentStringTooShort => 'Equipment string is too short.';

  @override
  String get errorValidationEquipmentNotAString => 'Equipment must be a string.';

  @override
  String get errorValidationEquipmentEmpty => 'Equipment cannot be empty.';

  @override
  String get errorValidationTargetMusclesStringTooShort => 'Target muscles string is too short.';

  @override
  String get errorValidationTargetMusclesNotAString => 'Target muscles must be a string.';

  @override
  String get errorValidationTargetMusclesEmpty => 'Target muscles cannot be empty.';

  @override
  String get errorValidationDurationStringTooShort => 'Duration string is too short.';

  @override
  String get errorValidationVideoNotUrlAddress => 'Video must be a valid URL address.';

  @override
  String get errorValidationProgramIdEmpty => 'Program ID cannot be empty.';

  @override
  String get errorValidationProgramIdNotANumber => 'Program ID must be a number.';

  @override
  String get errorValidationProgramIdNotAnInteger => 'Program ID must be an integer.';

  @override
  String get errorValidationProgramIdNotAPositiveNumber => 'Program ID must be a positive number.';

  @override
  String get errorValidationImageNotUrlAddress => 'Image must be a valid URL address.';

  @override
  String get errorValidationOrderNotAPositiveNumber => 'Order must be a positive number.';

  @override
  String get errorValidationOrderNotAnInteger => 'Order must be an integer.';

  @override
  String get errorValidationModuleIdNotAPositiveNumber => 'Module ID must be a positive number.';

  @override
  String get errorValidationModuleIdNotAnInteger => 'Module ID must be an integer.';

  @override
  String get errorValidationModuleIdNotANumber => 'Module ID must be a number.';

  @override
  String get errorValidationModuleIdEmpty => 'Module ID cannot be empty.';

  @override
  String get errorValidationExternalIdNotAPositiveNumber =>
      'External ID must be a positive number.';

  @override
  String get errorValidationExternalIdNotAnInteger => 'External ID must be an integer.';

  @override
  String get errorValidationExternalIdNotANumber => 'External ID must be a number.';

  @override
  String get errorValidationExternalIdEmpty => 'External ID cannot be empty.';

  @override
  String get errorValidationStreamTypeInvalidEnum => 'Stream type is invalid.';

  @override
  String get errorValidationStreamTypeEmpty => 'Stream type cannot be empty.';

  @override
  String get errorValidationIconTypeInvalidEnum => 'Icon type is invalid.';

  @override
  String get errorValidationIconTypeEmpty => 'Icon type cannot be empty.';

  @override
  String get errorValidationIsRootItemNotABoolean => 'Is root item must be a boolean.';

  @override
  String get errorValidationIsRootItemEmpty => 'Is root item cannot be empty.';

  @override
  String get errorValidationLessonExternalIdNotAPositiveNumber =>
      'Lesson external ID must be a positive number.';

  @override
  String get errorValidationLessonExternalIdNotAnInteger =>
      'Lesson external ID must be an integer.';

  @override
  String get errorValidationLessonExternalIdNotANumber => 'Lesson external ID must be a number.';

  @override
  String get errorValidationLessonExternalIdEmpty => 'Lesson external ID cannot be empty.';

  @override
  String get errorValidationUnlocksItemExternalIdsNotANumber =>
      'Unlocks item external IDs must be numbers.';

  @override
  String get errorValidationUnlocksItemExternalIdsNotAnArray =>
      'Unlocks item external IDs must be an array.';

  @override
  String get errorValidationUnlocksItemExternalIdsEmpty =>
      'Unlocks item external IDs cannot be empty.';

  @override
  String get errorValidationUnlocksFeatureNotAString => 'Unlocks feature must be a string.';

  @override
  String get errorValidationUnlocksFeatureNotAnArray => 'Unlocks feature must be an array.';

  @override
  String get errorValidationUnlocksFeatureEmpty => 'Unlocks feature cannot be empty.';

  @override
  String get errorValidationUnlocksReflectionExternalIdNotANumber =>
      'Unlocks reflection external ID must be a number.';

  @override
  String get errorValidationUnlocksReflectionExternalIdEmpty =>
      'Unlocks reflection external ID cannot be empty.';

  @override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber =>
      'Unlocks smart goal category external ID must be a number.';

  @override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdEmpty =>
      'Unlocks smart goal category external ID cannot be empty.';

  @override
  String get errorValidationCrossModuleNotABoolean => 'Cross module must be a boolean.';

  @override
  String get errorValidationCrossModuleEmpty => 'Cross module cannot be empty.';

  @override
  String get errorValidationFeaturePlacementInvalidEnum => 'Feature placement is invalid.';

  @override
  String get errorValidationFeaturePlacementEmpty => 'Feature placement cannot be empty.';

  @override
  String get errorValidationModuleItemsNotAnArray => 'Module items must be an array.';

  @override
  String get errorValidationModuleItemsEmpty => 'Module items cannot be empty.';

  @override
  String get errorValidationRiverModuleIdEmpty => 'River module ID cannot be empty.';

  @override
  String get errorValidationRiverModuleIdNotANumber => 'River module ID must be a number.';

  @override
  String get errorValidationRiverModuleIdNotAnInteger => 'River module ID must be an integer.';

  @override
  String get errorValidationRiverModuleIdNotAPositiveNumber =>
      'River module ID must be a positive number.';

  @override
  String get errorValidationRiverModuleItemIdEmpty => 'River module item ID cannot be empty.';

  @override
  String get errorValidationRiverModuleItemIdNotANumber => 'River module item ID must be a number.';

  @override
  String get errorValidationRiverModuleItemIdNotAnInteger =>
      'River module item ID must be an integer.';

  @override
  String get errorValidationRiverModuleItemIdNotAPositiveNumber =>
      'River module item ID must be a positive number.';

  @override
  String get errorValidationLanguageNotAString => 'Language must be a string.';

  @override
  String get errorValidationCountryNotAString => 'Country must be a string.';

  @override
  String get errorValidationTimezoneOffsetNotANumber => 'Timezone offset must be a number.';

  @override
  String get errorValidationTimezoneNameNotAString => 'Timezone name must be a string.';

  @override
  String get errorValidationMeasurementSystemNotAString => 'Measurement system must be a string.';

  @override
  String get errorValidationRefreshTokenNotAString => 'Refresh token must be a string.';

  @override
  String get errorValidationDiabetesNotAPositiveNumber => 'Diabetes must be a positive number.';

  @override
  String get errorValidationDiabetesNotANumber => 'Diabetes must be a number.';

  @override
  String get errorValidationTextStringTooLong => 'Text string is too long.';

  @override
  String get errorValidationTextStringTooShort => 'Text string is too short.';

  @override
  String get errorValidationTextEmpty => 'Text cannot be empty.';

  @override
  String get errorValidationTextNotAString => 'Text must be a string.';

  @override
  String get errorValidationReplyMessageIdNotANumberString =>
      'Reply message ID must be a number string.';

  @override
  String get errorValidationMessageIdNotANumber => 'Message ID must be a number.';

  @override
  String get errorValidationMessageIdNotAnInteger => 'Message ID must be an integer.';

  @override
  String get errorValidationMessageIdNotAPositiveNumber => 'Message ID must be a positive number.';

  @override
  String get errorValidationTimeEmpty => 'Time cannot be empty.';

  @override
  String get errorValidationTimeNotAString => 'Time must be a string.';

  @override
  String get errorValidationTimeStringTooLong => 'Time string is too long.';

  @override
  String get errorValidationTimeStringTooShort => 'Time string is too short.';

  @override
  String get errorValidationSubjectEmpty => 'Subject cannot be empty.';

  @override
  String get errorValidationSubjectNotAString => 'Subject must be a string.';

  @override
  String get errorValidationSubjectStringTooLong => 'Subject string is too long.';

  @override
  String get errorValidationSubjectStringTooShort => 'Subject string is too short.';

  @override
  String get errorValidationMessageEmpty => 'Message cannot be empty.';

  @override
  String get errorValidationMessageNotAString => 'Message must be a string.';

  @override
  String get errorValidationMessageStringTooLong => 'Message string is too long.';

  @override
  String get errorValidationMessageStringTooShort => 'Message string is too short.';

  @override
  String get errorValidationAppVersionEmpty => 'App version cannot be empty.';

  @override
  String get errorValidationAppVersionNotAString => 'App version must be a string.';

  @override
  String get errorValidationAppVersionStringTooLong => 'App version string is too long.';

  @override
  String get errorValidationAppVersionStringTooShort => 'App version string is too short.';

  @override
  String get errorValidationEmailTokenEmpty => 'Email token cannot be empty.';

  @override
  String get errorValidationEmailTokenNotAString => 'Email token must be a string.';

  @override
  String get errorValidationEmailTokenNotAJwt => 'Email token must be a JWT.';

  @override
  String get errorValidationExtraAccountsCountNumberTooSmall =>
      'Extra accounts count is too small.';

  @override
  String get errorValidationExtraAccountsCountNotAnInteger =>
      'Extra accounts count must be an integer.';

  @override
  String get errorValidationExtraAccountsCountNotANumber =>
      'Extra accounts count must be a number.';

  @override
  String get errorValidationUidNotAString => 'UID must be a string.';

  @override
  String get errorValidationPlatformInvalidEnum => 'Platform is invalid.';

  @override
  String get errorValidationPlatformNotAString => 'Platform must be a string.';

  @override
  String get errorValidationDeviceIdNotAString => 'Device ID must be a string.';

  @override
  String get errorValidationDeviceIdEmpty => 'Device ID cannot be empty.';

  @override
  String get errorValidationDeviceIdStringTooLong => 'Device ID string is too long.';

  @override
  String get errorValidationAdvertisingIdNotAString => 'Advertising ID must be a string.';

  @override
  String get errorValidationAdvertisingIdEmpty => 'Advertising ID cannot be empty.';

  @override
  String get errorValidationAdvertisingIdStringTooLong => 'Advertising ID string is too long.';

  @override
  String get errorValidationLimitNumberTooBig => 'Limit number is too big.';

  @override
  String get errorValidationFromMessageIdNotANumberString =>
      'From message ID must be a number string.';

  @override
  String get errorValidationChatMessageIdNotAString => 'Chat message ID must be a string.';

  @override
  String get errorValidationChatMessageIdNotANumberString =>
      'Chat message ID must be a number string.';

  @override
  String get errorValidationReflectionIdEmpty => 'Reflection ID cannot be empty.';

  @override
  String get errorValidationReflectionIdNotANumber => 'Reflection ID must be a number.';

  @override
  String get errorValidationReflectionIdNotAnInteger => 'Reflection ID must be an integer.';

  @override
  String get errorValidationReflectionIdNotAPositiveNumber =>
      'Reflection ID must be a positive number.';

  @override
  String get errorValidationReflectionQuestionIdEmpty => 'Reflection question ID cannot be empty.';

  @override
  String get errorValidationReflectionQuestionIdNotANumber =>
      'Reflection question ID must be a number.';

  @override
  String get errorValidationReflectionQuestionIdNotAnInteger =>
      'Reflection question ID must be an integer.';

  @override
  String get errorValidationReflectionQuestionIdNotAPositiveNumber =>
      'Reflection question ID must be a positive number.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNumberTooBig =>
      'Reflection question option IDs number is too big.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNumberTooSmall =>
      'Reflection question option IDs number is too small.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAPositiveNumber =>
      'Reflection question option IDs must be a positive number.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAnInteger =>
      'Reflection question option IDs must be an integer.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotANumber =>
      'Reflection question option IDs must be a number.';

  @override
  String get errorValidationReflectionQuestionOptionIdsEmptyArray =>
      'Reflection question option IDs cannot be an empty array.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAnArray =>
      'Reflection question option IDs must be an array.';

  @override
  String get errorValidationValueNumberTooBig => 'Value number is too big.';

  @override
  String get errorValidationValueNumberTooSmall => 'Value number is too small.';

  @override
  String get errorValidationValueNotAPositiveNumber => 'Value must be a positive number.';

  @override
  String get errorValidationValueNotAnInteger => 'Value must be an integer.';

  @override
  String get errorValidationValueNotANumber => 'Value must be a number.';

  @override
  String get errorValidationLessonIdEmpty => 'Lesson ID cannot be empty.';

  @override
  String get errorValidationLessonIdNotANumber => 'Lesson ID must be a number.';

  @override
  String get errorValidationLessonIdNotAnInteger => 'Lesson ID must be an integer.';

  @override
  String get errorValidationLessonIdNotAPositiveNumber => 'Lesson ID must be a positive number.';

  @override
  String get errorValidationLabelNotAString => 'Label must be a string.';

  @override
  String get errorValidationIsCorrectNotABoolean => 'Is correct must be a boolean.';

  @override
  String get errorValidationMinValueNotAPositiveNumber => 'Min value must be a positive number.';

  @override
  String get errorValidationMinValueNotAnInteger => 'Min value must be an integer.';

  @override
  String get errorValidationMinValueNotANumber => 'Min value must be a number.';

  @override
  String get errorValidationMaxValueNotAPositiveNumber => 'Max value must be a positive number.';

  @override
  String get errorValidationMaxValueNotAnInteger => 'Max value must be an integer.';

  @override
  String get errorValidationMaxValueNotANumber => 'Max value must be a number.';

  @override
  String get errorValidationLowestTextNotAString => 'Lowest text must be a string.';

  @override
  String get errorValidationHighestTextNotAString => 'Highest text must be a string.';

  @override
  String get errorValidationScaleNotAnArray => 'Scale must be an array.';

  @override
  String get errorValidationQuestionNotAString => 'Question must be a string.';

  @override
  String get errorValidationAnswerTypeInvalidEnum => 'Answer type is invalid.';

  @override
  String get errorValidationAnswerTypeNotAString => 'Answer type must be a string.';

  @override
  String get errorValidationIntroductionNotAString => 'Introduction must be a string.';

  @override
  String get errorValidationFeedbackNotAnArray => 'Feedback must be an array.';

  @override
  String get errorValidationExtraInstructionNotAString => 'Extra instruction must be a string.';

  @override
  String get errorValidationInstructionNotAString => 'Instruction must be a string.';

  @override
  String get errorValidationCategoryNotAString => 'Category must be a string.';

  @override
  String get errorValidationExternalLessonIdNotAPositiveNumber =>
      'External lesson ID must be a positive number.';

  @override
  String get errorValidationExternalLessonIdNotAnInteger =>
      'External lesson ID must be an integer.';

  @override
  String get errorValidationExternalLessonIdNotANumber => 'External lesson ID must be a number.';

  @override
  String get errorValidationQuestionsNotAnArray => 'Questions must be an array.';

  @override
  String get errorValidationOrderNotANumber => 'Order must be a number.';

  @override
  String get errorValidationOrderEmpty => 'Order cannot be empty.';

  @override
  String get errorValidationContentTypeInvalidEnum => 'Content type is invalid.';

  @override
  String get errorValidationContentTypeNotAString => 'Content type must be a string.';

  @override
  String get errorValidationContentTypeEmpty => 'Content type cannot be empty.';

  @override
  String get errorValidationCardImageUrlNotAString => 'Card image URL must be a string.';

  @override
  String get errorValidationImageUrlNotAString => 'Image URL must be a string.';

  @override
  String get errorValidationAudioUrlNotAString => 'Audio URL must be a string.';

  @override
  String get errorValidationHtmlUrlNotAString => 'HTML URL must be a string.';

  @override
  String get errorValidationSubtitlesImagesNotAString => 'Subtitles images must be a string.';

  @override
  String get errorValidationConclusionNotAString => 'Conclusion must be a string.';

  @override
  String get errorValidationUnlockTitleNotAString => 'Unlock title must be a string.';

  @override
  String get errorValidationUnlockDescriptionNotAString => 'Unlock description must be a string.';

  @override
  String get errorValidationAudioEmpty => 'Audio cannot be empty.';

  @override
  String get errorValidationAudioNotAString => 'Audio must be a string.';

  @override
  String get errorValidationSubtitlesImagesEmpty => 'Subtitles images cannot be empty.';

  @override
  String get errorValidationCorrectNotAString => 'Correct must be a string.';

  @override
  String get errorValidationIncorrectNotAString => 'Incorrect must be a string.';

  @override
  String get errorValidationVisualEmpty => 'Visual cannot be empty.';

  @override
  String get errorValidationVisualNotAString => 'Visual must be a string.';

  @override
  String get errorValidationCompletionTimeNotAString => 'Completion time must be a string.';

  @override
  String get errorValidationCompletionTimeEmpty => 'Completion time cannot be empty.';

  @override
  String get errorValidationLessonsArraySizeTooSmall => 'Lessons array size is too small.';

  @override
  String get errorValidationLessonsNotAnArray => 'Lessons must be an array.';

  @override
  String get errorValidationLessonQuizIdEmpty => 'Lesson quiz ID cannot be empty.';

  @override
  String get errorValidationLessonQuizIdNotANumber => 'Lesson quiz ID must be a number.';

  @override
  String get errorValidationLessonQuizIdNotAnInteger => 'Lesson quiz ID must be an integer.';

  @override
  String get errorValidationLessonQuizIdNotAPositiveNumber =>
      'Lesson quiz ID must be a positive number.';

  @override
  String get errorValidationLessonQuizQuestionOptionIdsNumberTooBig =>
      'Lesson quiz question option IDs number is too big.';

  @override
  String get errorLessonQuizQuestionOptionIdsNumberTooSmall =>
      'Lesson quiz question option IDs number is too small.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAPositiveNumber =>
      'Lesson quiz question option IDs must be positive numbers.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAnInteger =>
      'Lesson quiz question option IDs must be integers.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotANumber =>
      'Lesson quiz question option IDs must be numbers.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAnArray =>
      'Lesson quiz question option IDs must be an array.';

  @override
  String get errorLessonQuizQuestionIdEmpty => 'Lesson quiz question ID cannot be empty.';

  @override
  String get errorLessonQuizQuestionIdNotANumber => 'Lesson quiz question ID must be a number.';

  @override
  String get errorLessonQuizQuestionIdNotAnInteger => 'Lesson quiz question ID must be an integer.';

  @override
  String get errorLessonQuizQuestionIdNotAPositiveNumber =>
      'Lesson quiz question ID must be a positive number.';

  @override
  String get errorExplanationTypeInvalidEnum => 'Explanation type is invalid.';

  @override
  String get errorExplanationTypeNotAString => 'Explanation type must be a string.';

  @override
  String get errorExplanationTypeEmpty => 'Explanation type cannot be empty.';

  @override
  String get errorExplanationSrcNotAString => 'Explanation source must be a string.';

  @override
  String get errorExplanationSrcEmpty => 'Explanation source cannot be empty.';

  @override
  String get errorExplanationDurationNotAPositiveNumber =>
      'Explanation duration must be a positive number.';

  @override
  String get errorExplanationDurationNotANumber => 'Explanation duration must be a number.';

  @override
  String get errorExplanationDurationEmpty => 'Explanation duration cannot be empty.';

  @override
  String get errorExplanationOrientationInvalidEnum => 'Explanation orientation is invalid.';

  @override
  String get errorExplanationOrientationNotAString => 'Explanation orientation must be a string.';

  @override
  String get errorExerciseTypeInvalidEnum => 'Exercise type is invalid.';

  @override
  String get errorExerciseTypeNotAString => 'Exercise type must be a string.';

  @override
  String get errorExerciseTypeEmpty => 'Exercise type cannot be empty.';

  @override
  String get errorExerciseOrientationInvalidEnum => 'Exercise orientation is invalid.';

  @override
  String get errorExerciseOrientationNotAString => 'Exercise orientation must be a string.';

  @override
  String get errorExerciseOrientationEmpty => 'Exercise orientation cannot be empty.';

  @override
  String get errorExerciseDurationNotAPositiveNumber =>
      'Exercise duration must be a positive number.';

  @override
  String get errorExerciseDurationNotANumber => 'Exercise duration must be a number.';

  @override
  String get errorExerciseDurationEmpty => 'Exercise duration cannot be empty.';

  @override
  String get errorExerciseSrcNotAString => 'Exercise source must be a string.';

  @override
  String get errorExerciseSrcEmpty => 'Exercise source cannot be empty.';

  @override
  String get errorShortDescriptionNotAString => 'Short description must be a string.';

  @override
  String get errorShortDescriptionEmpty => 'Short description cannot be empty.';

  @override
  String get errorDifficultyEmpty => 'Difficulty cannot be empty.';

  @override
  String get errorScaleBeforeQuestionNotAString => 'Scale before question must be a string.';

  @override
  String get errorScaleBeforeLowestTextNotAString => 'Scale before lowest text must be a string.';

  @override
  String get errorScaleBeforeHighestTextNotAString => 'Scale before highest text must be a string.';

  @override
  String get errorScaleAfterQuestionNotAString => 'Scale after question must be a string.';

  @override
  String get errorScaleAfterLowestTextNotAString => 'Scale after lowest text must be a string.';

  @override
  String get errorScaleAfterHighestTextNotAString => 'Scale after highest text must be a string.';

  @override
  String get errorTechniqueIdNotAPositiveNumber => 'Technique ID must be a positive number.';

  @override
  String get errorTechniqueIdNotAnInteger => 'Technique ID must be an integer.';

  @override
  String get errorTechniqueIdNotANumber => 'Technique ID must be a number.';

  @override
  String get errorTechniqueIdEmpty => 'Technique ID cannot be empty.';

  @override
  String get errorSubtitleNotAString => 'Subtitle must be a string.';

  @override
  String get errorSubtitleEmpty => 'Subtitle cannot be empty.';

  @override
  String get errorShortIntroductionNotAString => 'Short introduction must be a string.';

  @override
  String get errorShortIntroductionEmpty => 'Short introduction cannot be empty.';

  @override
  String get errorExplanationEmptyArray => 'Explanation cannot be an empty array.';

  @override
  String get errorExplanationNotAnArray => 'Explanation must be an array.';

  @override
  String get errorTechniquesEmptyArray => 'Techniques cannot be an empty array.';

  @override
  String get errorTechniquesNotAnArray => 'Techniques must be an array.';

  @override
  String get errorExternalTechniqueIdNotAPositiveNumber =>
      'External technique ID must be a positive number.';

  @override
  String get errorExternalTechniqueIdNotAnInteger => 'External technique ID must be an integer.';

  @override
  String get errorExternalTechniqueIdNotANumber => 'External technique ID must be a number.';

  @override
  String get errorExternalTechniqueIdEmpty => 'External technique ID cannot be empty.';

  @override
  String get errorExerciseUnlockStyleInvalidEnum => 'Exercise unlock style is invalid.';

  @override
  String get errorExerciseUnlockStyleNotAString => 'Exercise unlock style must be a string.';

  @override
  String get errorExerciseUnlockStyleEmpty => 'Exercise unlock style cannot be empty.';

  @override
  String get errorExercisesNotAnArray => 'Exercises must be an array.';

  @override
  String get errorScaleBeforeAnswerNumberTooBig => 'Scale before answer number is too big.';

  @override
  String get errorScaleBeforeAnswerNumberTooSmall => 'Scale before answer number is too small.';

  @override
  String get errorScaleBeforeAnswerNotAnInteger => 'Scale before answer must be an integer.';

  @override
  String get errorScaleBeforeAnswerNotANumber => 'Scale before answer must be a number.';

  @override
  String get errorScaleAfterAnswerNumberTooBig => 'Scale after answer number is too big.';

  @override
  String get errorScaleAfterAnswerNumberTooSmall => 'Scale after answer number is too small.';

  @override
  String get errorScaleAfterAnswerNotAnInteger => 'Scale after answer must be an integer.';

  @override
  String get errorScaleAfterAnswerNotANumber => 'Scale after answer must be a number.';

  @override
  String get errorScaleEmpty => 'Scale cannot be empty.';

  @override
  String get errorScaleInvalidEnum => 'Scale is invalid.';

  @override
  String get errorTimeNotADateString => 'Time must be a date string.';

  @override
  String get errorEmotionNotAnArray => 'Emotion must be an array.';

  @override
  String get errorEmotionArrayContainsDuplicates => 'Emotion array contains duplicates.';

  @override
  String get errorEmotionArraySizeTooBig => 'Emotion array size is too big.';

  @override
  String get errorEmotionNotAString => 'Emotion must be a string.';

  @override
  String get errorEmotionInvalidEnum => 'Emotion is invalid.';

  @override
  String get errorPersonNotAnArray => 'Person must be an array.';

  @override
  String get errorPersonArrayContainsDuplicates => 'Person array contains duplicates.';

  @override
  String get errorPersonArraySizeTooBig => 'Person array size is too big.';

  @override
  String get errorPersonNotAString => 'Person must be a string.';

  @override
  String get errorPersonInvalidEnum => 'Person is invalid.';

  @override
  String get errorLocationNotAnArray => 'Location must be an array.';

  @override
  String get errorLocationArrayContainsDuplicates => 'Location array contains duplicates.';

  @override
  String get errorLocationArraySizeTooBig => 'Location array size is too big.';

  @override
  String get errorLocationNotAString => 'Location must be a string.';

  @override
  String get errorFoodNotAnArray => 'Food must be an array.';

  @override
  String get errorFoodArrayContainsDuplicates => 'Food array contains duplicates.';

  @override
  String get errorFoodArraySizeTooBig => 'Food array size is too big.';

  @override
  String get errorFoodNotAString => 'Food must be a string.';

  @override
  String get errorFoodInvalidEnum => 'Food is invalid.';

  @override
  String get errorNoteNotAString => 'Note must be a string.';

  @override
  String get errorNoteStringTooShort => 'Note string is too short.';

  @override
  String get errorNoteStringTooLong => 'Note string is too long.';

  @override
  String get errorMoodIdEmpty => 'Mood ID cannot be empty.';

  @override
  String get errorMoodIdNotANumber => 'Mood ID must be a number.';

  @override
  String get errorMoodIdNotAnInteger => 'Mood ID must be an integer.';

  @override
  String get errorMoodIdNotAPositiveNumber => 'Mood ID must be a positive number.';

  @override
  String get errorExternalIdNotANumberString => 'External ID must be a number string.';

  @override
  String get errorShortTitleNotAString => 'Short title must be a string.';

  @override
  String get errorShortTitleEmpty => 'Short title cannot be empty.';

  @override
  String get errorDescriptionNotAString => 'Description must be a string.';

  @override
  String get errorDescriptionEmpty => 'Description cannot be empty.';

  @override
  String get errorFunFactNotAString => 'Fun fact must be a string.';

  @override
  String get errorFunFactEmpty => 'Fun fact cannot be empty.';

  @override
  String get errorRequiredCompletionDaysNotANumber => 'Required completion days must be a number.';

  @override
  String get errorRequiredCompletionDaysNotAnInteger =>
      'Required completion days must be an integer.';

  @override
  String get errorRequiredCompletionDaysNotAPositiveNumber =>
      'Required completion days must be a positive number.';

  @override
  String get errorLengthInDaysNotANumber => 'Length in days must be a number.';

  @override
  String get errorLengthInDaysNotAnInteger => 'Length in days must be an integer.';

  @override
  String get errorLengthInDaysNotAPositiveNumber => 'Length in days must be a positive number.';

  @override
  String get errorLengthInDaysNumberTooBig => 'Length in days number is too big.';

  @override
  String get errorRelatedExternalGoalIdsNotAPositiveNumber =>
      'Related external goal IDs must be positive numbers.';

  @override
  String get errorRelatedExternalGoalIdsNotAnInteger =>
      'Related external goal IDs must be integers.';

  @override
  String get errorRelatedExternalGoalIdsNotANumber => 'Related external goal IDs must be numbers.';

  @override
  String get errorRelatedExternalGoalIdsNotAnArray => 'Related external goal IDs must be an array.';

  @override
  String get errorGoalIdEmpty => 'Goal ID cannot be empty.';

  @override
  String get errorGoalIdNotANumber => 'Goal ID must be a number.';

  @override
  String get errorGoalIdNotAnInteger => 'Goal ID must be an integer.';

  @override
  String get errorGoalIdNotAPositiveNumber => 'Goal ID must be a positive number.';

  @override
  String get errorCompletionDaysPer7DaysNotANumber =>
      'Completion days per 7 days must be a number.';

  @override
  String get errorCompletionDaysPer7DaysNotAnInteger =>
      'Completion days per 7 days must be an integer.';

  @override
  String get errorCompletionDaysPer7DaysNotAPositiveNumber =>
      'Completion days per 7 days must be a positive number.';

  @override
  String get errorCompletionDaysPer7DaysNumberTooBig =>
      'Completion days per 7 days number is too big.';

  @override
  String get errorFilePathEmpty => 'File path cannot be empty.';

  @override
  String get errorFilePathNotAString => 'File path must be a string.';

  @override
  String get errorCategoryIdEmpty => 'Category ID cannot be empty.';

  @override
  String get errorCategoryIdNotANumber => 'Category ID must be a number.';

  @override
  String get errorCategoryIdNotAnInteger => 'Category ID must be an integer.';

  @override
  String get errorCategoryIdNotAPositiveNumber => 'Category ID must be a positive number.';

  @override
  String get errorTimesNotAnInteger => 'Times must be an integer.';

  @override
  String get errorTimesNumberTooSmall => 'Times number is too small.';

  @override
  String get errorReviewIdEmpty => 'Review ID cannot be empty.';

  @override
  String get errorReviewIdNotANumber => 'Review ID must be a number.';

  @override
  String get errorReviewIdNotAnInteger => 'Review ID must be an integer.';

  @override
  String get errorReviewIdNotAPositiveNumber => 'Review ID must be a positive number.';

  @override
  String get errorProgressNotAnArray => 'Progress must be an array.';

  @override
  String get errorProgressEmptyArray => 'Progress cannot be an empty array.';

  @override
  String get errorDifficultyNotANumber => 'Difficulty must be a number.';

  @override
  String get errorDifficultyNotAnInteger => 'Difficulty must be an integer.';

  @override
  String get errorDifficultyNotAPositiveNumber => 'Difficulty must be a positive number.';

  @override
  String get errorDifficultyNumberTooBig => 'Difficulty number is too big.';

  @override
  String get errorIsTryAgainNotABoolean => 'Is try again must be a boolean.';

  @override
  String get errorSmartGoalIdEmpty => 'Smart goal ID cannot be empty.';

  @override
  String get errorSmartGoalIdNotANumber => 'Smart goal ID must be a number.';

  @override
  String get errorSmartGoalIdNotAnInteger => 'Smart goal ID must be an integer.';

  @override
  String get errorSmartGoalIdNotAPositiveNumber => 'Smart goal ID must be a positive number.';

  @override
  String get errorStartedAtEmpty => 'Started at cannot be empty.';

  @override
  String get errorStartedAtNotAString => 'Started at must be a string.';

  @override
  String get errorStartedAtNotADateString => 'Started at must be a date string.';

  @override
  String get errorReasonInvalidEnum => 'Reason is invalid.';

  @override
  String get errorSessionIdEmpty => 'Session ID cannot be empty.';

  @override
  String get errorProgressIdEmpty => 'Progress ID cannot be empty.';

  @override
  String get errorProgressIdNotANumber => 'Progress ID must be a number.';

  @override
  String get errorProgressIdNotAnInteger => 'Progress ID must be an integer.';

  @override
  String get errorProgressIdNotAPositiveNumber => 'Progress ID must be a positive number.';

  @override
  String get errorCoreAccountIdFailedToSendMessage => 'Core account ID failed to send message.';

  @override
  String get errorCoreRequestNeedToBeRefetched => 'Request needs to be refetched.';

  @override
  String get errorCoreMvpAccessDenied => 'MVP access denied.';

  @override
  String get errorCoreAccountIdCanNotParse => 'Account ID cannot be parsed.';

  @override
  String get errorCoreAccountIdNotAuthenticated => 'Account ID not authenticated.';

  @override
  String get errorCoreEmailOrPasswordAreIncorrect => 'Email or password are incorrect.';

  @override
  String get errorCoreEmailNotApproved => 'Email not approved.';

  @override
  String get errorCoreRefreshTokenHasBeenExpired => 'Refresh token has been expired.';

  @override
  String get errorCorePasswordTokenNotFound => 'Password token not found.';

  @override
  String get errorCorePasswordTokenExpired => 'Password token expired.';

  @override
  String get errorAuthAccessTokenInvalid => 'Auth access token is invalid.';

  @override
  String get errorAuthRefreshTokenNotFound => 'Auth refresh token not found.';

  @override
  String get errorAccountEmailOrPasswordInvalid =>
      'We were unable to update your email address. Please check your credentials and try again';

  @override
  String get errorAccountIdAlreadyExists => 'This email address is incorrect or already taken.';

  @override
  String get errorAccountIdNotFound => 'Account ID not found.';

  @override
  String get errorAccountEmailNotFound => 'Email or password are incorrect.';

  @override
  String get errorAccountInvitationNotFound => 'Account invitation not found.';

  @override
  String get errorAccountEmailTokenNotFound => 'Account email token not found.';

  @override
  String get errorAccountPasswordTokenNotFound => 'Account password token not found.';

  @override
  String get errorAccountPasswordTokenExpired => 'Account password token expired.';

  @override
  String get errorAccountEmailExpired => 'Account email expired.';

  @override
  String get errorAccountEmailPreviouslySubmitted => 'Account email previously submitted.';

  @override
  String get errorAccountDiabetesTypeNotFound => 'Account diabetes type not found.';

  @override
  String get errorAccountSubscriptionCancelActive => 'Account subscription cancel active.';

  @override
  String get errorAccountPasswordTokenInvalid => 'Account password token is invalid.';

  @override
  String get errorCoreFileInvalid => 'Core file is invalid.';

  @override
  String get errorAccountEmailLessThanADayFromLastChange =>
      'Account email change must be more than a day ago.';

  @override
  String get errorPurchaseVerificationError =>
      'Something went wrong with verification subscription, please try restore';

  @override
  String get errorSubscriptionIdAbsent => 'Subscription ID is absent.';

  @override
  String get errorSubscriptionIosProductIdNotFound => 'Subscription iOS product ID not found.';

  @override
  String get errorSubscriptionAndroidProductIdNotFound =>
      'Subscription Android product ID not found.';

  @override
  String get errorSubscriptionAccountIdAbsent => 'Subscription account ID is absent.';

  @override
  String get errorSubscriptionPurchaseTokenAbsent => 'Subscription purchase token is absent.';

  @override
  String get errorSubscriptionPackageNameInvalid => 'Subscription package name is invalid.';

  @override
  String get errorSubscriptionAccountIdInvalid =>
      'It looks like your Apple ID already has a subscription on another LeanOnMe account. Please log in with that email address to use your subscription. If you need assistance, please contact support@lean-on.me';

  @override
  String get errorSubscriptionVendorInvalid => 'Subscription vendor is invalid.';

  @override
  String get errorSubscriptionPurchaseTokenInvalid => 'Subscription purchase token is invalid.';

  @override
  String get errorSubscriptionEnvironmentInvalid => 'Subscription environment is invalid.';

  @override
  String get errorSubscriptionBaseTransactionIdInvalid =>
      'Subscription base transaction ID is invalid.';

  @override
  String get errorSubscriptionTransactionIdInvalid => 'Subscription transaction ID is invalid.';

  @override
  String get errorSubscriptionAndroidDataEmpty => 'Subscription Android data is empty.';

  @override
  String get errorSubscriptionWithAccountNotFound => 'Subscription with account not found.';

  @override
  String get errorGroupingAccountIdAppFeatureLocked => 'Grouping account ID app feature is locked.';

  @override
  String get errorGroupingDataOneOptionalFieldRequired =>
      'Grouping data requires one optional field.';

  @override
  String get errorGroupingGenderPreferenceInvalid => 'Grouping gender preference is invalid.';

  @override
  String get errorGroupingBmiRangeCanNotCalculate => 'Grouping BMI range cannot be calculated.';

  @override
  String get errorGroupingAgeRangeCanNotCalculate => 'Grouping age range cannot be calculated.';

  @override
  String get errorGroupingAccountGroupingStateCanNotCancel =>
      'Grouping account grouping state cannot be canceled.';

  @override
  String get errorGroupingGroupIdNotFound => 'Grouping group ID not found.';

  @override
  String get errorGroupingAccountIdAlreadyInGroup => 'Account ID is already in the group.';

  @override
  String get errorBuddyAccountAlreadyHaveABuddy => 'Account already has a buddy.';

  @override
  String get errorBuddyEntityNotFound => 'Buddy entity not found.';

  @override
  String get errorBuddyRefreshTokenNotFound => 'Buddy refresh token not found.';

  @override
  String get errorBuddyRegistrationAlreadyExists => 'Buddy registration already exists.';

  @override
  String get errorBuddyRegistrationAlreadyConfirmed => 'Buddy registration already confirmed.';

  @override
  String get errorBuddyPasswordTokenInvalid => 'Buddy password token is invalid.';

  @override
  String get errorBuddyRegistrationTokenExpired => 'Buddy registration token has expired.';

  @override
  String get errorBuddyRegistrationTokenInvalid => 'Buddy registration token is invalid.';

  @override
  String get errorBuddyInvitationTokenExpired => 'Buddy invitation token has expired.';

  @override
  String get errorBuddyInvitationTokenInvalid => 'Buddy invitation token is invalid.';

  @override
  String get errorBuddyInvitationEmailInvalid => 'Buddy invitation email is invalid.';

  @override
  String get errorBuddyInvitationNotFound => 'Buddy invitation not found.';

  @override
  String get errorBuddyInvitationHasBeenRejected => 'Buddy invitation has been rejected.';

  @override
  String get errorBuddyInvitationAlreadyApproved => 'Buddy invitation has already been approved.';

  @override
  String get errorBuddyInvitationBuddyOccupied =>
      'Sorry, this person isn’t available for the buddy program. Can you think of someone else who could help you? Reach out to support if you need a hand';

  @override
  String get errorDiabetesTypeNotFound => 'Diabetes type not found.';

  @override
  String get errorNutritionMealIdNotFound => 'Nutrition meal ID not found.';

  @override
  String get errorNutritionMealFoodItemIdNotFound => 'Nutrition meal food item ID not found.';

  @override
  String get errorNutritionMealRecipeIdNotFound => 'Nutrition meal recipe ID not found.';

  @override
  String get errorNutritionMealDishIdNotFound => 'Nutrition meal dish ID not found.';

  @override
  String get errorNutritionFavoriteFoodItemIdNotFound =>
      'Nutrition favorite food item ID not found.';

  @override
  String get errorNutritionFavoriteServingIdNotFound => 'Nutrition favorite serving ID not found.';

  @override
  String get errorNutritionFavoriteAccountIdNotFound => 'Nutrition favorite account ID not found.';

  @override
  String get errorNutritionFavoriteAlreadyExists => 'Nutrition favorite already exists.';

  @override
  String get errorNutritionWeightLogNotFound => 'Nutrition weight log not found.';

  @override
  String get errorNutritionRecipeIdNotFound => 'Nutrition recipe ID not found.';

  @override
  String get errorNutritionAccountDishesNotFound => 'Nutrition account dishes not found.';

  @override
  String get errorNutritionDishNotFound => 'Nutrition dish not found.';

  @override
  String get errorNutritionDishFoodItemNotFound => 'Nutrition dish food item not found.';

  @override
  String get errorNutritionDishMealRecipeNotFound => 'Nutrition dish meal recipe not found.';

  @override
  String get errorNutritionDishFoodItemsEmpty => 'Nutrition dish food items are empty.';

  @override
  String get errorFoodPreferencesHateTagNotFound => 'Food preferences hate tag not found.';

  @override
  String get errorFoodPreferencesAllergenTagNotFound => 'Food preferences allergen tag not found.';

  @override
  String get errorFoodPreferencesDislikeTagNotFound => 'Food preferences dislike tag not found.';

  @override
  String get errorMentalHealthQuestionIdInvalid => 'Mental health question ID is invalid.';

  @override
  String get errorMentalHealthOptionIdInvalid => 'Mental health option ID is invalid.';

  @override
  String get errorMentalHealthTypeInvalid => 'Mental health type is invalid.';

  @override
  String get errorMedicalOnboardingQuestionTypeInvalid =>
      'Medical onboarding question type is invalid.';

  @override
  String get errorPhysicalActivitiesPhysicalProgramIdNotFound => 'Physical program ID not found.';

  @override
  String get errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound =>
      'Physical program exercise ID not found.';

  @override
  String get errorPhysicalActivitiesPreferencesNotFound =>
      'Physical activities preferences not found.';

  @override
  String get errorRiverModuleNotFound => 'River module not found.';

  @override
  String get errorRiverModuleItemNotFound => 'River module item not found.';

  @override
  String get errorEducationLessonNotFound => 'Education lesson not found.';

  @override
  String get errorEducationQuizUpdateNotAllowed => 'Education quiz update not allowed.';

  @override
  String get errorEducationQuizSubmitNotFound => 'Education quiz submit not found.';

  @override
  String get errorEducationQuizAlreadySubmitted => 'Education quiz already submitted.';

  @override
  String get errorEducationQuizOptionNotFound => 'Education quiz option not found.';

  @override
  String get errorEducationQuizNotFound => 'Education quiz not found.';

  @override
  String get errorEducationReflectionNotFound => 'Education reflection not found.';

  @override
  String get errorEducationReflectionOptionNotFound => 'Education reflection option not found.';

  @override
  String get errorEducationReflectionFeedbackNotFound => 'Education reflection feedback not found.';

  @override
  String get errorEducationReflectionAlreadySubmitted => 'Education reflection already submitted.';

  @override
  String get errorEducationReflectionFeedbackAlreadySubmitted =>
      'Education reflection feedback already submitted.';

  @override
  String get errorNutritionPlannedMealIdNotFound => 'Nutrition planned meal ID not found.';

  @override
  String get errorNutritionPlannedMealDateInvalid => 'Nutrition planned meal date is invalid.';

  @override
  String get errorGroupSessionIdNotFound => 'Group session ID not found.';

  @override
  String get errorGroupSessionAccountIdNotGrouped => 'Account ID is not grouped in the session.';

  @override
  String get errorGroupSessionAccountIdNotFound => 'Group session account ID not found.';

  @override
  String get errorGroupSessionAccountIdAlreadySigned =>
      'Account ID is already signed in the session.';

  @override
  String get errorGroupSessionAccountIdWasNotSigned => 'Account ID was not signed in the session.';

  @override
  String get errorGroupSessionProgramImageNotFound => 'Group session program image not found.';

  @override
  String get errorGroupSessionProgramImageInvalidMimeType =>
      'Group session program image has an invalid MIME type.';

  @override
  String get errorGroupSessionStatusMismatchUpdateFlow =>
      'Group session status mismatch in update flow.';

  @override
  String get errorChatAccountIdNotAssignedToGroup =>
      'Chat account ID is not assigned to the group.';

  @override
  String get errorChatMessageIdNotFound => 'Chat message ID not found.';

  @override
  String get errorMindTechniqueIdNotFound => 'Mind technique ID not found.';

  @override
  String get errorMindExerciseIdNotFound => 'Mind exercise ID not found.';

  @override
  String get errorMoodIdNotFound => 'Mood ID not found.';

  @override
  String get errorMoodCreatedAyIsOld => 'Mood created day is too old.';

  @override
  String get errorSmartGoalStartDateActiveSessionExists =>
      'Smart goal start date has an active session.';

  @override
  String get errorSmartGoalIdNotFound => 'Smart goal ID not found.';

  @override
  String get errorSmartGoalSessionIdNotFound => 'Smart goal session ID not found.';

  @override
  String get errorSmartGoalReviewIdNotFound => 'Smart goal review ID not found.';

  @override
  String get errorSmartGoalProgressLogsInvalid => 'Smart goal progress logs are invalid.';

  @override
  String get errorSmartGoalCategoryIdsLocked => 'Smart goal category IDs are locked.';

  @override
  String get errorSmartGoalCategoryIdLocked => 'Smart goal category ID is locked.';

  @override
  String get errorSmartGoalSessionIdActiveLimitExceeded =>
      'Smart goal session ID active limit exceeded.';

  @override
  String get errorSmartGoalCategoryIdNotFound => 'Smart goal category ID not found.';

  @override
  String get errorSmartGoalIdConflictsWithActive => 'Smart goal ID conflicts with an active one.';

  @override
  String get errorSmartGoalIdDuplicatesFound => 'Duplicate smart goal IDs found.';

  @override
  String get errorCoreInternalServer => 'Internal server error.';

  @override
  String get errorRetry => 'Retry';

  @override
  String get errorNoConnectionTitle => 'No connection';

  @override
  String get errorNoConnectionText =>
      'Your internet connection was interrupted. \nRestore the connection and try again';

  @override
  String get errorInvalidIngredientText => 'Sorry, invalid ingredients data';

  @override
  String get errorOeps => 'Oops!';

  @override
  String get errorSomethingWentWrong => 'Something went wrong \nPlease try again later';

  @override
  String get errorSubscriptionServiceUnavailable =>
      'Something went wrong with service, please try again';

  @override
  String get errorPurchaseStreamError =>
      'Something went wrong with stream subscription, please try again';

  @override
  String get errorPurchaseErrorMessage => 'Product was not purchased, please try again';

  @override
  String get errorSomethingIsIncorrect => 'Something is incorrect or missing';

  @override
  String get errorServingIdIsNotFound => 'Sorry, invalid ingredients data';

  @override
  String get errorSocketException => 'Something went wrong with socket';

  @override
  String get errorParsingException => 'Something is incorrect or missing in data';

  @override
  String get errorLoadTranslations => 'Error loading translations';

  @override
  String get errorTimeoutDio => 'Something went wrong.';

  @override
  String get errorConnectionDio =>
      'Your internet connection was interrupted. \nRestore the connection and try again';

  @override
  String get errorRequestCancelledDio => 'Something went wrong.';

  @override
  String get errorBadRequestDio => 'Something went wrong.';

  @override
  String get errorUnauthorizedDio => 'Something went wrong.';

  @override
  String get errorForbiddenDio => 'Something went wrong.';

  @override
  String get errorNotFoundDio => 'Something went wrong.';

  @override
  String get errorConflictDio => 'Something went wrong.';

  @override
  String get errorServerErrorDio => 'Something went wrong.';

  @override
  String get errorUnprocessableEntityDio => 'Something went wrong.';

  @override
  String get errorUnhandledResponseDio => 'Something went wrong.';

  @override
  String get errorUnhandledErrorDio => 'Something went wrong.';

  @override
  String get errorOtherDio => 'Something went wrong';

  @override
  String get onboardingIntroTitle => 'LeanOnMe gives you the tools to lose weight sustainably.';

  @override
  String get onboardingIntroProgram1 =>
      'Based on a psychology driven program which successfully helped people to lose weight and feel better, long term.';

  @override
  String get onboardingIntroProgram2 =>
      'Nutrition, physical activity, medical knowledge, and community support combine with psychology to help you reach your goals.';

  @override
  String get onboardingIntroMissionTitle =>
      'Our team of experts  brings the success of the clinical program to you!';

  @override
  String get onboardingIntroMissionAndrew =>
      'Andrew has a PHD in Bio-Chemistry and is the brains behind our nutrition program. With curated recipes, customized goals, and NO FOCUS ON CALORIE TRACKING, our nutrition program is one-of-a-kind.';

  @override
  String get onboardingIntroMissionMaria =>
      'Maria has an MSc in Digital Psychology, and is the link between the successful clinical program and our digitalized version.';

  @override
  String get onboardingIntroMissionShalu =>
      'Shalu is an MD specialized in Psychiatry. With her focus on addiction and addictive-behaviors, she is intrinsically qualified to oversee and encourage your journey to happier, healthier lifestyle.';

  @override
  String get onboardingIntroMissionJoshua =>
      'With a love for sports and the human body, Josh has a Sports Science degree and years of experience as a physiotherapist focusing on weight loss. He\'s great at helping people move better and feel their best.';

  @override
  String get onboardingIntroMissionDenise =>
      'Denise is an experienced clinical psychologist, who is also trained in Cognitive Behaviour Therapy, Meditation, and Mindfulness Based Therapy. Her passion is to give people the courage to change, and to guide them through the process step-by step.';

  @override
  String get onboardingPacingTitle => 'Go slow to go fast.';

  @override
  String get onboardingPacingMessage =>
      'Our program is split up into modules, called “pools”. You should aim to spend a minimum of 1 week in each pool, absorbing knowledge and practicing new habits.';

  @override
  String get onboardingIAmReady => 'I’m ready';

  @override
  String get onboardingPhysicalIntroTitle => 'Basics first';

  @override
  String get onboardingPhysicalIntroBody =>
      'Joshua needs to know the answers to some basics so we can customize your program.';

  @override
  String get onboardingAgeCheckFailedTitle =>
      'We are sorry. Unfortunately, your enrollment is not possible now.';

  @override
  String get onboardingAgeCheckFailedBody =>
      'Our program is not set up for people under the age of 18';

  @override
  String get onboardingWhatYourSex => 'What is your sex?';

  @override
  String get onboardingSexQuestionBody =>
      'Please indicate what biological sex should be used to calculate certain metrics that will help to properly tailor the program to you.';

  @override
  String get onboardingSex => 'Sex';

  @override
  String get onboardingGenderPageTitle => 'What is your gender?';

  @override
  String get onboardingHappinessTitle => 'How do you feel about your current lifestyle?';

  @override
  String get onboardingHappinessBody1 => 'Take a moment to reflect on your lifestyle right now.';

  @override
  String get onboardingHappinessBody2 =>
      'Using the scale below, please indicate how you generally feel, when you think about your current lifestyle.';

  @override
  String get onboardingYourHeight => 'Your height';

  @override
  String get onboardingMetric => 'Metric';

  @override
  String get onboardingImperial => 'Imperial';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingChangeYourHeight => 'Change your height';

  @override
  String get onboardingHeightSmall =>
      'Are you sure this is the correct height? Seems rather small. Please correct your input';

  @override
  String get onboardingHeightLarge =>
      'Are you sure this is the correct height? Seems rather large. Please correct your input';

  @override
  String get onboardingCorrectHeight => 'Please correct your answer';

  @override
  String get onboardingYourWeight => 'Your weight';

  @override
  String get onboardingBmiExclusionBodyTitle => 'Body Mass Index (BMI) is:';

  @override
  String get onboardingHighBmiDescription1 =>
      'LeanOnMe currently has customized programs to support people with a BMI between 25 and 40. We are working on additional customizations to help support people who are outside this BMI range, but we’re not quite there yet.';

  @override
  String get onboardingHighBmiDescription2 =>
      'Some parts of our current program may not be 100% tailored to your needs.';

  @override
  String get onboardingHighBmiDescription3 =>
      'Listen to your body, and if you have any concerns that something is not right for you, please contact support@lean-on.me.';

  @override
  String get onboardingLowerBmiDescription1 =>
      'According to your BMI, you’re within a healthy range, that’s great! But LeanOnMe’s program is designed to support people living with various degrees of overweight and obesity.';

  @override
  String get onboardingLowerBmiDescription2 =>
      'None of our content is bad for you! But some may not feel as relevant. Enjoy!';

  @override
  String get onboardingBmiExclusionBody1 =>
      'Your BMI indicates that you may be underweight. LeanOnMe is currently a weight-loss program. In respect to your current BMI, additional weight-loss could affect your health.';

  @override
  String get onboardingBmiExclusionBody2 =>
      'Please consult to your GP to make sure that your health is not being affected.';

  @override
  String get onboardingPhysicalCheckPassedTitle => 'Basics completed!';

  @override
  String get onboardingAge => 'Age';

  @override
  String get onboardingHeight => 'Height';

  @override
  String get onboardingWeight => 'Weight';

  @override
  String get onboardingBmi => 'BMI';

  @override
  String get onboardingYears => 'years';

  @override
  String get onboardingBmiDescription1 =>
      'The Body Mass Index (BMI) is a measure  that uses your height and weight to calculate if your weight for your body is within a healthy range';

  @override
  String get onboardingBmiDescriptionAccent => 'Body Mass Index (BMI)';

  @override
  String get onboardingBmiDescription2 =>
      'However, BMI has limitations - for example it can\'t differentiate between fat, muscle, and bone weight. We\'ll use it along with other metrics to customize your program, but don\'t worry: It won\'t be the only factor that is taken into account';

  @override
  String get onboardingLetsMoveOn => 'Let’s move on';

  @override
  String get onboardingMedicalIntroTitle => 'Medical check';

  @override
  String get onboardingMedicalIntroBody =>
      'To ensure that this program is suitable for your current circumstances and to tailor it specifically to you, please answer the next set of questions regarding your health conditions.';

  @override
  String get onboardingAreYouPregnant => 'Are you pregnant?';

  @override
  String get onboardingFailedPregnancyTitle =>
      'We are sorry. Unfortunately, your enrollment is not possible for now.';

  @override
  String get onboardingFailedPregnancyBody1 => 'You are having a baby.';

  @override
  String get onboardingFailedPregnancyBody2 =>
      'This program is not suitable for people who are pregnant.';

  @override
  String get onboardingFailedPregnancyBody3 =>
      'We would be happy to welcome you back here after your pregnancy.';

  @override
  String get onboardingFailedPregnancyBody4 =>
      'Wishing you all the best for you and your baby-to-be!';

  @override
  String get onboardingMedicinesTitle => 'Which medicines do you take regularly?';

  @override
  String get onboardingMedicinesPlaceholder => 'Write down one medicine here';

  @override
  String get onboardingWeightLossMedicationQuestion =>
      'Are you taking any medication to help you on your weight-loss journey?';

  @override
  String get onboardingObesityQuestion =>
      'Have you been diagnosed with a secondary form of obesity (e.g. Cushing syndrome, Prader-Willi syndrome or hypogonadism)?';

  @override
  String get onboardingThyroidDiseaseQuestion =>
      'Have you been diagnosed with a thyroid disease (e.g. Hashimoto’s disease or hypothyroidism)?';

  @override
  String get onboardingMetabolicDiseaseQuestion =>
      'Have you been diagnosed with a form of metabolic disease?';

  @override
  String get onboardingHypertensionQuestion => 'Have you been diagnosed with hypertension?';

  @override
  String get onboardingCardiovascularDiseaseQuestion =>
      'Have you been diagnosed with a cardiovascular disease or did you have heart surgery in the last 12 months?';

  @override
  String get onboardingStomachReductionQuestion =>
      'Did you have a stomach reduction or bariatric surgery in the last 3 years or are you in a preparatory phase for such surgery?';

  @override
  String get onboardingDiabetesQuestion => 'Have you been diagnosed with diabetes?';

  @override
  String get onboardingRenalFailureQuestion => 'Have you been diagnosed with renal failure?';

  @override
  String get onboardingAsthmaQuestion => 'Have you been diagnosed with asthma or COPD?';

  @override
  String get onboardingLiverDiseaseQuestion =>
      'Have you been diagnosed with hepatitis or liver disease?';

  @override
  String get onboardingSleepApneaSyndromeQuestion =>
      'Have you been diagnosed with sleep apnea syndrome?';

  @override
  String get onboardingLocomotorSystemDiseaseQuestion =>
      'Have you been diagnosed with any disease of the locomotor system (e.g. arthritis, osteoporosis, back/neck pains or inflammatory disease)?';

  @override
  String get onboardingTreatmentByTheDoctorQuestion =>
      'Are you currently being treated by a psychologist or psychiatrist?';

  @override
  String get onboardingMedicalCheckPassedTitle => 'Medical check completed!';

  @override
  String get onboardingMedicalCheckPassedBody =>
      'You already completed 2 out of 3 sections. Great, you’re nearly done!';

  @override
  String get onboardingMedicalCheckFailedTitle => 'Please check with your doctor or specialist!';

  @override
  String get onboardingMedicalCheckFailedBody =>
      'Please ask your doctor, specialist or psychologist before you use this app if it fits to your medical condition and / or treatment of:';

  @override
  String get onboardingMedicalCheckFailedBody2 =>
      'Please note, we additionally offer support groups. If you would like to take part in one of these groups later on in the program, you will need permission from your psychologist/psychiatrist first';

  @override
  String get onboardingCardioVascularDisease => 'Cardiovascular disease';

  @override
  String get onboardingStomachReductionDisease => 'Stomach reduction disease';

  @override
  String get onboardingObesity => 'Obesity disease';

  @override
  String get onboardingThyroidDisease => 'Thyroid disease';

  @override
  String get onboardingMetabolicDisease => 'Metabolic disease';

  @override
  String get onboardingHypertension => 'Hypertension';

  @override
  String get onboardingDiabetes => 'Diabetes disease';

  @override
  String get onboardingDiabetesTypeI => 'Diabetes type I disease';

  @override
  String get onboardingDiabetesTypeII => 'Diabetes type II disease';

  @override
  String get onboardingRenalFailure => 'Renal failure';

  @override
  String get onboardingAsthma => 'Asthma';

  @override
  String get onboardingLiverDisease => 'Liver disease';

  @override
  String get onboardingSleepApneaSyndrome => 'Sleep apnea syndrome';

  @override
  String get onboardingLocomotorSystemDisease => 'Locomotor system disease';

  @override
  String get onboardingMentalHealth => 'Mental health';

  @override
  String get onboardingMentalIntroBody1 =>
      'In this section you will be asked questions regarding your current well-being, physiological symptoms and mood.';

  @override
  String get onboardingMentalIntroBody2 =>
      'Based on these results, the program will be adjusted to suit your needs.';

  @override
  String get onboardingYourMentalHealth => 'Your mental health';

  @override
  String get onboardingMentalHealthIntroTextOne =>
      'A good mental health is vital to successfully improve your lifestyle.';

  @override
  String get onboardingMentalHealthIntroTextTwo => 'This section will take around 15 minutes.';

  @override
  String get onboardingMentalHealthIntroTextTwoAccent => '15 minutes';

  @override
  String get onboardingMentalHealthIntroTextThree =>
      'You can take a break in between as long as you finish this section within one hour.';

  @override
  String get onboardingMentalHealthIntroTextThreeAccent => 'within one hour';

  @override
  String get onboardingMentalHealthIntroTextFour =>
      'If you do take more than an hour, you will need to start this section over again.';

  @override
  String get onboardingMentalHealthIntroTextFive =>
      'You will receive your results immediately after the questions.';

  @override
  String get onboardingMentalHealthIntroTextSix =>
      'Please note that these test results are not a diagnosis. A diagnosis can only be made by a doctor or psychologist.';

  @override
  String onboardingMentalHealthMoreInfo(String appName) {
    return 'In this section you will be asked questions from scientifically validated questionnaires, carefully chosen by our clinical psychologist. \n\nIf you would like to get more information on the questionnaires that are used, please contact $appName.';
  }

  @override
  String get onboardingMentalHealthMoreInfoBold1 => 'scientifically validated questionnaires';

  @override
  String get onboardingMentalHealthMoreInfoBold2 => 'our clinical psychologist';

  @override
  String get onboardingWho8Question =>
      'Please indicate for each of the given statements which is closest to how you have been feeling over the last two weeks.';

  @override
  String get onboardingLastTwoWeeks => 'last two weeks';

  @override
  String get onboardingPastFourWeeks => 'past four weeks';

  @override
  String get onboardingPhq15Question =>
      'During the past four weeks, how much have you been bothered by any of the following problems?';

  @override
  String get onboardingPhq8Question =>
      'Over the last two weeks, how often have you been bothered by any of the following problems?';

  @override
  String get onboardingStartAgain => 'Start again';

  @override
  String get onboardingWho5ResultTestMinimal =>
      'Regarding your general well-being, you have indicated that in the last two weeks your well-being has been severely limited, and you have felt unwell most of the time. If you feel unwell for a longer period, we recommend that you consult a psychologist or your doctor to check these symptoms. You can find psychologists here:';

  @override
  String get onboardingWho5ResultTestHigh =>
      'In terms of your general well-being, you indicated that you have generally felt balanced, joyful, and relaxed over the past two weeks. This result indicates a good state of well-being.';

  @override
  String get onboardingPhq15ResultMinimal =>
      'You have stated that you have had no or few physical ailments in the last four weeks. That’s great.';

  @override
  String get onboardingPhq15ResultMild =>
      'You have stated that you have been bothered by a few physical problems in the last four weeks. Mild physical problems can also be a sign of stress. It could be helpful to reduce stress. \nTo clarify whether these ailments are related to stress, please consult your doctor.';

  @override
  String get onboardingPhq15ResultMedium =>
      'You have stated that a number of physical ailments have bothered you over the past four weeks. A consultation with your doctor is recommended to check whether these are temporary. The symptoms can be a reaction of your body to stress or emotional issues.';

  @override
  String get onboardingPhq15ResultHigh =>
      'You have stated that many physical ailments have bothered you in the last four weeks. Please consult your doctor to check these symptoms. These symptoms may have a medical cause or indicate a somatization disorder. \n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:';

  @override
  String get onboardingGad7ResultMinimal =>
      'You have stated that you were at ease most of the time in the last two weeks. Your everyday life is not affected by anxiety. Great, keep it up.';

  @override
  String get onboardingGad7ResultMild =>
      'You have stated that in the last two weeks you have had problems to relax from time to time. You may also have felt nervous, anxious, or on edge. Don’t be concerned about it. These may be temporary symptoms. Give yourself a break to relax more often. \nBut if the symptoms worsen, we recommend consulting your doctor or a psychologist.';

  @override
  String get onboardingGad7ResultMedium =>
      'You have stated that you have felt nervous or anxious more than half the time in the last two weeks. You may also have not been able to stop or control worrying. This can be a burden for you in your daily life.\n\nIf the symptoms persist or worsen, we recommend consulting your doctor or a psychologist.';

  @override
  String get onboardingGad7ResultHigh =>
      'You have stated that you have felt nervous or anxious nearly every day in the last two weeks. You may also have not been able to stop or control worrying. These symptoms could indicate an anxiety disorder.\n\nIn order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:';

  @override
  String get onboardingPhq8ResultMinimal =>
      'You have stated that your mood was not affected most days in the last two weeks. Great, keep it up and look out for all the positive things you will come across on your journey.';

  @override
  String get onboardingPhq8ResultMild =>
      'You have stated that in the last two weeksYou have stated that in the last two weeks you have felt down from time to time. You may also have had feelings of hopelessness or a lack of energy. Throughout the LeanOnMe program, you will learn about the connection between thoughts and feelings and what you can do to improve your mental health.\nIf the symptoms worsen, we recommend a consultation with a psychologist or your doctor.';

  @override
  String get onboardingPhq8ResultMedium =>
      'You have stated that you have been depressed more than half the time in the last two weeks. You may also have had feelings of hopelessness or have felt down. Throughout the LeanOnMe program, you will learn about the connection between thoughts and feelings and what you can do to improve your mental health.\nIf the symptoms persist or worsen, we recommend a consultation with a psychologist or your doctor.';

  @override
  String get onboardingPhq8ResultHigh =>
      'You have stated that your mood has often been significantly affected in the last two weeks. You have indicated that you have felt depressed and have often suffered from listlessness or dejection. The symptoms indicate current psychological distress with emotional impairment. These may be indications of a temporary depressive episode. \n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:';

  @override
  String get onboardingPhq8ResultHighest =>
      'You have stated that your mood has been significantly affected almost every day for the past two weeks. You have indicated that you have felt depressed and have often or constantly suffered from listlessness or dejection. These symptoms currently indicate a high level of psychological distress with emotional impairment and could be an indication of depression.\n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor and a clarification by a psychologist. You can find addresses here:';

  @override
  String get onboardingPhq8FinalResultHigh1 =>
      'The questionnaire results indicate that you are currently experiencing notable mental distress.';

  @override
  String get onboardingPhq8FinalResultHigh2 =>
      'Unfortunately, the program is not suitable for people who are currently experiencing considerable mental distress, as participation in this program could place additional stress on you.';

  @override
  String get onboardingPhq8FinalResultHigh3 =>
      'In order to have a closer look at these symptoms and to treat them, we recommend consulting a psychologist. You can find addresses here:';

  @override
  String get onboardingPhq8FinalResultHigh4 =>
      'We invite you to repeat the test when these symptoms have subsided so that you can focus all your energy on your weight-loss journey.';

  @override
  String get onboardingIfYouHaveSuicidalThoughts =>
      'If you are in an acute crisis or having suicidal thoughts, please contact one of the 24-hour toll-free emergency numbers immediately:';

  @override
  String get onboardingPersonalProgram =>
      'Based on your information, we tailor the program to you personally.';

  @override
  String get onboardingSupportMessage =>
      'We would like to support you on your journey in the best possible way and tailor the program to you personally.';

  @override
  String get onboardingFeelLimited1 =>
      'It turned out that you currently feel limited by anxiety and physical symptoms. We recommend you talk to a primary care physician or psychologist.';

  @override
  String get onboardingFeelLimited2 =>
      'It turned out that you currently feel limited by physical symptoms. We recommend you talk to a primary care physician or psychologist.';

  @override
  String get onboardingFeelLimited3 =>
      'It turned out that you currently feel limited by anxiety symptoms. We recommend you talk to a primary care physician or psychologist.';

  @override
  String get onboardingFeelLimited4 =>
      'It turned out that you are troubled in several areas at the moment.';

  @override
  String get onboardingNotATherapy => 'Please keep in mind that LeanOnMe is not a therapy.';

  @override
  String get onboardingLearnManyThings =>
      'However, you will learn many things that will support you in your mental and physical well-being.';

  @override
  String get onboardingUnlockAllSections => 'You will have access to all sections of the program.';

  @override
  String get onboardingAwailableAreas =>
      'The following areas will be available to you as you progress through the program:';

  @override
  String get onboardingUnlockBuddyMessage => 'Find a Buddy and get into a Support Group';

  @override
  String get onboardingWeWillGuideYou =>
      'We will guide you step by step in your weight-loss journey.\n\nHave fun with exploring!';

  @override
  String get onboardingPhq8Fail =>
      'We are sorry! Unfortunately, your enrollment is not possible now.';

  @override
  String get onboardingGeneralWellBeingSummary => 'General well-being summary';

  @override
  String get onboardingBodyAndMindBalanceSummary => 'Body and mind balance summary';

  @override
  String get onboardingStateOfMindSummary => 'State of mind summary';

  @override
  String get onboardingCheckCompleted => 'Check completed!';

  @override
  String get onboardingYouExceededTimeMessage =>
      'Sorry, but you exceeded the time limit of one hour';

  @override
  String get onboardingNoWorriesYouCanDoItLater => 'But don’t worry, you can start over';

  @override
  String get onboardingMentalResultSubText1 =>
      'You’ve completed the first part. Keep going. You’re doing great!';

  @override
  String get onboardingMentalResultSubText2 =>
      'You\'re breezing through these questions. Nicely done! You’ve reached the halfway point!';

  @override
  String get onboardingMentalResultSubText3 => 'Three down, one to go! Just a few last questions!';

  @override
  String get avatarAvatar => 'Avatar';

  @override
  String get avatarSelectProfilePicture => 'Select your profile picture';

  @override
  String get avatarMoveToResize => 'move to resize';

  @override
  String get avatarChooseYourAvatar => 'Choose your avatar';

  @override
  String get avatarAddPhoto => 'Add photo';

  @override
  String get avatarSizeErrorMessageTitle =>
      'Oops! It looks like the picture you’re trying to upload is over the 10 MB size limit.';

  @override
  String get avatarSizeErrorMessageSubtitle => 'Please choose a smaller file and try again.';

  @override
  String get avatarGoToAppSettings => 'Go to app settings';

  @override
  String get avatarGaleryPermissionsMessage => 'Please allow access to your gallery';

  @override
  String get avatarGaleryPermissionsMessageAndroid =>
      'Please allow access to your media gallery and camera';

  @override
  String get avatarCropper => 'Cropper';

  @override
  String get smartGoalsMyGoals => 'My goals';

  @override
  String get smartGoalsNoGoalsSelected => 'No goals selected yet';

  @override
  String get smartGoalsChooseGoalsForUpcomingDays => 'Choose goals for upcoming 7 days';

  @override
  String get smartGoalsUpcomingGoals => 'Upcoming goals';

  @override
  String get smartGoalsUpcomingGoalsTitle => 'Let’s set goals';

  @override
  String get smartGoalsUpcomingGoalsDescription =>
      'You can choose up to 2 goals for the upcoming 7 days.';

  @override
  String get smartGoalsCancelGoal => 'Cancel goal';

  @override
  String get smartGoalsCancelGoalTitle => 'Cancel your goal?';

  @override
  String get smartGoalsCancelGoalSubTitle =>
      'Please tell us the reason why you want to cancel this goal.';

  @override
  String get smartGoalsSetGoal => 'Set goal';

  @override
  String get smartGoalsSelectGoalsCategoryTitle => 'Select a Goal Category';

  @override
  String get smartGoalsNewLabel => 'New';

  @override
  String get smartGoalsSelectGoalsTitle => 'Select a Goal';

  @override
  String get smartGoalsSelectGoalsSubtitle =>
      'You have 7 days to complete your goal with one countable log per day.';

  @override
  String get smartGoalsSaveWeeklyGoalsSuccessMessage => 'Goals were added to your weekly list';

  @override
  String get smartGoalsStatisticsTitle => 'Your favourite goal categories';

  @override
  String get smartGoalsAccomplishedInTotal => 'goals accomplished in total.';

  @override
  String get smartGoalsAccomplishedEmptyMessage =>
      'Once you start completing goals your favourite goal categories will appear here.';

  @override
  String get smartGoalsAccomplished => 'goals accomplished';

  @override
  String smartGoalsGoalLogDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Goal: $count logged days in a week',
      one: 'Goal: $count logged day in a week',
      zero: 'Goal: $count logged days in a week',
    );
    return '$_temp0';
  }

  @override
  String smartGoalsGoalLogged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Logged days: $count',
      one: 'Logged day: $count',
      zero: 'Logged days: $count',
    );
    return '$_temp0';
  }

  @override
  String smartGoalsGoalTotalCompletions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Total logs: $count',
      one: 'Total log: $count',
      zero: 'Total logs: $count',
    );
    return '$_temp0';
  }

  @override
  String get smartGoalsGoalCompleted => 'Completed: Yes';

  @override
  String get smartGoalsGoalNotCompleted => 'Completed: No';

  @override
  String get smartGoalsHowHardWasTheGoal => 'How hard was this goal for you?';

  @override
  String get smartGoalsWantToTryInFuture => 'Want to try this again in the future?';

  @override
  String get smartGoalsGoalReview => 'Goal review';

  @override
  String smartGoalsWeeklyDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left to complete',
      one: '1 day left to complete',
      zero: 'No days left to complete',
    );
    return '$_temp0';
  }

  @override
  String get smartGoalsWeeklyDayLeft => '1 day to complete';

  @override
  String get smartGoalsWeeklyDaysReview => 'Finished';

  @override
  String smartGoalsWeeklyTimes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count times',
      one: '1 time',
      zero: 'No times',
    );
    return '$_temp0';
  }

  @override
  String get smartGoalsReasonGoalNotLike => 'I don’t like it.';

  @override
  String get smartGoalsReasonGoalChallenging => 'The goal is too challenging.';

  @override
  String get smartGoalsReasonGoalMissing => 'I am missing something to complete it.';

  @override
  String get smartGoalsReasonGoalHabit => 'The goal is already a habit.';

  @override
  String get smartGoalsReasonGoalSpecific => 'No specific reason.';

  @override
  String get nutritionProteinDegree => 'Protein\n degree';

  @override
  String get nutritionFiber => 'Fiber\n';

  @override
  String get nutritionCalorieDensity => 'Calorie\n density';

  @override
  String get buddyTitle => 'Buddy';

  @override
  String get buddyBuddy => 'buddy';

  @override
  String get buddyUnlocked => 'Buddy unlocked';

  @override
  String get buddyUnlockedBody => 'You can start to find a Buddy in the profile section.';

  @override
  String get buddyGoToPreferences => 'Go to Buddy preferences';

  @override
  String get buddyIntroTitle => 'Find your Buddy';

  @override
  String get buddyDescriptionTitle => 'How to find a Buddy?';

  @override
  String get buddyIntroBody =>
      'With a Buddy at your side not only are you more likely to stick to your goals, but also have someone to share your journey and make it more enjoyable. \n\nTo stay on track, a buddy is strongly recommended. This is especially the case if you also want to join a support group. Make your social network as strong as possible.';

  @override
  String get buddyIntroYesBtn => 'Yes, I’d like to have buddy support';

  @override
  String get buddyIntroNoBtn => 'I may do this later';

  @override
  String get buddyDescriptionContent =>
      'It’s great that you want to share your journey! \nBut how do you actually find a Buddy? \n\nConsider testing the waters by talking to people about being a Buddy in your immediate social circle. \n\nHere are a few things that you can mention when talking to a friend that is interested: \n• the role a Buddy has in your journey\n• what you would need from a Buddy and discuss boundaries for your potential Buddy relationship\n• as a Buddy, they would gain access to the Buddy Network to help them learn about the best way to provide support\n\nThe previous lesson “Finding a Buddy” can also provide some insight on how to go about this. \n\nOnce you have found a loved one that is open to joining you, go to your profile and fill out the Buddy preferences. Once completed, your friend will receive an invitation to join the Buddy Network. \n\n';

  @override
  String get buddyPreferences => 'Buddy preferences';

  @override
  String get buddyNoPreferencesState => 'Would you like to add a Buddy?';

  @override
  String get buddyCompleted => 'Buddy preferences\ncompleted';

  @override
  String get buddyCompletedContent =>
      'Your Buddy will receive an invite shortly. We will notify you once your Buddy has responded.';

  @override
  String get buddyLiveTogetherTitle => 'Do you live together with your Buddy?';

  @override
  String get buddyRelationTitle => 'How is your Buddy related to you?';

  @override
  String get buddyEmailTitle => 'What is your Buddy’s email address?';

  @override
  String get buddyEmailLabel =>
      'We will invite your Buddy to share in your journey via this email address.';

  @override
  String get buddyEmailHint => 'Buddy email address';

  @override
  String get buddyPartner => 'Husband or wife';

  @override
  String get buddyChild => 'child';

  @override
  String get buddyParent => 'parent';

  @override
  String get buddyFamily => 'family';

  @override
  String get buddyFriend => 'friend';

  @override
  String get buddyPendingTitle => 'We’ve sent an invite to your Buddy';

  @override
  String buddyPendingSubTitle(String date, String time) {
    return 'We sent this invite on\n$date at $time.\n\nWe will notify you once your Buddy has responded.';
  }

  @override
  String get buddyRejectTitle => 'Your Buddy did not accept the invite';

  @override
  String get buddyRejectSubTitle =>
      'Unfortunately, your friend cannot join you on your journey. There can be many different reasons why they couldn’t join you, but don’t let this discourage you! Try to find another Buddy.\n\nPlease talk to friends and loved ones about whether they are open to being your Buddy before you send the next invite. \n\nAre you having trouble finding a Buddy? The article “Finding a Buddy” can provide some insight on how to approach this topic with others.\n\nYou can easily invite another person to share in your journey.';

  @override
  String get buddyNotAvailableTitle => 'Your Buddy is no longer able to support you';

  @override
  String get buddyNotAvailableSubTitle =>
      'Unfortunately, your current Buddy cannot be there to support you in the way that a Buddy does. \n\nNo need to worry, there is another Buddy out there. Talk to your close friends and ask around whether one of them would like to join you.\n\nThe education lesson “Finding a Buddy” can also help you to find a new Buddy. \n\nYou can easily invite another person to share in your journey.';

  @override
  String get buddyResendInvitation => 'Resend invitation';

  @override
  String get buddyInviteAnotherBuddy => 'Invite another buddy';

  @override
  String get buddyFindAnotherBuddyContent =>
      'Please note: if you do want a new Buddy. your current Buddy will be notified that you have made this request.';

  @override
  String get buddyFindAnotherBuddy => 'Yes, I want another buddy';

  @override
  String get buddyNotNeedAnotherBuddy => 'No, I would like to keep this buddy';

  @override
  String get buddyEmail => 'Buddy email';

  @override
  String get buddyUserName => 'Buddy username';

  @override
  String get buddySince => 'Buddy since';

  @override
  String get buddyRemoveInvite => 'Remove invite';

  @override
  String get buddyRemoveBuddy => 'Remove buddy';

  @override
  String get buddyInviteBuddy => 'Invite buddy';

  @override
  String buddyFindAnotherBuddyLabel(String name) {
    return 'Are you sure that you want to remove $name as your current Buddy?';
  }

  @override
  String get buddyFindAnotherBuddyContentOne =>
      'We believe in our Buddy program and recommend keeping your buddy or inviting someone else who can offer you better encouragement.';

  @override
  String get buddyFindAnotherBuddyContentTwo =>
      'Please note: if you do want a new Buddy. your current Buddy will be notified that you have made this request.';

  @override
  String get linksTermsAndConditionsUrl => 'https://lean-on.me/terms-and-conditions';

  @override
  String get linksPrivacyPolicyUrl => 'https://lean-on.me/privacy-policy';

  @override
  String get linksPsychologistConsulting => 'https://locator.apa.org/';

  @override
  String get linksInstructionsUrl =>
      'https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf';

  @override
  String get riverOverviewTitle => 'The River Overview';

  @override
  String get riverGuidancePracticeTitle => 'Practice makes progression.';

  @override
  String get riverGuidancePracticeDescription =>
      'The calendar will be your daily entry point to practice what you’ve learned.';

  @override
  String get riverGuidanceProfileTitle => 'Your profile and account settings.';

  @override
  String get riverGuidanceProfileDescription =>
      'In the profile, you can customize your account settings, change personal preferences and access past assignments and features.';

  @override
  String get riverGuidanceCompletedTitle => 'Congratulation, you finished the Beginning.';

  @override
  String get riverGuidanceCompletedDescription =>
      'You can now move on to the first Practice session: What’s your why?.';

  @override
  String riverModuleCompletedTitle(String module) {
    return 'Congratulation, you completed the module: \"$module\"';
  }

  @override
  String riverModuleCompletedDescription(String nextModule) {
    return 'No rush, you can stay in this module and repeat the practices as often as you prefer. When you feel comfortable, you can move to the next module: \"$nextModule\".\nGreat job.';
  }

  @override
  String get riverLastModuleCompletedDescription =>
      'Take your time to revisit the previous modules and reinforce the practices whenever you need.\nYou\'ve done an amazing job reaching this point! Stay tuned, more exciting content is coming soon!';

  @override
  String get riverGuidanceStartRiverTitle => 'Great!';

  @override
  String get riverGuidanceStartRiverDescription =>
      'Now tap the other icons to unlock features and explore.';

  @override
  String get riverModuleGraduationCompletedItemsTitle =>
      'Great job. You have completed the lessons in this pool.';

  @override
  String get riverModuleGraduationCompletedTimeTitle =>
      'Your module is fully colored-in, meaning you  first read the Reflection over 7 days ago.';

  @override
  String get riverModuleGraduationCompletedItemsMessage =>
      'You are one step closer to finishing this section. But before you can graduate, we encourage you to practice and reflect on what you have learned in this Pool.\n\nOnce the 7 day timer has filled this section with color, you can move on to the next pool.';

  @override
  String get riverModuleGraduationCompletedTimeMessage =>
      'No rush: Every module takes the time it takes. Keep reflecting! When you’ve completed all the necessary steps, we’ll ask you if you’re ready to move on. Need some help? Reach out by emailing support@lean-on.me, and one of our specialists will be glad to assist.';

  @override
  String get subscriptionTrialTitle => 'First 2 weeks for free!';

  @override
  String get subscriptionTrialLabel =>
      'After your trial period you are enrolled and \nyou can cancel on a monthly basis.';

  @override
  String get subscriptionTrialExpiredTitle => 'Your trial has expired';

  @override
  String get subscriptionTrialExpiredLabel1 => 'We hope you enjoyed our program.';

  @override
  String get subscriptionTrialExpiredLabel2 =>
      'If you want to continue,\nrefresh your subscription here:';

  @override
  String get subscriptionEndedTitle => 'Your subscription \nhas ended';

  @override
  String get subscriptionEmptyToRestore =>
      'Sorry, the store didn\'t return a subscription for us to restore. If you think this is an error, please send proof of subscription to support@lean-on.me.';

  @override
  String get subscriptionEndedLabel1 => 'We hope you enjoyed our program.';

  @override
  String get subscriptionEndedLabel2 => 'If you want to continue,\nrefresh your subscription here:';

  @override
  String get subscriptionCancelledTitle => 'Your subscription \nwas cancelled';

  @override
  String get subscriptionCancelledLabel1 => 'We hope you enjoyed our program.';

  @override
  String get subscriptionCancelledLabel2 =>
      'If you want to continue,\nrefresh your subscription here:';

  @override
  String get subscriptionRenewedTitle => 'Your subscription \ncould not be renewed';

  @override
  String get subscriptionRenewedLabel =>
      'We want to let you know that your\nsubscription could not be automatically\nrenewed. \n\nYou will get a couple of days to look into this.\nDuring this time you can still use the app.';

  @override
  String get subscriptionRestoreLabel => 'Restore Purchase';

  @override
  String get subscriptionTermsLabel => 'Terms & Conditions';

  @override
  String get subscriptionPrivacyLabel => 'Privacy policy';

  @override
  String get subscriptionAnnual => 'Annual';

  @override
  String get subscriptionMonthly => 'Monthly';

  @override
  String get subscriptionSubscribe => 'Subscribe';

  @override
  String get subscriptionRedeem => 'Redeem';

  @override
  String subscriptionSubTitlePrice(String description) {
    return '$description';
  }

  @override
  String subscriptionTitlePrice(String title, String priceWithCurrency) {
    return '$title $priceWithCurrency';
  }

  @override
  String get subscriptionSubscription => 'Subscription';

  @override
  String get subscriptionManageSubscription => 'Manage subscription';

  @override
  String get subscriptionType => 'Subscription type';

  @override
  String get subscriptionSubscriptionVia => 'Subscription via';

  @override
  String get subscriptionMemberSince => 'Member since';

  @override
  String get subscriptionAutomaticRenewalOn => 'Automatic renewal on';

  @override
  String get subscriptionServiceUnavailable => 'Service is unavailable,\nplease try later.';

  @override
  String get subscriptionOtherPurchaseVendor =>
      'Sorry, your subscription seems to be purchased from a different store.';

  @override
  String get subscriptionAppStore => 'App Store';

  @override
  String get subscriptionGoogleMarket => 'Play Market';

  @override
  String get subscriptionCancelAccountSubscription =>
      'Before you delete your account with LeanOnMe, please take a moment to cancel your subscription. This will prevent any future charges. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings';

  @override
  String get subscriptionOtherPurchaseVendorCancelAccountSubscription =>
      'Your subscription seems to be purchased from a different store.';

  @override
  String get subscriptionRestoreSubscriptionFromSettings =>
      'Please take a moment to resubscribe your subscription plan from Subscription Settings. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings';

  @override
  String get subscriptionAskRestoreSubscription =>
      'Sorry, your subscription seems to be purchased but is not verified, please, tap on Restore Purchase to verify it.';

  @override
  String get subscriptionDuplicateSubscriptionFromSettings =>
      'This subscription seems to be purchased before. Please take a moment to resubscribe your subscription plan from Subscription Settings. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings';

  @override
  String get subscriptionRecommendedAccess => 'recommended';

  @override
  String get subscriptionLimitedAccess => 'limited time offer';

  @override
  String get subscriptionLifeTimeAccess => 'lifetime access';

  @override
  String get subscriptionFlexibleAccess => 'flexible access';

  @override
  String get subscriptionMonth => 'monthly';

  @override
  String get subscriptionQuarterly => 'quarterly';

  @override
  String get subscriptionAnnually => 'annually';

  @override
  String get subscriptionWeekly => 'weekly';

  @override
  String get subscriptionDaily => 'days';

  @override
  String get subscriptionDescriptionLabel => 'Cancel anytime in subscriptions center';

  @override
  String get subscriptionGenericTitle => 'Your journey is about to begin.';

  @override
  String get emergencyAssistanceTitle => 'Emergency assistance: (call or text)';

  @override
  String get emergencyAssistanceNumber => '911';

  @override
  String get emergencyAssistanceLabel => '911';

  @override
  String get emergencyUsLifelineTitle => 'U.S suicide and crisis lifeline (call or text)';

  @override
  String get emergencyUsLifelineTitleNumber => '988';

  @override
  String get emergencyUsLifelineTitleLabel => '988';

  @override
  String get emergencyCrisisChatTitle => 'Lifeline Crisis Chat';

  @override
  String get emergencyCrisisChatUrl => 'https://988lifeline.org/chat';

  @override
  String get emergencyCrisisChatLabel => 'Live messenger';

  @override
  String get emergencySelfHarmLineTitle => 'Self-harm Line';

  @override
  String get emergencySelfHarmLineNumber => '1-800-366-8288';

  @override
  String get emergencySelfHarmLineLabel => '1-800-366-8288';

  @override
  String get emergencyLGBTQLineTitle => 'LGBTQ Youth Suicide Hotline (Trevor Project)';

  @override
  String get emergencyLGBTQLineNumber => '1-866-488-786';

  @override
  String get emergencyLGBTQLineLabel => '1-866-488-786';

  @override
  String get emergencyNationalHotlineTitle => 'National Crisis Hotline (Anorexia & Bulimia)';

  @override
  String get emergencyNationalHotlineNumber => '1-800-233-4357';

  @override
  String get emergencyNationalHotlineLabel => '1-800-233-4357';

  @override
  String get emergencyVeteransLineTitle => 'Veterans Line';

  @override
  String get emergencyVeteransLineUrl => 'https://veteranscrisisline.net/';

  @override
  String get emergencyVeteransLineLabel => 'Veterans Line';

  @override
  String introTitle(String projectName) {
    return 'Welcome to $projectName!';
  }

  @override
  String get introBodyTextFirst =>
      'This program is specifically designed for people living with overweight and obesity that want to sustainably lose weight and change their lifestyle.';

  @override
  String get introBodyTextSecond => 'If this description fits you, let’s start your journey.';

  @override
  String loginTitle(String projectName) {
    return 'Welcome back to $projectName';
  }

  @override
  String get forgotPasswordTitle => 'Forgot your password';

  @override
  String get forgotPasswordSubTitle => 'Your email address';

  @override
  String get forgotPasswordBody =>
      'Enter your email address and we will send you instructions to reset your password';

  @override
  String get minutes => 'minutes';

  @override
  String stepCounter(String currentStep, String totalSteps) {
    return 'Step $currentStep of $totalSteps';
  }

  @override
  String get yes => 'yes';

  @override
  String get no => 'no';

  @override
  String get legalStatement => 'Legal statement';

  @override
  String get legalStatementTextOne =>
      'For your own health and safety, it is important that you have answered all questions truthfully';

  @override
  String get legalStatementTextTwo => 'To continue, please read and accept our legal statement';

  @override
  String get readLegalStatement => 'Read legal statement';

  @override
  String get legalStatementCheckboxTitle => 'I hereby declare, that:';

  @override
  String get legalStatementCheckboxItemOne =>
      'my answers are true to the best of my knowledge and I will continue to answer questions truthfully in future.';

  @override
  String get confirm => 'Confirm';

  @override
  String get openLinkErrorMessage => 'Can\'t open the link';

  @override
  String get signUpWelcomeTitle => 'Hurray,\n you can now start the LeanOnMe program';

  @override
  String get signUpWelcomeBody =>
      'It\'s great to have you on board. Create an account to embark on your journey';

  @override
  String get createAccount => 'Create account';

  @override
  String get whatIsYourName => 'What name would you like to use';

  @override
  String get niceToMeetYou => 'Nice to meet you';

  @override
  String get enterPasswordSubTitle => 'What password would you like to use';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordStrengthToShort => 'Your password is too short';

  @override
  String get passwordStrengthToLong => 'Your password is too long';

  @override
  String get passwordStrengthNotSecure => 'Not secure enough yet...';

  @override
  String get passwordStrengthMiddle => 'Better, but need some';

  @override
  String get passwordStrengthNice => 'That looks nice and secure!';

  @override
  String get passwordValidationRule1 => 'minimum eight characters';

  @override
  String get passwordValidationRule2 => 'at least one number';

  @override
  String get passwordValidationRule3 => 'at least one special character';

  @override
  String get emailTitle => 'Now, please write down your email address';

  @override
  String get emailBody => 'You will receive an email to confirm your address';

  @override
  String get termsAndConditions => 'terms and conditions';

  @override
  String get privacyPolicy => 'privacy policy';

  @override
  String get termsAndConditionsTitle => 'Terms and Conditions';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get iAcceptThe => 'I accept the';

  @override
  String get pleaseAcceptTOC => 'Please accept terms and conditions';

  @override
  String get pleaseAcceptPrivacyPolicy => 'Please accept privacy policy';

  @override
  String get register => 'Register';

  @override
  String get receiveEmailCheckboxLabel => 'I agree to receive occasional emails about updates';

  @override
  String get waitingForConfirmationTitle => 'You’ve got mail';

  @override
  String get resendConfirmationMessage => 'We\'ve just sent another email to you';

  @override
  String get waitingForConfirmationSubtitle => 'Please confirm your e-mail';

  @override
  String get waitingForConfirmationBody =>
      'No rush, you can confirm your email address later. We sent it to:';

  @override
  String get waitingForConfirmationBody3 =>
      'If you haven\'t received anything, make sure to check your spam folder';

  @override
  String get waitingForConfirmationBody4 =>
      'No message in your inbox? Please click the button below';

  @override
  String get resend => 'Resend confirmation email';

  @override
  String get incorrectEmail => 'Incorrect email';

  @override
  String get changeAddress => 'Change email address';

  @override
  String get changeEmail => 'Change email';

  @override
  String get changeEmailAddressTitle => 'Please write down the new email address';

  @override
  String get emailConfirmedBottomSheetTitle => 'Email address is confirmed';

  @override
  String get emailConfirmedBottomSheetContent =>
      'Thanks for confirming your email address. You can now start using the app';

  @override
  String get logMood => 'Log Mood';

  @override
  String get yourNote => 'Your note';

  @override
  String get educationTitle => 'Taking one step at a time will have a huge impact';

  @override
  String get locked => 'Locked';

  @override
  String get lesson => 'Lesson';

  @override
  String get lessonCompleted => 'Lesson completed!';

  @override
  String get groupSessionsUnlocked => 'Support group unlocked';

  @override
  String get waitingForGroupCompletedLesson =>
      'We will let you know once we have found a group for you based on your preferences';

  @override
  String get notJoinedToGroupCompletedLesson =>
      'If you would like to join group sessions in the future, you can indicate this in your preferences';

  @override
  String get groupSessionUnlockOnTrialPeriod =>
      'Group sessions is only available if you have a paid subscription.  After you have paid, you can enrol from the dashboard or your profile.';

  @override
  String get unlockFeatureDescription =>
      'Your preferences have been added to your profile. You can update them later.';

  @override
  String get lessonCompleteDescription => 'Well done! You can proceed to the next lesson';

  @override
  String get assignmentCompleted => 'Assignment completed!';

  @override
  String get assignmentCompleteDescription =>
      'Well done! Your answers are saved, so you can revisit them later.';

  @override
  String get consultYourTherapistBody1 =>
      'You indicated that you are currently being treated by a psychologist or psychiatrist.';

  @override
  String get consultYourTherapistBody2 =>
      'Together with your therapist, please discuss whether joining a support group would be a good step for you in your current treatment plan.';

  @override
  String get consultYourTherapistBody3 =>
      'Once you have discussed this with your therapist, you can continue the process of joining a support group.';

  @override
  String get consultYourTherapistBody4 =>
      'To do so, go to your Profile and under Preferences you will find Support group.';

  @override
  String get completeLesson => 'Complete the lesson';

  @override
  String get didYouCheckWithSpecialist => 'Did you check with your therapist?';

  @override
  String get iConsultedTherapist => 'I consulted my therapist';

  @override
  String get treatedByTherapistLessonComplete =>
      'Once you have discussed it with your therapist, go to Support Group preferences in the User Profile to continue.';

  @override
  String get trialSubscriptionLessonComplete =>
      'Support group is only available if you have a paid subscription. After you have purchased a subscription, you can enrol from the Support Group preferences in the User Profile.';

  @override
  String get groupSessionsJoinLaterLessonComplete =>
      'If you want to join a support group in the future, go to Support Group preferences in the User Profile. Please note that support group is only available if you have a paid subscription.';

  @override
  String get needSubscrionScreenTitle => 'Support groups available with paid subscription';

  @override
  String get needSubscrionScreenBody1 =>
      'You are currently on your free 14-day trial of the LeanOnMe program.';

  @override
  String get needSubscrionScreenBody2 =>
      'Once the free-trial period ends, you can choose to join a support group. ';

  @override
  String get needSubscrionScreenBody3 =>
      'The Support group widget on your dashboard will tell you when this function becomes available.';

  @override
  String get needSubscrionScreenBody4 =>
      'You can then join a group through the Dashboard or through your Profile.';

  @override
  String get consultYourTherapist => 'Consult your therapist';

  @override
  String get groupSession => 'Group Session';

  @override
  String get getStarted => 'Get started';

  @override
  String get haveAnAccount => 'Have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get bodyAndMind => 'Body and Mind';

  @override
  String get finish => 'Finish';

  @override
  String get introPage => 'Intro Page';

  @override
  String get moreInfo => 'More info';

  @override
  String get yourBirthday => 'Your birthday';

  @override
  String get continueBtn => 'Continue';

  @override
  String get downloadInstructions => 'Download instructions';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get yourPassword => 'Your password';

  @override
  String get login => 'Login';

  @override
  String get yourEmail => 'Your email';

  @override
  String get yourName => 'Your name';

  @override
  String get connectionLost =>
      'Internet connection lost, please check your internet connection or try later';

  @override
  String get pleaseEnterYourEmailAddress => 'Please enter your email address';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get nameRegexValidationError => 'Only . + - \' special characters are allowed';

  @override
  String get pleaseEnterValidEmailAddress => 'Please enter a valid email address';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get enterYourHeight => 'Please enter your height';

  @override
  String forgotEmailSuccessMessage(String email) {
    return 'If there is an account associated with the $email, an email with further instructions will be sent to that address.';
  }

  @override
  String get close => 'Close';

  @override
  String get youAndFoodItemThree => 'Allergies';

  @override
  String get start => 'Start';

  @override
  String get iDoNotEatOrDrink => 'I do not eat or drink:';

  @override
  String get iAmAllergicTo => 'I am allergic to:';

  @override
  String get iDoNotLike => 'I do not like:';

  @override
  String get typeOne => 'Yes, type 1';

  @override
  String get typeTwo => 'Yes, type 2';

  @override
  String get breakfast => 'Breakfast';

  @override
  String get lunch => 'Lunch';

  @override
  String get dinner => 'Dinner';

  @override
  String get lateDinner => 'Late night';

  @override
  String get nutritionSummary => 'Nutrition summary';

  @override
  String get calorieDensity => 'Calorie density';

  @override
  String get proteinDegree => 'Protein degree';

  @override
  String get whatIsCalorieDensity => 'What is calorie density';

  @override
  String get whatIsProtein => 'What is protein degree';

  @override
  String get calorieDensityExplanation =>
      'Calorie density is  a measure of how many calories are in a given weight of food, most often expressed as calories per gram. It is a good indicator for how filling it is.';

  @override
  String get forMoreInformationSeeLesson => 'For more information see lesson';

  @override
  String get proteinDegreeExplanation =>
      'Protein is the most filling macro-nutrient. Eating 300 calories of protein is more filling compared to eating 300 calories carbohydrates or fat.';

  @override
  String get fiberExplanation =>
      'Fiber is the best nutrient to maintain a healthy gut and microbiome. Additionally, it is an excellent indicator for the overall quality of carbohydrates in your diet.';

  @override
  String get importanceOfProtein => 'The Importance of Protein';

  @override
  String get carbohydratesPart2 => 'Carbohydrates Part 2';

  @override
  String fiberDailyGoal(String fiberAmount, String dailyGoal) {
    return '${fiberAmount}g of your daily goal of ${dailyGoal}g fiber';
  }

  @override
  String fiberRatioToCarbo(String totalCarbohydrates, String ratio) {
    return 'Ratio to ${totalCarbohydrates}g total Carbohydrates is 1:$ratio';
  }

  @override
  String get calories => 'Calories';

  @override
  String get amount => 'Amount';

  @override
  String get addAsFavourite => 'Add as a favorite';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get addedToFavorites => 'Added to Favorites';

  @override
  String get removedFromFavorites => 'Removed from Favorites';

  @override
  String get myFavorites => 'My favorites';

  @override
  String get my => 'My';

  @override
  String get myDishes => 'My dishes';

  @override
  String get dishes => 'dishes';

  @override
  String get scan => 'Scan';

  @override
  String get showMy => 'Show my';

  @override
  String get qrCodeSubtext_1 =>
      'Keep the barcode right in front of your camera and make sure it is within the indicated area.';

  @override
  String get qrCodeSubtext_2 => 'If the barcode is identified you will hear a bleep ';

  @override
  String get qrCodeSubtext_3 =>
      'If the camera image is blurry, then move the product slightly around to help the camera refocus';

  @override
  String get scanOtherProduct => 'Scan other product';

  @override
  String get sorryNotFound => 'Sorry, but we can not find this barcode in our system';

  @override
  String get scanYourProduct => 'Scan your barcode';

  @override
  String get barCodeResultCalories => 'Calories: ';

  @override
  String get barCodeResultPerServing => 'Per serving : ';

  @override
  String get openSettings => 'Open settings';

  @override
  String get allowCameraMessage =>
      'To use the barcode scanner, please allow Camera usage in settings';

  @override
  String get item => 'item';

  @override
  String get items => 'items';

  @override
  String get selected => 'selected';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String get add => 'Add';

  @override
  String get addFoodItem => 'Add food item';

  @override
  String get saveToMyDishes => 'Save to my dishes';

  @override
  String get addToDishes => 'Add to my dishes';

  @override
  String get viewRecipe => 'View recipe';

  @override
  String get ingredientsBasedOn => 'ingredients based on';

  @override
  String portionMeal(String numberOfPortion) {
    return '$numberOfPortion portion meal';
  }

  @override
  String get total => 'total';

  @override
  String get searchHint => 'Search for food';

  @override
  String get searchFilterAll => 'All';

  @override
  String get searchFilterProducts => 'Products';

  @override
  String get searchFilterRecipes => 'Recipes';

  @override
  String get searchFilterMy => 'My Food';

  @override
  String get inbetweens => 'Inbetweens & snacks';

  @override
  String get inbetweensShort => 'Inbetweens';

  @override
  String get drinks => 'Drinks';

  @override
  String get favorites => 'favorites';

  @override
  String get allMy => 'All my';

  @override
  String get showNutritionValue => 'Show nutrition value';

  @override
  String youHaveNo(String text) {
    return 'You have no $text yet';
  }

  @override
  String get favoritesExplain => 'Favorites help you quickly log your most used food items';

  @override
  String get favoritesList =>
      '1. Search a food item \n2. View its details \n3. Tap the star on the right side to bookmark it as your favorite';

  @override
  String get dishesExplain => 'My dishes help you quickly log your most eaten meals';

  @override
  String get dishesList =>
      '1. Log the desired food items \n2. Create a My dish directly from your log summary';

  @override
  String get groupPreferences => 'Group Preferences';

  @override
  String get groupRules => 'Group Rules';

  @override
  String get wouldYouLikeToJoinSupportGroup => 'Would you like to join a support group?';

  @override
  String get genderPreferencesQuestion => 'Do you have a gender preference for your support group?';

  @override
  String get nicknamePreferencesQuestion =>
      'Which name do you want to use within your support group?';

  @override
  String get nicknamePlaceholder => 'Your name';

  @override
  String get weAreLookingForAMatch => 'We are looking for a match';

  @override
  String get weAreLookingForAGroupSince =>
      'We are looking for a group that matches your preferences since';

  @override
  String get genderPreference => 'Gender preference';

  @override
  String get timezone => 'Time zone';

  @override
  String get yourNickname => 'Your Nickname';

  @override
  String get partOfGroup => 'Part of group';

  @override
  String get iNoLongerWantToJoin => 'I no longer want to join a group';

  @override
  String get update => 'Update';

  @override
  String weHaveNotYetFound(String dateTime) {
    return 'We have not yet been able to find a group that matches your preferences since $dateTime\n\nTo speed up the process you could adjust your group gender preference to ‘no preference’';
  }

  @override
  String get goodNews => 'Good news!';

  @override
  String get youHaveBeenAddedToGroup =>
      'You have been added to a group matching your preferences. Sign up for a group session and use the chat to meet your fellow group members';

  @override
  String get readTheGroupRules => 'Read the group rules';

  @override
  String get leaveGroup => 'Leave group';

  @override
  String get notYet => 'Not yet';

  @override
  String get whatIsYourTimezone => 'What is your time zone?';

  @override
  String get searchTimezone => 'Search time zone';

  @override
  String get groupRulesOneTitle => 'Feeling safe in a trusting environment';

  @override
  String get groupRulesAttention => 'Please read the 14 group rules carefully';

  @override
  String get groupRulesOneParagraphOne =>
      'It is very important for all group meetings that you uphold the group rules. These group rules help ensure that a safe and trusting environment is created for each and every member.';

  @override
  String get groupRulesOneParagraphTwo =>
      'Your group should provide a place that you feel comfortable, and can open up, in. It gives you the opportunity to discuss things that are on your mind in a trusting environment, outside of the chaos of everyday life.';

  @override
  String get continueToTheRules => 'Continue to the rules';

  @override
  String get yesIAgree => 'Yes, I agree';

  @override
  String get supportGroupPreferences => 'Support Group Preferences';

  @override
  String get groupRulesTwoParagraphOne =>
      'Everything that is discussed within the group, stays within the group. Every member strives to create a friendly atmosphere, in which all can feel comfortable in.';

  @override
  String get groupRulesTwoParagraphTwo =>
      'We treat each other with respect and are kind to one another.';

  @override
  String get groupRulesTwoParagraphThree =>
      'We let each other talk and do not criticize one another.';

  @override
  String get groupRulesThreeParagraphOne =>
      'Together, we ensure that all members get the same opportunity to share.';

  @override
  String get groupRulesThreeParagraphTwo =>
      'We actively listen – sometimes just listening to one another is worth more than constant comments and advice.';

  @override
  String get groupRulesThreeParagraphThree =>
      'Every topic, every problem, will be taken seriously.';

  @override
  String get groupRulesFourParagraphOnePartOne => 'We send';

  @override
  String get groupRulesFourParagraphOnePartTwo =>
      'We use these to express/phrase our own emotions, opinions, assumptions, and perceptions. Therefore, we avoid phrases such as';

  @override
  String get groupRulesFourParagraphOnePartThree => 'Instead, a sentence could start with';

  @override
  String get groupRulesFourParagraphOneItalicOne => '“Me-messages”.';

  @override
  String get groupRulesFourParagraphOneItalicTwo => '“you must/you are”.';

  @override
  String get groupRulesFourParagraphOneItalicThree =>
      '“I have had positive experiences with.../I found it helpful when...”.';

  @override
  String get groupRulesFourParagraphTwo =>
      'It is helpful to regularly be aware of one self – your body, your thoughts, your feelings.';

  @override
  String get groupRulesFiveParagraphOne =>
      'We also talk to each other, not about each other. Absent group members will not be the subject of conversation.';

  @override
  String get groupRulesFiveParagraphTwo =>
      'Individual responsibility: every member of a group is responsible for what they do and/or say. Appreciation and respect for yourself and others is important, that means I respect my own boundaries that I set for myself as well as those of my group members.';

  @override
  String get groupRulesSixParagraphOne =>
      'The camera should remain on during sessions so that you can all see each other and no member is forgotten.';

  @override
  String get groupRulesSixParagraphTwo => 'Take some time and relax before a session.';

  @override
  String get groupRulesSixParagraphThree =>
      'Be patient with others, but especially with yourself – be kind to yourself.';

  @override
  String get groupRulesSixParagraphFour => 'Last but not least: Have fun!';

  @override
  String get noPreference => 'no Preference';

  @override
  String get femaleOnly => 'female only';

  @override
  String get maleOnly => 'male only';

  @override
  String get mixed => 'mixed';

  @override
  String get female => 'Female';

  @override
  String get male => 'Male';

  @override
  String get woman => 'Woman';

  @override
  String get man => 'Man';

  @override
  String get other => 'Other';

  @override
  String get at => 'at';

  @override
  String get joinAGroup => 'Join a group';

  @override
  String get unavailableGroupPrefsLabel =>
      'As soon as you have finished the Education lesson on “Surrounding yourself with people who get it”, you can join a support group';

  @override
  String get findingMatchingGroup => 'Finding a matching group';

  @override
  String get moreInformationInPreferences => 'More information in Preferences';

  @override
  String get bookYourSeat => 'Book your seat';

  @override
  String get comingUpThisWeek => 'Coming up this week';

  @override
  String get happeningNow => 'Happening Now';

  @override
  String get joinSession => 'Join session';

  @override
  String bookedFromTo(String day, String startTime, String endTime) {
    return 'Booked $day from $startTime to $endTime';
  }

  @override
  String dayFromTo(String day, String startTime, String endTime) {
    return '$day\nfrom $startTime to $endTime';
  }

  @override
  String get prepareForSession => 'Prepare for session';

  @override
  String prepareTakes(String times) {
    return 'Prepare for this session ($times mins)';
  }

  @override
  String get timeslotCancelled => 'Sorry, this time slot is canceled';

  @override
  String get timeslotMissed => 'Sorry, you missed this time slot';

  @override
  String get chooseAnotherTimeslot => 'Choose another time slot';

  @override
  String get noOtherTimeslotsAvailable =>
      'No other time slots are available for this week. Next week’s topic is coming soon';

  @override
  String noMinMemberCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Less than $count users have signed up to this session, so it might be canceled.',
      one: 'Only 1 user has signed up to this session, so it might be canceled.',
      zero: 'No users have signed up to this session, so it might be canceled.',
    );
    return '$_temp0';
  }

  @override
  String get noGroupThisWeek => 'No group sessions this week.';

  @override
  String get on => 'on';

  @override
  String get off => 'off';

  @override
  String get noMoodRecords => 'You have no records for the selected day';

  @override
  String get yourSupportSystem => 'Your Support System';

  @override
  String get supportGroupIntroDesc =>
      'Having a support group increases the likelihood of staying on track and reaching sustainable weight loss. \nSurround yourself with people who get it. Chat with fellow members anytime. In the weekly sessions you can discuss, learn new things and share your experiences. ';

  @override
  String get yesILikeToJoin => 'Yes, I would like to join a support group';

  @override
  String get joinLater => 'I may join later';

  @override
  String get theSupportGroup => 'The Support Group';

  @override
  String get introduction => 'Introduction';

  @override
  String get reportIssue => 'Report Issue';

  @override
  String get discussion => 'Discussion';

  @override
  String get left => 'left';

  @override
  String get error => 'Error';

  @override
  String get sessionIsInProgress => 'Session is in progress';

  @override
  String get failedToJoinSession => 'Fail when trying to join session';

  @override
  String get disconnectedFromSession => 'You were disconnected from the session';

  @override
  String micState(String micState) {
    return 'Your microphone was $micState';
  }

  @override
  String get toggleSpeakerError => 'Device doesn’t support speaker toggle';

  @override
  String get mute => 'Mute';

  @override
  String get stopVideo => 'Stop video';

  @override
  String get settings => 'Settings';

  @override
  String get sessionLeaveDialogText =>
      'When you hang up, you might not be able to rejoin this group session';

  @override
  String get sessionEndDialogText => 'Your session has ended, thanks for participating';

  @override
  String get leaveSession => 'Leave the session anyway';

  @override
  String get stayInTheSession => 'Stay in the session';

  @override
  String get signatureErrorMessage =>
      'Something went wrong with your session, try go back and return later';

  @override
  String get sessionAlreadyEnded => 'Your session has already ended, you can’t join';

  @override
  String get duration => 'Duration';

  @override
  String get badConnectionMessage => 'Your connection is poor';

  @override
  String get exercise => 'Exercise';

  @override
  String get noMicrophoneAccessTitle => 'Can\'t Access Microphone';

  @override
  String get noMicrophoneAccessDescription =>
      'Please turn on the toggle in system settings to grant permission';

  @override
  String get noCameraAccessTitle => 'Can\'t Access Camera';

  @override
  String get noCameraAccessDescription =>
      'Please turn on the toggle in system settings to grant permission';

  @override
  String get sessionGreeting => 'Great to see that you are going to be joining the session';

  @override
  String get goodToKnow => 'Good to know';

  @override
  String get warningOne =>
      'Your camera will be on and your mic will be unmuted when you enter the session';

  @override
  String get warningTwo => 'You are expected to be aware and follow the';

  @override
  String get hi => 'Hi';

  @override
  String get sessionWillStartIn => 'The session will start in';

  @override
  String get sessionStartedMessage => 'The session has already started';

  @override
  String get enterSession => 'Enter session';

  @override
  String get pickADateAndTime => 'Pick a date and time';

  @override
  String fromTo(String startTime, String endTime) {
    return 'From $startTime to $endTime';
  }

  @override
  String fromToLower(String startTime, String endTime) {
    return 'from $startTime to $endTime';
  }

  @override
  String numberOfAvailableSeats(String number, String totalNumber) {
    return '$number of $totalNumber places available';
  }

  @override
  String get passedSession => 'Past session';

  @override
  String get cancelledSession => 'Canceled session';

  @override
  String get minimumNotReached => 'Minimum not reached';

  @override
  String get noMoreSeatAvailable => 'No more places available';

  @override
  String get bookedForYou => 'Booked for you';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get sessionWarning_1 =>
      'If less than four places are booked, the session will be canceled';

  @override
  String get sessionWarning_2 => 'If you can’t make it, please be sure to cancel your booking';

  @override
  String get emergencySubtitle =>
      'This program is not psychotherapy and cannot replace psychotherapy. \n\nIf you have an acute mental health crisis or feel you need psychological support or are having suicidal thoughts, please seek medical or psychological help immediately.\n\nIn an emergency, you can also contact the following numbers, which you can reach 24h/day toll-free:';

  @override
  String get subjectReport => 'Subject';

  @override
  String get descriptionReport => 'Description';

  @override
  String get reportTitle => 'Report issue';

  @override
  String get reportSubTitle => 'Please describe the matter.';

  @override
  String get reportSuccessTitle => 'We have received your report and will act accordingly on it';

  @override
  String get errorReportMessage =>
      'Text message must be at least one symbol and less than 500 symbols';

  @override
  String get errorSubjectMessage =>
      'Text message must be at least one symbol and less than 30 symbols';

  @override
  String get requiredField => 'Field is required';

  @override
  String get send => 'Send';

  @override
  String get changeYourEmail => 'Change your email';

  @override
  String get changeYourEmailDescription =>
      'Enter your new email address and confirm with your password.';

  @override
  String get submit => 'Submit';

  @override
  String get emailChangeConfirmedTitle => 'Email address change confirmed';

  @override
  String get emailChangeConfirmedBody1 => 'Your email address has been successfully updated.';

  @override
  String get emailChangeConfirmedBody2 =>
      'We have sent you an email to your new address. Please click the link to verify.';

  @override
  String yourPreferencesUpdated(String prefName) {
    return 'Your $prefName preferences have been updated';
  }

  @override
  String get createNew => 'Create new';

  @override
  String get updateExist => 'Update existing';

  @override
  String get existMealText => 'You want to create a new meal or edit an existing one?';

  @override
  String chooseDateFor(String mealCategory) {
    return 'Choose date for $mealCategory';
  }

  @override
  String get youCanChangeTheDate =>
      'You can change the date and/or plan it on multiple days. Don’t forget to save any changes you have made';

  @override
  String weekWithNumber(String number) {
    return 'WEEK $number';
  }

  @override
  String capitalizeWeekWithNumber(String number) {
    return 'Week $number';
  }

  @override
  String weekDates(String from, String to, String month) {
    return '$from to $to $month';
  }

  @override
  String get saveChanges => 'Save changes';

  @override
  String get changesSaved => 'Changes have been saved';

  @override
  String get thisMealPlannedFor => 'This meal is planned for';

  @override
  String get saveDateError =>
      'You first have to select another date before you can deselect this one';

  @override
  String get kcal => 'kcal';

  @override
  String get yesReplace => 'Yes replace';

  @override
  String youAlreadyPlanned(String mealCategory) {
    return 'You have already planned a $mealCategory for this day:';
  }

  @override
  String andOtherDates(String number) {
    return 'and $number other dates';
  }

  @override
  String alreadyPlannedCategory(String mealCategory) {
    return '$mealCategory ALREADY PLANNED';
  }

  @override
  String get replaceWith => 'Replace with?';

  @override
  String get nothingOnTheMenu => 'Nothing on the menu yet';

  @override
  String get mindTraining => 'Mind training';

  @override
  String get learnMoreButton => 'Learn more';

  @override
  String get lock => 'Lock';

  @override
  String unlocksOn(String date) {
    return 'Unlocks on $date';
  }

  @override
  String get unlocksAfterCompletionExercise => 'Unlocks after completion of previous exercise';

  @override
  String get intro => 'Intro';

  @override
  String get exercises => 'Exercises';

  @override
  String get startExercise => 'Start exercise';

  @override
  String countMins(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mins',
      one: '$count min',
    );
    return '$_temp0';
  }

  @override
  String get chooseAnExercise => 'Choose an exercise';

  @override
  String get completedExerciseMessage1 => 'Great! You completed';

  @override
  String completedExerciseMessage2(String count) {
    return '$count exercise';
  }

  @override
  String get completedIntroductionMessage2 => 'the introduction to';

  @override
  String get chooseTechnique => 'Choose technique';

  @override
  String get chooseExercise => 'Choose exercise';

  @override
  String get selectedExercise => 'Selected exercise';

  @override
  String get skipIntro => 'Skip intro';

  @override
  String get selectMoodText => 'How do you feel?';

  @override
  String get selectMoodSubtext => 'You can choose what information to fill.';

  @override
  String get time => 'Time';

  @override
  String get specifyEmotion => 'Specify emotion(s)';

  @override
  String get withWho => 'With whom';

  @override
  String get where => 'Where';

  @override
  String get makeChoice => 'Choose';

  @override
  String get personalNote => 'Personal note';

  @override
  String get moodOptionPageEmotionTitle => 'Emotions';

  @override
  String get descriptionEmotions => 'Choose up to three emotions';

  @override
  String get deleteMood => 'Delete mood';

  @override
  String get quiz => 'Quiz';

  @override
  String get letsGo => 'Let’s go';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'That’s incorrect';

  @override
  String get assignmentAddedTitle => 'Assignment added to your calendar';

  @override
  String assignmentAddedText(String date) {
    return 'Please aim to finish it before $date';
  }

  @override
  String get startNow => 'Start now';

  @override
  String get reflection => 'Reflection';

  @override
  String get reflections => 'Reflections';

  @override
  String get seeLesson => 'See lesson';

  @override
  String get allAssignmentsCompleted => 'All assignments have been completed';

  @override
  String get errorOpenTextMessage =>
      'Text message must be at least one symbol and less than 20,000 symbols';

  @override
  String get thisWeek => 'this week';

  @override
  String get doneToday => 'Done today';

  @override
  String completeBefore(String date) {
    return 'Complete before $date';
  }

  @override
  String completedOn(String date) {
    return 'Completed on $date';
  }

  @override
  String get pastReflections => 'Past reflections';

  @override
  String get iWantToLogMy => 'I want to log my';

  @override
  String get logMealServingTitle => 'Select serving size';

  @override
  String get descriptionTime => 'Choose the time';

  @override
  String get descriptionWithWhom => 'Choose with whom you were';

  @override
  String get descriptionWhere => 'Choose where you were';

  @override
  String get descriptionFood => 'Choose what food you were eating?';

  @override
  String get logWeight => 'Log Weight';

  @override
  String get foodLoggingUnlocked => 'Food logging unlocked';

  @override
  String get youCanStartLogging => 'You can start logging your meals right now';

  @override
  String get reportIssueAndEmergencyTitle => 'Report issue and emergency';

  @override
  String get groupChat => 'Group chat';

  @override
  String get groupChatTitle => 'Group members';

  @override
  String groupChatLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count members in your support group',
      one: 'There is 1 member in your support group',
      zero: 'There are no members in your support group',
    );
    return '$_temp0';
  }

  @override
  String get copyGroupMessage => 'Copy';

  @override
  String get removeGroupMessage => 'Remove';

  @override
  String get reportGroupMessage => 'Report';

  @override
  String get snackMassageCopy => 'Message text has been copied to clipboard';

  @override
  String get messageRemoved => 'This message was deleted';

  @override
  String get membersEmpty => 'This group chat does not have members';

  @override
  String get messageLengthRestriction =>
      'A text message may contain up to 1,024 characters. Please make your message shorter';

  @override
  String get yourUser => 'You';

  @override
  String get passwordValidationRule4 => 'at least 1 capital character';

  @override
  String get pleaseEnterRegistrationCode => 'Please enter registration code';

  @override
  String get pleaseEnterValidRegistrationCode => 'Please enter a valid registration code';

  @override
  String get favorite => 'Favorite';

  @override
  String get recipe => 'Recipe';

  @override
  String get recipeDetails => 'Recipe details';

  @override
  String get myDish => 'My dish';

  @override
  String get editMyDish => 'Edit my dish';

  @override
  String get serving => 'serving';

  @override
  String get logList => 'log';

  @override
  String get clearMealList => 'Clear log list';

  @override
  String get logListEmptyMessage => 'Nothing logged yet\n What did you have for lunch?';

  @override
  String get backToDashboard => 'Back to dashboard';

  @override
  String get backToTodayLogging => 'Back to Today';

  @override
  String get hello => 'Hello';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get logYourWeight => 'Log your weight';

  @override
  String get mealLog => 'Meal log';

  @override
  String get planYourMeals => 'Plan your meals';

  @override
  String get planThisMeal => 'Plan this meal';

  @override
  String get diary => 'Diary';

  @override
  String get mood => 'Mood';

  @override
  String get today => 'today';

  @override
  String get physicalActivities => 'Physical activity';

  @override
  String get physicalActivitiesPreferences => 'Physical preferences';

  @override
  String get trainingFrequency => 'Training frequency';

  @override
  String get trainingFocus => 'Training focus';

  @override
  String get didItWorkOutForYou => 'Did it work out for you?';

  @override
  String get foodPreferencesDesc =>
      'We love to offer you personal and relevant food recommendations.';

  @override
  String get foodPreferencesItemOne =>
      'Food items you don’t eat due to religious or personal reasons';

  @override
  String get foodPreferencesItemTwo => 'If you want to reduce your meat / fish intake';

  @override
  String get foodPreferencesItemThree => 'Allergies';

  @override
  String get foodPreferencesItemFour => 'Food you dislike';

  @override
  String get physicalActivitiesPreferencesDesc =>
      'We love to offer you personal and relevant physical activities.';

  @override
  String get physicalActivitiesPreferencesItemOne => 'Do you already exercise?';

  @override
  String get physicalActivitiesPreferencesItemTwo => 'How often can you train per week?';

  @override
  String get physicalActivitiesPreferencesItemThree => 'What would you like to work on?';

  @override
  String get physicalActivitiesFrequencyTitle => 'How often do you want to train per week?';

  @override
  String get physicalActivitiesFrequencyItemOne => '1 time';

  @override
  String get physicalActivitiesFrequencyItemTwo => '2 times';

  @override
  String get physicalActivitiesFrequencyItemThree => '3 times';

  @override
  String get physicalActivitiesFrequencyItemFour => '4 times';

  @override
  String get physicalActivitiesFrequencyItemFive => '5 times';

  @override
  String get physicalActivitiesFrequencyItemSix => 'Currently not able to exercise';

  @override
  String get physicalActivitiesFrequencyZero => 'I am currently not able to exercise';

  @override
  String get physicalActivitiesNoActivities => 'No activities:';

  @override
  String get whatWouldYouLikeToStartWorkingOn => 'What would you like to start working on?';

  @override
  String get buildUpMuscle => 'Build up muscle';

  @override
  String get inceaseYourStamina => 'Increase your stamina';

  @override
  String get youCanAlsoOptionally => 'You can also optionally work on your body’s mobility.';

  @override
  String get moreFlexibility => 'Become more flexible';

  @override
  String get physicalActivitiesCompletedTitle => 'Why it is important to exercise?';

  @override
  String get physicalActivitiesCompletedDesc =>
      'Your preference have been added to your profile. You can update them later.';

  @override
  String get physicalActivitiesUnlockedTitle => 'Physical activities unlocked.';

  @override
  String get physicalActivitiesUnlockedText =>
      'You will get recommended exercises based on your preferences.';

  @override
  String get physicalExercises => 'Physical exercises';

  @override
  String get perWeek => 'per week';

  @override
  String get supportGroup => 'Support group';

  @override
  String get account => 'Account';

  @override
  String get education => 'Education';

  @override
  String get preferableInTheMorning => 'Preferably in the morning';

  @override
  String get noWeightLogged => 'No weight logged';

  @override
  String get ok => 'ok';

  @override
  String get todaysWeight => 'Today\'s weight';

  @override
  String get all => 'All';

  @override
  String get general => 'General';

  @override
  String get nutrition => 'Nutrition';

  @override
  String get mind => 'Mind';

  @override
  String get activity => 'Activity';

  @override
  String get noMealsLogged => 'No meals logged';

  @override
  String get noMealsPlanned => 'No meals planned';

  @override
  String get noMealsLoggedYet => 'No meals logged yet';

  @override
  String get noMealsPlannedYet => 'No meals planned yet';

  @override
  String get summary => 'Summary';

  @override
  String get instructions => 'Instructions';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get addToMyDishes => 'Add to My dishes';

  @override
  String get addToMyDishedAs => 'Add to My dishes as';

  @override
  String get giveNameToThisDish => 'Name this dish';

  @override
  String get save => 'Save';

  @override
  String get cookingTime => 'Cooking\ntime';

  @override
  String get preparation => 'Preparation';

  @override
  String get preparationTime => 'Preparation\ntime';

  @override
  String get show => 'Show';

  @override
  String get portions => 'Portions';

  @override
  String get howToPrepare => 'How to prepare';

  @override
  String get searchEmptyResultTitle => 'Sorry no results for this one';

  @override
  String get searchEmptyResultText => 'Maybe check your spelling or try another term';

  @override
  String get createMyDish => 'Create my dish';

  @override
  String get logItem => 'Log item';

  @override
  String get deleteDish => 'Delete this dish';

  @override
  String get deleteModalMessage =>
      'Are you sure you want to delete your account? This action is not reversible';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get signOut => 'Sign out';

  @override
  String get yesDelete => 'Yes, delete';

  @override
  String get deleteMealModalMessage => 'Are you sure you want to remove this meal?';

  @override
  String deleteMultiDateMealModalMessage(String mealCategory) {
    return 'Remove this $mealCategory';
  }

  @override
  String get deleteMultiDateMealModalExplain =>
      'You planned this meal on multiple dates. \nIt will be removed from all days';

  @override
  String get deleteMultiDateMealModalExplain2 =>
      'If you wan to remove it from specific days, then you can do that in the datepicker';

  @override
  String get openDatepicker => 'Open datepicker';

  @override
  String get remove => 'Remove';

  @override
  String get recommendations => 'Recommendations';

  @override
  String get noCancel => 'No, cancel';

  @override
  String get recentSearch => 'Recent searches';

  @override
  String get dishWasSaved => 'Dish was saved';

  @override
  String get foodItemWasAddedToDish => 'Food item was added to the dish';

  @override
  String get foodItemWasDeletedFromDish => 'Food item was removed from the dish';

  @override
  String get invalidDishNameMessage => 'Give this dish a name please';

  @override
  String get invalidDishServingsAmountMessage => 'Serving size can\'t be empty';

  @override
  String get invalidDishSelectedMealCategory => 'At least one meal category should be selected';

  @override
  String get invalidDishPortionsAmountMessage => 'Portions can\'t be empty';

  @override
  String get availableIn => 'Available in';

  @override
  String get psychology => 'psychology';

  @override
  String get medical => 'medical';

  @override
  String get community => 'community';

  @override
  String get invalidCreateDishFromMealMessage =>
      'A dish cannot contain other dishes or recipes. Please remove dishes or recipes and try again';

  @override
  String get readText => 'Read text version';

  @override
  String get backToToday => 'Back to today';

  @override
  String get backToEducation => 'Back to education';

  @override
  String get backToThePool => 'Back to the pool';

  @override
  String get completed => 'Completed';

  @override
  String get complete => 'Complete';

  @override
  String get todo => 'Todo';

  @override
  String get done => 'Done';

  @override
  String get physicalActivity => 'Physical activity';

  @override
  String get selectYourProgram => 'Select your program';

  @override
  String get selectExerciseType => 'Exercise type';

  @override
  String get yourOwnActivity => 'Your own activity';

  @override
  String countExercises(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Contains the following $count exercises',
      one: 'Contains the following $count exercise',
    );
    return '$_temp0';
  }

  @override
  String get strength => 'Strength';

  @override
  String get endurance => 'Endurance';

  @override
  String get mobility => 'Mobility';

  @override
  String get yourLocation => 'Your location';

  @override
  String get home => 'Home';

  @override
  String get office => 'Office';

  @override
  String get outdoor => 'Outdoor';

  @override
  String get desiredDifficulty => 'Desired difficulty';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get logActivity => 'Log activity';

  @override
  String get whatPhysicalActivityDidYouDo => 'What physical activity did you do?';

  @override
  String get errorActivityMessage => 'Text activity name must be less than 30 symbols';

  @override
  String get strengthPrograms => 'Strength programs';

  @override
  String get yourProfile => 'Your profile';

  @override
  String get reportAbuse => 'Report abuse';

  @override
  String get inCaseOfEmergency => 'In case of emergency';

  @override
  String get personalDetails => 'Personal details';

  @override
  String get testResults => 'Test results';

  @override
  String get preferences => 'Preferences';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email address';

  @override
  String get changePassword => 'Change password';

  @override
  String get useFaceOrTouchId => 'Use Face or touch ID';

  @override
  String get requireLoginEachTime => 'Require login each time app is used';

  @override
  String get food => 'Food';

  @override
  String get group => 'Group';

  @override
  String get groupSessions => 'Support group';

  @override
  String get foodPreferences => 'Food preferences';

  @override
  String get dontEat => 'Don\'t eat';

  @override
  String get dontLike => 'Don\'t like';

  @override
  String get howHard => 'How hard was this program for you?';

  @override
  String get veryEasy => 'very easy';

  @override
  String get veryHard => 'very hard';

  @override
  String get rotateDevice => 'Please rotate your device and use your LeanOnMe phone stand';

  @override
  String get skipExplanation => 'Skip explanation';

  @override
  String get repeat => 'Repeat';

  @override
  String exerciseCompleteMessage(String currentIndex, String length) {
    return 'Great! You completed\nexercise $currentIndex of $length';
  }

  @override
  String get activitiesForThisWeek => 'activities for this week';

  @override
  String get didYouLikeThisProgram => 'Did you like the program?';

  @override
  String get backToTodayNotLogged => 'Back to today (not logged)';

  @override
  String get notReally => 'No';

  @override
  String get yesYes => 'Yes!';

  @override
  String get recommended => 'Recommended';

  @override
  String get alternatives => 'Alternatives';

  @override
  String equipment(String equipment) {
    return 'Equipment: $equipment';
  }

  @override
  String targetMuscles(String targetMuscles) {
    return 'Target muscles: $targetMuscles';
  }

  @override
  String get breakBetweenExercises => 'short break before next exercise';

  @override
  String get inProgress => 'in progress';

  @override
  String logAs(String mealCategory) {
    return 'Log as $mealCategory';
  }

  @override
  String get skip => 'Skip';

  @override
  String get plannedMeals => 'planned meals';

  @override
  String get loggedMeals => 'logged meals';

  @override
  String get hey => 'Hey';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get cancel => 'Cancel';

  @override
  String get missed => 'Missed';

  @override
  String get saved => 'Saved!';

  @override
  String get notEnrolledInGroup => 'You are currently not enrolled in a group';

  @override
  String get supportGroupPaidSubscriptionNotGrouped =>
      'You have a paid subscription, but are currently not enrolled in a group';

  @override
  String get supportGroupTrialSubscriptionNotGrouped =>
      'You are currently in your free trial period. This feature will be available with a paid subscription. Once your free trial is over, you can enrol here or in your profile';

  @override
  String get updateRequired => 'Update required';

  @override
  String get updateRequiredBodyText1 =>
      'To ensure a seamless experience and access to new features, It\'s essential to update to the latest version of LeanOnMe';

  @override
  String get updateRequiredBodyText2 => 'The previous version is no longer supported';

  @override
  String get updatePoliciesDocuments => 'Important Update: Our Policies Have Changed';

  @override
  String get updatePoliciesDocumentsBodyText1 =>
      'To continue using our app, please review and accept the following documents';

  @override
  String get updatePoliciesDocumentsBodyText2 =>
      'If you do not agree with the new terms, you can delete your account by contacting our support at';

  @override
  String get nextWeekTopic => 'The topic for next week’s session will be made available soon';

  @override
  String get registrationCodePlaceholder => 'Your access code';

  @override
  String get registrationCodeTitle => 'Enter access code';

  @override
  String get registrationCodeLabel => 'Enter the access code you received via email.';

  @override
  String get checkAccessCode => 'Check code';

  @override
  String get noAccessCodeYet => 'No access code yet? ';

  @override
  String get physicalActivitiesPreferencesLabel => 'Physical activities preferences';

  @override
  String get requestCode => 'Request code';

  @override
  String get calorie => 'calorie';

  @override
  String get dencity => 'dencity';

  @override
  String get protein => 'protein';

  @override
  String get degree => 'degree';

  @override
  String get fiber => 'fiber';

  @override
  String get dailyCalorieBudget => 'Daily calorie budget';

  @override
  String get dailyCalorieBudgetDescription =>
      'Your daily calorie budget shows your estimated calorie intake necessary to lose weight. Importantly, the better your diets calorie density, protein score, and fiber content is, the easier it will feel to naturally eat calories within this range.';

  @override
  String get dailyCalorieBudgetLink => 'What’s Missing If You Track Calories Alone.';

  @override
  String get calorieDensityHighQualityDescription =>
      'Nice work! This is a very filling meal. The combination of items you chose will help you fight excessive hunger and cravings!';

  @override
  String get calorieDensityHighQualityLabel => 'Very Filling';

  @override
  String get calorieDensityMidQualityDescription =>
      'The density of this meal is average. If you struggle with excessive hunger throughout the day, consider adding more low dense options!';

  @override
  String get calorieDensityMidQualityLabel => 'Somewhat Filling';

  @override
  String get calorieDensityLowQualityDescription =>
      'The density of the meal you logged is high. A daily density at this level will make it more likely you eat in excess today.';

  @override
  String get calorieDensityLowQualityLabel => 'Not Filling';

  @override
  String get proteinDegreeLowQualityDescription =>
      'The percentage of protein in this meal is very low. You will likely struggle with excessive hunger and cravings throughout the day. Increasing the portion of protein in this meal above 25% will improve it.';

  @override
  String get proteinDegreeLowQualityLabel => 'Needs Improvement';

  @override
  String get proteinDegreeLowMidQualityDescription =>
      'The percentage of protein in this meal is slightly low. You may struggle with excessive hunger and cravings throughout the day. Increasing the portion of protein in this meal above 25% will improve it.';

  @override
  String get proteinDegreeLowMidQualityLabel => 'Could be better';

  @override
  String get proteinDegreeMidQualityDescription =>
      'The percentage of protein in this meal is okay. If you struggle with excessive hunger and cravings throughout the day, increasing the portion of protein in this meal above 25% will improve it.';

  @override
  String get proteinDegreeMidQualityLabel => 'Average';

  @override
  String get proteinDegreeHighQualityDescription =>
      'Nice work! The protein content of this meal will help you fight excessive hunger and cravings throughout your day!';

  @override
  String get proteinDegreeHighQualityLabel => 'Good';

  @override
  String get fiberHighQualityLabel => 'High quality';

  @override
  String get fiberMidQualityLabel => 'Mixed quality';

  @override
  String get fiberLowQualityLabel => 'Low quality';

  @override
  String get notSignificant => 'Not significant';

  @override
  String get insignificant => 'Insignificant';

  @override
  String get practice => 'Practice';

  @override
  String get pool => 'Pool';

  @override
  String get mindDashboardTitle => 'Mind training';

  @override
  String get mindDashboardBtn => 'Choose exercise';

  @override
  String get maintenanceLabel => 'Maintenance';

  @override
  String get maintenancePageTitle => 'We’ll be back soon!';

  @override
  String get maintenancePageDescription =>
      'We’re currently releasing exciting new content, if you’ve opted in, you’ll receive a push notification when we’re back online.\n\nSubscribe to our newsletter to get a sneak peak at what’s coming up!';

  @override
  String get noAlternativesAvailable => 'No alternatives available';

  @override
  String get chooseAlternative => 'Choose alternative';
}
