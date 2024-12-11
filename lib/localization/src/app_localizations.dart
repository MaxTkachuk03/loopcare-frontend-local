import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'src/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('de'), Locale('en')];

  /// No description provided for @interactiveLessonsTextAreaLabel.
  ///
  /// In en, this message translates to:
  /// **'Your thoughts'**
  String get interactiveLessonsTextAreaLabel;

  /// No description provided for @interactiveLessonsMultipleChoiceBtnLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get interactiveLessonsMultipleChoiceBtnLabel;

  /// No description provided for @interactiveLessonsScaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate on a scale'**
  String get interactiveLessonsScaleLabel;

  /// No description provided for @interactiveLessonsSingleSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Single answer'**
  String get interactiveLessonsSingleSelectLabel;

  /// No description provided for @interactiveLessonsMultipleSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose All That Apply'**
  String get interactiveLessonsMultipleSelectLabel;

  /// No description provided for @interactiveLessonsCorrectFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'This is correct'**
  String get interactiveLessonsCorrectFeedbackTitle;

  /// No description provided for @interactiveLessonsIncorrectFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'This is incorrect'**
  String get interactiveLessonsIncorrectFeedbackTitle;

  /// No description provided for @interactiveLessonsScaleFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Scale selection feedback'**
  String get interactiveLessonsScaleFeedbackTitle;

  /// No description provided for @interactiveLessonsOrderingLabel.
  ///
  /// In en, this message translates to:
  /// **'Arrange in order'**
  String get interactiveLessonsOrderingLabel;

  /// No description provided for @interactiveLessonsOrderingCheck.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get interactiveLessonsOrderingCheck;

  /// No description provided for @interactiveLessonsOrderingShowAnswer.
  ///
  /// In en, this message translates to:
  /// **'Show answer'**
  String get interactiveLessonsOrderingShowAnswer;

  /// No description provided for @errorValidationIosMinVersionNotANumber.
  ///
  /// In en, this message translates to:
  /// **'iOS minimum version must be a number.'**
  String get errorValidationIosMinVersionNotANumber;

  /// No description provided for @errorValidationIosMinVersionNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'iOS minimum version must be an integer.'**
  String get errorValidationIosMinVersionNotAnInteger;

  /// No description provided for @errorValidationIosMinVersionNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'iOS minimum version must be a positive number.'**
  String get errorValidationIosMinVersionNotAPositiveNumber;

  /// No description provided for @errorValidationAndroidMinVersionNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Android minimum version must be a number.'**
  String get errorValidationAndroidMinVersionNotANumber;

  /// No description provided for @errorValidationAndroidMinVersionNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Android minimum version must be an integer.'**
  String get errorValidationAndroidMinVersionNotAnInteger;

  /// No description provided for @errorValidationAndroidMinVersionNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Android minimum version must be a positive number.'**
  String get errorValidationAndroidMinVersionNotAPositiveNumber;

  /// No description provided for @errorValidationTermsAndConditionsVersionNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions version must be a number.'**
  String get errorValidationTermsAndConditionsVersionNotANumber;

  /// No description provided for @errorValidationTermsAndConditionsVersionNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions version must be an integer.'**
  String get errorValidationTermsAndConditionsVersionNotAnInteger;

  /// No description provided for @errorValidationTermsAndConditionsVersionNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions version must be a positive number.'**
  String get errorValidationTermsAndConditionsVersionNotAPositiveNumber;

  /// No description provided for @errorValidationPrivacyPolicyVersionNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy version must be a number.'**
  String get errorValidationPrivacyPolicyVersionNotANumber;

  /// No description provided for @errorValidationPrivacyPolicyVersionNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy version must be an integer.'**
  String get errorValidationPrivacyPolicyVersionNotAnInteger;

  /// No description provided for @errorValidationPrivacyPolicyVersionNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy version must be a positive number.'**
  String get errorValidationPrivacyPolicyVersionNotAPositiveNumber;

  /// No description provided for @errorValidationRefreshTokenNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Refresh token must be a valid JWT.'**
  String get errorValidationRefreshTokenNotAJwt;

  /// No description provided for @errorValidationVersionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Version cannot be empty.'**
  String get errorValidationVersionEmpty;

  /// No description provided for @errorValidationVersionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Version must be a string.'**
  String get errorValidationVersionNotAString;

  /// No description provided for @errorValidationNotificationTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Notification type is invalid.'**
  String get errorValidationNotificationTypeInvalidEnum;

  /// No description provided for @errorValidationPurchaseTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Purchase token cannot be empty.'**
  String get errorValidationPurchaseTokenEmpty;

  /// No description provided for @errorValidationPurchaseTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Purchase token must be a string.'**
  String get errorValidationPurchaseTokenNotAString;

  /// No description provided for @errorValidationSubscriptionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subscription ID cannot be empty.'**
  String get errorValidationSubscriptionIdEmpty;

  /// No description provided for @errorValidationSubscriptionIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Subscription ID must be a string.'**
  String get errorValidationSubscriptionIdNotAString;

  /// No description provided for @errorValidationPackageNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Package name cannot be empty.'**
  String get errorValidationPackageNameEmpty;

  /// No description provided for @errorValidationPackageNameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Package name must be a string.'**
  String get errorValidationPackageNameNotAString;

  /// No description provided for @errorValidationEventTimeMillisNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Event time must be a valid number string.'**
  String get errorValidationEventTimeMillisNotANumberString;

  /// No description provided for @errorValidationSubscriptionNotificationEmptyObject.
  ///
  /// In en, this message translates to:
  /// **'Subscription notification cannot be an empty object.'**
  String get errorValidationSubscriptionNotificationEmptyObject;

  /// No description provided for @errorValidationFilenameStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Filename is too short.'**
  String get errorValidationFilenameStringTooShort;

  /// No description provided for @errorValidationFilenameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Filename must be a string.'**
  String get errorValidationFilenameNotAString;

  /// No description provided for @errorValidationFilenameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Filename cannot be empty.'**
  String get errorValidationFilenameEmpty;

  /// No description provided for @errorValidationMimetypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'MIME type is invalid.'**
  String get errorValidationMimetypeInvalidEnum;

  /// No description provided for @errorValidationMimetypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'MIME type must be a string.'**
  String get errorValidationMimetypeNotAString;

  /// No description provided for @errorValidationMimetypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'MIME type cannot be empty.'**
  String get errorValidationMimetypeEmpty;

  /// No description provided for @errorValidationFieldnameInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Field name is invalid.'**
  String get errorValidationFieldnameInvalidEnum;

  /// No description provided for @errorValidationFieldnameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field name cannot be empty.'**
  String get errorValidationFieldnameEmpty;

  /// No description provided for @errorValidationFieldnameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Field name must be a string.'**
  String get errorValidationFieldnameNotAString;

  /// No description provided for @errorValidationPasswordPasswordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'We were unable to update your email address. Please check your credentials and try again'**
  String get errorValidationPasswordPasswordTooWeak;

  /// No description provided for @errorValidationPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty.'**
  String get errorValidationPasswordEmpty;

  /// No description provided for @errorValidationPasswordNotAString.
  ///
  /// In en, this message translates to:
  /// **'Password must be a string.'**
  String get errorValidationPasswordNotAString;

  /// No description provided for @errorValidationEmailStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Email is too long.'**
  String get errorValidationEmailStringTooLong;

  /// No description provided for @errorValidationEmailStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Email is too short.'**
  String get errorValidationEmailStringTooShort;

  /// No description provided for @errorValidationEmailInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Email is invalid.'**
  String get errorValidationEmailInvalidEmail;

  /// No description provided for @errorValidationEmailNotAString.
  ///
  /// In en, this message translates to:
  /// **'Email must be a string.'**
  String get errorValidationEmailNotAString;

  /// No description provided for @errorValidationNameStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name is too long.'**
  String get errorValidationNameStringTooLong;

  /// No description provided for @errorValidationNameStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name is too short.'**
  String get errorValidationNameStringTooShort;

  /// No description provided for @errorValidationNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty.'**
  String get errorValidationNameEmpty;

  /// No description provided for @errorValidationNameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Name must be a string.'**
  String get errorValidationNameNotAString;

  /// No description provided for @errorValidationInvitationTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Invitation token cannot be empty.'**
  String get errorValidationInvitationTokenEmpty;

  /// No description provided for @errorValidationInvitationTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Invitation token must be a string.'**
  String get errorValidationInvitationTokenNotAString;

  /// No description provided for @errorValidationInvitationTokenNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Invitation token must be a valid JWT.'**
  String get errorValidationInvitationTokenNotAJwt;

  /// No description provided for @errorValidationNumberOfUnitsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Number of units cannot be empty.'**
  String get errorValidationNumberOfUnitsEmpty;

  /// No description provided for @errorValidationNumberOfUnitsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Number of units must be a number.'**
  String get errorValidationNumberOfUnitsNotANumber;

  /// No description provided for @errorValidationNumberOfUnitsNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Number of units must be a positive number.'**
  String get errorValidationNumberOfUnitsNotAPositiveNumber;

  /// No description provided for @errorValidationNumberOfUnitsNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Number of units is too big.'**
  String get errorValidationNumberOfUnitsNumberTooBig;

  /// No description provided for @errorValidationNumberOfUnitsNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Number of units is too small.'**
  String get errorValidationNumberOfUnitsNumberTooSmall;

  /// No description provided for @errorValidationFoodItemIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Food item ID cannot be empty.'**
  String get errorValidationFoodItemIdEmpty;

  /// No description provided for @errorValidationFoodItemIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Food item ID must be a valid number string.'**
  String get errorValidationFoodItemIdNotANumberString;

  /// No description provided for @errorValidationServingIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Serving ID cannot be empty.'**
  String get errorValidationServingIdEmpty;

  /// No description provided for @errorValidationServingIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Serving ID must be a valid number string.'**
  String get errorValidationServingIdNotANumberString;

  /// No description provided for @errorValidationMealCategoriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Meal categories cannot be empty.'**
  String get errorValidationMealCategoriesEmpty;

  /// No description provided for @errorValidationMealCategoriesNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Meal categories must be an array.'**
  String get errorValidationMealCategoriesNotAnArray;

  /// No description provided for @errorValidationMealCategoriesEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Meal categories cannot be an empty array.'**
  String get errorValidationMealCategoriesEmptyArray;

  /// No description provided for @errorValidationMealCategoriesInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Meal categories contain an invalid value.'**
  String get errorValidationMealCategoriesInvalidEnum;

  /// No description provided for @errorValidationNicknameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nickname cannot be empty.'**
  String get errorValidationNicknameEmpty;

  /// No description provided for @errorValidationNicknameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Nickname must be a string.'**
  String get errorValidationNicknameNotAString;

  /// No description provided for @errorValidationNicknameStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Nickname is too long.'**
  String get errorValidationNicknameStringTooLong;

  /// No description provided for @errorValidationNicknameStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Nickname is too short.'**
  String get errorValidationNicknameStringTooShort;

  /// No description provided for @errorValidationGenderPreferenceEmpty.
  ///
  /// In en, this message translates to:
  /// **'Gender preference cannot be empty.'**
  String get errorValidationGenderPreferenceEmpty;

  /// No description provided for @errorValidationGenderPreferenceInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Gender preference is invalid.'**
  String get errorValidationGenderPreferenceInvalidEnum;

  /// No description provided for @errorValidationTimezoneEmpty.
  ///
  /// In en, this message translates to:
  /// **'Timezone cannot be empty.'**
  String get errorValidationTimezoneEmpty;

  /// No description provided for @errorValidationTimezoneNotAString.
  ///
  /// In en, this message translates to:
  /// **'Timezone must be a string.'**
  String get errorValidationTimezoneNotAString;

  /// No description provided for @errorValidationRulesAcceptedNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Rules accepted must be a boolean.'**
  String get errorValidationRulesAcceptedNotABoolean;

  /// No description provided for @errorValidationMealIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Meal ID cannot be empty.'**
  String get errorValidationMealIdEmpty;

  /// No description provided for @errorValidationMealIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Meal ID must be a number.'**
  String get errorValidationMealIdNotANumber;

  /// No description provided for @errorValidationMealIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Meal ID must be an integer.'**
  String get errorValidationMealIdNotAnInteger;

  /// No description provided for @errorValidationMealIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Meal ID must be a positive number.'**
  String get errorValidationMealIdNotAPositiveNumber;

  /// No description provided for @errorValidationMealRecipeIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID cannot be empty.'**
  String get errorValidationMealRecipeIdEmpty;

  /// No description provided for @errorValidationMealRecipeIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID must be a number.'**
  String get errorValidationMealRecipeIdNotANumber;

  /// No description provided for @errorValidationMealRecipeIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID must be an integer.'**
  String get errorValidationMealRecipeIdNotAnInteger;

  /// No description provided for @errorValidationMealRecipeIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID must be a positive number.'**
  String get errorValidationMealRecipeIdNotAPositiveNumber;

  /// No description provided for @errorValidationTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Type is invalid.'**
  String get errorValidationTypeInvalidEnum;

  /// No description provided for @errorValidationMealCategoryInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Meal category is invalid.'**
  String get errorValidationMealCategoryInvalidEnum;

  /// No description provided for @errorValidationStartDateNotAString.
  ///
  /// In en, this message translates to:
  /// **'Start date must be a string.'**
  String get errorValidationStartDateNotAString;

  /// No description provided for @errorValidationStartDateNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Start date must be a valid date string.'**
  String get errorValidationStartDateNotADateString;

  /// No description provided for @errorValidationEndDateNotAString.
  ///
  /// In en, this message translates to:
  /// **'End date must be a string.'**
  String get errorValidationEndDateNotAString;

  /// No description provided for @errorValidationEndDateNotADateString.
  ///
  /// In en, this message translates to:
  /// **'End date must be a valid date string.'**
  String get errorValidationEndDateNotADateString;

  /// No description provided for @errorValidationPregnantEmpty.
  ///
  /// In en, this message translates to:
  /// **'Pregnant field cannot be empty.'**
  String get errorValidationPregnantEmpty;

  /// No description provided for @errorValidationPregnantNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Pregnant field must be a boolean.'**
  String get errorValidationPregnantNotABoolean;

  /// No description provided for @errorValidationMedicinesNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Medicines must be an array.'**
  String get errorValidationMedicinesNotAnArray;

  /// No description provided for @errorValidationMedicinesEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Medicines cannot be an empty array.'**
  String get errorValidationMedicinesEmptyArray;

  /// No description provided for @errorValidationUseSemaglutideMedicationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Use of semaglutide medication must be a string.'**
  String get errorValidationUseSemaglutideMedicationNotAString;

  /// No description provided for @errorValidationHowLongTakeSemaglutideMedicationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Duration of taking semaglutide medication must be a string.'**
  String get errorValidationHowLongTakeSemaglutideMedicationNotAString;

  /// No description provided for @errorValidationHowLongSemaglutideTreatmentLastNotAString.
  ///
  /// In en, this message translates to:
  /// **'Duration of semaglutide treatment must be a string.'**
  String get errorValidationHowLongSemaglutideTreatmentLastNotAString;

  /// No description provided for @errorValidationIsUseSemaglutideMedicationNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Use of semaglutide medication must be a boolean.'**
  String get errorValidationIsUseSemaglutideMedicationNotABoolean;

  /// No description provided for @errorValidationObesityNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Obesity field must be a boolean.'**
  String get errorValidationObesityNotABoolean;

  /// No description provided for @errorValidationObesityEmpty.
  ///
  /// In en, this message translates to:
  /// **'Obesity field cannot be empty.'**
  String get errorValidationObesityEmpty;

  /// No description provided for @errorValidationThyroidDiseaseEmpty.
  ///
  /// In en, this message translates to:
  /// **'Thyroid disease field cannot be empty.'**
  String get errorValidationThyroidDiseaseEmpty;

  /// No description provided for @errorValidationThyroidDiseaseNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Thyroid disease field must be a boolean.'**
  String get errorValidationThyroidDiseaseNotABoolean;

  /// No description provided for @errorValidationMetabolicDiseaseEmpty.
  ///
  /// In en, this message translates to:
  /// **'Metabolic disease field cannot be empty.'**
  String get errorValidationMetabolicDiseaseEmpty;

  /// No description provided for @errorValidationMetabolicDiseaseNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Metabolic disease field must be a boolean.'**
  String get errorValidationMetabolicDiseaseNotABoolean;

  /// No description provided for @errorValidationHypertensionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Hypertension field cannot be empty.'**
  String get errorValidationHypertensionEmpty;

  /// No description provided for @errorValidationHypertensionNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Hypertension field must be a boolean.'**
  String get errorValidationHypertensionNotABoolean;

  /// No description provided for @errorValidationCardiovascularDiseaseEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular disease field cannot be empty.'**
  String get errorValidationCardiovascularDiseaseEmpty;

  /// No description provided for @errorValidationCardiovascularDiseaseNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular disease field must be a boolean.'**
  String get errorValidationCardiovascularDiseaseNotABoolean;

  /// No description provided for @errorValidationStomachReductionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Stomach reduction field cannot be empty.'**
  String get errorValidationStomachReductionEmpty;

  /// No description provided for @errorValidationStomachReductionNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Stomach reduction field must be a boolean.'**
  String get errorValidationStomachReductionNotABoolean;

  /// No description provided for @errorValidationDiabetesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Diabetes field cannot be empty.'**
  String get errorValidationDiabetesEmpty;

  /// No description provided for @errorValidationDiabetesNotAString.
  ///
  /// In en, this message translates to:
  /// **'Diabetes field must be a string.'**
  String get errorValidationDiabetesNotAString;

  /// No description provided for @errorValidationRenalFailureEmpty.
  ///
  /// In en, this message translates to:
  /// **'Renal failure field cannot be empty.'**
  String get errorValidationRenalFailureEmpty;

  /// No description provided for @errorValidationRenalFailureNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Renal failure field must be a boolean.'**
  String get errorValidationRenalFailureNotABoolean;

  /// No description provided for @errorValidationAsthmaEmpty.
  ///
  /// In en, this message translates to:
  /// **'Asthma field cannot be empty.'**
  String get errorValidationAsthmaEmpty;

  /// No description provided for @errorValidationAsthmaNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Asthma field must be a boolean.'**
  String get errorValidationAsthmaNotABoolean;

  /// No description provided for @errorValidationLiverDiseaseEmpty.
  ///
  /// In en, this message translates to:
  /// **'Liver disease field cannot be empty.'**
  String get errorValidationLiverDiseaseEmpty;

  /// No description provided for @errorValidationLiverDiseaseNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Liver disease field must be a boolean.'**
  String get errorValidationLiverDiseaseNotABoolean;

  /// No description provided for @errorValidationSleepApneaSyndromeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Sleep apnea syndrome field cannot be empty.'**
  String get errorValidationSleepApneaSyndromeEmpty;

  /// No description provided for @errorValidationSleepApneaSyndromeNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Sleep apnea syndrome field must be a boolean.'**
  String get errorValidationSleepApneaSyndromeNotABoolean;

  /// No description provided for @errorValidationLocomotorSystemDiseaseEmpty.
  ///
  /// In en, this message translates to:
  /// **'Locomotor system disease field cannot be empty.'**
  String get errorValidationLocomotorSystemDiseaseEmpty;

  /// No description provided for @errorValidationLocomotorSystemDiseaseNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Locomotor system disease field must be a boolean.'**
  String get errorValidationLocomotorSystemDiseaseNotABoolean;

  /// No description provided for @errorValidationTreatedByPsychiatristEmpty.
  ///
  /// In en, this message translates to:
  /// **'Treated by psychiatrist field cannot be empty.'**
  String get errorValidationTreatedByPsychiatristEmpty;

  /// No description provided for @errorValidationTreatedByPsychiatristNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Treated by psychiatrist field must be a boolean.'**
  String get errorValidationTreatedByPsychiatristNotABoolean;

  /// No description provided for @errorValidationItemStateNotFromDefinedList.
  ///
  /// In en, this message translates to:
  /// **'Item state must be from the defined list.'**
  String get errorValidationItemStateNotFromDefinedList;

  /// No description provided for @errorValidationItemStateNotAString.
  ///
  /// In en, this message translates to:
  /// **'Item state must be a string.'**
  String get errorValidationItemStateNotAString;

  /// No description provided for @errorValidationHatesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Hates field cannot be empty.'**
  String get errorValidationHatesEmpty;

  /// No description provided for @errorValidationHatesNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Hates field must be an array.'**
  String get errorValidationHatesNotAnArray;

  /// No description provided for @errorValidationHatesNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Hates field must be a number.'**
  String get errorValidationHatesNotANumber;

  /// No description provided for @errorValidationHatesNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Hates field must be an integer.'**
  String get errorValidationHatesNotAnInteger;

  /// No description provided for @errorValidationHatesNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Hates field must be a positive number.'**
  String get errorValidationHatesNotAPositiveNumber;

  /// No description provided for @errorValidationAllergicEmpty.
  ///
  /// In en, this message translates to:
  /// **'Allergic field cannot be empty.'**
  String get errorValidationAllergicEmpty;

  /// No description provided for @errorValidationAllergicNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Allergic field must be an array.'**
  String get errorValidationAllergicNotAnArray;

  /// No description provided for @errorValidationAllergicNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Allergic field must be a number.'**
  String get errorValidationAllergicNotANumber;

  /// No description provided for @errorValidationAllergicNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Allergic field must be an integer.'**
  String get errorValidationAllergicNotAnInteger;

  /// No description provided for @errorValidationAllergicNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Allergic field must be a positive number.'**
  String get errorValidationAllergicNotAPositiveNumber;

  /// No description provided for @errorValidationDislikeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Dislike field cannot be empty.'**
  String get errorValidationDislikeEmpty;

  /// No description provided for @errorValidationDislikeNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Dislike field must be an array.'**
  String get errorValidationDislikeNotAnArray;

  /// No description provided for @errorValidationDislikeNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Dislike field must be a number.'**
  String get errorValidationDislikeNotANumber;

  /// No description provided for @errorValidationDislikeNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Dislike field must be an integer.'**
  String get errorValidationDislikeNotAnInteger;

  /// No description provided for @errorValidationDislikeNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Dislike field must be a positive number.'**
  String get errorValidationDislikeNotAPositiveNumber;

  /// No description provided for @errorValidationQuestionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Question ID cannot be empty.'**
  String get errorValidationQuestionIdEmpty;

  /// No description provided for @errorValidationQuestionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Question ID must be a number.'**
  String get errorValidationQuestionIdNotANumber;

  /// No description provided for @errorValidationQuestionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Question ID must be an integer.'**
  String get errorValidationQuestionIdNotAnInteger;

  /// No description provided for @errorValidationQuestionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Question ID must be a positive number.'**
  String get errorValidationQuestionIdNotAPositiveNumber;

  /// No description provided for @errorValidationOptionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Option ID cannot be empty.'**
  String get errorValidationOptionIdEmpty;

  /// No description provided for @errorValidationOptionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Option ID must be a number.'**
  String get errorValidationOptionIdNotANumber;

  /// No description provided for @errorValidationOptionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Option ID must be an integer.'**
  String get errorValidationOptionIdNotAnInteger;

  /// No description provided for @errorValidationOptionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Option ID must be a positive number.'**
  String get errorValidationOptionIdNotAPositiveNumber;

  /// No description provided for @errorValidationAnswersEmpty.
  ///
  /// In en, this message translates to:
  /// **'Answers field cannot be empty.'**
  String get errorValidationAnswersEmpty;

  /// No description provided for @errorValidationAnswersNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Answers field must be an array.'**
  String get errorValidationAnswersNotAnArray;

  /// No description provided for @errorValidationAnswersEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Answers field cannot be an empty array.'**
  String get errorValidationAnswersEmptyArray;

  /// No description provided for @errorValidationIsConsentApprovedEmpty.
  ///
  /// In en, this message translates to:
  /// **'Consent approved field cannot be empty.'**
  String get errorValidationIsConsentApprovedEmpty;

  /// No description provided for @errorValidationIsConsentApprovedNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Consent approved field must be a boolean.'**
  String get errorValidationIsConsentApprovedNotABoolean;

  /// No description provided for @errorValidationIsLegalApprovedEmpty.
  ///
  /// In en, this message translates to:
  /// **'Legal approved field cannot be empty.'**
  String get errorValidationIsLegalApprovedEmpty;

  /// No description provided for @errorValidationIsLegalApprovedNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Legal approved field must be a boolean.'**
  String get errorValidationIsLegalApprovedNotABoolean;

  /// No description provided for @errorValidationHeightEmpty.
  ///
  /// In en, this message translates to:
  /// **'Height field cannot be empty.'**
  String get errorValidationHeightEmpty;

  /// No description provided for @errorValidationHeightNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Height field must be a number.'**
  String get errorValidationHeightNotANumber;

  /// No description provided for @errorValidationHeightNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Height field is too big.'**
  String get errorValidationHeightNumberTooBig;

  /// No description provided for @errorValidationHeightNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Height field is too small.'**
  String get errorValidationHeightNumberTooSmall;

  /// No description provided for @errorValidationBirthDateEmpty.
  ///
  /// In en, this message translates to:
  /// **'Birth date cannot be empty.'**
  String get errorValidationBirthDateEmpty;

  /// No description provided for @errorValidationBirthDateNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Birth date must be a valid date string.'**
  String get errorValidationBirthDateNotADateString;

  /// No description provided for @errorValidationWeightEmpty.
  ///
  /// In en, this message translates to:
  /// **'Weight field cannot be empty.'**
  String get errorValidationWeightEmpty;

  /// No description provided for @errorValidationWeightNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Weight field must be a number.'**
  String get errorValidationWeightNotANumber;

  /// No description provided for @errorValidationWeightNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Weight field must be a positive number.'**
  String get errorValidationWeightNotAPositiveNumber;

  /// No description provided for @errorValidationBmiEmpty.
  ///
  /// In en, this message translates to:
  /// **'BMI field cannot be empty.'**
  String get errorValidationBmiEmpty;

  /// No description provided for @errorValidationBmiNotANumber.
  ///
  /// In en, this message translates to:
  /// **'BMI field must be a number.'**
  String get errorValidationBmiNotANumber;

  /// No description provided for @errorValidationBmiNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'BMI field must be a positive number.'**
  String get errorValidationBmiNotAPositiveNumber;

  /// No description provided for @errorValidationGenderEmpty.
  ///
  /// In en, this message translates to:
  /// **'Gender field cannot be empty.'**
  String get errorValidationGenderEmpty;

  /// No description provided for @errorValidationGenderNotAString.
  ///
  /// In en, this message translates to:
  /// **'Gender field must be a string.'**
  String get errorValidationGenderNotAString;

  /// No description provided for @errorValidationGenderInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Gender field is invalid.'**
  String get errorValidationGenderInvalidEnum;

  /// No description provided for @errorValidationSexEmpty.
  ///
  /// In en, this message translates to:
  /// **'Sex field cannot be empty.'**
  String get errorValidationSexEmpty;

  /// No description provided for @errorValidationSexNotAString.
  ///
  /// In en, this message translates to:
  /// **'Sex field must be a string.'**
  String get errorValidationSexNotAString;

  /// No description provided for @errorValidationSexInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Sex field is invalid.'**
  String get errorValidationSexInvalidEnum;

  /// No description provided for @errorValidationHappinessEmpty.
  ///
  /// In en, this message translates to:
  /// **'Happiness field cannot be empty.'**
  String get errorValidationHappinessEmpty;

  /// No description provided for @errorValidationHappinessInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Happiness field is invalid.'**
  String get errorValidationHappinessInvalidEnum;

  /// No description provided for @errorValidationMentalHealthTestEmptyObject.
  ///
  /// In en, this message translates to:
  /// **'Mental health test field cannot be an empty object.'**
  String get errorValidationMentalHealthTestEmptyObject;

  /// No description provided for @errorValidationMedicalOnboardingEmptyObject.
  ///
  /// In en, this message translates to:
  /// **'Medical onboarding field cannot be an empty object.'**
  String get errorValidationMedicalOnboardingEmptyObject;

  /// No description provided for @errorValidationCustomerIoIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Customer IO ID cannot be empty.'**
  String get errorValidationCustomerIoIdEmpty;

  /// No description provided for @errorValidationCustomerIoIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Customer IO ID must be a string.'**
  String get errorValidationCustomerIoIdNotAString;

  /// No description provided for @errorValidationNameLettersAndNumbersRequired.
  ///
  /// In en, this message translates to:
  /// **'Name must contain letters and numbers.'**
  String get errorValidationNameLettersAndNumbersRequired;

  /// No description provided for @errorValidationBucketStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Bucket string is too short.'**
  String get errorValidationBucketStringTooShort;

  /// No description provided for @errorValidationBucketLettersAndNumbersRequired.
  ///
  /// In en, this message translates to:
  /// **'Bucket must contain letters and numbers.'**
  String get errorValidationBucketLettersAndNumbersRequired;

  /// No description provided for @errorValidationBucketEmpty.
  ///
  /// In en, this message translates to:
  /// **'Bucket field cannot be empty.'**
  String get errorValidationBucketEmpty;

  /// No description provided for @errorValidationBucketNotAString.
  ///
  /// In en, this message translates to:
  /// **'Bucket field must be a string.'**
  String get errorValidationBucketNotAString;

  /// No description provided for @errorValidationDistributionUrlNotUrlAddress.
  ///
  /// In en, this message translates to:
  /// **'Distribution URL must be a valid URL address.'**
  String get errorValidationDistributionUrlNotUrlAddress;

  /// No description provided for @errorValidationDistributionUrlEmpty.
  ///
  /// In en, this message translates to:
  /// **'Distribution URL cannot be empty.'**
  String get errorValidationDistributionUrlEmpty;

  /// No description provided for @errorValidationDistributionUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'Distribution URL must be a string.'**
  String get errorValidationDistributionUrlNotAString;

  /// No description provided for @errorValidationTypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Type field must be a string.'**
  String get errorValidationTypeNotAString;

  /// No description provided for @errorValidationAccountIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Account ID cannot be empty.'**
  String get errorValidationAccountIdEmpty;

  /// No description provided for @errorValidationAccountIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Account ID must be a number.'**
  String get errorValidationAccountIdNotANumber;

  /// No description provided for @errorValidationAccountIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Account ID must be an integer.'**
  String get errorValidationAccountIdNotAnInteger;

  /// No description provided for @errorValidationAccountIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Account ID must be a positive number.'**
  String get errorValidationAccountIdNotAPositiveNumber;

  /// No description provided for @errorValidationProductIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Product ID cannot be empty.'**
  String get errorValidationProductIdEmpty;

  /// No description provided for @errorValidationProductIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Product ID must be a number.'**
  String get errorValidationProductIdNotANumber;

  /// No description provided for @errorValidationProductIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Product ID must be an integer.'**
  String get errorValidationProductIdNotAnInteger;

  /// No description provided for @errorValidationProductIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Product ID must be a positive number.'**
  String get errorValidationProductIdNotAPositiveNumber;

  /// No description provided for @errorValidationStateInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'State field is invalid.'**
  String get errorValidationStateInvalidEnum;

  /// No description provided for @errorValidationExpiresAtEmpty.
  ///
  /// In en, this message translates to:
  /// **'Expiration date cannot be empty.'**
  String get errorValidationExpiresAtEmpty;

  /// No description provided for @errorValidationExpiresAtNotADate.
  ///
  /// In en, this message translates to:
  /// **'Expiration date must be a valid date.'**
  String get errorValidationExpiresAtNotADate;

  /// No description provided for @errorValidationCreatedAtEmpty.
  ///
  /// In en, this message translates to:
  /// **'Creation date cannot be empty.'**
  String get errorValidationCreatedAtEmpty;

  /// No description provided for @errorValidationCreatedAtNotADate.
  ///
  /// In en, this message translates to:
  /// **'Creation date must be a valid date.'**
  String get errorValidationCreatedAtNotADate;

  /// No description provided for @errorValidationReceiptEmpty.
  ///
  /// In en, this message translates to:
  /// **'Receipt field cannot be empty.'**
  String get errorValidationReceiptEmpty;

  /// No description provided for @errorValidationReceiptNotAString.
  ///
  /// In en, this message translates to:
  /// **'Receipt field must be a string.'**
  String get errorValidationReceiptNotAString;

  /// No description provided for @errorValidationTransactionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID cannot be empty.'**
  String get errorValidationTransactionIdEmpty;

  /// No description provided for @errorValidationTransactionIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID must be a valid number string.'**
  String get errorValidationTransactionIdNotANumberString;

  /// No description provided for @errorValidationBaseTransactionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Base transaction ID cannot be empty.'**
  String get errorValidationBaseTransactionIdEmpty;

  /// No description provided for @errorValidationBaseTransactionIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Base transaction ID must be a valid number string.'**
  String get errorValidationBaseTransactionIdNotANumberString;

  /// No description provided for @errorValidationLinkedPurchaseTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Linked purchase token cannot be empty.'**
  String get errorValidationLinkedPurchaseTokenEmpty;

  /// No description provided for @errorValidationLinkedPurchaseTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Linked purchase token must be a string.'**
  String get errorValidationLinkedPurchaseTokenNotAString;

  /// No description provided for @errorValidationDataEmptyObject.
  ///
  /// In en, this message translates to:
  /// **'Data cannot be an empty object.'**
  String get errorValidationDataEmptyObject;

  /// No description provided for @errorValidationSignedPayloadNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Signed payload must be a valid JWT.'**
  String get errorValidationSignedPayloadNotAJwt;

  /// No description provided for @errorValidationSignedPayloadEmpty.
  ///
  /// In en, this message translates to:
  /// **'Signed payload cannot be empty.'**
  String get errorValidationSignedPayloadEmpty;

  /// No description provided for @errorValidationMessageIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Message ID cannot be empty.'**
  String get errorValidationMessageIdEmpty;

  /// No description provided for @errorValidationMessageIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Message ID must be a valid number string.'**
  String get errorValidationMessageIdNotANumberString;

  /// No description provided for @errorValidationDataEmpty.
  ///
  /// In en, this message translates to:
  /// **'Data cannot be empty.'**
  String get errorValidationDataEmpty;

  /// No description provided for @errorValidationDataNotBase64Encoded.
  ///
  /// In en, this message translates to:
  /// **'Data must be base64 encoded.'**
  String get errorValidationDataNotBase64Encoded;

  /// No description provided for @errorValidationDataNotAString.
  ///
  /// In en, this message translates to:
  /// **'Data must be a string.'**
  String get errorValidationDataNotAString;

  /// No description provided for @errorValidationMessageEmptyObject.
  ///
  /// In en, this message translates to:
  /// **'Message cannot be an empty object.'**
  String get errorValidationMessageEmptyObject;

  /// No description provided for @errorValidationSubscriptionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subscription cannot be empty.'**
  String get errorValidationSubscriptionEmpty;

  /// No description provided for @errorValidationSubscriptionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Subscription must be a string.'**
  String get errorValidationSubscriptionNotAString;

  /// No description provided for @errorValidationProductIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Product ID must be a string.'**
  String get errorValidationProductIdNotAString;

  /// No description provided for @errorValidationOfferIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Offer ID cannot be empty.'**
  String get errorValidationOfferIdEmpty;

  /// No description provided for @errorValidationOfferIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Offer ID must be a string.'**
  String get errorValidationOfferIdNotAString;

  /// No description provided for @errorValidationAccountTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Account token cannot be empty.'**
  String get errorValidationAccountTokenEmpty;

  /// No description provided for @errorValidationAccountTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Account token must be a string.'**
  String get errorValidationAccountTokenNotAString;

  /// No description provided for @errorValidationAccountTokenNotUuidV4.
  ///
  /// In en, this message translates to:
  /// **'Account token must be a valid UUID v4.'**
  String get errorValidationAccountTokenNotUuidV4;

  /// No description provided for @errorValidationVendorInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Vendor is invalid.'**
  String get errorValidationVendorInvalidEnum;

  /// No description provided for @errorValidationLiveTogetherEmpty.
  ///
  /// In en, this message translates to:
  /// **'Live together field cannot be empty.'**
  String get errorValidationLiveTogetherEmpty;

  /// No description provided for @errorValidationLiveTogetherNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Live together field must be a boolean.'**
  String get errorValidationLiveTogetherNotABoolean;

  /// No description provided for @errorValidationRelationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Relation field cannot be empty.'**
  String get errorValidationRelationEmpty;

  /// No description provided for @errorValidationRelationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Relation field must be a string.'**
  String get errorValidationRelationNotAString;

  /// No description provided for @errorValidationRelationInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Relation field is invalid.'**
  String get errorValidationRelationInvalidEnum;

  /// No description provided for @errorValidationEmailEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty.'**
  String get errorValidationEmailEmpty;

  /// No description provided for @errorValidationRegistrationTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Registration token cannot be empty.'**
  String get errorValidationRegistrationTokenEmpty;

  /// No description provided for @errorValidationRegistrationTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Registration token must be a string.'**
  String get errorValidationRegistrationTokenNotAString;

  /// No description provided for @errorValidationRegistrationTokenNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Registration token must be a valid JWT.'**
  String get errorValidationRegistrationTokenNotAJwt;

  /// No description provided for @errorValidationPasswordTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password token cannot be empty.'**
  String get errorValidationPasswordTokenEmpty;

  /// No description provided for @errorValidationPasswordTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Password token must be a string.'**
  String get errorValidationPasswordTokenNotAString;

  /// No description provided for @errorValidationPasswordTokenNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Password token must be a valid JWT.'**
  String get errorValidationPasswordTokenNotAJwt;

  /// No description provided for @errorValidationBuddyIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Buddy ID cannot be empty.'**
  String get errorValidationBuddyIdEmpty;

  /// No description provided for @errorValidationBuddyIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Buddy ID must be a number.'**
  String get errorValidationBuddyIdNotANumber;

  /// No description provided for @errorValidationBuddyIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Buddy ID must be an integer.'**
  String get errorValidationBuddyIdNotAnInteger;

  /// No description provided for @errorValidationBuddyIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Buddy ID must be a positive number.'**
  String get errorValidationBuddyIdNotAPositiveNumber;

  /// No description provided for @errorValidationIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'ID cannot be empty.'**
  String get errorValidationIdEmpty;

  /// No description provided for @errorValidationIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'ID must be a number.'**
  String get errorValidationIdNotANumber;

  /// No description provided for @errorValidationIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'ID must be an integer.'**
  String get errorValidationIdNotAnInteger;

  /// No description provided for @errorValidationIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'ID must be a positive number.'**
  String get errorValidationIdNotAPositiveNumber;

  /// No description provided for @errorValidationDishIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Dish ID cannot be empty.'**
  String get errorValidationDishIdEmpty;

  /// No description provided for @errorValidationDishIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Dish ID must be a number.'**
  String get errorValidationDishIdNotANumber;

  /// No description provided for @errorValidationDishIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Dish ID must be an integer.'**
  String get errorValidationDishIdNotAnInteger;

  /// No description provided for @errorValidationDishIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Dish ID must be a positive number.'**
  String get errorValidationDishIdNotAPositiveNumber;

  /// No description provided for @errorValidationMealCategoriesNotAString.
  ///
  /// In en, this message translates to:
  /// **'Meal categories must be a string.'**
  String get errorValidationMealCategoriesNotAString;

  /// No description provided for @errorValidationNumberOfServingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Number of servings cannot be empty.'**
  String get errorValidationNumberOfServingsEmpty;

  /// No description provided for @errorValidationNumberOfServingsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Number of servings must be a number.'**
  String get errorValidationNumberOfServingsNotANumber;

  /// No description provided for @errorValidationNumberOfServingsNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Number of servings must be a positive number.'**
  String get errorValidationNumberOfServingsNotAPositiveNumber;

  /// No description provided for @errorValidationExternalFoodItemIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'External food item ID cannot be empty.'**
  String get errorValidationExternalFoodItemIdEmpty;

  /// No description provided for @errorValidationExternalFoodItemIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'External food item ID must be a valid number string.'**
  String get errorValidationExternalFoodItemIdNotANumberString;

  /// No description provided for @errorValidationFoodItemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Food items cannot be empty.'**
  String get errorValidationFoodItemsEmpty;

  /// No description provided for @errorValidationFoodItemsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Food items must be an array.'**
  String get errorValidationFoodItemsNotAnArray;

  /// No description provided for @errorValidationFoodItemsEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Food items cannot be an empty array.'**
  String get errorValidationFoodItemsEmptyArray;

  /// No description provided for @errorValidationInternalFoodItemIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Internal food item ID cannot be empty.'**
  String get errorValidationInternalFoodItemIdEmpty;

  /// No description provided for @errorValidationInternalFoodItemIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Internal food item ID must be a number.'**
  String get errorValidationInternalFoodItemIdNotANumber;

  /// No description provided for @errorValidationInternalFoodItemIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Internal food item ID must be an integer.'**
  String get errorValidationInternalFoodItemIdNotAnInteger;

  /// No description provided for @errorValidationInternalFoodItemIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Internal food item ID must be a positive number.'**
  String get errorValidationInternalFoodItemIdNotAPositiveNumber;

  /// No description provided for @errorValidationMealRecipeIdNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID number is too big.'**
  String get errorValidationMealRecipeIdNumberTooBig;

  /// No description provided for @errorValidationMealRecipeIdNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Meal recipe ID number is too small.'**
  String get errorValidationMealRecipeIdNumberTooSmall;

  /// No description provided for @errorValidationRecipeIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID must be a number.'**
  String get errorValidationRecipeIdNotANumber;

  /// No description provided for @errorValidationRecipeIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID must be an integer.'**
  String get errorValidationRecipeIdNotAnInteger;

  /// No description provided for @errorValidationRecipeIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID must be a positive number.'**
  String get errorValidationRecipeIdNotAPositiveNumber;

  /// No description provided for @errorValidationRecipeIdNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID number is too big.'**
  String get errorValidationRecipeIdNumberTooBig;

  /// No description provided for @errorValidationRecipeIdNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Recipe ID number is too small.'**
  String get errorValidationRecipeIdNumberTooSmall;

  /// No description provided for @errorValidationRegionInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Region is invalid.'**
  String get errorValidationRegionInvalidEnum;

  /// No description provided for @errorValidationBarcodeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Barcode cannot be empty.'**
  String get errorValidationBarcodeEmpty;

  /// No description provided for @errorValidationBarcodeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Barcode must be a string.'**
  String get errorValidationBarcodeNotAString;

  /// No description provided for @errorValidationBarcodeStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Barcode string is too long.'**
  String get errorValidationBarcodeStringTooLong;

  /// No description provided for @errorValidationBarcodeStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Barcode string is too short.'**
  String get errorValidationBarcodeStringTooShort;

  /// No description provided for @errorValidationExternalFoodItemIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'External food item ID must be a string.'**
  String get errorValidationExternalFoodItemIdNotAString;

  /// No description provided for @errorValidationServingIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Serving ID must be a string.'**
  String get errorValidationServingIdNotAString;

  /// No description provided for @errorValidationFoodItemsArraySizeTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Food items array size is too small.'**
  String get errorValidationFoodItemsArraySizeTooSmall;

  /// No description provided for @errorValidationInternalRecipeIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Internal recipe ID cannot be empty.'**
  String get errorValidationInternalRecipeIdEmpty;

  /// No description provided for @errorValidationInternalRecipeIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Internal recipe ID must be a number.'**
  String get errorValidationInternalRecipeIdNotANumber;

  /// No description provided for @errorValidationInternalRecipeIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Internal recipe ID must be an integer.'**
  String get errorValidationInternalRecipeIdNotAnInteger;

  /// No description provided for @errorValidationInternalRecipeIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Internal recipe ID must be a positive number.'**
  String get errorValidationInternalRecipeIdNotAPositiveNumber;

  /// No description provided for @errorValidationLoggingDateEmpty.
  ///
  /// In en, this message translates to:
  /// **'Logging date cannot be empty.'**
  String get errorValidationLoggingDateEmpty;

  /// No description provided for @errorValidationLoggingDateNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Logging date must be a valid date string.'**
  String get errorValidationLoggingDateNotADateString;

  /// No description provided for @errorValidationMealCategoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Meal category cannot be empty.'**
  String get errorValidationMealCategoryEmpty;

  /// No description provided for @errorValidationInternalFoodItemIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Internal food item ID must be a valid number string.'**
  String get errorValidationInternalFoodItemIdNotANumberString;

  /// No description provided for @errorValidationDateEmpty.
  ///
  /// In en, this message translates to:
  /// **'Date cannot be empty.'**
  String get errorValidationDateEmpty;

  /// No description provided for @errorValidationDateNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Date must be a valid date string.'**
  String get errorValidationDateNotADateString;

  /// No description provided for @errorValidationQueryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Query cannot be empty.'**
  String get errorValidationQueryEmpty;

  /// No description provided for @errorValidationQueryNotAString.
  ///
  /// In en, this message translates to:
  /// **'Query must be a string.'**
  String get errorValidationQueryNotAString;

  /// No description provided for @errorValidationQueryStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Query string is too short.'**
  String get errorValidationQueryStringTooShort;

  /// No description provided for @errorValidationModesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Modes cannot be empty.'**
  String get errorValidationModesEmpty;

  /// No description provided for @errorValidationModesNotFromDefinedList.
  ///
  /// In en, this message translates to:
  /// **'Modes must be from the defined list.'**
  String get errorValidationModesNotFromDefinedList;

  /// No description provided for @errorValidationPageNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Page must be a number.'**
  String get errorValidationPageNotANumber;

  /// No description provided for @errorValidationPageNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Page must be an integer.'**
  String get errorValidationPageNotAnInteger;

  /// No description provided for @errorValidationPageNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Page must be a positive number.'**
  String get errorValidationPageNotAPositiveNumber;

  /// No description provided for @errorValidationPageSizeNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Page size must be a number.'**
  String get errorValidationPageSizeNotANumber;

  /// No description provided for @errorValidationPageSizeNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Page size must be an integer.'**
  String get errorValidationPageSizeNotAnInteger;

  /// No description provided for @errorValidationPageSizeNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Page size must be a positive number.'**
  String get errorValidationPageSizeNotAPositiveNumber;

  /// No description provided for @errorValidationPageSizeNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Page size number is too big.'**
  String get errorValidationPageSizeNumberTooBig;

  /// No description provided for @errorValidationPlanningDatesDateTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Planning dates date is too small.'**
  String get errorValidationPlanningDatesDateTooSmall;

  /// No description provided for @errorValidationPlanningDatesDateTooBig.
  ///
  /// In en, this message translates to:
  /// **'Planning dates date is too big.'**
  String get errorValidationPlanningDatesDateTooBig;

  /// No description provided for @errorValidationPlanningDatesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Planning dates cannot be empty.'**
  String get errorValidationPlanningDatesEmpty;

  /// No description provided for @errorValidationPlanningDatesEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Planning dates cannot be an empty array.'**
  String get errorValidationPlanningDatesEmptyArray;

  /// No description provided for @errorValidationPlanningDatesNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Planning dates must be a valid date string.'**
  String get errorValidationPlanningDatesNotADateString;

  /// No description provided for @errorValidationStartDateDateEmptyPeriod.
  ///
  /// In en, this message translates to:
  /// **'Start date cannot be empty or invalid.'**
  String get errorValidationStartDateDateEmptyPeriod;

  /// No description provided for @errorValidationPlannedMealIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Planned meal ID cannot be empty.'**
  String get errorValidationPlannedMealIdEmpty;

  /// No description provided for @errorValidationPlannedMealIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Planned meal ID must be a number.'**
  String get errorValidationPlannedMealIdNotANumber;

  /// No description provided for @errorValidationPlannedMealIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Planned meal ID must be an integer.'**
  String get errorValidationPlannedMealIdNotAnInteger;

  /// No description provided for @errorValidationPlannedMealIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Planned meal ID must be a positive number.'**
  String get errorValidationPlannedMealIdNotAPositiveNumber;

  /// No description provided for @errorValidationLoggingDateDateTooBig.
  ///
  /// In en, this message translates to:
  /// **'Logging date is too big.'**
  String get errorValidationLoggingDateDateTooBig;

  /// No description provided for @errorValidationLoggingDateDateTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Logging date is too small.'**
  String get errorValidationLoggingDateDateTooSmall;

  /// No description provided for @errorValidationLimitNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Limit number is too small.'**
  String get errorValidationLimitNumberTooSmall;

  /// No description provided for @errorValidationLimitNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Limit must be an integer.'**
  String get errorValidationLimitNotAnInteger;

  /// No description provided for @errorValidationLimitNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Limit must be a positive number.'**
  String get errorValidationLimitNotAPositiveNumber;

  /// No description provided for @errorValidationLimitNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Limit must be a number.'**
  String get errorValidationLimitNotANumber;

  /// No description provided for @errorValidationUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'URL must be a string.'**
  String get errorValidationUrlNotAString;

  /// No description provided for @errorValidationUrlNotUrlAddress.
  ///
  /// In en, this message translates to:
  /// **'URL must be a valid URL address.'**
  String get errorValidationUrlNotUrlAddress;

  /// No description provided for @errorValidationDataArraySizeTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Data array size is too small.'**
  String get errorValidationDataArraySizeTooSmall;

  /// No description provided for @errorValidationDataNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Data must be an array.'**
  String get errorValidationDataNotAnArray;

  /// No description provided for @errorValidationDateNotAString.
  ///
  /// In en, this message translates to:
  /// **'Date must be a string.'**
  String get errorValidationDateNotAString;

  /// No description provided for @errorValidationDateDateTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Date is too small.'**
  String get errorValidationDateDateTooSmall;

  /// No description provided for @errorValidationDateDateTooBig.
  ///
  /// In en, this message translates to:
  /// **'Date is too big.'**
  String get errorValidationDateDateTooBig;

  /// No description provided for @errorValidationWeightNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Weight number is too big.'**
  String get errorValidationWeightNumberTooBig;

  /// No description provided for @errorValidationStartDateDateTooBig.
  ///
  /// In en, this message translates to:
  /// **'Start date is too big.'**
  String get errorValidationStartDateDateTooBig;

  /// No description provided for @errorValidationEndDateDateTooBig.
  ///
  /// In en, this message translates to:
  /// **'End date is too big.'**
  String get errorValidationEndDateDateTooBig;

  /// No description provided for @errorValidationStateNotAString.
  ///
  /// In en, this message translates to:
  /// **'State must be a string.'**
  String get errorValidationStateNotAString;

  /// No description provided for @errorValidationGenderPreferenceIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Gender preference ID cannot be empty.'**
  String get errorValidationGenderPreferenceIdEmpty;

  /// No description provided for @errorValidationGenderPreferenceIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Gender preference ID must be a number.'**
  String get errorValidationGenderPreferenceIdNotANumber;

  /// No description provided for @errorValidationGenderPreferenceIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Gender preference ID must be an integer.'**
  String get errorValidationGenderPreferenceIdNotAnInteger;

  /// No description provided for @errorValidationGenderPreferenceIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Gender preference ID must be a positive number.'**
  String get errorValidationGenderPreferenceIdNotAPositiveNumber;

  /// No description provided for @errorValidationTypeIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Type ID cannot be empty.'**
  String get errorValidationTypeIdEmpty;

  /// No description provided for @errorValidationTypeIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Type ID must be a number.'**
  String get errorValidationTypeIdNotANumber;

  /// No description provided for @errorValidationTypeIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Type ID must be an integer.'**
  String get errorValidationTypeIdNotAnInteger;

  /// No description provided for @errorValidationTypeIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Type ID must be a positive number.'**
  String get errorValidationTypeIdNotAPositiveNumber;

  /// No description provided for @errorValidationBmiRangeNotAString.
  ///
  /// In en, this message translates to:
  /// **'BMI range must be a string.'**
  String get errorValidationBmiRangeNotAString;

  /// No description provided for @errorValidationBmiRangeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'BMI range is invalid.'**
  String get errorValidationBmiRangeInvalidEnum;

  /// No description provided for @errorValidationAgeRangeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Age range must be a string.'**
  String get errorValidationAgeRangeNotAString;

  /// No description provided for @errorValidationAgeRangeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Age range is invalid.'**
  String get errorValidationAgeRangeInvalidEnum;

  /// No description provided for @errorValidationTimezoneStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Timezone string is too short.'**
  String get errorValidationTimezoneStringTooShort;

  /// No description provided for @errorValidationGroupIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Group ID cannot be empty.'**
  String get errorValidationGroupIdEmpty;

  /// No description provided for @errorValidationGroupIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Group ID must be a number.'**
  String get errorValidationGroupIdNotANumber;

  /// No description provided for @errorValidationGroupIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Group ID must be an integer.'**
  String get errorValidationGroupIdNotAnInteger;

  /// No description provided for @errorValidationGroupIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Group ID must be a positive number.'**
  String get errorValidationGroupIdNotAPositiveNumber;

  /// No description provided for @errorValidationGroupSessionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Group session ID cannot be empty.'**
  String get errorValidationGroupSessionIdEmpty;

  /// No description provided for @errorValidationGroupSessionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Group session ID must be a number.'**
  String get errorValidationGroupSessionIdNotANumber;

  /// No description provided for @errorValidationGroupSessionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Group session ID must be an integer.'**
  String get errorValidationGroupSessionIdNotAnInteger;

  /// No description provided for @errorValidationGroupSessionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Group session ID must be a positive number.'**
  String get errorValidationGroupSessionIdNotAPositiveNumber;

  /// No description provided for @errorValidationEventInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Event is invalid.'**
  String get errorValidationEventInvalidEnum;

  /// No description provided for @errorValidationEventNotAString.
  ///
  /// In en, this message translates to:
  /// **'Event must be a string.'**
  String get errorValidationEventNotAString;

  /// No description provided for @errorValidationEventEmpty.
  ///
  /// In en, this message translates to:
  /// **'Event cannot be empty.'**
  String get errorValidationEventEmpty;

  /// No description provided for @errorValidationStartDateNotAnIsoDateString.
  ///
  /// In en, this message translates to:
  /// **'Start date must be a valid ISO date string.'**
  String get errorValidationStartDateNotAnIsoDateString;

  /// No description provided for @errorValidationEndDateNotAnIsoDateString.
  ///
  /// In en, this message translates to:
  /// **'End date must be a valid ISO date string.'**
  String get errorValidationEndDateNotAnIsoDateString;

  /// No description provided for @errorValidationStatusEmpty.
  ///
  /// In en, this message translates to:
  /// **'Status cannot be empty.'**
  String get errorValidationStatusEmpty;

  /// No description provided for @errorValidationStatusNotAString.
  ///
  /// In en, this message translates to:
  /// **'Status must be a string.'**
  String get errorValidationStatusNotAString;

  /// No description provided for @errorValidationStatusInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Status is invalid.'**
  String get errorValidationStatusInvalidEnum;

  /// No description provided for @errorValidationTopicStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Topic string is too long.'**
  String get errorValidationTopicStringTooLong;

  /// No description provided for @errorValidationTopicStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Topic string is too short.'**
  String get errorValidationTopicStringTooShort;

  /// No description provided for @errorValidationTopicNotAString.
  ///
  /// In en, this message translates to:
  /// **'Topic must be a string.'**
  String get errorValidationTopicNotAString;

  /// No description provided for @errorValidationPasswordStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Password string is too long.'**
  String get errorValidationPasswordStringTooLong;

  /// No description provided for @errorValidationPasswordStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password string is too short.'**
  String get errorValidationPasswordStringTooShort;

  /// No description provided for @errorValidationGroupSessionProgramIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Group session program ID must be a positive number.'**
  String get errorValidationGroupSessionProgramIdNotAPositiveNumber;

  /// No description provided for @errorValidationGroupSessionProgramIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Group session program ID must be an integer.'**
  String get errorValidationGroupSessionProgramIdNotAnInteger;

  /// No description provided for @errorValidationGroupSessionProgramIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Group session program ID must be a number.'**
  String get errorValidationGroupSessionProgramIdNotANumber;

  /// No description provided for @errorValidationPreparationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Preparation must be a string.'**
  String get errorValidationPreparationNotAString;

  /// No description provided for @errorValidationPreparationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Preparation cannot be empty.'**
  String get errorValidationPreparationEmpty;

  /// No description provided for @errorValidationTitleNotAString.
  ///
  /// In en, this message translates to:
  /// **'Title must be a string.'**
  String get errorValidationTitleNotAString;

  /// No description provided for @errorValidationTitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Title cannot be empty.'**
  String get errorValidationTitleEmpty;

  /// No description provided for @errorValidationEventsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Events must be an array.'**
  String get errorValidationEventsNotAnArray;

  /// No description provided for @errorValidationImageNotAString.
  ///
  /// In en, this message translates to:
  /// **'Image must be a string.'**
  String get errorValidationImageNotAString;

  /// No description provided for @errorValidationImageEmpty.
  ///
  /// In en, this message translates to:
  /// **'Image cannot be empty.'**
  String get errorValidationImageEmpty;

  /// No description provided for @errorValidationStartNotAString.
  ///
  /// In en, this message translates to:
  /// **'Start must be a string.'**
  String get errorValidationStartNotAString;

  /// No description provided for @errorValidationStartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Start cannot be empty.'**
  String get errorValidationStartEmpty;

  /// No description provided for @errorValidationPromptNotAString.
  ///
  /// In en, this message translates to:
  /// **'Prompt must be a string.'**
  String get errorValidationPromptNotAString;

  /// No description provided for @errorValidationVideoNotAString.
  ///
  /// In en, this message translates to:
  /// **'Video must be a string.'**
  String get errorValidationVideoNotAString;

  /// No description provided for @errorValidationDurationNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Duration must be an integer.'**
  String get errorValidationDurationNotAnInteger;

  /// No description provided for @errorValidationDurationNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Duration must be a positive number.'**
  String get errorValidationDurationNotAPositiveNumber;

  /// No description provided for @errorValidationDurationNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Duration must be a number.'**
  String get errorValidationDurationNotANumber;

  /// No description provided for @errorValidationSessionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Session ID must be an integer.'**
  String get errorValidationSessionIdNotAnInteger;

  /// No description provided for @errorValidationSessionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Session ID must be a positive number.'**
  String get errorValidationSessionIdNotAPositiveNumber;

  /// No description provided for @errorValidationSessionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Session ID must be a number.'**
  String get errorValidationSessionIdNotANumber;

  /// No description provided for @errorValidationTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Type cannot be empty.'**
  String get errorValidationTypeEmpty;

  /// No description provided for @errorValidationImagePathStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Image path string is too short.'**
  String get errorValidationImagePathStringTooShort;

  /// No description provided for @errorValidationImagePathNotAString.
  ///
  /// In en, this message translates to:
  /// **'Image path must be a string.'**
  String get errorValidationImagePathNotAString;

  /// No description provided for @errorValidationImagePathEmpty.
  ///
  /// In en, this message translates to:
  /// **'Image path cannot be empty.'**
  String get errorValidationImagePathEmpty;

  /// No description provided for @errorValidationDifficultyNotAString.
  ///
  /// In en, this message translates to:
  /// **'Difficulty must be a string.'**
  String get errorValidationDifficultyNotAString;

  /// No description provided for @errorValidationDifficultyInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Difficulty is invalid.'**
  String get errorValidationDifficultyInvalidEnum;

  /// No description provided for @errorValidationPlaceNotAString.
  ///
  /// In en, this message translates to:
  /// **'Place must be a string.'**
  String get errorValidationPlaceNotAString;

  /// No description provided for @errorValidationPlaceInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Place is invalid.'**
  String get errorValidationPlaceInvalidEnum;

  /// No description provided for @errorValidationPhysicalProgramIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Physical program ID cannot be empty.'**
  String get errorValidationPhysicalProgramIdEmpty;

  /// No description provided for @errorValidationPhysicalProgramIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Physical program ID must be a number.'**
  String get errorValidationPhysicalProgramIdNotANumber;

  /// No description provided for @errorValidationPhysicalProgramIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Physical program ID must be an integer.'**
  String get errorValidationPhysicalProgramIdNotAnInteger;

  /// No description provided for @errorValidationPhysicalProgramIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Physical program ID must be a positive number.'**
  String get errorValidationPhysicalProgramIdNotAPositiveNumber;

  /// No description provided for @errorValidationScoreEmpty.
  ///
  /// In en, this message translates to:
  /// **'Score cannot be empty.'**
  String get errorValidationScoreEmpty;

  /// No description provided for @errorValidationScoreNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Score must be a number.'**
  String get errorValidationScoreNotANumber;

  /// No description provided for @errorValidationScoreNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Score number is too big.'**
  String get errorValidationScoreNumberTooBig;

  /// No description provided for @errorValidationScoreNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Score number is too small.'**
  String get errorValidationScoreNumberTooSmall;

  /// No description provided for @errorValidationLikeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Like cannot be empty.'**
  String get errorValidationLikeEmpty;

  /// No description provided for @errorValidationLikeNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Like must be a boolean.'**
  String get errorValidationLikeNotABoolean;

  /// No description provided for @errorValidationTrainingFrequencyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Training frequency cannot be empty.'**
  String get errorValidationTrainingFrequencyEmpty;

  /// No description provided for @errorValidationTrainingFrequencyNotAString.
  ///
  /// In en, this message translates to:
  /// **'Training frequency must be a string.'**
  String get errorValidationTrainingFrequencyNotAString;

  /// No description provided for @errorValidationTrainingFrequencyInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Training frequency is invalid.'**
  String get errorValidationTrainingFrequencyInvalidEnum;

  /// No description provided for @errorValidationTrainingTargetsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Training targets cannot be empty.'**
  String get errorValidationTrainingTargetsEmpty;

  /// No description provided for @errorValidationTrainingTargetsNotAString.
  ///
  /// In en, this message translates to:
  /// **'Training targets must be a string.'**
  String get errorValidationTrainingTargetsNotAString;

  /// No description provided for @errorValidationTrainingTargetsInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Training targets are invalid.'**
  String get errorValidationTrainingTargetsInvalidEnum;

  /// No description provided for @errorValidationFlexibleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Flexible cannot be empty.'**
  String get errorValidationFlexibleEmpty;

  /// No description provided for @errorValidationFlexibleNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Flexible must be a boolean.'**
  String get errorValidationFlexibleNotABoolean;

  /// No description provided for @errorValidationImageStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Image string is too short.'**
  String get errorValidationImageStringTooShort;

  /// No description provided for @errorValidationVideoStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Video string is too short.'**
  String get errorValidationVideoStringTooShort;

  /// No description provided for @errorValidationVideoEmpty.
  ///
  /// In en, this message translates to:
  /// **'Video cannot be empty.'**
  String get errorValidationVideoEmpty;

  /// No description provided for @errorValidationDurationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Duration must be a string.'**
  String get errorValidationDurationNotAString;

  /// No description provided for @errorValidationDurationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Duration cannot be empty.'**
  String get errorValidationDurationEmpty;

  /// No description provided for @errorValidationSkipToNotAString.
  ///
  /// In en, this message translates to:
  /// **'Skip to must be a string.'**
  String get errorValidationSkipToNotAString;

  /// No description provided for @errorValidationSkipToEmpty.
  ///
  /// In en, this message translates to:
  /// **'Skip to cannot be empty.'**
  String get errorValidationSkipToEmpty;

  /// No description provided for @errorValidationExerciseIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise ID cannot be empty.'**
  String get errorValidationExerciseIdEmpty;

  /// No description provided for @errorValidationExerciseIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Exercise ID must be a number.'**
  String get errorValidationExerciseIdNotANumber;

  /// No description provided for @errorValidationExerciseIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Exercise ID must be an integer.'**
  String get errorValidationExerciseIdNotAnInteger;

  /// No description provided for @errorValidationExerciseIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Exercise ID must be a positive number.'**
  String get errorValidationExerciseIdNotAPositiveNumber;

  /// No description provided for @errorValidationCategoryInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Category is invalid.'**
  String get errorValidationCategoryInvalidEnum;

  /// No description provided for @errorValidationLocationInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Location is invalid.'**
  String get errorValidationLocationInvalidEnum;

  /// No description provided for @errorValidationEquipmentStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Equipment string is too short.'**
  String get errorValidationEquipmentStringTooShort;

  /// No description provided for @errorValidationEquipmentNotAString.
  ///
  /// In en, this message translates to:
  /// **'Equipment must be a string.'**
  String get errorValidationEquipmentNotAString;

  /// No description provided for @errorValidationEquipmentEmpty.
  ///
  /// In en, this message translates to:
  /// **'Equipment cannot be empty.'**
  String get errorValidationEquipmentEmpty;

  /// No description provided for @errorValidationTargetMusclesStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Target muscles string is too short.'**
  String get errorValidationTargetMusclesStringTooShort;

  /// No description provided for @errorValidationTargetMusclesNotAString.
  ///
  /// In en, this message translates to:
  /// **'Target muscles must be a string.'**
  String get errorValidationTargetMusclesNotAString;

  /// No description provided for @errorValidationTargetMusclesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Target muscles cannot be empty.'**
  String get errorValidationTargetMusclesEmpty;

  /// No description provided for @errorValidationDurationStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Duration string is too short.'**
  String get errorValidationDurationStringTooShort;

  /// No description provided for @errorValidationVideoNotUrlAddress.
  ///
  /// In en, this message translates to:
  /// **'Video must be a valid URL address.'**
  String get errorValidationVideoNotUrlAddress;

  /// No description provided for @errorValidationProgramIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Program ID cannot be empty.'**
  String get errorValidationProgramIdEmpty;

  /// No description provided for @errorValidationProgramIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Program ID must be a number.'**
  String get errorValidationProgramIdNotANumber;

  /// No description provided for @errorValidationProgramIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Program ID must be an integer.'**
  String get errorValidationProgramIdNotAnInteger;

  /// No description provided for @errorValidationProgramIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Program ID must be a positive number.'**
  String get errorValidationProgramIdNotAPositiveNumber;

  /// No description provided for @errorValidationImageNotUrlAddress.
  ///
  /// In en, this message translates to:
  /// **'Image must be a valid URL address.'**
  String get errorValidationImageNotUrlAddress;

  /// No description provided for @errorValidationOrderNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Order must be a positive number.'**
  String get errorValidationOrderNotAPositiveNumber;

  /// No description provided for @errorValidationOrderNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Order must be an integer.'**
  String get errorValidationOrderNotAnInteger;

  /// No description provided for @errorValidationModuleIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Module ID must be a positive number.'**
  String get errorValidationModuleIdNotAPositiveNumber;

  /// No description provided for @errorValidationModuleIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Module ID must be an integer.'**
  String get errorValidationModuleIdNotAnInteger;

  /// No description provided for @errorValidationModuleIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Module ID must be a number.'**
  String get errorValidationModuleIdNotANumber;

  /// No description provided for @errorValidationModuleIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Module ID cannot be empty.'**
  String get errorValidationModuleIdEmpty;

  /// No description provided for @errorValidationExternalIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'External ID must be a positive number.'**
  String get errorValidationExternalIdNotAPositiveNumber;

  /// No description provided for @errorValidationExternalIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'External ID must be an integer.'**
  String get errorValidationExternalIdNotAnInteger;

  /// No description provided for @errorValidationExternalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'External ID must be a number.'**
  String get errorValidationExternalIdNotANumber;

  /// No description provided for @errorValidationExternalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'External ID cannot be empty.'**
  String get errorValidationExternalIdEmpty;

  /// No description provided for @errorValidationStreamTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Stream type is invalid.'**
  String get errorValidationStreamTypeInvalidEnum;

  /// No description provided for @errorValidationStreamTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Stream type cannot be empty.'**
  String get errorValidationStreamTypeEmpty;

  /// No description provided for @errorValidationIconTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Icon type is invalid.'**
  String get errorValidationIconTypeInvalidEnum;

  /// No description provided for @errorValidationIconTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Icon type cannot be empty.'**
  String get errorValidationIconTypeEmpty;

  /// No description provided for @errorValidationIsRootItemNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Is root item must be a boolean.'**
  String get errorValidationIsRootItemNotABoolean;

  /// No description provided for @errorValidationIsRootItemEmpty.
  ///
  /// In en, this message translates to:
  /// **'Is root item cannot be empty.'**
  String get errorValidationIsRootItemEmpty;

  /// No description provided for @errorValidationLessonExternalIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson external ID must be a positive number.'**
  String get errorValidationLessonExternalIdNotAPositiveNumber;

  /// No description provided for @errorValidationLessonExternalIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Lesson external ID must be an integer.'**
  String get errorValidationLessonExternalIdNotAnInteger;

  /// No description provided for @errorValidationLessonExternalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson external ID must be a number.'**
  String get errorValidationLessonExternalIdNotANumber;

  /// No description provided for @errorValidationLessonExternalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Lesson external ID cannot be empty.'**
  String get errorValidationLessonExternalIdEmpty;

  /// No description provided for @errorValidationUnlocksItemExternalIdsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Unlocks item external IDs must be numbers.'**
  String get errorValidationUnlocksItemExternalIdsNotANumber;

  /// No description provided for @errorValidationUnlocksItemExternalIdsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Unlocks item external IDs must be an array.'**
  String get errorValidationUnlocksItemExternalIdsNotAnArray;

  /// No description provided for @errorValidationUnlocksItemExternalIdsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Unlocks item external IDs cannot be empty.'**
  String get errorValidationUnlocksItemExternalIdsEmpty;

  /// No description provided for @errorValidationUnlocksFeatureNotAString.
  ///
  /// In en, this message translates to:
  /// **'Unlocks feature must be a string.'**
  String get errorValidationUnlocksFeatureNotAString;

  /// No description provided for @errorValidationUnlocksFeatureNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Unlocks feature must be an array.'**
  String get errorValidationUnlocksFeatureNotAnArray;

  /// No description provided for @errorValidationUnlocksFeatureEmpty.
  ///
  /// In en, this message translates to:
  /// **'Unlocks feature cannot be empty.'**
  String get errorValidationUnlocksFeatureEmpty;

  /// No description provided for @errorValidationUnlocksReflectionExternalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Unlocks reflection external ID must be a number.'**
  String get errorValidationUnlocksReflectionExternalIdNotANumber;

  /// No description provided for @errorValidationUnlocksReflectionExternalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Unlocks reflection external ID cannot be empty.'**
  String get errorValidationUnlocksReflectionExternalIdEmpty;

  /// No description provided for @errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Unlocks smart goal category external ID must be a number.'**
  String get errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber;

  /// No description provided for @errorValidationUnlocksSmartGoalCategoryExternalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Unlocks smart goal category external ID cannot be empty.'**
  String get errorValidationUnlocksSmartGoalCategoryExternalIdEmpty;

  /// No description provided for @errorValidationCrossModuleNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Cross module must be a boolean.'**
  String get errorValidationCrossModuleNotABoolean;

  /// No description provided for @errorValidationCrossModuleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cross module cannot be empty.'**
  String get errorValidationCrossModuleEmpty;

  /// No description provided for @errorValidationFeaturePlacementInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Feature placement is invalid.'**
  String get errorValidationFeaturePlacementInvalidEnum;

  /// No description provided for @errorValidationFeaturePlacementEmpty.
  ///
  /// In en, this message translates to:
  /// **'Feature placement cannot be empty.'**
  String get errorValidationFeaturePlacementEmpty;

  /// No description provided for @errorValidationModuleItemsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Module items must be an array.'**
  String get errorValidationModuleItemsNotAnArray;

  /// No description provided for @errorValidationModuleItemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Module items cannot be empty.'**
  String get errorValidationModuleItemsEmpty;

  /// No description provided for @errorValidationRiverModuleIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'River module ID cannot be empty.'**
  String get errorValidationRiverModuleIdEmpty;

  /// No description provided for @errorValidationRiverModuleIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'River module ID must be a number.'**
  String get errorValidationRiverModuleIdNotANumber;

  /// No description provided for @errorValidationRiverModuleIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'River module ID must be an integer.'**
  String get errorValidationRiverModuleIdNotAnInteger;

  /// No description provided for @errorValidationRiverModuleIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'River module ID must be a positive number.'**
  String get errorValidationRiverModuleIdNotAPositiveNumber;

  /// No description provided for @errorValidationRiverModuleItemIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'River module item ID cannot be empty.'**
  String get errorValidationRiverModuleItemIdEmpty;

  /// No description provided for @errorValidationRiverModuleItemIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'River module item ID must be a number.'**
  String get errorValidationRiverModuleItemIdNotANumber;

  /// No description provided for @errorValidationRiverModuleItemIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'River module item ID must be an integer.'**
  String get errorValidationRiverModuleItemIdNotAnInteger;

  /// No description provided for @errorValidationRiverModuleItemIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'River module item ID must be a positive number.'**
  String get errorValidationRiverModuleItemIdNotAPositiveNumber;

  /// No description provided for @errorValidationLanguageNotAString.
  ///
  /// In en, this message translates to:
  /// **'Language must be a string.'**
  String get errorValidationLanguageNotAString;

  /// No description provided for @errorValidationCountryNotAString.
  ///
  /// In en, this message translates to:
  /// **'Country must be a string.'**
  String get errorValidationCountryNotAString;

  /// No description provided for @errorValidationTimezoneOffsetNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Timezone offset must be a number.'**
  String get errorValidationTimezoneOffsetNotANumber;

  /// No description provided for @errorValidationTimezoneNameNotAString.
  ///
  /// In en, this message translates to:
  /// **'Timezone name must be a string.'**
  String get errorValidationTimezoneNameNotAString;

  /// No description provided for @errorValidationMeasurementSystemNotAString.
  ///
  /// In en, this message translates to:
  /// **'Measurement system must be a string.'**
  String get errorValidationMeasurementSystemNotAString;

  /// No description provided for @errorValidationRefreshTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Refresh token must be a string.'**
  String get errorValidationRefreshTokenNotAString;

  /// No description provided for @errorValidationDiabetesNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Diabetes must be a positive number.'**
  String get errorValidationDiabetesNotAPositiveNumber;

  /// No description provided for @errorValidationDiabetesNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Diabetes must be a number.'**
  String get errorValidationDiabetesNotANumber;

  /// No description provided for @errorValidationTextStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Text string is too long.'**
  String get errorValidationTextStringTooLong;

  /// No description provided for @errorValidationTextStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Text string is too short.'**
  String get errorValidationTextStringTooShort;

  /// No description provided for @errorValidationTextEmpty.
  ///
  /// In en, this message translates to:
  /// **'Text cannot be empty.'**
  String get errorValidationTextEmpty;

  /// No description provided for @errorValidationTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Text must be a string.'**
  String get errorValidationTextNotAString;

  /// No description provided for @errorValidationReplyMessageIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Reply message ID must be a number string.'**
  String get errorValidationReplyMessageIdNotANumberString;

  /// No description provided for @errorValidationMessageIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Message ID must be a number.'**
  String get errorValidationMessageIdNotANumber;

  /// No description provided for @errorValidationMessageIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Message ID must be an integer.'**
  String get errorValidationMessageIdNotAnInteger;

  /// No description provided for @errorValidationMessageIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Message ID must be a positive number.'**
  String get errorValidationMessageIdNotAPositiveNumber;

  /// No description provided for @errorValidationTimeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Time cannot be empty.'**
  String get errorValidationTimeEmpty;

  /// No description provided for @errorValidationTimeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Time must be a string.'**
  String get errorValidationTimeNotAString;

  /// No description provided for @errorValidationTimeStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Time string is too long.'**
  String get errorValidationTimeStringTooLong;

  /// No description provided for @errorValidationTimeStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Time string is too short.'**
  String get errorValidationTimeStringTooShort;

  /// No description provided for @errorValidationSubjectEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subject cannot be empty.'**
  String get errorValidationSubjectEmpty;

  /// No description provided for @errorValidationSubjectNotAString.
  ///
  /// In en, this message translates to:
  /// **'Subject must be a string.'**
  String get errorValidationSubjectNotAString;

  /// No description provided for @errorValidationSubjectStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Subject string is too long.'**
  String get errorValidationSubjectStringTooLong;

  /// No description provided for @errorValidationSubjectStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Subject string is too short.'**
  String get errorValidationSubjectStringTooShort;

  /// No description provided for @errorValidationMessageEmpty.
  ///
  /// In en, this message translates to:
  /// **'Message cannot be empty.'**
  String get errorValidationMessageEmpty;

  /// No description provided for @errorValidationMessageNotAString.
  ///
  /// In en, this message translates to:
  /// **'Message must be a string.'**
  String get errorValidationMessageNotAString;

  /// No description provided for @errorValidationMessageStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message string is too long.'**
  String get errorValidationMessageStringTooLong;

  /// No description provided for @errorValidationMessageStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Message string is too short.'**
  String get errorValidationMessageStringTooShort;

  /// No description provided for @errorValidationAppVersionEmpty.
  ///
  /// In en, this message translates to:
  /// **'App version cannot be empty.'**
  String get errorValidationAppVersionEmpty;

  /// No description provided for @errorValidationAppVersionNotAString.
  ///
  /// In en, this message translates to:
  /// **'App version must be a string.'**
  String get errorValidationAppVersionNotAString;

  /// No description provided for @errorValidationAppVersionStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'App version string is too long.'**
  String get errorValidationAppVersionStringTooLong;

  /// No description provided for @errorValidationAppVersionStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'App version string is too short.'**
  String get errorValidationAppVersionStringTooShort;

  /// No description provided for @errorValidationEmailTokenEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email token cannot be empty.'**
  String get errorValidationEmailTokenEmpty;

  /// No description provided for @errorValidationEmailTokenNotAString.
  ///
  /// In en, this message translates to:
  /// **'Email token must be a string.'**
  String get errorValidationEmailTokenNotAString;

  /// No description provided for @errorValidationEmailTokenNotAJwt.
  ///
  /// In en, this message translates to:
  /// **'Email token must be a JWT.'**
  String get errorValidationEmailTokenNotAJwt;

  /// No description provided for @errorValidationExtraAccountsCountNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Extra accounts count is too small.'**
  String get errorValidationExtraAccountsCountNumberTooSmall;

  /// No description provided for @errorValidationExtraAccountsCountNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Extra accounts count must be an integer.'**
  String get errorValidationExtraAccountsCountNotAnInteger;

  /// No description provided for @errorValidationExtraAccountsCountNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Extra accounts count must be a number.'**
  String get errorValidationExtraAccountsCountNotANumber;

  /// No description provided for @errorValidationUidNotAString.
  ///
  /// In en, this message translates to:
  /// **'UID must be a string.'**
  String get errorValidationUidNotAString;

  /// No description provided for @errorValidationPlatformInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Platform is invalid.'**
  String get errorValidationPlatformInvalidEnum;

  /// No description provided for @errorValidationPlatformNotAString.
  ///
  /// In en, this message translates to:
  /// **'Platform must be a string.'**
  String get errorValidationPlatformNotAString;

  /// No description provided for @errorValidationDeviceIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Device ID must be a string.'**
  String get errorValidationDeviceIdNotAString;

  /// No description provided for @errorValidationDeviceIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Device ID cannot be empty.'**
  String get errorValidationDeviceIdEmpty;

  /// No description provided for @errorValidationDeviceIdStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Device ID string is too long.'**
  String get errorValidationDeviceIdStringTooLong;

  /// No description provided for @errorValidationAdvertisingIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Advertising ID must be a string.'**
  String get errorValidationAdvertisingIdNotAString;

  /// No description provided for @errorValidationAdvertisingIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Advertising ID cannot be empty.'**
  String get errorValidationAdvertisingIdEmpty;

  /// No description provided for @errorValidationAdvertisingIdStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Advertising ID string is too long.'**
  String get errorValidationAdvertisingIdStringTooLong;

  /// No description provided for @errorValidationLimitNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Limit number is too big.'**
  String get errorValidationLimitNumberTooBig;

  /// No description provided for @errorValidationFromMessageIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'From message ID must be a number string.'**
  String get errorValidationFromMessageIdNotANumberString;

  /// No description provided for @errorValidationChatMessageIdNotAString.
  ///
  /// In en, this message translates to:
  /// **'Chat message ID must be a string.'**
  String get errorValidationChatMessageIdNotAString;

  /// No description provided for @errorValidationChatMessageIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'Chat message ID must be a number string.'**
  String get errorValidationChatMessageIdNotANumberString;

  /// No description provided for @errorValidationReflectionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Reflection ID cannot be empty.'**
  String get errorValidationReflectionIdEmpty;

  /// No description provided for @errorValidationReflectionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection ID must be a number.'**
  String get errorValidationReflectionIdNotANumber;

  /// No description provided for @errorValidationReflectionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Reflection ID must be an integer.'**
  String get errorValidationReflectionIdNotAnInteger;

  /// No description provided for @errorValidationReflectionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection ID must be a positive number.'**
  String get errorValidationReflectionIdNotAPositiveNumber;

  /// No description provided for @errorValidationReflectionQuestionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Reflection question ID cannot be empty.'**
  String get errorValidationReflectionQuestionIdEmpty;

  /// No description provided for @errorValidationReflectionQuestionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection question ID must be a number.'**
  String get errorValidationReflectionQuestionIdNotANumber;

  /// No description provided for @errorValidationReflectionQuestionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Reflection question ID must be an integer.'**
  String get errorValidationReflectionQuestionIdNotAnInteger;

  /// No description provided for @errorValidationReflectionQuestionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection question ID must be a positive number.'**
  String get errorValidationReflectionQuestionIdNotAPositiveNumber;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs number is too big.'**
  String get errorValidationReflectionQuestionOptionIdsNumberTooBig;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs number is too small.'**
  String get errorValidationReflectionQuestionOptionIdsNumberTooSmall;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs must be a positive number.'**
  String get errorValidationReflectionQuestionOptionIdsNotAPositiveNumber;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs must be an integer.'**
  String get errorValidationReflectionQuestionOptionIdsNotAnInteger;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs must be a number.'**
  String get errorValidationReflectionQuestionOptionIdsNotANumber;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs cannot be an empty array.'**
  String get errorValidationReflectionQuestionOptionIdsEmptyArray;

  /// No description provided for @errorValidationReflectionQuestionOptionIdsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Reflection question option IDs must be an array.'**
  String get errorValidationReflectionQuestionOptionIdsNotAnArray;

  /// No description provided for @errorValidationValueNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Value number is too big.'**
  String get errorValidationValueNumberTooBig;

  /// No description provided for @errorValidationValueNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Value number is too small.'**
  String get errorValidationValueNumberTooSmall;

  /// No description provided for @errorValidationValueNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Value must be a positive number.'**
  String get errorValidationValueNotAPositiveNumber;

  /// No description provided for @errorValidationValueNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Value must be an integer.'**
  String get errorValidationValueNotAnInteger;

  /// No description provided for @errorValidationValueNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Value must be a number.'**
  String get errorValidationValueNotANumber;

  /// No description provided for @errorValidationLessonIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Lesson ID cannot be empty.'**
  String get errorValidationLessonIdEmpty;

  /// No description provided for @errorValidationLessonIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson ID must be a number.'**
  String get errorValidationLessonIdNotANumber;

  /// No description provided for @errorValidationLessonIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Lesson ID must be an integer.'**
  String get errorValidationLessonIdNotAnInteger;

  /// No description provided for @errorValidationLessonIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson ID must be a positive number.'**
  String get errorValidationLessonIdNotAPositiveNumber;

  /// No description provided for @errorValidationLabelNotAString.
  ///
  /// In en, this message translates to:
  /// **'Label must be a string.'**
  String get errorValidationLabelNotAString;

  /// No description provided for @errorValidationIsCorrectNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Is correct must be a boolean.'**
  String get errorValidationIsCorrectNotABoolean;

  /// No description provided for @errorValidationMinValueNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Min value must be a positive number.'**
  String get errorValidationMinValueNotAPositiveNumber;

  /// No description provided for @errorValidationMinValueNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Min value must be an integer.'**
  String get errorValidationMinValueNotAnInteger;

  /// No description provided for @errorValidationMinValueNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Min value must be a number.'**
  String get errorValidationMinValueNotANumber;

  /// No description provided for @errorValidationMaxValueNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Max value must be a positive number.'**
  String get errorValidationMaxValueNotAPositiveNumber;

  /// No description provided for @errorValidationMaxValueNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Max value must be an integer.'**
  String get errorValidationMaxValueNotAnInteger;

  /// No description provided for @errorValidationMaxValueNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Max value must be a number.'**
  String get errorValidationMaxValueNotANumber;

  /// No description provided for @errorValidationLowestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Lowest text must be a string.'**
  String get errorValidationLowestTextNotAString;

  /// No description provided for @errorValidationHighestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Highest text must be a string.'**
  String get errorValidationHighestTextNotAString;

  /// No description provided for @errorValidationScaleNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Scale must be an array.'**
  String get errorValidationScaleNotAnArray;

  /// No description provided for @errorValidationQuestionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Question must be a string.'**
  String get errorValidationQuestionNotAString;

  /// No description provided for @errorValidationAnswerTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Answer type is invalid.'**
  String get errorValidationAnswerTypeInvalidEnum;

  /// No description provided for @errorValidationAnswerTypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Answer type must be a string.'**
  String get errorValidationAnswerTypeNotAString;

  /// No description provided for @errorValidationIntroductionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Introduction must be a string.'**
  String get errorValidationIntroductionNotAString;

  /// No description provided for @errorValidationFeedbackNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Feedback must be an array.'**
  String get errorValidationFeedbackNotAnArray;

  /// No description provided for @errorValidationExtraInstructionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Extra instruction must be a string.'**
  String get errorValidationExtraInstructionNotAString;

  /// No description provided for @errorValidationInstructionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Instruction must be a string.'**
  String get errorValidationInstructionNotAString;

  /// No description provided for @errorValidationCategoryNotAString.
  ///
  /// In en, this message translates to:
  /// **'Category must be a string.'**
  String get errorValidationCategoryNotAString;

  /// No description provided for @errorValidationExternalLessonIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'External lesson ID must be a positive number.'**
  String get errorValidationExternalLessonIdNotAPositiveNumber;

  /// No description provided for @errorValidationExternalLessonIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'External lesson ID must be an integer.'**
  String get errorValidationExternalLessonIdNotAnInteger;

  /// No description provided for @errorValidationExternalLessonIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'External lesson ID must be a number.'**
  String get errorValidationExternalLessonIdNotANumber;

  /// No description provided for @errorValidationQuestionsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Questions must be an array.'**
  String get errorValidationQuestionsNotAnArray;

  /// No description provided for @errorValidationOrderNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Order must be a number.'**
  String get errorValidationOrderNotANumber;

  /// No description provided for @errorValidationOrderEmpty.
  ///
  /// In en, this message translates to:
  /// **'Order cannot be empty.'**
  String get errorValidationOrderEmpty;

  /// No description provided for @errorValidationContentTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Content type is invalid.'**
  String get errorValidationContentTypeInvalidEnum;

  /// No description provided for @errorValidationContentTypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Content type must be a string.'**
  String get errorValidationContentTypeNotAString;

  /// No description provided for @errorValidationContentTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Content type cannot be empty.'**
  String get errorValidationContentTypeEmpty;

  /// No description provided for @errorValidationCardImageUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'Card image URL must be a string.'**
  String get errorValidationCardImageUrlNotAString;

  /// No description provided for @errorValidationImageUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'Image URL must be a string.'**
  String get errorValidationImageUrlNotAString;

  /// No description provided for @errorValidationAudioUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'Audio URL must be a string.'**
  String get errorValidationAudioUrlNotAString;

  /// No description provided for @errorValidationHtmlUrlNotAString.
  ///
  /// In en, this message translates to:
  /// **'HTML URL must be a string.'**
  String get errorValidationHtmlUrlNotAString;

  /// No description provided for @errorValidationSubtitlesImagesNotAString.
  ///
  /// In en, this message translates to:
  /// **'Subtitles images must be a string.'**
  String get errorValidationSubtitlesImagesNotAString;

  /// No description provided for @errorValidationConclusionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Conclusion must be a string.'**
  String get errorValidationConclusionNotAString;

  /// No description provided for @errorValidationUnlockTitleNotAString.
  ///
  /// In en, this message translates to:
  /// **'Unlock title must be a string.'**
  String get errorValidationUnlockTitleNotAString;

  /// No description provided for @errorValidationUnlockDescriptionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Unlock description must be a string.'**
  String get errorValidationUnlockDescriptionNotAString;

  /// No description provided for @errorValidationAudioEmpty.
  ///
  /// In en, this message translates to:
  /// **'Audio cannot be empty.'**
  String get errorValidationAudioEmpty;

  /// No description provided for @errorValidationAudioNotAString.
  ///
  /// In en, this message translates to:
  /// **'Audio must be a string.'**
  String get errorValidationAudioNotAString;

  /// No description provided for @errorValidationSubtitlesImagesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subtitles images cannot be empty.'**
  String get errorValidationSubtitlesImagesEmpty;

  /// No description provided for @errorValidationCorrectNotAString.
  ///
  /// In en, this message translates to:
  /// **'Correct must be a string.'**
  String get errorValidationCorrectNotAString;

  /// No description provided for @errorValidationIncorrectNotAString.
  ///
  /// In en, this message translates to:
  /// **'Incorrect must be a string.'**
  String get errorValidationIncorrectNotAString;

  /// No description provided for @errorValidationVisualEmpty.
  ///
  /// In en, this message translates to:
  /// **'Visual cannot be empty.'**
  String get errorValidationVisualEmpty;

  /// No description provided for @errorValidationVisualNotAString.
  ///
  /// In en, this message translates to:
  /// **'Visual must be a string.'**
  String get errorValidationVisualNotAString;

  /// No description provided for @errorValidationCompletionTimeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Completion time must be a string.'**
  String get errorValidationCompletionTimeNotAString;

  /// No description provided for @errorValidationCompletionTimeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Completion time cannot be empty.'**
  String get errorValidationCompletionTimeEmpty;

  /// No description provided for @errorValidationLessonsArraySizeTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Lessons array size is too small.'**
  String get errorValidationLessonsArraySizeTooSmall;

  /// No description provided for @errorValidationLessonsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Lessons must be an array.'**
  String get errorValidationLessonsNotAnArray;

  /// No description provided for @errorValidationLessonQuizIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz ID cannot be empty.'**
  String get errorValidationLessonQuizIdEmpty;

  /// No description provided for @errorValidationLessonQuizIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz ID must be a number.'**
  String get errorValidationLessonQuizIdNotANumber;

  /// No description provided for @errorValidationLessonQuizIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz ID must be an integer.'**
  String get errorValidationLessonQuizIdNotAnInteger;

  /// No description provided for @errorValidationLessonQuizIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz ID must be a positive number.'**
  String get errorValidationLessonQuizIdNotAPositiveNumber;

  /// No description provided for @errorValidationLessonQuizQuestionOptionIdsNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs number is too big.'**
  String get errorValidationLessonQuizQuestionOptionIdsNumberTooBig;

  /// No description provided for @errorLessonQuizQuestionOptionIdsNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs number is too small.'**
  String get errorLessonQuizQuestionOptionIdsNumberTooSmall;

  /// No description provided for @errorLessonQuizQuestionOptionIdsNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs must be positive numbers.'**
  String get errorLessonQuizQuestionOptionIdsNotAPositiveNumber;

  /// No description provided for @errorLessonQuizQuestionOptionIdsNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs must be integers.'**
  String get errorLessonQuizQuestionOptionIdsNotAnInteger;

  /// No description provided for @errorLessonQuizQuestionOptionIdsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs must be numbers.'**
  String get errorLessonQuizQuestionOptionIdsNotANumber;

  /// No description provided for @errorLessonQuizQuestionOptionIdsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question option IDs must be an array.'**
  String get errorLessonQuizQuestionOptionIdsNotAnArray;

  /// No description provided for @errorLessonQuizQuestionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question ID cannot be empty.'**
  String get errorLessonQuizQuestionIdEmpty;

  /// No description provided for @errorLessonQuizQuestionIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question ID must be a number.'**
  String get errorLessonQuizQuestionIdNotANumber;

  /// No description provided for @errorLessonQuizQuestionIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question ID must be an integer.'**
  String get errorLessonQuizQuestionIdNotAnInteger;

  /// No description provided for @errorLessonQuizQuestionIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Lesson quiz question ID must be a positive number.'**
  String get errorLessonQuizQuestionIdNotAPositiveNumber;

  /// No description provided for @errorExplanationTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Explanation type is invalid.'**
  String get errorExplanationTypeInvalidEnum;

  /// No description provided for @errorExplanationTypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Explanation type must be a string.'**
  String get errorExplanationTypeNotAString;

  /// No description provided for @errorExplanationTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Explanation type cannot be empty.'**
  String get errorExplanationTypeEmpty;

  /// No description provided for @errorExplanationSrcNotAString.
  ///
  /// In en, this message translates to:
  /// **'Explanation source must be a string.'**
  String get errorExplanationSrcNotAString;

  /// No description provided for @errorExplanationSrcEmpty.
  ///
  /// In en, this message translates to:
  /// **'Explanation source cannot be empty.'**
  String get errorExplanationSrcEmpty;

  /// No description provided for @errorExplanationDurationNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Explanation duration must be a positive number.'**
  String get errorExplanationDurationNotAPositiveNumber;

  /// No description provided for @errorExplanationDurationNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Explanation duration must be a number.'**
  String get errorExplanationDurationNotANumber;

  /// No description provided for @errorExplanationDurationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Explanation duration cannot be empty.'**
  String get errorExplanationDurationEmpty;

  /// No description provided for @errorExplanationOrientationInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Explanation orientation is invalid.'**
  String get errorExplanationOrientationInvalidEnum;

  /// No description provided for @errorExplanationOrientationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Explanation orientation must be a string.'**
  String get errorExplanationOrientationNotAString;

  /// No description provided for @errorExerciseTypeInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Exercise type is invalid.'**
  String get errorExerciseTypeInvalidEnum;

  /// No description provided for @errorExerciseTypeNotAString.
  ///
  /// In en, this message translates to:
  /// **'Exercise type must be a string.'**
  String get errorExerciseTypeNotAString;

  /// No description provided for @errorExerciseTypeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise type cannot be empty.'**
  String get errorExerciseTypeEmpty;

  /// No description provided for @errorExerciseOrientationInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Exercise orientation is invalid.'**
  String get errorExerciseOrientationInvalidEnum;

  /// No description provided for @errorExerciseOrientationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Exercise orientation must be a string.'**
  String get errorExerciseOrientationNotAString;

  /// No description provided for @errorExerciseOrientationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise orientation cannot be empty.'**
  String get errorExerciseOrientationEmpty;

  /// No description provided for @errorExerciseDurationNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Exercise duration must be a positive number.'**
  String get errorExerciseDurationNotAPositiveNumber;

  /// No description provided for @errorExerciseDurationNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Exercise duration must be a number.'**
  String get errorExerciseDurationNotANumber;

  /// No description provided for @errorExerciseDurationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise duration cannot be empty.'**
  String get errorExerciseDurationEmpty;

  /// No description provided for @errorExerciseSrcNotAString.
  ///
  /// In en, this message translates to:
  /// **'Exercise source must be a string.'**
  String get errorExerciseSrcNotAString;

  /// No description provided for @errorExerciseSrcEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise source cannot be empty.'**
  String get errorExerciseSrcEmpty;

  /// No description provided for @errorShortDescriptionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Short description must be a string.'**
  String get errorShortDescriptionNotAString;

  /// No description provided for @errorShortDescriptionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Short description cannot be empty.'**
  String get errorShortDescriptionEmpty;

  /// No description provided for @errorDifficultyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty cannot be empty.'**
  String get errorDifficultyEmpty;

  /// No description provided for @errorScaleBeforeQuestionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale before question must be a string.'**
  String get errorScaleBeforeQuestionNotAString;

  /// No description provided for @errorScaleBeforeLowestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale before lowest text must be a string.'**
  String get errorScaleBeforeLowestTextNotAString;

  /// No description provided for @errorScaleBeforeHighestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale before highest text must be a string.'**
  String get errorScaleBeforeHighestTextNotAString;

  /// No description provided for @errorScaleAfterQuestionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale after question must be a string.'**
  String get errorScaleAfterQuestionNotAString;

  /// No description provided for @errorScaleAfterLowestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale after lowest text must be a string.'**
  String get errorScaleAfterLowestTextNotAString;

  /// No description provided for @errorScaleAfterHighestTextNotAString.
  ///
  /// In en, this message translates to:
  /// **'Scale after highest text must be a string.'**
  String get errorScaleAfterHighestTextNotAString;

  /// No description provided for @errorTechniqueIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Technique ID must be a positive number.'**
  String get errorTechniqueIdNotAPositiveNumber;

  /// No description provided for @errorTechniqueIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Technique ID must be an integer.'**
  String get errorTechniqueIdNotAnInteger;

  /// No description provided for @errorTechniqueIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Technique ID must be a number.'**
  String get errorTechniqueIdNotANumber;

  /// No description provided for @errorTechniqueIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Technique ID cannot be empty.'**
  String get errorTechniqueIdEmpty;

  /// No description provided for @errorSubtitleNotAString.
  ///
  /// In en, this message translates to:
  /// **'Subtitle must be a string.'**
  String get errorSubtitleNotAString;

  /// No description provided for @errorSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subtitle cannot be empty.'**
  String get errorSubtitleEmpty;

  /// No description provided for @errorShortIntroductionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Short introduction must be a string.'**
  String get errorShortIntroductionNotAString;

  /// No description provided for @errorShortIntroductionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Short introduction cannot be empty.'**
  String get errorShortIntroductionEmpty;

  /// No description provided for @errorExplanationEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Explanation cannot be an empty array.'**
  String get errorExplanationEmptyArray;

  /// No description provided for @errorExplanationNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Explanation must be an array.'**
  String get errorExplanationNotAnArray;

  /// No description provided for @errorTechniquesEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Techniques cannot be an empty array.'**
  String get errorTechniquesEmptyArray;

  /// No description provided for @errorTechniquesNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Techniques must be an array.'**
  String get errorTechniquesNotAnArray;

  /// No description provided for @errorExternalTechniqueIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'External technique ID must be a positive number.'**
  String get errorExternalTechniqueIdNotAPositiveNumber;

  /// No description provided for @errorExternalTechniqueIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'External technique ID must be an integer.'**
  String get errorExternalTechniqueIdNotAnInteger;

  /// No description provided for @errorExternalTechniqueIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'External technique ID must be a number.'**
  String get errorExternalTechniqueIdNotANumber;

  /// No description provided for @errorExternalTechniqueIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'External technique ID cannot be empty.'**
  String get errorExternalTechniqueIdEmpty;

  /// No description provided for @errorExerciseUnlockStyleInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Exercise unlock style is invalid.'**
  String get errorExerciseUnlockStyleInvalidEnum;

  /// No description provided for @errorExerciseUnlockStyleNotAString.
  ///
  /// In en, this message translates to:
  /// **'Exercise unlock style must be a string.'**
  String get errorExerciseUnlockStyleNotAString;

  /// No description provided for @errorExerciseUnlockStyleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Exercise unlock style cannot be empty.'**
  String get errorExerciseUnlockStyleEmpty;

  /// No description provided for @errorExercisesNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Exercises must be an array.'**
  String get errorExercisesNotAnArray;

  /// No description provided for @errorScaleBeforeAnswerNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Scale before answer number is too big.'**
  String get errorScaleBeforeAnswerNumberTooBig;

  /// No description provided for @errorScaleBeforeAnswerNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Scale before answer number is too small.'**
  String get errorScaleBeforeAnswerNumberTooSmall;

  /// No description provided for @errorScaleBeforeAnswerNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Scale before answer must be an integer.'**
  String get errorScaleBeforeAnswerNotAnInteger;

  /// No description provided for @errorScaleBeforeAnswerNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Scale before answer must be a number.'**
  String get errorScaleBeforeAnswerNotANumber;

  /// No description provided for @errorScaleAfterAnswerNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Scale after answer number is too big.'**
  String get errorScaleAfterAnswerNumberTooBig;

  /// No description provided for @errorScaleAfterAnswerNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Scale after answer number is too small.'**
  String get errorScaleAfterAnswerNumberTooSmall;

  /// No description provided for @errorScaleAfterAnswerNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Scale after answer must be an integer.'**
  String get errorScaleAfterAnswerNotAnInteger;

  /// No description provided for @errorScaleAfterAnswerNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Scale after answer must be a number.'**
  String get errorScaleAfterAnswerNotANumber;

  /// No description provided for @errorScaleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Scale cannot be empty.'**
  String get errorScaleEmpty;

  /// No description provided for @errorScaleInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Scale is invalid.'**
  String get errorScaleInvalidEnum;

  /// No description provided for @errorTimeNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Time must be a date string.'**
  String get errorTimeNotADateString;

  /// No description provided for @errorEmotionNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Emotion must be an array.'**
  String get errorEmotionNotAnArray;

  /// No description provided for @errorEmotionArrayContainsDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Emotion array contains duplicates.'**
  String get errorEmotionArrayContainsDuplicates;

  /// No description provided for @errorEmotionArraySizeTooBig.
  ///
  /// In en, this message translates to:
  /// **'Emotion array size is too big.'**
  String get errorEmotionArraySizeTooBig;

  /// No description provided for @errorEmotionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Emotion must be a string.'**
  String get errorEmotionNotAString;

  /// No description provided for @errorEmotionInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Emotion is invalid.'**
  String get errorEmotionInvalidEnum;

  /// No description provided for @errorPersonNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Person must be an array.'**
  String get errorPersonNotAnArray;

  /// No description provided for @errorPersonArrayContainsDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Person array contains duplicates.'**
  String get errorPersonArrayContainsDuplicates;

  /// No description provided for @errorPersonArraySizeTooBig.
  ///
  /// In en, this message translates to:
  /// **'Person array size is too big.'**
  String get errorPersonArraySizeTooBig;

  /// No description provided for @errorPersonNotAString.
  ///
  /// In en, this message translates to:
  /// **'Person must be a string.'**
  String get errorPersonNotAString;

  /// No description provided for @errorPersonInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Person is invalid.'**
  String get errorPersonInvalidEnum;

  /// No description provided for @errorLocationNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Location must be an array.'**
  String get errorLocationNotAnArray;

  /// No description provided for @errorLocationArrayContainsDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Location array contains duplicates.'**
  String get errorLocationArrayContainsDuplicates;

  /// No description provided for @errorLocationArraySizeTooBig.
  ///
  /// In en, this message translates to:
  /// **'Location array size is too big.'**
  String get errorLocationArraySizeTooBig;

  /// No description provided for @errorLocationNotAString.
  ///
  /// In en, this message translates to:
  /// **'Location must be a string.'**
  String get errorLocationNotAString;

  /// No description provided for @errorFoodNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Food must be an array.'**
  String get errorFoodNotAnArray;

  /// No description provided for @errorFoodArrayContainsDuplicates.
  ///
  /// In en, this message translates to:
  /// **'Food array contains duplicates.'**
  String get errorFoodArrayContainsDuplicates;

  /// No description provided for @errorFoodArraySizeTooBig.
  ///
  /// In en, this message translates to:
  /// **'Food array size is too big.'**
  String get errorFoodArraySizeTooBig;

  /// No description provided for @errorFoodNotAString.
  ///
  /// In en, this message translates to:
  /// **'Food must be a string.'**
  String get errorFoodNotAString;

  /// No description provided for @errorFoodInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Food is invalid.'**
  String get errorFoodInvalidEnum;

  /// No description provided for @errorNoteNotAString.
  ///
  /// In en, this message translates to:
  /// **'Note must be a string.'**
  String get errorNoteNotAString;

  /// No description provided for @errorNoteStringTooShort.
  ///
  /// In en, this message translates to:
  /// **'Note string is too short.'**
  String get errorNoteStringTooShort;

  /// No description provided for @errorNoteStringTooLong.
  ///
  /// In en, this message translates to:
  /// **'Note string is too long.'**
  String get errorNoteStringTooLong;

  /// No description provided for @errorMoodIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Mood ID cannot be empty.'**
  String get errorMoodIdEmpty;

  /// No description provided for @errorMoodIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Mood ID must be a number.'**
  String get errorMoodIdNotANumber;

  /// No description provided for @errorMoodIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Mood ID must be an integer.'**
  String get errorMoodIdNotAnInteger;

  /// No description provided for @errorMoodIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Mood ID must be a positive number.'**
  String get errorMoodIdNotAPositiveNumber;

  /// No description provided for @errorExternalIdNotANumberString.
  ///
  /// In en, this message translates to:
  /// **'External ID must be a number string.'**
  String get errorExternalIdNotANumberString;

  /// No description provided for @errorShortTitleNotAString.
  ///
  /// In en, this message translates to:
  /// **'Short title must be a string.'**
  String get errorShortTitleNotAString;

  /// No description provided for @errorShortTitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Short title cannot be empty.'**
  String get errorShortTitleEmpty;

  /// No description provided for @errorDescriptionNotAString.
  ///
  /// In en, this message translates to:
  /// **'Description must be a string.'**
  String get errorDescriptionNotAString;

  /// No description provided for @errorDescriptionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Description cannot be empty.'**
  String get errorDescriptionEmpty;

  /// No description provided for @errorFunFactNotAString.
  ///
  /// In en, this message translates to:
  /// **'Fun fact must be a string.'**
  String get errorFunFactNotAString;

  /// No description provided for @errorFunFactEmpty.
  ///
  /// In en, this message translates to:
  /// **'Fun fact cannot be empty.'**
  String get errorFunFactEmpty;

  /// No description provided for @errorRequiredCompletionDaysNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Required completion days must be a number.'**
  String get errorRequiredCompletionDaysNotANumber;

  /// No description provided for @errorRequiredCompletionDaysNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Required completion days must be an integer.'**
  String get errorRequiredCompletionDaysNotAnInteger;

  /// No description provided for @errorRequiredCompletionDaysNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Required completion days must be a positive number.'**
  String get errorRequiredCompletionDaysNotAPositiveNumber;

  /// No description provided for @errorLengthInDaysNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Length in days must be a number.'**
  String get errorLengthInDaysNotANumber;

  /// No description provided for @errorLengthInDaysNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Length in days must be an integer.'**
  String get errorLengthInDaysNotAnInteger;

  /// No description provided for @errorLengthInDaysNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Length in days must be a positive number.'**
  String get errorLengthInDaysNotAPositiveNumber;

  /// No description provided for @errorLengthInDaysNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Length in days number is too big.'**
  String get errorLengthInDaysNumberTooBig;

  /// No description provided for @errorRelatedExternalGoalIdsNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Related external goal IDs must be positive numbers.'**
  String get errorRelatedExternalGoalIdsNotAPositiveNumber;

  /// No description provided for @errorRelatedExternalGoalIdsNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Related external goal IDs must be integers.'**
  String get errorRelatedExternalGoalIdsNotAnInteger;

  /// No description provided for @errorRelatedExternalGoalIdsNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Related external goal IDs must be numbers.'**
  String get errorRelatedExternalGoalIdsNotANumber;

  /// No description provided for @errorRelatedExternalGoalIdsNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Related external goal IDs must be an array.'**
  String get errorRelatedExternalGoalIdsNotAnArray;

  /// No description provided for @errorGoalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Goal ID cannot be empty.'**
  String get errorGoalIdEmpty;

  /// No description provided for @errorGoalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Goal ID must be a number.'**
  String get errorGoalIdNotANumber;

  /// No description provided for @errorGoalIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Goal ID must be an integer.'**
  String get errorGoalIdNotAnInteger;

  /// No description provided for @errorGoalIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Goal ID must be a positive number.'**
  String get errorGoalIdNotAPositiveNumber;

  /// No description provided for @errorCompletionDaysPer7DaysNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Completion days per 7 days must be a number.'**
  String get errorCompletionDaysPer7DaysNotANumber;

  /// No description provided for @errorCompletionDaysPer7DaysNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Completion days per 7 days must be an integer.'**
  String get errorCompletionDaysPer7DaysNotAnInteger;

  /// No description provided for @errorCompletionDaysPer7DaysNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Completion days per 7 days must be a positive number.'**
  String get errorCompletionDaysPer7DaysNotAPositiveNumber;

  /// No description provided for @errorCompletionDaysPer7DaysNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Completion days per 7 days number is too big.'**
  String get errorCompletionDaysPer7DaysNumberTooBig;

  /// No description provided for @errorFilePathEmpty.
  ///
  /// In en, this message translates to:
  /// **'File path cannot be empty.'**
  String get errorFilePathEmpty;

  /// No description provided for @errorFilePathNotAString.
  ///
  /// In en, this message translates to:
  /// **'File path must be a string.'**
  String get errorFilePathNotAString;

  /// No description provided for @errorCategoryIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Category ID cannot be empty.'**
  String get errorCategoryIdEmpty;

  /// No description provided for @errorCategoryIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Category ID must be a number.'**
  String get errorCategoryIdNotANumber;

  /// No description provided for @errorCategoryIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Category ID must be an integer.'**
  String get errorCategoryIdNotAnInteger;

  /// No description provided for @errorCategoryIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Category ID must be a positive number.'**
  String get errorCategoryIdNotAPositiveNumber;

  /// No description provided for @errorTimesNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Times must be an integer.'**
  String get errorTimesNotAnInteger;

  /// No description provided for @errorTimesNumberTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Times number is too small.'**
  String get errorTimesNumberTooSmall;

  /// No description provided for @errorReviewIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Review ID cannot be empty.'**
  String get errorReviewIdEmpty;

  /// No description provided for @errorReviewIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Review ID must be a number.'**
  String get errorReviewIdNotANumber;

  /// No description provided for @errorReviewIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Review ID must be an integer.'**
  String get errorReviewIdNotAnInteger;

  /// No description provided for @errorReviewIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Review ID must be a positive number.'**
  String get errorReviewIdNotAPositiveNumber;

  /// No description provided for @errorProgressNotAnArray.
  ///
  /// In en, this message translates to:
  /// **'Progress must be an array.'**
  String get errorProgressNotAnArray;

  /// No description provided for @errorProgressEmptyArray.
  ///
  /// In en, this message translates to:
  /// **'Progress cannot be an empty array.'**
  String get errorProgressEmptyArray;

  /// No description provided for @errorDifficultyNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Difficulty must be a number.'**
  String get errorDifficultyNotANumber;

  /// No description provided for @errorDifficultyNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Difficulty must be an integer.'**
  String get errorDifficultyNotAnInteger;

  /// No description provided for @errorDifficultyNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Difficulty must be a positive number.'**
  String get errorDifficultyNotAPositiveNumber;

  /// No description provided for @errorDifficultyNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Difficulty number is too big.'**
  String get errorDifficultyNumberTooBig;

  /// No description provided for @errorIsTryAgainNotABoolean.
  ///
  /// In en, this message translates to:
  /// **'Is try again must be a boolean.'**
  String get errorIsTryAgainNotABoolean;

  /// No description provided for @errorSmartGoalIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID cannot be empty.'**
  String get errorSmartGoalIdEmpty;

  /// No description provided for @errorSmartGoalIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID must be a number.'**
  String get errorSmartGoalIdNotANumber;

  /// No description provided for @errorSmartGoalIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID must be an integer.'**
  String get errorSmartGoalIdNotAnInteger;

  /// No description provided for @errorSmartGoalIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID must be a positive number.'**
  String get errorSmartGoalIdNotAPositiveNumber;

  /// No description provided for @errorStartedAtEmpty.
  ///
  /// In en, this message translates to:
  /// **'Started at cannot be empty.'**
  String get errorStartedAtEmpty;

  /// No description provided for @errorStartedAtNotAString.
  ///
  /// In en, this message translates to:
  /// **'Started at must be a string.'**
  String get errorStartedAtNotAString;

  /// No description provided for @errorStartedAtNotADateString.
  ///
  /// In en, this message translates to:
  /// **'Started at must be a date string.'**
  String get errorStartedAtNotADateString;

  /// No description provided for @errorReasonInvalidEnum.
  ///
  /// In en, this message translates to:
  /// **'Reason is invalid.'**
  String get errorReasonInvalidEnum;

  /// No description provided for @errorSessionIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Session ID cannot be empty.'**
  String get errorSessionIdEmpty;

  /// No description provided for @errorProgressIdEmpty.
  ///
  /// In en, this message translates to:
  /// **'Progress ID cannot be empty.'**
  String get errorProgressIdEmpty;

  /// No description provided for @errorProgressIdNotANumber.
  ///
  /// In en, this message translates to:
  /// **'Progress ID must be a number.'**
  String get errorProgressIdNotANumber;

  /// No description provided for @errorProgressIdNotAnInteger.
  ///
  /// In en, this message translates to:
  /// **'Progress ID must be an integer.'**
  String get errorProgressIdNotAnInteger;

  /// No description provided for @errorProgressIdNotAPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Progress ID must be a positive number.'**
  String get errorProgressIdNotAPositiveNumber;

  /// No description provided for @errorCoreAccountIdFailedToSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Core account ID failed to send message.'**
  String get errorCoreAccountIdFailedToSendMessage;

  /// No description provided for @errorCoreRequestNeedToBeRefetched.
  ///
  /// In en, this message translates to:
  /// **'Request needs to be refetched.'**
  String get errorCoreRequestNeedToBeRefetched;

  /// No description provided for @errorCoreMvpAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'MVP access denied.'**
  String get errorCoreMvpAccessDenied;

  /// No description provided for @errorCoreAccountIdCanNotParse.
  ///
  /// In en, this message translates to:
  /// **'Account ID cannot be parsed.'**
  String get errorCoreAccountIdCanNotParse;

  /// No description provided for @errorCoreAccountIdNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'Account ID not authenticated.'**
  String get errorCoreAccountIdNotAuthenticated;

  /// No description provided for @errorCoreEmailOrPasswordAreIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password are incorrect.'**
  String get errorCoreEmailOrPasswordAreIncorrect;

  /// No description provided for @errorCoreEmailNotApproved.
  ///
  /// In en, this message translates to:
  /// **'Email not approved.'**
  String get errorCoreEmailNotApproved;

  /// No description provided for @errorCoreRefreshTokenHasBeenExpired.
  ///
  /// In en, this message translates to:
  /// **'Refresh token has been expired.'**
  String get errorCoreRefreshTokenHasBeenExpired;

  /// No description provided for @errorCorePasswordTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Password token not found.'**
  String get errorCorePasswordTokenNotFound;

  /// No description provided for @errorCorePasswordTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Password token expired.'**
  String get errorCorePasswordTokenExpired;

  /// No description provided for @errorAuthAccessTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Auth access token is invalid.'**
  String get errorAuthAccessTokenInvalid;

  /// No description provided for @errorAuthRefreshTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Auth refresh token not found.'**
  String get errorAuthRefreshTokenNotFound;

  /// No description provided for @errorAccountEmailOrPasswordInvalid.
  ///
  /// In en, this message translates to:
  /// **'We were unable to update your email address. Please check your credentials and try again'**
  String get errorAccountEmailOrPasswordInvalid;

  /// No description provided for @errorAccountIdAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This email address is incorrect or already taken.'**
  String get errorAccountIdAlreadyExists;

  /// No description provided for @errorAccountIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account ID not found.'**
  String get errorAccountIdNotFound;

  /// No description provided for @errorAccountEmailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email or password are incorrect.'**
  String get errorAccountEmailNotFound;

  /// No description provided for @errorAccountInvitationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account invitation not found.'**
  String get errorAccountInvitationNotFound;

  /// No description provided for @errorAccountEmailTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account email token not found.'**
  String get errorAccountEmailTokenNotFound;

  /// No description provided for @errorAccountPasswordTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account password token not found.'**
  String get errorAccountPasswordTokenNotFound;

  /// No description provided for @errorAccountPasswordTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Account password token expired.'**
  String get errorAccountPasswordTokenExpired;

  /// No description provided for @errorAccountEmailExpired.
  ///
  /// In en, this message translates to:
  /// **'Account email expired.'**
  String get errorAccountEmailExpired;

  /// No description provided for @errorAccountEmailPreviouslySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Account email previously submitted.'**
  String get errorAccountEmailPreviouslySubmitted;

  /// No description provided for @errorAccountDiabetesTypeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account diabetes type not found.'**
  String get errorAccountDiabetesTypeNotFound;

  /// No description provided for @errorAccountSubscriptionCancelActive.
  ///
  /// In en, this message translates to:
  /// **'Account subscription cancel active.'**
  String get errorAccountSubscriptionCancelActive;

  /// No description provided for @errorAccountPasswordTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Account password token is invalid.'**
  String get errorAccountPasswordTokenInvalid;

  /// No description provided for @errorCoreFileInvalid.
  ///
  /// In en, this message translates to:
  /// **'Core file is invalid.'**
  String get errorCoreFileInvalid;

  /// No description provided for @errorAccountEmailLessThanADayFromLastChange.
  ///
  /// In en, this message translates to:
  /// **'Account email change must be more than a day ago.'**
  String get errorAccountEmailLessThanADayFromLastChange;

  /// No description provided for @errorPurchaseVerificationError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with verification subscription, please try restore'**
  String get errorPurchaseVerificationError;

  /// No description provided for @errorSubscriptionIdAbsent.
  ///
  /// In en, this message translates to:
  /// **'Subscription ID is absent.'**
  String get errorSubscriptionIdAbsent;

  /// No description provided for @errorSubscriptionIosProductIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Subscription iOS product ID not found.'**
  String get errorSubscriptionIosProductIdNotFound;

  /// No description provided for @errorSubscriptionAndroidProductIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Subscription Android product ID not found.'**
  String get errorSubscriptionAndroidProductIdNotFound;

  /// No description provided for @errorSubscriptionAccountIdAbsent.
  ///
  /// In en, this message translates to:
  /// **'Subscription account ID is absent.'**
  String get errorSubscriptionAccountIdAbsent;

  /// No description provided for @errorSubscriptionPurchaseTokenAbsent.
  ///
  /// In en, this message translates to:
  /// **'Subscription purchase token is absent.'**
  String get errorSubscriptionPurchaseTokenAbsent;

  /// No description provided for @errorSubscriptionPackageNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription package name is invalid.'**
  String get errorSubscriptionPackageNameInvalid;

  /// No description provided for @errorSubscriptionAccountIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'It looks like your Apple ID already has a subscription on another LeanOnMe account. Please log in with that email address to use your subscription. If you need assistance, please contact support@lean-on.me'**
  String get errorSubscriptionAccountIdInvalid;

  /// No description provided for @errorSubscriptionVendorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription vendor is invalid.'**
  String get errorSubscriptionVendorInvalid;

  /// No description provided for @errorSubscriptionPurchaseTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription purchase token is invalid.'**
  String get errorSubscriptionPurchaseTokenInvalid;

  /// No description provided for @errorSubscriptionEnvironmentInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription environment is invalid.'**
  String get errorSubscriptionEnvironmentInvalid;

  /// No description provided for @errorSubscriptionBaseTransactionIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription base transaction ID is invalid.'**
  String get errorSubscriptionBaseTransactionIdInvalid;

  /// No description provided for @errorSubscriptionTransactionIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Subscription transaction ID is invalid.'**
  String get errorSubscriptionTransactionIdInvalid;

  /// No description provided for @errorSubscriptionAndroidDataEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subscription Android data is empty.'**
  String get errorSubscriptionAndroidDataEmpty;

  /// No description provided for @errorSubscriptionWithAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'Subscription with account not found.'**
  String get errorSubscriptionWithAccountNotFound;

  /// No description provided for @errorGroupingAccountIdAppFeatureLocked.
  ///
  /// In en, this message translates to:
  /// **'Grouping account ID app feature is locked.'**
  String get errorGroupingAccountIdAppFeatureLocked;

  /// No description provided for @errorGroupingDataOneOptionalFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Grouping data requires one optional field.'**
  String get errorGroupingDataOneOptionalFieldRequired;

  /// No description provided for @errorGroupingGenderPreferenceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Grouping gender preference is invalid.'**
  String get errorGroupingGenderPreferenceInvalid;

  /// No description provided for @errorGroupingBmiRangeCanNotCalculate.
  ///
  /// In en, this message translates to:
  /// **'Grouping BMI range cannot be calculated.'**
  String get errorGroupingBmiRangeCanNotCalculate;

  /// No description provided for @errorGroupingAgeRangeCanNotCalculate.
  ///
  /// In en, this message translates to:
  /// **'Grouping age range cannot be calculated.'**
  String get errorGroupingAgeRangeCanNotCalculate;

  /// No description provided for @errorGroupingAccountGroupingStateCanNotCancel.
  ///
  /// In en, this message translates to:
  /// **'Grouping account grouping state cannot be canceled.'**
  String get errorGroupingAccountGroupingStateCanNotCancel;

  /// No description provided for @errorGroupingGroupIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Grouping group ID not found.'**
  String get errorGroupingGroupIdNotFound;

  /// No description provided for @errorGroupingAccountIdAlreadyInGroup.
  ///
  /// In en, this message translates to:
  /// **'Account ID is already in the group.'**
  String get errorGroupingAccountIdAlreadyInGroup;

  /// No description provided for @errorBuddyAccountAlreadyHaveABuddy.
  ///
  /// In en, this message translates to:
  /// **'Account already has a buddy.'**
  String get errorBuddyAccountAlreadyHaveABuddy;

  /// No description provided for @errorBuddyEntityNotFound.
  ///
  /// In en, this message translates to:
  /// **'Buddy entity not found.'**
  String get errorBuddyEntityNotFound;

  /// No description provided for @errorBuddyRefreshTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Buddy refresh token not found.'**
  String get errorBuddyRefreshTokenNotFound;

  /// No description provided for @errorBuddyRegistrationAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Buddy registration already exists.'**
  String get errorBuddyRegistrationAlreadyExists;

  /// No description provided for @errorBuddyRegistrationAlreadyConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Buddy registration already confirmed.'**
  String get errorBuddyRegistrationAlreadyConfirmed;

  /// No description provided for @errorBuddyPasswordTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Buddy password token is invalid.'**
  String get errorBuddyPasswordTokenInvalid;

  /// No description provided for @errorBuddyRegistrationTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Buddy registration token has expired.'**
  String get errorBuddyRegistrationTokenExpired;

  /// No description provided for @errorBuddyRegistrationTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Buddy registration token is invalid.'**
  String get errorBuddyRegistrationTokenInvalid;

  /// No description provided for @errorBuddyInvitationTokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation token has expired.'**
  String get errorBuddyInvitationTokenExpired;

  /// No description provided for @errorBuddyInvitationTokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation token is invalid.'**
  String get errorBuddyInvitationTokenInvalid;

  /// No description provided for @errorBuddyInvitationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation email is invalid.'**
  String get errorBuddyInvitationEmailInvalid;

  /// No description provided for @errorBuddyInvitationNotFound.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation not found.'**
  String get errorBuddyInvitationNotFound;

  /// No description provided for @errorBuddyInvitationHasBeenRejected.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation has been rejected.'**
  String get errorBuddyInvitationHasBeenRejected;

  /// No description provided for @errorBuddyInvitationAlreadyApproved.
  ///
  /// In en, this message translates to:
  /// **'Buddy invitation has already been approved.'**
  String get errorBuddyInvitationAlreadyApproved;

  /// No description provided for @errorBuddyInvitationBuddyOccupied.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this person isn’t available for the buddy program. Can you think of someone else who could help you? Reach out to support if you need a hand'**
  String get errorBuddyInvitationBuddyOccupied;

  /// No description provided for @errorDiabetesTypeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Diabetes type not found.'**
  String get errorDiabetesTypeNotFound;

  /// No description provided for @errorNutritionMealIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition meal ID not found.'**
  String get errorNutritionMealIdNotFound;

  /// No description provided for @errorNutritionMealFoodItemIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition meal food item ID not found.'**
  String get errorNutritionMealFoodItemIdNotFound;

  /// No description provided for @errorNutritionMealRecipeIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition meal recipe ID not found.'**
  String get errorNutritionMealRecipeIdNotFound;

  /// No description provided for @errorNutritionMealDishIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition meal dish ID not found.'**
  String get errorNutritionMealDishIdNotFound;

  /// No description provided for @errorNutritionFavoriteFoodItemIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition favorite food item ID not found.'**
  String get errorNutritionFavoriteFoodItemIdNotFound;

  /// No description provided for @errorNutritionFavoriteServingIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition favorite serving ID not found.'**
  String get errorNutritionFavoriteServingIdNotFound;

  /// No description provided for @errorNutritionFavoriteAccountIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition favorite account ID not found.'**
  String get errorNutritionFavoriteAccountIdNotFound;

  /// No description provided for @errorNutritionFavoriteAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Nutrition favorite already exists.'**
  String get errorNutritionFavoriteAlreadyExists;

  /// No description provided for @errorNutritionWeightLogNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition weight log not found.'**
  String get errorNutritionWeightLogNotFound;

  /// No description provided for @errorNutritionRecipeIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition recipe ID not found.'**
  String get errorNutritionRecipeIdNotFound;

  /// No description provided for @errorNutritionAccountDishesNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition account dishes not found.'**
  String get errorNutritionAccountDishesNotFound;

  /// No description provided for @errorNutritionDishNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition dish not found.'**
  String get errorNutritionDishNotFound;

  /// No description provided for @errorNutritionDishFoodItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition dish food item not found.'**
  String get errorNutritionDishFoodItemNotFound;

  /// No description provided for @errorNutritionDishMealRecipeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition dish meal recipe not found.'**
  String get errorNutritionDishMealRecipeNotFound;

  /// No description provided for @errorNutritionDishFoodItemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nutrition dish food items are empty.'**
  String get errorNutritionDishFoodItemsEmpty;

  /// No description provided for @errorFoodPreferencesHateTagNotFound.
  ///
  /// In en, this message translates to:
  /// **'Food preferences hate tag not found.'**
  String get errorFoodPreferencesHateTagNotFound;

  /// No description provided for @errorFoodPreferencesAllergenTagNotFound.
  ///
  /// In en, this message translates to:
  /// **'Food preferences allergen tag not found.'**
  String get errorFoodPreferencesAllergenTagNotFound;

  /// No description provided for @errorFoodPreferencesDislikeTagNotFound.
  ///
  /// In en, this message translates to:
  /// **'Food preferences dislike tag not found.'**
  String get errorFoodPreferencesDislikeTagNotFound;

  /// No description provided for @errorMentalHealthQuestionIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Mental health question ID is invalid.'**
  String get errorMentalHealthQuestionIdInvalid;

  /// No description provided for @errorMentalHealthOptionIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Mental health option ID is invalid.'**
  String get errorMentalHealthOptionIdInvalid;

  /// No description provided for @errorMentalHealthTypeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Mental health type is invalid.'**
  String get errorMentalHealthTypeInvalid;

  /// No description provided for @errorMedicalOnboardingQuestionTypeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Medical onboarding question type is invalid.'**
  String get errorMedicalOnboardingQuestionTypeInvalid;

  /// No description provided for @errorPhysicalActivitiesPhysicalProgramIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Physical program ID not found.'**
  String get errorPhysicalActivitiesPhysicalProgramIdNotFound;

  /// No description provided for @errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Physical program exercise ID not found.'**
  String get errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound;

  /// No description provided for @errorPhysicalActivitiesPreferencesNotFound.
  ///
  /// In en, this message translates to:
  /// **'Physical activities preferences not found.'**
  String get errorPhysicalActivitiesPreferencesNotFound;

  /// No description provided for @errorRiverModuleNotFound.
  ///
  /// In en, this message translates to:
  /// **'River module not found.'**
  String get errorRiverModuleNotFound;

  /// No description provided for @errorRiverModuleItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'River module item not found.'**
  String get errorRiverModuleItemNotFound;

  /// No description provided for @errorEducationLessonNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education lesson not found.'**
  String get errorEducationLessonNotFound;

  /// No description provided for @errorEducationQuizUpdateNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Education quiz update not allowed.'**
  String get errorEducationQuizUpdateNotAllowed;

  /// No description provided for @errorEducationQuizSubmitNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education quiz submit not found.'**
  String get errorEducationQuizSubmitNotFound;

  /// No description provided for @errorEducationQuizAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Education quiz already submitted.'**
  String get errorEducationQuizAlreadySubmitted;

  /// No description provided for @errorEducationQuizOptionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education quiz option not found.'**
  String get errorEducationQuizOptionNotFound;

  /// No description provided for @errorEducationQuizNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education quiz not found.'**
  String get errorEducationQuizNotFound;

  /// No description provided for @errorEducationReflectionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education reflection not found.'**
  String get errorEducationReflectionNotFound;

  /// No description provided for @errorEducationReflectionOptionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education reflection option not found.'**
  String get errorEducationReflectionOptionNotFound;

  /// No description provided for @errorEducationReflectionFeedbackNotFound.
  ///
  /// In en, this message translates to:
  /// **'Education reflection feedback not found.'**
  String get errorEducationReflectionFeedbackNotFound;

  /// No description provided for @errorEducationReflectionAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Education reflection already submitted.'**
  String get errorEducationReflectionAlreadySubmitted;

  /// No description provided for @errorEducationReflectionFeedbackAlreadySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Education reflection feedback already submitted.'**
  String get errorEducationReflectionFeedbackAlreadySubmitted;

  /// No description provided for @errorNutritionPlannedMealIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrition planned meal ID not found.'**
  String get errorNutritionPlannedMealIdNotFound;

  /// No description provided for @errorNutritionPlannedMealDateInvalid.
  ///
  /// In en, this message translates to:
  /// **'Nutrition planned meal date is invalid.'**
  String get errorNutritionPlannedMealDateInvalid;

  /// No description provided for @errorGroupSessionIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group session ID not found.'**
  String get errorGroupSessionIdNotFound;

  /// No description provided for @errorGroupSessionAccountIdNotGrouped.
  ///
  /// In en, this message translates to:
  /// **'Account ID is not grouped in the session.'**
  String get errorGroupSessionAccountIdNotGrouped;

  /// No description provided for @errorGroupSessionAccountIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group session account ID not found.'**
  String get errorGroupSessionAccountIdNotFound;

  /// No description provided for @errorGroupSessionAccountIdAlreadySigned.
  ///
  /// In en, this message translates to:
  /// **'Account ID is already signed in the session.'**
  String get errorGroupSessionAccountIdAlreadySigned;

  /// No description provided for @errorGroupSessionAccountIdWasNotSigned.
  ///
  /// In en, this message translates to:
  /// **'Account ID was not signed in the session.'**
  String get errorGroupSessionAccountIdWasNotSigned;

  /// No description provided for @errorGroupSessionProgramImageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Group session program image not found.'**
  String get errorGroupSessionProgramImageNotFound;

  /// No description provided for @errorGroupSessionProgramImageInvalidMimeType.
  ///
  /// In en, this message translates to:
  /// **'Group session program image has an invalid MIME type.'**
  String get errorGroupSessionProgramImageInvalidMimeType;

  /// No description provided for @errorGroupSessionStatusMismatchUpdateFlow.
  ///
  /// In en, this message translates to:
  /// **'Group session status mismatch in update flow.'**
  String get errorGroupSessionStatusMismatchUpdateFlow;

  /// No description provided for @errorChatAccountIdNotAssignedToGroup.
  ///
  /// In en, this message translates to:
  /// **'Chat account ID is not assigned to the group.'**
  String get errorChatAccountIdNotAssignedToGroup;

  /// No description provided for @errorChatMessageIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Chat message ID not found.'**
  String get errorChatMessageIdNotFound;

  /// No description provided for @errorMindTechniqueIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Mind technique ID not found.'**
  String get errorMindTechniqueIdNotFound;

  /// No description provided for @errorMindExerciseIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Mind exercise ID not found.'**
  String get errorMindExerciseIdNotFound;

  /// No description provided for @errorMoodIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Mood ID not found.'**
  String get errorMoodIdNotFound;

  /// No description provided for @errorMoodCreatedAyIsOld.
  ///
  /// In en, this message translates to:
  /// **'Mood created day is too old.'**
  String get errorMoodCreatedAyIsOld;

  /// No description provided for @errorSmartGoalStartDateActiveSessionExists.
  ///
  /// In en, this message translates to:
  /// **'Smart goal start date has an active session.'**
  String get errorSmartGoalStartDateActiveSessionExists;

  /// No description provided for @errorSmartGoalIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID not found.'**
  String get errorSmartGoalIdNotFound;

  /// No description provided for @errorSmartGoalSessionIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Smart goal session ID not found.'**
  String get errorSmartGoalSessionIdNotFound;

  /// No description provided for @errorSmartGoalReviewIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Smart goal review ID not found.'**
  String get errorSmartGoalReviewIdNotFound;

  /// No description provided for @errorSmartGoalProgressLogsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Smart goal progress logs are invalid.'**
  String get errorSmartGoalProgressLogsInvalid;

  /// No description provided for @errorSmartGoalCategoryIdsLocked.
  ///
  /// In en, this message translates to:
  /// **'Smart goal category IDs are locked.'**
  String get errorSmartGoalCategoryIdsLocked;

  /// No description provided for @errorSmartGoalCategoryIdLocked.
  ///
  /// In en, this message translates to:
  /// **'Smart goal category ID is locked.'**
  String get errorSmartGoalCategoryIdLocked;

  /// No description provided for @errorSmartGoalSessionIdActiveLimitExceeded.
  ///
  /// In en, this message translates to:
  /// **'Smart goal session ID active limit exceeded.'**
  String get errorSmartGoalSessionIdActiveLimitExceeded;

  /// No description provided for @errorSmartGoalCategoryIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Smart goal category ID not found.'**
  String get errorSmartGoalCategoryIdNotFound;

  /// No description provided for @errorSmartGoalIdConflictsWithActive.
  ///
  /// In en, this message translates to:
  /// **'Smart goal ID conflicts with an active one.'**
  String get errorSmartGoalIdConflictsWithActive;

  /// No description provided for @errorSmartGoalIdDuplicatesFound.
  ///
  /// In en, this message translates to:
  /// **'Duplicate smart goal IDs found.'**
  String get errorSmartGoalIdDuplicatesFound;

  /// No description provided for @errorCoreInternalServer.
  ///
  /// In en, this message translates to:
  /// **'Internal server error.'**
  String get errorCoreInternalServer;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorRetry;

  /// No description provided for @errorNoConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get errorNoConnectionTitle;

  /// No description provided for @errorNoConnectionText.
  ///
  /// In en, this message translates to:
  /// **'Your internet connection was interrupted. \nRestore the connection and try again'**
  String get errorNoConnectionText;

  /// No description provided for @errorInvalidIngredientText.
  ///
  /// In en, this message translates to:
  /// **'Sorry, invalid ingredients data'**
  String get errorInvalidIngredientText;

  /// No description provided for @errorOeps.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get errorOeps;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong \nPlease try again later'**
  String get errorSomethingWentWrong;

  /// No description provided for @errorSubscriptionServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with service, please try again'**
  String get errorSubscriptionServiceUnavailable;

  /// No description provided for @errorPurchaseStreamError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with stream subscription, please try again'**
  String get errorPurchaseStreamError;

  /// No description provided for @errorPurchaseErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Product was not purchased, please try again'**
  String get errorPurchaseErrorMessage;

  /// No description provided for @errorSomethingIsIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Something is incorrect or missing'**
  String get errorSomethingIsIncorrect;

  /// No description provided for @errorServingIdIsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Sorry, invalid ingredients data'**
  String get errorServingIdIsNotFound;

  /// No description provided for @errorSocketException.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with socket'**
  String get errorSocketException;

  /// No description provided for @errorParsingException.
  ///
  /// In en, this message translates to:
  /// **'Something is incorrect or missing in data'**
  String get errorParsingException;

  /// No description provided for @errorLoadTranslations.
  ///
  /// In en, this message translates to:
  /// **'Error loading translations'**
  String get errorLoadTranslations;

  /// No description provided for @errorTimeoutDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorTimeoutDio;

  /// No description provided for @errorConnectionDio.
  ///
  /// In en, this message translates to:
  /// **'Your internet connection was interrupted. \nRestore the connection and try again'**
  String get errorConnectionDio;

  /// No description provided for @errorRequestCancelledDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorRequestCancelledDio;

  /// No description provided for @errorBadRequestDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorBadRequestDio;

  /// No description provided for @errorUnauthorizedDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorUnauthorizedDio;

  /// No description provided for @errorForbiddenDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorForbiddenDio;

  /// No description provided for @errorNotFoundDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorNotFoundDio;

  /// No description provided for @errorConflictDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorConflictDio;

  /// No description provided for @errorServerErrorDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorServerErrorDio;

  /// No description provided for @errorUnprocessableEntityDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorUnprocessableEntityDio;

  /// No description provided for @errorUnhandledResponseDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorUnhandledResponseDio;

  /// No description provided for @errorUnhandledErrorDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorUnhandledErrorDio;

  /// No description provided for @errorOtherDio.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorOtherDio;

  /// No description provided for @onboardingIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'LeanOnMe gives you the tools to lose weight sustainably.'**
  String get onboardingIntroTitle;

  /// No description provided for @onboardingIntroProgram1.
  ///
  /// In en, this message translates to:
  /// **'Based on a psychology driven program which successfully helped people to lose weight and feel better, long term.'**
  String get onboardingIntroProgram1;

  /// No description provided for @onboardingIntroProgram2.
  ///
  /// In en, this message translates to:
  /// **'Nutrition, physical activity, medical knowledge, and community support combine with psychology to help you reach your goals.'**
  String get onboardingIntroProgram2;

  /// No description provided for @onboardingIntroMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Our team of experts  brings the success of the clinical program to you!'**
  String get onboardingIntroMissionTitle;

  /// No description provided for @onboardingIntroMissionAndrew.
  ///
  /// In en, this message translates to:
  /// **'Andrew has a PHD in Bio-Chemistry and is the brains behind our nutrition program. With curated recipes, customized goals, and NO FOCUS ON CALORIE TRACKING, our nutrition program is one-of-a-kind.'**
  String get onboardingIntroMissionAndrew;

  /// No description provided for @onboardingIntroMissionMaria.
  ///
  /// In en, this message translates to:
  /// **'Maria has an MSc in Digital Psychology, and is the link between the successful clinical program and our digitalized version.'**
  String get onboardingIntroMissionMaria;

  /// No description provided for @onboardingIntroMissionShalu.
  ///
  /// In en, this message translates to:
  /// **'Shalu is an MD specialized in Psychiatry. With her focus on addiction and addictive-behaviors, she is intrinsically qualified to oversee and encourage your journey to happier, healthier lifestyle.'**
  String get onboardingIntroMissionShalu;

  /// No description provided for @onboardingIntroMissionJoshua.
  ///
  /// In en, this message translates to:
  /// **'With a love for sports and the human body, Josh has a Sports Science degree and years of experience as a physiotherapist focusing on weight loss. He\'s great at helping people move better and feel their best.'**
  String get onboardingIntroMissionJoshua;

  /// No description provided for @onboardingIntroMissionDenise.
  ///
  /// In en, this message translates to:
  /// **'Denise is an experienced clinical psychologist, who is also trained in Cognitive Behaviour Therapy, Meditation, and Mindfulness Based Therapy. Her passion is to give people the courage to change, and to guide them through the process step-by step.'**
  String get onboardingIntroMissionDenise;

  /// No description provided for @onboardingPacingTitle.
  ///
  /// In en, this message translates to:
  /// **'Go slow to go fast.'**
  String get onboardingPacingTitle;

  /// No description provided for @onboardingPacingMessage.
  ///
  /// In en, this message translates to:
  /// **'Our program is split up into modules, called “pools”. You should aim to spend a minimum of 1 week in each pool, absorbing knowledge and practicing new habits.'**
  String get onboardingPacingMessage;

  /// No description provided for @onboardingIAmReady.
  ///
  /// In en, this message translates to:
  /// **'I’m ready'**
  String get onboardingIAmReady;

  /// No description provided for @onboardingPhysicalIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Basics first'**
  String get onboardingPhysicalIntroTitle;

  /// No description provided for @onboardingPhysicalIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Joshua needs to know the answers to some basics so we can customize your program.'**
  String get onboardingPhysicalIntroBody;

  /// No description provided for @onboardingAgeCheckFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'We are sorry. Unfortunately, your enrollment is not possible now.'**
  String get onboardingAgeCheckFailedTitle;

  /// No description provided for @onboardingAgeCheckFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Our program is not set up for people under the age of 18'**
  String get onboardingAgeCheckFailedBody;

  /// No description provided for @onboardingWhatYourSex.
  ///
  /// In en, this message translates to:
  /// **'What is your sex?'**
  String get onboardingWhatYourSex;

  /// No description provided for @onboardingSexQuestionBody.
  ///
  /// In en, this message translates to:
  /// **'Please indicate what biological sex should be used to calculate certain metrics that will help to properly tailor the program to you.'**
  String get onboardingSexQuestionBody;

  /// No description provided for @onboardingSex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get onboardingSex;

  /// No description provided for @onboardingGenderPageTitle.
  ///
  /// In en, this message translates to:
  /// **'What is your gender?'**
  String get onboardingGenderPageTitle;

  /// No description provided for @onboardingHappinessTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you feel about your current lifestyle?'**
  String get onboardingHappinessTitle;

  /// No description provided for @onboardingHappinessBody1.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to reflect on your lifestyle right now.'**
  String get onboardingHappinessBody1;

  /// No description provided for @onboardingHappinessBody2.
  ///
  /// In en, this message translates to:
  /// **'Using the scale below, please indicate how you generally feel, when you think about your current lifestyle.'**
  String get onboardingHappinessBody2;

  /// No description provided for @onboardingYourHeight.
  ///
  /// In en, this message translates to:
  /// **'Your height'**
  String get onboardingYourHeight;

  /// No description provided for @onboardingMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get onboardingMetric;

  /// No description provided for @onboardingImperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get onboardingImperial;

  /// No description provided for @onboardingChangeYourHeight.
  ///
  /// In en, this message translates to:
  /// **'Change your height'**
  String get onboardingChangeYourHeight;

  /// No description provided for @onboardingHeightSmall.
  ///
  /// In en, this message translates to:
  /// **'Are you sure this is the correct height? Seems rather small. Please correct your input'**
  String get onboardingHeightSmall;

  /// No description provided for @onboardingHeightLarge.
  ///
  /// In en, this message translates to:
  /// **'Are you sure this is the correct height? Seems rather large. Please correct your input'**
  String get onboardingHeightLarge;

  /// No description provided for @onboardingCorrectHeight.
  ///
  /// In en, this message translates to:
  /// **'Please correct your answer'**
  String get onboardingCorrectHeight;

  /// No description provided for @onboardingYourWeight.
  ///
  /// In en, this message translates to:
  /// **'Your weight'**
  String get onboardingYourWeight;

  /// No description provided for @onboardingBmiExclusionBodyTitle.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index (BMI) is:'**
  String get onboardingBmiExclusionBodyTitle;

  /// No description provided for @onboardingHighBmiDescription1.
  ///
  /// In en, this message translates to:
  /// **'LeanOnMe currently has customized programs to support people with a BMI between 25 and 40. We are working on additional customizations to help support people who are outside this BMI range, but we’re not quite there yet.'**
  String get onboardingHighBmiDescription1;

  /// No description provided for @onboardingHighBmiDescription2.
  ///
  /// In en, this message translates to:
  /// **'Some parts of our current program may not be 100% tailored to your needs.'**
  String get onboardingHighBmiDescription2;

  /// No description provided for @onboardingHighBmiDescription3.
  ///
  /// In en, this message translates to:
  /// **'Listen to your body, and if you have any concerns that something is not right for you, please contact support@lean-on.me.'**
  String get onboardingHighBmiDescription3;

  /// No description provided for @onboardingLowerBmiDescription1.
  ///
  /// In en, this message translates to:
  /// **'According to your BMI, you’re within a healthy range, that’s great! But LeanOnMe’s program is designed to support people living with various degrees of overweight and obesity.'**
  String get onboardingLowerBmiDescription1;

  /// No description provided for @onboardingLowerBmiDescription2.
  ///
  /// In en, this message translates to:
  /// **'None of our content is bad for you! But some may not feel as relevant. Enjoy!'**
  String get onboardingLowerBmiDescription2;

  /// No description provided for @onboardingBmiExclusionBody1.
  ///
  /// In en, this message translates to:
  /// **'Your BMI indicates that you may be underweight. LeanOnMe is currently a weight-loss program. In respect to your current BMI, additional weight-loss could affect your health.'**
  String get onboardingBmiExclusionBody1;

  /// No description provided for @onboardingBmiExclusionBody2.
  ///
  /// In en, this message translates to:
  /// **'Please consult to your GP to make sure that your health is not being affected.'**
  String get onboardingBmiExclusionBody2;

  /// No description provided for @onboardingPhysicalCheckPassedTitle.
  ///
  /// In en, this message translates to:
  /// **'Basics completed!'**
  String get onboardingPhysicalCheckPassedTitle;

  /// No description provided for @onboardingAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get onboardingAge;

  /// No description provided for @onboardingHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get onboardingHeight;

  /// No description provided for @onboardingWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get onboardingWeight;

  /// No description provided for @onboardingBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get onboardingBmi;

  /// No description provided for @onboardingYears.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get onboardingYears;

  /// No description provided for @onboardingBmiDescription1.
  ///
  /// In en, this message translates to:
  /// **'The Body Mass Index (BMI) is a measure  that uses your height and weight to calculate if your weight for your body is within a healthy range'**
  String get onboardingBmiDescription1;

  /// No description provided for @onboardingBmiDescriptionAccent.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index (BMI)'**
  String get onboardingBmiDescriptionAccent;

  /// No description provided for @onboardingBmiDescription2.
  ///
  /// In en, this message translates to:
  /// **'However, BMI has limitations - for example it can\'t differentiate between fat, muscle, and bone weight. We\'ll use it along with other metrics to customize your program, but don\'t worry: It won\'t be the only factor that is taken into account'**
  String get onboardingBmiDescription2;

  /// No description provided for @onboardingLetsMoveOn.
  ///
  /// In en, this message translates to:
  /// **'Let’s move on'**
  String get onboardingLetsMoveOn;

  /// No description provided for @onboardingMedicalIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical check'**
  String get onboardingMedicalIntroTitle;

  /// No description provided for @onboardingMedicalIntroBody.
  ///
  /// In en, this message translates to:
  /// **'To ensure that this program is suitable for your current circumstances and to tailor it specifically to you, please answer the next set of questions regarding your health conditions.'**
  String get onboardingMedicalIntroBody;

  /// No description provided for @onboardingAreYouPregnant.
  ///
  /// In en, this message translates to:
  /// **'Are you pregnant?'**
  String get onboardingAreYouPregnant;

  /// No description provided for @onboardingFailedPregnancyTitle.
  ///
  /// In en, this message translates to:
  /// **'We are sorry. Unfortunately, your enrollment is not possible for now.'**
  String get onboardingFailedPregnancyTitle;

  /// No description provided for @onboardingFailedPregnancyBody1.
  ///
  /// In en, this message translates to:
  /// **'You are having a baby.'**
  String get onboardingFailedPregnancyBody1;

  /// No description provided for @onboardingFailedPregnancyBody2.
  ///
  /// In en, this message translates to:
  /// **'This program is not suitable for people who are pregnant.'**
  String get onboardingFailedPregnancyBody2;

  /// No description provided for @onboardingFailedPregnancyBody3.
  ///
  /// In en, this message translates to:
  /// **'We would be happy to welcome you back here after your pregnancy.'**
  String get onboardingFailedPregnancyBody3;

  /// No description provided for @onboardingFailedPregnancyBody4.
  ///
  /// In en, this message translates to:
  /// **'Wishing you all the best for you and your baby-to-be!'**
  String get onboardingFailedPregnancyBody4;

  /// No description provided for @onboardingMedicinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Which medicines do you take regularly?'**
  String get onboardingMedicinesTitle;

  /// No description provided for @onboardingMedicinesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write down one medicine here'**
  String get onboardingMedicinesPlaceholder;

  /// No description provided for @onboardingWeightLossMedicationQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you taking any medication to help you on your weight-loss journey?'**
  String get onboardingWeightLossMedicationQuestion;

  /// No description provided for @onboardingObesityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with a secondary form of obesity (e.g. Cushing syndrome, Prader-Willi syndrome or hypogonadism)?'**
  String get onboardingObesityQuestion;

  /// No description provided for @onboardingThyroidDiseaseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with a thyroid disease (e.g. Hashimoto’s disease or hypothyroidism)?'**
  String get onboardingThyroidDiseaseQuestion;

  /// No description provided for @onboardingMetabolicDiseaseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with a form of metabolic disease?'**
  String get onboardingMetabolicDiseaseQuestion;

  /// No description provided for @onboardingHypertensionQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with hypertension?'**
  String get onboardingHypertensionQuestion;

  /// No description provided for @onboardingCardiovascularDiseaseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with a cardiovascular disease or did you have heart surgery in the last 12 months?'**
  String get onboardingCardiovascularDiseaseQuestion;

  /// No description provided for @onboardingStomachReductionQuestion.
  ///
  /// In en, this message translates to:
  /// **'Did you have a stomach reduction or bariatric surgery in the last 3 years or are you in a preparatory phase for such surgery?'**
  String get onboardingStomachReductionQuestion;

  /// No description provided for @onboardingDiabetesQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with diabetes?'**
  String get onboardingDiabetesQuestion;

  /// No description provided for @onboardingRenalFailureQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with renal failure?'**
  String get onboardingRenalFailureQuestion;

  /// No description provided for @onboardingAsthmaQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with asthma or COPD?'**
  String get onboardingAsthmaQuestion;

  /// No description provided for @onboardingLiverDiseaseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with hepatitis or liver disease?'**
  String get onboardingLiverDiseaseQuestion;

  /// No description provided for @onboardingSleepApneaSyndromeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with sleep apnea syndrome?'**
  String get onboardingSleepApneaSyndromeQuestion;

  /// No description provided for @onboardingLocomotorSystemDiseaseQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you been diagnosed with any disease of the locomotor system (e.g. arthritis, osteoporosis, back/neck pains or inflammatory disease)?'**
  String get onboardingLocomotorSystemDiseaseQuestion;

  /// No description provided for @onboardingTreatmentByTheDoctorQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you currently being treated by a psychologist or psychiatrist?'**
  String get onboardingTreatmentByTheDoctorQuestion;

  /// No description provided for @onboardingMedicalCheckPassedTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical check completed!'**
  String get onboardingMedicalCheckPassedTitle;

  /// No description provided for @onboardingMedicalCheckPassedBody.
  ///
  /// In en, this message translates to:
  /// **'You already completed 2 out of 3 sections. Great, you’re nearly done!'**
  String get onboardingMedicalCheckPassedBody;

  /// No description provided for @onboardingMedicalCheckFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Please check with your doctor or specialist!'**
  String get onboardingMedicalCheckFailedTitle;

  /// No description provided for @onboardingMedicalCheckFailedBody.
  ///
  /// In en, this message translates to:
  /// **'Please ask your doctor, specialist or psychologist before you use this app if it fits to your medical condition and / or treatment of:'**
  String get onboardingMedicalCheckFailedBody;

  /// No description provided for @onboardingMedicalCheckFailedBody2.
  ///
  /// In en, this message translates to:
  /// **'Please note, we additionally offer support groups. If you would like to take part in one of these groups later on in the program, you will need permission from your psychologist/psychiatrist first'**
  String get onboardingMedicalCheckFailedBody2;

  /// No description provided for @onboardingCardioVascularDisease.
  ///
  /// In en, this message translates to:
  /// **'Cardiovascular disease'**
  String get onboardingCardioVascularDisease;

  /// No description provided for @onboardingStomachReductionDisease.
  ///
  /// In en, this message translates to:
  /// **'Stomach reduction disease'**
  String get onboardingStomachReductionDisease;

  /// No description provided for @onboardingObesity.
  ///
  /// In en, this message translates to:
  /// **'Obesity disease'**
  String get onboardingObesity;

  /// No description provided for @onboardingThyroidDisease.
  ///
  /// In en, this message translates to:
  /// **'Thyroid disease'**
  String get onboardingThyroidDisease;

  /// No description provided for @onboardingMetabolicDisease.
  ///
  /// In en, this message translates to:
  /// **'Metabolic disease'**
  String get onboardingMetabolicDisease;

  /// No description provided for @onboardingHypertension.
  ///
  /// In en, this message translates to:
  /// **'Hypertension'**
  String get onboardingHypertension;

  /// No description provided for @onboardingDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes disease'**
  String get onboardingDiabetes;

  /// No description provided for @onboardingDiabetesTypeI.
  ///
  /// In en, this message translates to:
  /// **'Diabetes type I disease'**
  String get onboardingDiabetesTypeI;

  /// No description provided for @onboardingDiabetesTypeII.
  ///
  /// In en, this message translates to:
  /// **'Diabetes type II disease'**
  String get onboardingDiabetesTypeII;

  /// No description provided for @onboardingRenalFailure.
  ///
  /// In en, this message translates to:
  /// **'Renal failure'**
  String get onboardingRenalFailure;

  /// No description provided for @onboardingAsthma.
  ///
  /// In en, this message translates to:
  /// **'Asthma'**
  String get onboardingAsthma;

  /// No description provided for @onboardingLiverDisease.
  ///
  /// In en, this message translates to:
  /// **'Liver disease'**
  String get onboardingLiverDisease;

  /// No description provided for @onboardingSleepApneaSyndrome.
  ///
  /// In en, this message translates to:
  /// **'Sleep apnea syndrome'**
  String get onboardingSleepApneaSyndrome;

  /// No description provided for @onboardingLocomotorSystemDisease.
  ///
  /// In en, this message translates to:
  /// **'Locomotor system disease'**
  String get onboardingLocomotorSystemDisease;

  /// No description provided for @onboardingMentalHealth.
  ///
  /// In en, this message translates to:
  /// **'Mental health'**
  String get onboardingMentalHealth;

  /// No description provided for @onboardingMentalIntroBody1.
  ///
  /// In en, this message translates to:
  /// **'In this section you will be asked questions regarding your current well-being, physiological symptoms and mood.'**
  String get onboardingMentalIntroBody1;

  /// No description provided for @onboardingMentalIntroBody2.
  ///
  /// In en, this message translates to:
  /// **'Based on these results, the program will be adjusted to suit your needs.'**
  String get onboardingMentalIntroBody2;

  /// No description provided for @onboardingYourMentalHealth.
  ///
  /// In en, this message translates to:
  /// **'Your mental health'**
  String get onboardingYourMentalHealth;

  /// No description provided for @onboardingMentalHealthIntroTextOne.
  ///
  /// In en, this message translates to:
  /// **'A good mental health is vital to successfully improve your lifestyle.'**
  String get onboardingMentalHealthIntroTextOne;

  /// No description provided for @onboardingMentalHealthIntroTextTwo.
  ///
  /// In en, this message translates to:
  /// **'This section will take around 15 minutes.'**
  String get onboardingMentalHealthIntroTextTwo;

  /// No description provided for @onboardingMentalHealthIntroTextTwoAccent.
  ///
  /// In en, this message translates to:
  /// **'15 minutes'**
  String get onboardingMentalHealthIntroTextTwoAccent;

  /// No description provided for @onboardingMentalHealthIntroTextThree.
  ///
  /// In en, this message translates to:
  /// **'You can take a break in between as long as you finish this section within one hour.'**
  String get onboardingMentalHealthIntroTextThree;

  /// No description provided for @onboardingMentalHealthIntroTextThreeAccent.
  ///
  /// In en, this message translates to:
  /// **'within one hour'**
  String get onboardingMentalHealthIntroTextThreeAccent;

  /// No description provided for @onboardingMentalHealthIntroTextFour.
  ///
  /// In en, this message translates to:
  /// **'If you do take more than an hour, you will need to start this section over again.'**
  String get onboardingMentalHealthIntroTextFour;

  /// No description provided for @onboardingMentalHealthIntroTextFive.
  ///
  /// In en, this message translates to:
  /// **'You will receive your results immediately after the questions.'**
  String get onboardingMentalHealthIntroTextFive;

  /// No description provided for @onboardingMentalHealthIntroTextSix.
  ///
  /// In en, this message translates to:
  /// **'Please note that these test results are not a diagnosis. A diagnosis can only be made by a doctor or psychologist.'**
  String get onboardingMentalHealthIntroTextSix;

  /// Information about the mental health section and how to get more details.
  ///
  /// In en, this message translates to:
  /// **'In this section you will be asked questions from scientifically validated questionnaires, carefully chosen by our clinical psychologist. \n\nIf you would like to get more information on the questionnaires that are used, please contact {appName}.'**
  String onboardingMentalHealthMoreInfo(String appName);

  /// No description provided for @onboardingMentalHealthMoreInfoBold1.
  ///
  /// In en, this message translates to:
  /// **'scientifically validated questionnaires'**
  String get onboardingMentalHealthMoreInfoBold1;

  /// No description provided for @onboardingMentalHealthMoreInfoBold2.
  ///
  /// In en, this message translates to:
  /// **'our clinical psychologist'**
  String get onboardingMentalHealthMoreInfoBold2;

  /// No description provided for @onboardingWho8Question.
  ///
  /// In en, this message translates to:
  /// **'Please indicate for each of the given statements which is closest to how you have been feeling over the last two weeks.'**
  String get onboardingWho8Question;

  /// No description provided for @onboardingLastTwoWeeks.
  ///
  /// In en, this message translates to:
  /// **'last two weeks'**
  String get onboardingLastTwoWeeks;

  /// No description provided for @onboardingPastFourWeeks.
  ///
  /// In en, this message translates to:
  /// **'past four weeks'**
  String get onboardingPastFourWeeks;

  /// No description provided for @onboardingPhq15Question.
  ///
  /// In en, this message translates to:
  /// **'During the past four weeks, how much have you been bothered by any of the following problems?'**
  String get onboardingPhq15Question;

  /// No description provided for @onboardingPhq8Question.
  ///
  /// In en, this message translates to:
  /// **'Over the last two weeks, how often have you been bothered by any of the following problems?'**
  String get onboardingPhq8Question;

  /// No description provided for @onboardingStartAgain.
  ///
  /// In en, this message translates to:
  /// **'Start again'**
  String get onboardingStartAgain;

  /// No description provided for @onboardingWho5ResultTestMinimal.
  ///
  /// In en, this message translates to:
  /// **'Regarding your general well-being, you have indicated that in the last two weeks your well-being has been severely limited, and you have felt unwell most of the time. If you feel unwell for a longer period, we recommend that you consult a psychologist or your doctor to check these symptoms. You can find psychologists here:'**
  String get onboardingWho5ResultTestMinimal;

  /// No description provided for @onboardingWho5ResultTestHigh.
  ///
  /// In en, this message translates to:
  /// **'In terms of your general well-being, you indicated that you have generally felt balanced, joyful, and relaxed over the past two weeks. This result indicates a good state of well-being.'**
  String get onboardingWho5ResultTestHigh;

  /// No description provided for @onboardingPhq15ResultMinimal.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you have had no or few physical ailments in the last four weeks. That’s great.'**
  String get onboardingPhq15ResultMinimal;

  /// No description provided for @onboardingPhq15ResultMild.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you have been bothered by a few physical problems in the last four weeks. Mild physical problems can also be a sign of stress. It could be helpful to reduce stress. \nTo clarify whether these ailments are related to stress, please consult your doctor.'**
  String get onboardingPhq15ResultMild;

  /// No description provided for @onboardingPhq15ResultMedium.
  ///
  /// In en, this message translates to:
  /// **'You have stated that a number of physical ailments have bothered you over the past four weeks. A consultation with your doctor is recommended to check whether these are temporary. The symptoms can be a reaction of your body to stress or emotional issues.'**
  String get onboardingPhq15ResultMedium;

  /// No description provided for @onboardingPhq15ResultHigh.
  ///
  /// In en, this message translates to:
  /// **'You have stated that many physical ailments have bothered you in the last four weeks. Please consult your doctor to check these symptoms. These symptoms may have a medical cause or indicate a somatization disorder. \n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:'**
  String get onboardingPhq15ResultHigh;

  /// No description provided for @onboardingGad7ResultMinimal.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you were at ease most of the time in the last two weeks. Your everyday life is not affected by anxiety. Great, keep it up.'**
  String get onboardingGad7ResultMinimal;

  /// No description provided for @onboardingGad7ResultMild.
  ///
  /// In en, this message translates to:
  /// **'You have stated that in the last two weeks you have had problems to relax from time to time. You may also have felt nervous, anxious, or on edge. Don’t be concerned about it. These may be temporary symptoms. Give yourself a break to relax more often. \nBut if the symptoms worsen, we recommend consulting your doctor or a psychologist.'**
  String get onboardingGad7ResultMild;

  /// No description provided for @onboardingGad7ResultMedium.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you have felt nervous or anxious more than half the time in the last two weeks. You may also have not been able to stop or control worrying. This can be a burden for you in your daily life.\n\nIf the symptoms persist or worsen, we recommend consulting your doctor or a psychologist.'**
  String get onboardingGad7ResultMedium;

  /// No description provided for @onboardingGad7ResultHigh.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you have felt nervous or anxious nearly every day in the last two weeks. You may also have not been able to stop or control worrying. These symptoms could indicate an anxiety disorder.\n\nIn order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:'**
  String get onboardingGad7ResultHigh;

  /// No description provided for @onboardingPhq8ResultMinimal.
  ///
  /// In en, this message translates to:
  /// **'You have stated that your mood was not affected most days in the last two weeks. Great, keep it up and look out for all the positive things you will come across on your journey.'**
  String get onboardingPhq8ResultMinimal;

  /// No description provided for @onboardingPhq8ResultMild.
  ///
  /// In en, this message translates to:
  /// **'You have stated that in the last two weeksYou have stated that in the last two weeks you have felt down from time to time. You may also have had feelings of hopelessness or a lack of energy. Throughout the LeanOnMe program, you will learn about the connection between thoughts and feelings and what you can do to improve your mental health.\nIf the symptoms worsen, we recommend a consultation with a psychologist or your doctor.'**
  String get onboardingPhq8ResultMild;

  /// No description provided for @onboardingPhq8ResultMedium.
  ///
  /// In en, this message translates to:
  /// **'You have stated that you have been depressed more than half the time in the last two weeks. You may also have had feelings of hopelessness or have felt down. Throughout the LeanOnMe program, you will learn about the connection between thoughts and feelings and what you can do to improve your mental health.\nIf the symptoms persist or worsen, we recommend a consultation with a psychologist or your doctor.'**
  String get onboardingPhq8ResultMedium;

  /// No description provided for @onboardingPhq8ResultHigh.
  ///
  /// In en, this message translates to:
  /// **'You have stated that your mood has often been significantly affected in the last two weeks. You have indicated that you have felt depressed and have often suffered from listlessness or dejection. The symptoms indicate current psychological distress with emotional impairment. These may be indications of a temporary depressive episode. \n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor or a psychologist. You can find addresses here:'**
  String get onboardingPhq8ResultHigh;

  /// No description provided for @onboardingPhq8ResultHighest.
  ///
  /// In en, this message translates to:
  /// **'You have stated that your mood has been significantly affected almost every day for the past two weeks. You have indicated that you have felt depressed and have often or constantly suffered from listlessness or dejection. These symptoms currently indicate a high level of psychological distress with emotional impairment and could be an indication of depression.\n\nThis program is not a substitute for mental health diagnosis or psychological treatment. In order to have a closer look at the symptoms and to treat them, if necessary, we recommend consulting your doctor and a clarification by a psychologist. You can find addresses here:'**
  String get onboardingPhq8ResultHighest;

  /// No description provided for @onboardingPhq8FinalResultHigh1.
  ///
  /// In en, this message translates to:
  /// **'The questionnaire results indicate that you are currently experiencing notable mental distress.'**
  String get onboardingPhq8FinalResultHigh1;

  /// No description provided for @onboardingPhq8FinalResultHigh2.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, the program is not suitable for people who are currently experiencing considerable mental distress, as participation in this program could place additional stress on you.'**
  String get onboardingPhq8FinalResultHigh2;

  /// No description provided for @onboardingPhq8FinalResultHigh3.
  ///
  /// In en, this message translates to:
  /// **'In order to have a closer look at these symptoms and to treat them, we recommend consulting a psychologist. You can find addresses here:'**
  String get onboardingPhq8FinalResultHigh3;

  /// No description provided for @onboardingPhq8FinalResultHigh4.
  ///
  /// In en, this message translates to:
  /// **'We invite you to repeat the test when these symptoms have subsided so that you can focus all your energy on your weight-loss journey.'**
  String get onboardingPhq8FinalResultHigh4;

  /// No description provided for @onboardingIfYouHaveSuicidalThoughts.
  ///
  /// In en, this message translates to:
  /// **'If you are in an acute crisis or having suicidal thoughts, please contact one of the 24-hour toll-free emergency numbers immediately:'**
  String get onboardingIfYouHaveSuicidalThoughts;

  /// No description provided for @onboardingPersonalProgram.
  ///
  /// In en, this message translates to:
  /// **'Based on your information, we tailor the program to you personally.'**
  String get onboardingPersonalProgram;

  /// No description provided for @onboardingSupportMessage.
  ///
  /// In en, this message translates to:
  /// **'We would like to support you on your journey in the best possible way and tailor the program to you personally.'**
  String get onboardingSupportMessage;

  /// No description provided for @onboardingFeelLimited1.
  ///
  /// In en, this message translates to:
  /// **'It turned out that you currently feel limited by anxiety and physical symptoms. We recommend you talk to a primary care physician or psychologist.'**
  String get onboardingFeelLimited1;

  /// No description provided for @onboardingFeelLimited2.
  ///
  /// In en, this message translates to:
  /// **'It turned out that you currently feel limited by physical symptoms. We recommend you talk to a primary care physician or psychologist.'**
  String get onboardingFeelLimited2;

  /// No description provided for @onboardingFeelLimited3.
  ///
  /// In en, this message translates to:
  /// **'It turned out that you currently feel limited by anxiety symptoms. We recommend you talk to a primary care physician or psychologist.'**
  String get onboardingFeelLimited3;

  /// No description provided for @onboardingFeelLimited4.
  ///
  /// In en, this message translates to:
  /// **'It turned out that you are troubled in several areas at the moment.'**
  String get onboardingFeelLimited4;

  /// No description provided for @onboardingNotATherapy.
  ///
  /// In en, this message translates to:
  /// **'Please keep in mind that LeanOnMe is not a therapy.'**
  String get onboardingNotATherapy;

  /// No description provided for @onboardingLearnManyThings.
  ///
  /// In en, this message translates to:
  /// **'However, you will learn many things that will support you in your mental and physical well-being.'**
  String get onboardingLearnManyThings;

  /// No description provided for @onboardingUnlockAllSections.
  ///
  /// In en, this message translates to:
  /// **'You will have access to all sections of the program.'**
  String get onboardingUnlockAllSections;

  /// No description provided for @onboardingAwailableAreas.
  ///
  /// In en, this message translates to:
  /// **'The following areas will be available to you as you progress through the program:'**
  String get onboardingAwailableAreas;

  /// No description provided for @onboardingUnlockBuddyMessage.
  ///
  /// In en, this message translates to:
  /// **'Find a Buddy and get into a Support Group'**
  String get onboardingUnlockBuddyMessage;

  /// No description provided for @onboardingWeWillGuideYou.
  ///
  /// In en, this message translates to:
  /// **'We will guide you step by step in your weight-loss journey.\n\nHave fun with exploring!'**
  String get onboardingWeWillGuideYou;

  /// No description provided for @onboardingPhq8Fail.
  ///
  /// In en, this message translates to:
  /// **'We are sorry! Unfortunately, your enrollment is not possible now.'**
  String get onboardingPhq8Fail;

  /// No description provided for @onboardingGeneralWellBeingSummary.
  ///
  /// In en, this message translates to:
  /// **'General well-being summary'**
  String get onboardingGeneralWellBeingSummary;

  /// No description provided for @onboardingBodyAndMindBalanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Body and mind balance summary'**
  String get onboardingBodyAndMindBalanceSummary;

  /// No description provided for @onboardingStateOfMindSummary.
  ///
  /// In en, this message translates to:
  /// **'State of mind summary'**
  String get onboardingStateOfMindSummary;

  /// No description provided for @onboardingCheckCompleted.
  ///
  /// In en, this message translates to:
  /// **'Check completed!'**
  String get onboardingCheckCompleted;

  /// No description provided for @onboardingYouExceededTimeMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, but you exceeded the time limit of one hour'**
  String get onboardingYouExceededTimeMessage;

  /// No description provided for @onboardingNoWorriesYouCanDoItLater.
  ///
  /// In en, this message translates to:
  /// **'But don’t worry, you can start over'**
  String get onboardingNoWorriesYouCanDoItLater;

  /// No description provided for @onboardingMentalResultSubText1.
  ///
  /// In en, this message translates to:
  /// **'You’ve completed the first part. Keep going. You’re doing great!'**
  String get onboardingMentalResultSubText1;

  /// No description provided for @onboardingMentalResultSubText2.
  ///
  /// In en, this message translates to:
  /// **'You\'re breezing through these questions. Nicely done! You’ve reached the halfway point!'**
  String get onboardingMentalResultSubText2;

  /// No description provided for @onboardingMentalResultSubText3.
  ///
  /// In en, this message translates to:
  /// **'Three down, one to go! Just a few last questions!'**
  String get onboardingMentalResultSubText3;

  /// No description provided for @avatarAvatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatarAvatar;

  /// No description provided for @avatarSelectProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Select your profile picture'**
  String get avatarSelectProfilePicture;

  /// No description provided for @avatarMoveToResize.
  ///
  /// In en, this message translates to:
  /// **'move to resize'**
  String get avatarMoveToResize;

  /// No description provided for @avatarChooseYourAvatar.
  ///
  /// In en, this message translates to:
  /// **'Choose your avatar'**
  String get avatarChooseYourAvatar;

  /// No description provided for @avatarAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get avatarAddPhoto;

  /// No description provided for @avatarSizeErrorMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops! It looks like the picture you’re trying to upload is over the 10 MB size limit.'**
  String get avatarSizeErrorMessageTitle;

  /// No description provided for @avatarSizeErrorMessageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose a smaller file and try again.'**
  String get avatarSizeErrorMessageSubtitle;

  /// No description provided for @avatarGoToAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to app settings'**
  String get avatarGoToAppSettings;

  /// No description provided for @avatarGaleryPermissionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Please allow access to your gallery'**
  String get avatarGaleryPermissionsMessage;

  /// No description provided for @avatarGaleryPermissionsMessageAndroid.
  ///
  /// In en, this message translates to:
  /// **'Please allow access to your media gallery and camera'**
  String get avatarGaleryPermissionsMessageAndroid;

  /// No description provided for @avatarCropper.
  ///
  /// In en, this message translates to:
  /// **'Cropper'**
  String get avatarCropper;

  /// No description provided for @smartGoalsMyGoals.
  ///
  /// In en, this message translates to:
  /// **'My goals'**
  String get smartGoalsMyGoals;

  /// No description provided for @smartGoalsNoGoalsSelected.
  ///
  /// In en, this message translates to:
  /// **'No goals selected yet'**
  String get smartGoalsNoGoalsSelected;

  /// No description provided for @smartGoalsChooseGoalsForUpcomingDays.
  ///
  /// In en, this message translates to:
  /// **'Choose goals for upcoming 7 days'**
  String get smartGoalsChooseGoalsForUpcomingDays;

  /// No description provided for @smartGoalsUpcomingGoals.
  ///
  /// In en, this message translates to:
  /// **'Upcoming goals'**
  String get smartGoalsUpcomingGoals;

  /// No description provided for @smartGoalsUpcomingGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Let’s set goals'**
  String get smartGoalsUpcomingGoalsTitle;

  /// No description provided for @smartGoalsUpcomingGoalsDescription.
  ///
  /// In en, this message translates to:
  /// **'You can choose up to 2 goals for the upcoming 7 days.'**
  String get smartGoalsUpcomingGoalsDescription;

  /// No description provided for @smartGoalsCancelGoal.
  ///
  /// In en, this message translates to:
  /// **'Cancel goal'**
  String get smartGoalsCancelGoal;

  /// No description provided for @smartGoalsCancelGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel your goal?'**
  String get smartGoalsCancelGoalTitle;

  /// No description provided for @smartGoalsCancelGoalSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Please tell us the reason why you want to cancel this goal.'**
  String get smartGoalsCancelGoalSubTitle;

  /// No description provided for @smartGoalsSetGoal.
  ///
  /// In en, this message translates to:
  /// **'Set goal'**
  String get smartGoalsSetGoal;

  /// No description provided for @smartGoalsSelectGoalsCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Goal Category'**
  String get smartGoalsSelectGoalsCategoryTitle;

  /// No description provided for @smartGoalsNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get smartGoalsNewLabel;

  /// No description provided for @smartGoalsSelectGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Goal'**
  String get smartGoalsSelectGoalsTitle;

  /// No description provided for @smartGoalsSelectGoalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have 7 days to complete your goal with one countable log per day.'**
  String get smartGoalsSelectGoalsSubtitle;

  /// No description provided for @smartGoalsSaveWeeklyGoalsSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Goals were added to your weekly list'**
  String get smartGoalsSaveWeeklyGoalsSuccessMessage;

  /// No description provided for @smartGoalsStatisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your favourite goal categories'**
  String get smartGoalsStatisticsTitle;

  /// No description provided for @smartGoalsAccomplishedInTotal.
  ///
  /// In en, this message translates to:
  /// **'goals accomplished in total.'**
  String get smartGoalsAccomplishedInTotal;

  /// No description provided for @smartGoalsAccomplishedEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Once you start completing goals your favourite goal categories will appear here.'**
  String get smartGoalsAccomplishedEmptyMessage;

  /// No description provided for @smartGoalsAccomplished.
  ///
  /// In en, this message translates to:
  /// **'goals accomplished'**
  String get smartGoalsAccomplished;

  /// The text shown for the goal of logging days in a week
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Goal: {count} logged days in a week} =1{Goal: {count} logged day in a week} other{Goal: {count} logged days in a week}}'**
  String smartGoalsGoalLogDays(int count);

  /// The text shown for the number of logged days
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Logged days: {count}} =1{Logged day: {count}} other{Logged days: {count}}}'**
  String smartGoalsGoalLogged(int count);

  /// The text shown for the total number of completions/logs
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Total logs: {count}} =1{Total log: {count}} other{Total logs: {count}}}'**
  String smartGoalsGoalTotalCompletions(int count);

  /// No description provided for @smartGoalsGoalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed: Yes'**
  String get smartGoalsGoalCompleted;

  /// No description provided for @smartGoalsGoalNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed: No'**
  String get smartGoalsGoalNotCompleted;

  /// No description provided for @smartGoalsHowHardWasTheGoal.
  ///
  /// In en, this message translates to:
  /// **'How hard was this goal for you?'**
  String get smartGoalsHowHardWasTheGoal;

  /// No description provided for @smartGoalsWantToTryInFuture.
  ///
  /// In en, this message translates to:
  /// **'Want to try this again in the future?'**
  String get smartGoalsWantToTryInFuture;

  /// No description provided for @smartGoalsGoalReview.
  ///
  /// In en, this message translates to:
  /// **'Goal review'**
  String get smartGoalsGoalReview;

  /// Text indicating how many days are left to complete the goal
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No days left to complete} =1{1 day left to complete} other{{count} days left to complete}}'**
  String smartGoalsWeeklyDaysLeft(int count);

  /// No description provided for @smartGoalsWeeklyDayLeft.
  ///
  /// In en, this message translates to:
  /// **'1 day to complete'**
  String get smartGoalsWeeklyDayLeft;

  /// No description provided for @smartGoalsWeeklyDaysReview.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get smartGoalsWeeklyDaysReview;

  /// Text indicating how many times something has occurred
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No times} =1{1 time} other{{count} times}}'**
  String smartGoalsWeeklyTimes(int count);

  /// No description provided for @smartGoalsReasonGoalNotLike.
  ///
  /// In en, this message translates to:
  /// **'I don’t like it.'**
  String get smartGoalsReasonGoalNotLike;

  /// No description provided for @smartGoalsReasonGoalChallenging.
  ///
  /// In en, this message translates to:
  /// **'The goal is too challenging.'**
  String get smartGoalsReasonGoalChallenging;

  /// No description provided for @smartGoalsReasonGoalMissing.
  ///
  /// In en, this message translates to:
  /// **'I am missing something to complete it.'**
  String get smartGoalsReasonGoalMissing;

  /// No description provided for @smartGoalsReasonGoalHabit.
  ///
  /// In en, this message translates to:
  /// **'The goal is already a habit.'**
  String get smartGoalsReasonGoalHabit;

  /// No description provided for @smartGoalsReasonGoalSpecific.
  ///
  /// In en, this message translates to:
  /// **'No specific reason.'**
  String get smartGoalsReasonGoalSpecific;

  /// No description provided for @nutritionProteinDegree.
  ///
  /// In en, this message translates to:
  /// **'Protein\n degree'**
  String get nutritionProteinDegree;

  /// No description provided for @nutritionFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber\n'**
  String get nutritionFiber;

  /// No description provided for @nutritionCalorieDensity.
  ///
  /// In en, this message translates to:
  /// **'Calorie\n density'**
  String get nutritionCalorieDensity;

  /// No description provided for @buddyTitle.
  ///
  /// In en, this message translates to:
  /// **'Buddy'**
  String get buddyTitle;

  /// No description provided for @buddyBuddy.
  ///
  /// In en, this message translates to:
  /// **'buddy'**
  String get buddyBuddy;

  /// No description provided for @buddyUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Buddy unlocked'**
  String get buddyUnlocked;

  /// No description provided for @buddyUnlockedBody.
  ///
  /// In en, this message translates to:
  /// **'You can start to find a Buddy in the profile section.'**
  String get buddyUnlockedBody;

  /// No description provided for @buddyGoToPreferences.
  ///
  /// In en, this message translates to:
  /// **'Go to Buddy preferences'**
  String get buddyGoToPreferences;

  /// No description provided for @buddyIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Find your Buddy'**
  String get buddyIntroTitle;

  /// No description provided for @buddyDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'How to find a Buddy?'**
  String get buddyDescriptionTitle;

  /// No description provided for @buddyIntroBody.
  ///
  /// In en, this message translates to:
  /// **'With a Buddy at your side not only are you more likely to stick to your goals, but also have someone to share your journey and make it more enjoyable. \n\nTo stay on track, a buddy is strongly recommended. This is especially the case if you also want to join a support group. Make your social network as strong as possible.'**
  String get buddyIntroBody;

  /// No description provided for @buddyIntroYesBtn.
  ///
  /// In en, this message translates to:
  /// **'Yes, I’d like to have buddy support'**
  String get buddyIntroYesBtn;

  /// No description provided for @buddyIntroNoBtn.
  ///
  /// In en, this message translates to:
  /// **'I may do this later'**
  String get buddyIntroNoBtn;

  /// No description provided for @buddyDescriptionContent.
  ///
  /// In en, this message translates to:
  /// **'It’s great that you want to share your journey! \nBut how do you actually find a Buddy? \n\nConsider testing the waters by talking to people about being a Buddy in your immediate social circle. \n\nHere are a few things that you can mention when talking to a friend that is interested: \n• the role a Buddy has in your journey\n• what you would need from a Buddy and discuss boundaries for your potential Buddy relationship\n• as a Buddy, they would gain access to the Buddy Network to help them learn about the best way to provide support\n\nThe previous lesson “Finding a Buddy” can also provide some insight on how to go about this. \n\nOnce you have found a loved one that is open to joining you, go to your profile and fill out the Buddy preferences. Once completed, your friend will receive an invitation to join the Buddy Network. \n\n'**
  String get buddyDescriptionContent;

  /// No description provided for @buddyPreferences.
  ///
  /// In en, this message translates to:
  /// **'Buddy preferences'**
  String get buddyPreferences;

  /// No description provided for @buddyNoPreferencesState.
  ///
  /// In en, this message translates to:
  /// **'Would you like to add a Buddy?'**
  String get buddyNoPreferencesState;

  /// No description provided for @buddyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Buddy preferences\ncompleted'**
  String get buddyCompleted;

  /// No description provided for @buddyCompletedContent.
  ///
  /// In en, this message translates to:
  /// **'Your Buddy will receive an invite shortly. We will notify you once your Buddy has responded.'**
  String get buddyCompletedContent;

  /// No description provided for @buddyLiveTogetherTitle.
  ///
  /// In en, this message translates to:
  /// **'Do you live together with your Buddy?'**
  String get buddyLiveTogetherTitle;

  /// No description provided for @buddyRelationTitle.
  ///
  /// In en, this message translates to:
  /// **'How is your Buddy related to you?'**
  String get buddyRelationTitle;

  /// No description provided for @buddyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'What is your Buddy’s email address?'**
  String get buddyEmailTitle;

  /// No description provided for @buddyEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'We will invite your Buddy to share in your journey via this email address.'**
  String get buddyEmailLabel;

  /// No description provided for @buddyEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Buddy email address'**
  String get buddyEmailHint;

  /// No description provided for @buddyPartner.
  ///
  /// In en, this message translates to:
  /// **'Husband or wife'**
  String get buddyPartner;

  /// No description provided for @buddyChild.
  ///
  /// In en, this message translates to:
  /// **'child'**
  String get buddyChild;

  /// No description provided for @buddyParent.
  ///
  /// In en, this message translates to:
  /// **'parent'**
  String get buddyParent;

  /// No description provided for @buddyFamily.
  ///
  /// In en, this message translates to:
  /// **'family'**
  String get buddyFamily;

  /// No description provided for @buddyFriend.
  ///
  /// In en, this message translates to:
  /// **'friend'**
  String get buddyFriend;

  /// No description provided for @buddyPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent an invite to your Buddy'**
  String get buddyPendingTitle;

  /// Subtitle showing the invite details and notification message
  ///
  /// In en, this message translates to:
  /// **'We sent this invite on\n{date} at {time}.\n\nWe will notify you once your Buddy has responded.'**
  String buddyPendingSubTitle(String date, String time);

  /// No description provided for @buddyRejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Buddy did not accept the invite'**
  String get buddyRejectTitle;

  /// No description provided for @buddyRejectSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, your friend cannot join you on your journey. There can be many different reasons why they couldn’t join you, but don’t let this discourage you! Try to find another Buddy.\n\nPlease talk to friends and loved ones about whether they are open to being your Buddy before you send the next invite. \n\nAre you having trouble finding a Buddy? The article “Finding a Buddy” can provide some insight on how to approach this topic with others.\n\nYou can easily invite another person to share in your journey.'**
  String get buddyRejectSubTitle;

  /// No description provided for @buddyNotAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Buddy is no longer able to support you'**
  String get buddyNotAvailableTitle;

  /// No description provided for @buddyNotAvailableSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, your current Buddy cannot be there to support you in the way that a Buddy does. \n\nNo need to worry, there is another Buddy out there. Talk to your close friends and ask around whether one of them would like to join you.\n\nThe education lesson “Finding a Buddy” can also help you to find a new Buddy. \n\nYou can easily invite another person to share in your journey.'**
  String get buddyNotAvailableSubTitle;

  /// No description provided for @buddyResendInvitation.
  ///
  /// In en, this message translates to:
  /// **'Resend invitation'**
  String get buddyResendInvitation;

  /// No description provided for @buddyInviteAnotherBuddy.
  ///
  /// In en, this message translates to:
  /// **'Invite another buddy'**
  String get buddyInviteAnotherBuddy;

  /// No description provided for @buddyFindAnotherBuddyContent.
  ///
  /// In en, this message translates to:
  /// **'Please note: if you do want a new Buddy. your current Buddy will be notified that you have made this request.'**
  String get buddyFindAnotherBuddyContent;

  /// No description provided for @buddyFindAnotherBuddy.
  ///
  /// In en, this message translates to:
  /// **'Yes, I want another buddy'**
  String get buddyFindAnotherBuddy;

  /// No description provided for @buddyNotNeedAnotherBuddy.
  ///
  /// In en, this message translates to:
  /// **'No, I would like to keep this buddy'**
  String get buddyNotNeedAnotherBuddy;

  /// No description provided for @buddyEmail.
  ///
  /// In en, this message translates to:
  /// **'Buddy email'**
  String get buddyEmail;

  /// No description provided for @buddyUserName.
  ///
  /// In en, this message translates to:
  /// **'Buddy username'**
  String get buddyUserName;

  /// No description provided for @buddySince.
  ///
  /// In en, this message translates to:
  /// **'Buddy since'**
  String get buddySince;

  /// No description provided for @buddyRemoveInvite.
  ///
  /// In en, this message translates to:
  /// **'Remove invite'**
  String get buddyRemoveInvite;

  /// No description provided for @buddyRemoveBuddy.
  ///
  /// In en, this message translates to:
  /// **'Remove buddy'**
  String get buddyRemoveBuddy;

  /// No description provided for @buddyInviteBuddy.
  ///
  /// In en, this message translates to:
  /// **'Invite buddy'**
  String get buddyInviteBuddy;

  /// This is name of buddy.
  ///
  /// In en, this message translates to:
  /// **'Are you sure that you want to remove {name} as your current Buddy?'**
  String buddyFindAnotherBuddyLabel(String name);

  /// No description provided for @buddyFindAnotherBuddyContentOne.
  ///
  /// In en, this message translates to:
  /// **'We believe in our Buddy program and recommend keeping your buddy or inviting someone else who can offer you better encouragement.'**
  String get buddyFindAnotherBuddyContentOne;

  /// No description provided for @buddyFindAnotherBuddyContentTwo.
  ///
  /// In en, this message translates to:
  /// **'Please note: if you do want a new Buddy. your current Buddy will be notified that you have made this request.'**
  String get buddyFindAnotherBuddyContentTwo;

  /// No description provided for @linksTermsAndConditionsUrl.
  ///
  /// In en, this message translates to:
  /// **'https://lean-on.me/terms-and-conditions'**
  String get linksTermsAndConditionsUrl;

  /// No description provided for @linksPrivacyPolicyUrl.
  ///
  /// In en, this message translates to:
  /// **'https://lean-on.me/privacy-policy'**
  String get linksPrivacyPolicyUrl;

  /// No description provided for @linksPsychologistConsulting.
  ///
  /// In en, this message translates to:
  /// **'https://locator.apa.org/'**
  String get linksPsychologistConsulting;

  /// No description provided for @linksInstructionsUrl.
  ///
  /// In en, this message translates to:
  /// **'https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf'**
  String get linksInstructionsUrl;

  /// No description provided for @riverOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'The River Overview'**
  String get riverOverviewTitle;

  /// No description provided for @riverGuidancePracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice makes progression.'**
  String get riverGuidancePracticeTitle;

  /// No description provided for @riverGuidancePracticeDescription.
  ///
  /// In en, this message translates to:
  /// **'The calendar will be your daily entry point to practice what you’ve learned.'**
  String get riverGuidancePracticeDescription;

  /// No description provided for @riverGuidanceProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile and account settings.'**
  String get riverGuidanceProfileTitle;

  /// No description provided for @riverGuidanceProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'In the profile, you can customize your account settings, change personal preferences and access past assignments and features.'**
  String get riverGuidanceProfileDescription;

  /// No description provided for @riverGuidanceCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulation, you finished the Beginning.'**
  String get riverGuidanceCompletedTitle;

  /// No description provided for @riverGuidanceCompletedDescription.
  ///
  /// In en, this message translates to:
  /// **'You can now move on to the first Practice session: What’s your why?.'**
  String get riverGuidanceCompletedDescription;

  /// This is complete module message.
  ///
  /// In en, this message translates to:
  /// **'Congratulation, you completed the module: \"{module}\"'**
  String riverModuleCompletedTitle(String module);

  /// This is next module name.
  ///
  /// In en, this message translates to:
  /// **'No rush, you can stay in this module and repeat the practices as often as you prefer. When you feel comfortable, you can move to the next module: \"{nextModule}\".\nGreat job.'**
  String riverModuleCompletedDescription(String nextModule);

  /// No description provided for @riverLastModuleCompletedDescription.
  ///
  /// In en, this message translates to:
  /// **'Take your time to revisit the previous modules and reinforce the practices whenever you need.\nYou\'ve done an amazing job reaching this point! Stay tuned, more exciting content is coming soon!'**
  String get riverLastModuleCompletedDescription;

  /// No description provided for @riverGuidanceStartRiverTitle.
  ///
  /// In en, this message translates to:
  /// **'Great!'**
  String get riverGuidanceStartRiverTitle;

  /// No description provided for @riverGuidanceStartRiverDescription.
  ///
  /// In en, this message translates to:
  /// **'Now tap the other icons to unlock features and explore.'**
  String get riverGuidanceStartRiverDescription;

  /// No description provided for @riverModuleGraduationCompletedItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Great job. You have completed the lessons in this pool.'**
  String get riverModuleGraduationCompletedItemsTitle;

  /// No description provided for @riverModuleGraduationCompletedTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your module is fully colored-in, meaning you  first read the Reflection over 7 days ago.'**
  String get riverModuleGraduationCompletedTimeTitle;

  /// No description provided for @riverModuleGraduationCompletedItemsMessage.
  ///
  /// In en, this message translates to:
  /// **'You are one step closer to finishing this section. But before you can graduate, we encourage you to practice and reflect on what you have learned in this Pool.\n\nOnce the 7 day timer has filled this section with color, you can move on to the next pool.'**
  String get riverModuleGraduationCompletedItemsMessage;

  /// No description provided for @riverModuleGraduationCompletedTimeMessage.
  ///
  /// In en, this message translates to:
  /// **'No rush: Every module takes the time it takes. Keep reflecting! When you’ve completed all the necessary steps, we’ll ask you if you’re ready to move on. Need some help? Reach out by emailing support@lean-on.me, and one of our specialists will be glad to assist.'**
  String get riverModuleGraduationCompletedTimeMessage;

  /// No description provided for @subscriptionTrialTitle.
  ///
  /// In en, this message translates to:
  /// **'First 2 weeks for free!'**
  String get subscriptionTrialTitle;

  /// No description provided for @subscriptionTrialLabel.
  ///
  /// In en, this message translates to:
  /// **'After your trial period you are enrolled and \nyou can cancel on a monthly basis.'**
  String get subscriptionTrialLabel;

  /// No description provided for @subscriptionTrialExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Your trial has expired'**
  String get subscriptionTrialExpiredTitle;

  /// No description provided for @subscriptionTrialExpiredLabel1.
  ///
  /// In en, this message translates to:
  /// **'We hope you enjoyed our program.'**
  String get subscriptionTrialExpiredLabel1;

  /// No description provided for @subscriptionTrialExpiredLabel2.
  ///
  /// In en, this message translates to:
  /// **'If you want to continue,\nrefresh your subscription here:'**
  String get subscriptionTrialExpiredLabel2;

  /// No description provided for @subscriptionEndedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your subscription \nhas ended'**
  String get subscriptionEndedTitle;

  /// No description provided for @subscriptionEmptyToRestore.
  ///
  /// In en, this message translates to:
  /// **'Sorry, the store didn\'t return a subscription for us to restore. If you think this is an error, please send proof of subscription to support@lean-on.me.'**
  String get subscriptionEmptyToRestore;

  /// No description provided for @subscriptionEndedLabel1.
  ///
  /// In en, this message translates to:
  /// **'We hope you enjoyed our program.'**
  String get subscriptionEndedLabel1;

  /// No description provided for @subscriptionEndedLabel2.
  ///
  /// In en, this message translates to:
  /// **'If you want to continue,\nrefresh your subscription here:'**
  String get subscriptionEndedLabel2;

  /// No description provided for @subscriptionCancelledTitle.
  ///
  /// In en, this message translates to:
  /// **'Your subscription \nwas cancelled'**
  String get subscriptionCancelledTitle;

  /// No description provided for @subscriptionCancelledLabel1.
  ///
  /// In en, this message translates to:
  /// **'We hope you enjoyed our program.'**
  String get subscriptionCancelledLabel1;

  /// No description provided for @subscriptionCancelledLabel2.
  ///
  /// In en, this message translates to:
  /// **'If you want to continue,\nrefresh your subscription here:'**
  String get subscriptionCancelledLabel2;

  /// No description provided for @subscriptionRenewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your subscription \ncould not be renewed'**
  String get subscriptionRenewedTitle;

  /// No description provided for @subscriptionRenewedLabel.
  ///
  /// In en, this message translates to:
  /// **'We want to let you know that your\nsubscription could not be automatically\nrenewed. \n\nYou will get a couple of days to look into this.\nDuring this time you can still use the app.'**
  String get subscriptionRenewedLabel;

  /// No description provided for @subscriptionRestoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchase'**
  String get subscriptionRestoreLabel;

  /// No description provided for @subscriptionTermsLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get subscriptionTermsLabel;

  /// No description provided for @subscriptionPrivacyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get subscriptionPrivacyLabel;

  /// No description provided for @subscriptionAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get subscriptionAnnual;

  /// No description provided for @subscriptionMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionMonthly;

  /// No description provided for @subscriptionSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscriptionSubscribe;

  /// No description provided for @subscriptionRedeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get subscriptionRedeem;

  /// A formatted string showing a description, which could include a price or other details.
  ///
  /// In en, this message translates to:
  /// **'{description}'**
  String subscriptionSubTitlePrice(String description);

  /// A formatted string showing a title followed by the price with currency
  ///
  /// In en, this message translates to:
  /// **'{title} {priceWithCurrency}'**
  String subscriptionTitlePrice(String title, String priceWithCurrency);

  /// No description provided for @subscriptionSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscriptionSubscription;

  /// No description provided for @subscriptionManageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get subscriptionManageSubscription;

  /// No description provided for @subscriptionType.
  ///
  /// In en, this message translates to:
  /// **'Subscription type'**
  String get subscriptionType;

  /// No description provided for @subscriptionSubscriptionVia.
  ///
  /// In en, this message translates to:
  /// **'Subscription via'**
  String get subscriptionSubscriptionVia;

  /// No description provided for @subscriptionMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get subscriptionMemberSince;

  /// No description provided for @subscriptionAutomaticRenewalOn.
  ///
  /// In en, this message translates to:
  /// **'Automatic renewal on'**
  String get subscriptionAutomaticRenewalOn;

  /// No description provided for @subscriptionServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service is unavailable,\nplease try later.'**
  String get subscriptionServiceUnavailable;

  /// No description provided for @subscriptionOtherPurchaseVendor.
  ///
  /// In en, this message translates to:
  /// **'Sorry, your subscription seems to be purchased from a different store.'**
  String get subscriptionOtherPurchaseVendor;

  /// No description provided for @subscriptionAppStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get subscriptionAppStore;

  /// No description provided for @subscriptionGoogleMarket.
  ///
  /// In en, this message translates to:
  /// **'Play Market'**
  String get subscriptionGoogleMarket;

  /// No description provided for @subscriptionCancelAccountSubscription.
  ///
  /// In en, this message translates to:
  /// **'Before you delete your account with LeanOnMe, please take a moment to cancel your subscription. This will prevent any future charges. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings'**
  String get subscriptionCancelAccountSubscription;

  /// No description provided for @subscriptionOtherPurchaseVendorCancelAccountSubscription.
  ///
  /// In en, this message translates to:
  /// **'Your subscription seems to be purchased from a different store.'**
  String get subscriptionOtherPurchaseVendorCancelAccountSubscription;

  /// No description provided for @subscriptionRestoreSubscriptionFromSettings.
  ///
  /// In en, this message translates to:
  /// **'Please take a moment to resubscribe your subscription plan from Subscription Settings. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings'**
  String get subscriptionRestoreSubscriptionFromSettings;

  /// No description provided for @subscriptionAskRestoreSubscription.
  ///
  /// In en, this message translates to:
  /// **'Sorry, your subscription seems to be purchased but is not verified, please, tap on Restore Purchase to verify it.'**
  String get subscriptionAskRestoreSubscription;

  /// No description provided for @subscriptionDuplicateSubscriptionFromSettings.
  ///
  /// In en, this message translates to:
  /// **'This subscription seems to be purchased before. Please take a moment to resubscribe your subscription plan from Subscription Settings. If you\'re ready to proceed, tap \'Manage Subscription\' to go to your device settings'**
  String get subscriptionDuplicateSubscriptionFromSettings;

  /// No description provided for @subscriptionRecommendedAccess.
  ///
  /// In en, this message translates to:
  /// **'recommended'**
  String get subscriptionRecommendedAccess;

  /// No description provided for @subscriptionLimitedAccess.
  ///
  /// In en, this message translates to:
  /// **'limited time offer'**
  String get subscriptionLimitedAccess;

  /// No description provided for @subscriptionLifeTimeAccess.
  ///
  /// In en, this message translates to:
  /// **'lifetime access'**
  String get subscriptionLifeTimeAccess;

  /// No description provided for @subscriptionFlexibleAccess.
  ///
  /// In en, this message translates to:
  /// **'flexible access'**
  String get subscriptionFlexibleAccess;

  /// No description provided for @subscriptionMonth.
  ///
  /// In en, this message translates to:
  /// **'monthly'**
  String get subscriptionMonth;

  /// No description provided for @subscriptionQuarterly.
  ///
  /// In en, this message translates to:
  /// **'quarterly'**
  String get subscriptionQuarterly;

  /// No description provided for @subscriptionAnnually.
  ///
  /// In en, this message translates to:
  /// **'annually'**
  String get subscriptionAnnually;

  /// No description provided for @subscriptionWeekly.
  ///
  /// In en, this message translates to:
  /// **'weekly'**
  String get subscriptionWeekly;

  /// No description provided for @subscriptionDaily.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get subscriptionDaily;

  /// No description provided for @subscriptionDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime in subscriptions center'**
  String get subscriptionDescriptionLabel;

  /// No description provided for @subscriptionGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'Your journey is about to begin.'**
  String get subscriptionGenericTitle;

  /// No description provided for @emergencyAssistanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency assistance: (call or text)'**
  String get emergencyAssistanceTitle;

  /// No description provided for @emergencyAssistanceNumber.
  ///
  /// In en, this message translates to:
  /// **'911'**
  String get emergencyAssistanceNumber;

  /// No description provided for @emergencyAssistanceLabel.
  ///
  /// In en, this message translates to:
  /// **'911'**
  String get emergencyAssistanceLabel;

  /// No description provided for @emergencyUsLifelineTitle.
  ///
  /// In en, this message translates to:
  /// **'U.S suicide and crisis lifeline (call or text)'**
  String get emergencyUsLifelineTitle;

  /// No description provided for @emergencyUsLifelineTitleNumber.
  ///
  /// In en, this message translates to:
  /// **'988'**
  String get emergencyUsLifelineTitleNumber;

  /// No description provided for @emergencyUsLifelineTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'988'**
  String get emergencyUsLifelineTitleLabel;

  /// No description provided for @emergencyCrisisChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Lifeline Crisis Chat'**
  String get emergencyCrisisChatTitle;

  /// No description provided for @emergencyCrisisChatUrl.
  ///
  /// In en, this message translates to:
  /// **'https://988lifeline.org/chat'**
  String get emergencyCrisisChatUrl;

  /// No description provided for @emergencyCrisisChatLabel.
  ///
  /// In en, this message translates to:
  /// **'Live messenger'**
  String get emergencyCrisisChatLabel;

  /// No description provided for @emergencySelfHarmLineTitle.
  ///
  /// In en, this message translates to:
  /// **'Self-harm Line'**
  String get emergencySelfHarmLineTitle;

  /// No description provided for @emergencySelfHarmLineNumber.
  ///
  /// In en, this message translates to:
  /// **'1-800-366-8288'**
  String get emergencySelfHarmLineNumber;

  /// No description provided for @emergencySelfHarmLineLabel.
  ///
  /// In en, this message translates to:
  /// **'1-800-366-8288'**
  String get emergencySelfHarmLineLabel;

  /// No description provided for @emergencyLGBTQLineTitle.
  ///
  /// In en, this message translates to:
  /// **'LGBTQ Youth Suicide Hotline (Trevor Project)'**
  String get emergencyLGBTQLineTitle;

  /// No description provided for @emergencyLGBTQLineNumber.
  ///
  /// In en, this message translates to:
  /// **'1-866-488-786'**
  String get emergencyLGBTQLineNumber;

  /// No description provided for @emergencyLGBTQLineLabel.
  ///
  /// In en, this message translates to:
  /// **'1-866-488-786'**
  String get emergencyLGBTQLineLabel;

  /// No description provided for @emergencyNationalHotlineTitle.
  ///
  /// In en, this message translates to:
  /// **'National Crisis Hotline (Anorexia & Bulimia)'**
  String get emergencyNationalHotlineTitle;

  /// No description provided for @emergencyNationalHotlineNumber.
  ///
  /// In en, this message translates to:
  /// **'1-800-233-4357'**
  String get emergencyNationalHotlineNumber;

  /// No description provided for @emergencyNationalHotlineLabel.
  ///
  /// In en, this message translates to:
  /// **'1-800-233-4357'**
  String get emergencyNationalHotlineLabel;

  /// No description provided for @emergencyVeteransLineTitle.
  ///
  /// In en, this message translates to:
  /// **'Veterans Line'**
  String get emergencyVeteransLineTitle;

  /// No description provided for @emergencyVeteransLineUrl.
  ///
  /// In en, this message translates to:
  /// **'https://veteranscrisisline.net/'**
  String get emergencyVeteransLineUrl;

  /// No description provided for @emergencyVeteransLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Veterans Line'**
  String get emergencyVeteransLineLabel;

  /// This is a welcome message.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {projectName}!'**
  String introTitle(String projectName);

  /// No description provided for @introBodyTextFirst.
  ///
  /// In en, this message translates to:
  /// **'This program is specifically designed for people living with overweight and obesity that want to sustainably lose weight and change their lifestyle.'**
  String get introBodyTextFirst;

  /// No description provided for @introBodyTextSecond.
  ///
  /// In en, this message translates to:
  /// **'If this description fits you, let’s start your journey.'**
  String get introBodyTextSecond;

  /// A greeting message that includes the project name.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to {projectName}'**
  String loginTitle(String projectName);

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Your email address'**
  String get forgotPasswordSubTitle;

  /// No description provided for @forgotPasswordBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you instructions to reset your password'**
  String get forgotPasswordBody;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Indicates the current step out of the total number of steps.
  ///
  /// In en, this message translates to:
  /// **'Step {currentStep} of {totalSteps}'**
  String stepCounter(String currentStep, String totalSteps);

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @legalStatement.
  ///
  /// In en, this message translates to:
  /// **'Legal statement'**
  String get legalStatement;

  /// No description provided for @legalStatementTextOne.
  ///
  /// In en, this message translates to:
  /// **'For your own health and safety, it is important that you have answered all questions truthfully'**
  String get legalStatementTextOne;

  /// No description provided for @legalStatementTextTwo.
  ///
  /// In en, this message translates to:
  /// **'To continue, please read and accept our legal statement'**
  String get legalStatementTextTwo;

  /// No description provided for @readLegalStatement.
  ///
  /// In en, this message translates to:
  /// **'Read legal statement'**
  String get readLegalStatement;

  /// No description provided for @legalStatementCheckboxTitle.
  ///
  /// In en, this message translates to:
  /// **'I hereby declare, that:'**
  String get legalStatementCheckboxTitle;

  /// No description provided for @legalStatementCheckboxItemOne.
  ///
  /// In en, this message translates to:
  /// **'my answers are true to the best of my knowledge and I will continue to answer questions truthfully in future.'**
  String get legalStatementCheckboxItemOne;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @openLinkErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Can\'t open the link'**
  String get openLinkErrorMessage;

  /// No description provided for @signUpWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Hurray,\n you can now start the LeanOnMe program'**
  String get signUpWelcomeTitle;

  /// No description provided for @signUpWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s great to have you on board. Create an account to embark on your journey'**
  String get signUpWelcomeBody;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @whatIsYourName.
  ///
  /// In en, this message translates to:
  /// **'What name would you like to use'**
  String get whatIsYourName;

  /// No description provided for @niceToMeetYou.
  ///
  /// In en, this message translates to:
  /// **'Nice to meet you'**
  String get niceToMeetYou;

  /// No description provided for @enterPasswordSubTitle.
  ///
  /// In en, this message translates to:
  /// **'What password would you like to use'**
  String get enterPasswordSubTitle;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordStrengthToShort.
  ///
  /// In en, this message translates to:
  /// **'Your password is too short'**
  String get passwordStrengthToShort;

  /// No description provided for @passwordStrengthToLong.
  ///
  /// In en, this message translates to:
  /// **'Your password is too long'**
  String get passwordStrengthToLong;

  /// No description provided for @passwordStrengthNotSecure.
  ///
  /// In en, this message translates to:
  /// **'Not secure enough yet...'**
  String get passwordStrengthNotSecure;

  /// No description provided for @passwordStrengthMiddle.
  ///
  /// In en, this message translates to:
  /// **'Better, but need some'**
  String get passwordStrengthMiddle;

  /// No description provided for @passwordStrengthNice.
  ///
  /// In en, this message translates to:
  /// **'That looks nice and secure!'**
  String get passwordStrengthNice;

  /// No description provided for @passwordValidationRule1.
  ///
  /// In en, this message translates to:
  /// **'minimum eight characters'**
  String get passwordValidationRule1;

  /// No description provided for @passwordValidationRule2.
  ///
  /// In en, this message translates to:
  /// **'at least one number'**
  String get passwordValidationRule2;

  /// No description provided for @passwordValidationRule3.
  ///
  /// In en, this message translates to:
  /// **'at least one special character'**
  String get passwordValidationRule3;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Now, please write down your email address'**
  String get emailTitle;

  /// No description provided for @emailBody.
  ///
  /// In en, this message translates to:
  /// **'You will receive an email to confirm your address'**
  String get emailBody;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditionsTitle;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @iAcceptThe.
  ///
  /// In en, this message translates to:
  /// **'I accept the'**
  String get iAcceptThe;

  /// No description provided for @pleaseAcceptTOC.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and conditions'**
  String get pleaseAcceptTOC;

  /// No description provided for @pleaseAcceptPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Please accept privacy policy'**
  String get pleaseAcceptPrivacyPolicy;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @receiveEmailCheckboxLabel.
  ///
  /// In en, this message translates to:
  /// **'I agree to receive occasional emails about updates'**
  String get receiveEmailCheckboxLabel;

  /// No description provided for @waitingForConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'You’ve got mail'**
  String get waitingForConfirmationTitle;

  /// No description provided for @resendConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve just sent another email to you'**
  String get resendConfirmationMessage;

  /// No description provided for @waitingForConfirmationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your e-mail'**
  String get waitingForConfirmationSubtitle;

  /// No description provided for @waitingForConfirmationBody.
  ///
  /// In en, this message translates to:
  /// **'No rush, you can confirm your email address later. We sent it to:'**
  String get waitingForConfirmationBody;

  /// No description provided for @waitingForConfirmationBody3.
  ///
  /// In en, this message translates to:
  /// **'If you haven\'t received anything, make sure to check your spam folder'**
  String get waitingForConfirmationBody3;

  /// No description provided for @waitingForConfirmationBody4.
  ///
  /// In en, this message translates to:
  /// **'No message in your inbox? Please click the button below'**
  String get waitingForConfirmationBody4;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend confirmation email'**
  String get resend;

  /// No description provided for @incorrectEmail.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email'**
  String get incorrectEmail;

  /// No description provided for @changeAddress.
  ///
  /// In en, this message translates to:
  /// **'Change email address'**
  String get changeAddress;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @changeEmailAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Please write down the new email address'**
  String get changeEmailAddressTitle;

  /// No description provided for @emailConfirmedBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Email address is confirmed'**
  String get emailConfirmedBottomSheetTitle;

  /// No description provided for @emailConfirmedBottomSheetContent.
  ///
  /// In en, this message translates to:
  /// **'Thanks for confirming your email address. You can now start using the app'**
  String get emailConfirmedBottomSheetContent;

  /// No description provided for @logMood.
  ///
  /// In en, this message translates to:
  /// **'Log Mood'**
  String get logMood;

  /// No description provided for @yourNote.
  ///
  /// In en, this message translates to:
  /// **'Your note'**
  String get yourNote;

  /// No description provided for @educationTitle.
  ///
  /// In en, this message translates to:
  /// **'Taking one step at a time will have a huge impact'**
  String get educationTitle;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @lesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get lesson;

  /// No description provided for @lessonCompleted.
  ///
  /// In en, this message translates to:
  /// **'Lesson completed!'**
  String get lessonCompleted;

  /// No description provided for @groupSessionsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Support group unlocked'**
  String get groupSessionsUnlocked;

  /// No description provided for @waitingForGroupCompletedLesson.
  ///
  /// In en, this message translates to:
  /// **'We will let you know once we have found a group for you based on your preferences'**
  String get waitingForGroupCompletedLesson;

  /// No description provided for @notJoinedToGroupCompletedLesson.
  ///
  /// In en, this message translates to:
  /// **'If you would like to join group sessions in the future, you can indicate this in your preferences'**
  String get notJoinedToGroupCompletedLesson;

  /// No description provided for @groupSessionUnlockOnTrialPeriod.
  ///
  /// In en, this message translates to:
  /// **'Group sessions is only available if you have a paid subscription.  After you have paid, you can enrol from the dashboard or your profile.'**
  String get groupSessionUnlockOnTrialPeriod;

  /// No description provided for @unlockFeatureDescription.
  ///
  /// In en, this message translates to:
  /// **'Your preferences have been added to your profile. You can update them later.'**
  String get unlockFeatureDescription;

  /// No description provided for @lessonCompleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Well done! You can proceed to the next lesson'**
  String get lessonCompleteDescription;

  /// No description provided for @assignmentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Assignment completed!'**
  String get assignmentCompleted;

  /// No description provided for @assignmentCompleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Well done! Your answers are saved, so you can revisit them later.'**
  String get assignmentCompleteDescription;

  /// No description provided for @consultYourTherapistBody1.
  ///
  /// In en, this message translates to:
  /// **'You indicated that you are currently being treated by a psychologist or psychiatrist.'**
  String get consultYourTherapistBody1;

  /// No description provided for @consultYourTherapistBody2.
  ///
  /// In en, this message translates to:
  /// **'Together with your therapist, please discuss whether joining a support group would be a good step for you in your current treatment plan.'**
  String get consultYourTherapistBody2;

  /// No description provided for @consultYourTherapistBody3.
  ///
  /// In en, this message translates to:
  /// **'Once you have discussed this with your therapist, you can continue the process of joining a support group.'**
  String get consultYourTherapistBody3;

  /// No description provided for @consultYourTherapistBody4.
  ///
  /// In en, this message translates to:
  /// **'To do so, go to your Profile and under Preferences you will find Support group.'**
  String get consultYourTherapistBody4;

  /// No description provided for @completeLesson.
  ///
  /// In en, this message translates to:
  /// **'Complete the lesson'**
  String get completeLesson;

  /// No description provided for @didYouCheckWithSpecialist.
  ///
  /// In en, this message translates to:
  /// **'Did you check with your therapist?'**
  String get didYouCheckWithSpecialist;

  /// No description provided for @iConsultedTherapist.
  ///
  /// In en, this message translates to:
  /// **'I consulted my therapist'**
  String get iConsultedTherapist;

  /// No description provided for @treatedByTherapistLessonComplete.
  ///
  /// In en, this message translates to:
  /// **'Once you have discussed it with your therapist, go to Support Group preferences in the User Profile to continue.'**
  String get treatedByTherapistLessonComplete;

  /// No description provided for @trialSubscriptionLessonComplete.
  ///
  /// In en, this message translates to:
  /// **'Support group is only available if you have a paid subscription. After you have purchased a subscription, you can enrol from the Support Group preferences in the User Profile.'**
  String get trialSubscriptionLessonComplete;

  /// No description provided for @groupSessionsJoinLaterLessonComplete.
  ///
  /// In en, this message translates to:
  /// **'If you want to join a support group in the future, go to Support Group preferences in the User Profile. Please note that support group is only available if you have a paid subscription.'**
  String get groupSessionsJoinLaterLessonComplete;

  /// No description provided for @needSubscrionScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Support groups available with paid subscription'**
  String get needSubscrionScreenTitle;

  /// No description provided for @needSubscrionScreenBody1.
  ///
  /// In en, this message translates to:
  /// **'You are currently on your free 14-day trial of the LeanOnMe program.'**
  String get needSubscrionScreenBody1;

  /// No description provided for @needSubscrionScreenBody2.
  ///
  /// In en, this message translates to:
  /// **'Once the free-trial period ends, you can choose to join a support group. '**
  String get needSubscrionScreenBody2;

  /// No description provided for @needSubscrionScreenBody3.
  ///
  /// In en, this message translates to:
  /// **'The Support group widget on your dashboard will tell you when this function becomes available.'**
  String get needSubscrionScreenBody3;

  /// No description provided for @needSubscrionScreenBody4.
  ///
  /// In en, this message translates to:
  /// **'You can then join a group through the Dashboard or through your Profile.'**
  String get needSubscrionScreenBody4;

  /// No description provided for @consultYourTherapist.
  ///
  /// In en, this message translates to:
  /// **'Consult your therapist'**
  String get consultYourTherapist;

  /// No description provided for @groupSession.
  ///
  /// In en, this message translates to:
  /// **'Group Session'**
  String get groupSession;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @haveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAnAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @bodyAndMind.
  ///
  /// In en, this message translates to:
  /// **'Body and Mind'**
  String get bodyAndMind;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @introPage.
  ///
  /// In en, this message translates to:
  /// **'Intro Page'**
  String get introPage;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'More info'**
  String get moreInfo;

  /// No description provided for @yourBirthday.
  ///
  /// In en, this message translates to:
  /// **'Your birthday'**
  String get yourBirthday;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @downloadInstructions.
  ///
  /// In en, this message translates to:
  /// **'Download instructions'**
  String get downloadInstructions;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @yourPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get yourPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @yourEmail.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get yourEmail;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourName;

  /// No description provided for @connectionLost.
  ///
  /// In en, this message translates to:
  /// **'Internet connection lost, please check your internet connection or try later'**
  String get connectionLost;

  /// No description provided for @pleaseEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterYourEmailAddress;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @nameRegexValidationError.
  ///
  /// In en, this message translates to:
  /// **'Only . + - \' special characters are allowed'**
  String get nameRegexValidationError;

  /// No description provided for @pleaseEnterValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmailAddress;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @enterYourHeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter your height'**
  String get enterYourHeight;

  /// Message shown to the user after submitting their email address for account recovery.
  ///
  /// In en, this message translates to:
  /// **'If there is an account associated with the {email}, an email with further instructions will be sent to that address.'**
  String forgotEmailSuccessMessage(String email);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @youAndFoodItemThree.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get youAndFoodItemThree;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @iDoNotEatOrDrink.
  ///
  /// In en, this message translates to:
  /// **'I do not eat or drink:'**
  String get iDoNotEatOrDrink;

  /// No description provided for @iAmAllergicTo.
  ///
  /// In en, this message translates to:
  /// **'I am allergic to:'**
  String get iAmAllergicTo;

  /// No description provided for @iDoNotLike.
  ///
  /// In en, this message translates to:
  /// **'I do not like:'**
  String get iDoNotLike;

  /// No description provided for @typeOne.
  ///
  /// In en, this message translates to:
  /// **'Yes, type 1'**
  String get typeOne;

  /// No description provided for @typeTwo.
  ///
  /// In en, this message translates to:
  /// **'Yes, type 2'**
  String get typeTwo;

  /// No description provided for @breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get breakfast;

  /// No description provided for @lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get lunch;

  /// No description provided for @dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get dinner;

  /// No description provided for @lateDinner.
  ///
  /// In en, this message translates to:
  /// **'Late night'**
  String get lateDinner;

  /// No description provided for @nutritionSummary.
  ///
  /// In en, this message translates to:
  /// **'Nutrition summary'**
  String get nutritionSummary;

  /// No description provided for @calorieDensity.
  ///
  /// In en, this message translates to:
  /// **'Calorie density'**
  String get calorieDensity;

  /// No description provided for @proteinDegree.
  ///
  /// In en, this message translates to:
  /// **'Protein degree'**
  String get proteinDegree;

  /// No description provided for @whatIsCalorieDensity.
  ///
  /// In en, this message translates to:
  /// **'What is calorie density'**
  String get whatIsCalorieDensity;

  /// No description provided for @whatIsProtein.
  ///
  /// In en, this message translates to:
  /// **'What is protein degree'**
  String get whatIsProtein;

  /// No description provided for @calorieDensityExplanation.
  ///
  /// In en, this message translates to:
  /// **'Calorie density is  a measure of how many calories are in a given weight of food, most often expressed as calories per gram. It is a good indicator for how filling it is.'**
  String get calorieDensityExplanation;

  /// No description provided for @forMoreInformationSeeLesson.
  ///
  /// In en, this message translates to:
  /// **'For more information see lesson'**
  String get forMoreInformationSeeLesson;

  /// No description provided for @proteinDegreeExplanation.
  ///
  /// In en, this message translates to:
  /// **'Protein is the most filling macro-nutrient. Eating 300 calories of protein is more filling compared to eating 300 calories carbohydrates or fat.'**
  String get proteinDegreeExplanation;

  /// No description provided for @fiberExplanation.
  ///
  /// In en, this message translates to:
  /// **'Fiber is the best nutrient to maintain a healthy gut and microbiome. Additionally, it is an excellent indicator for the overall quality of carbohydrates in your diet.'**
  String get fiberExplanation;

  /// No description provided for @importanceOfProtein.
  ///
  /// In en, this message translates to:
  /// **'The Importance of Protein'**
  String get importanceOfProtein;

  /// No description provided for @carbohydratesPart2.
  ///
  /// In en, this message translates to:
  /// **'Carbohydrates Part 2'**
  String get carbohydratesPart2;

  /// Displays the amount of fiber consumed compared to the daily goal.
  ///
  /// In en, this message translates to:
  /// **'{fiberAmount}g of your daily goal of {dailyGoal}g fiber'**
  String fiberDailyGoal(String fiberAmount, String dailyGoal);

  /// Displays the ratio of fiber to total carbohydrates.
  ///
  /// In en, this message translates to:
  /// **'Ratio to {totalCarbohydrates}g total Carbohydrates is 1:{ratio}'**
  String fiberRatioToCarbo(String totalCarbohydrates, String ratio);

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @addAsFavourite.
  ///
  /// In en, this message translates to:
  /// **'Add as a favorite'**
  String get addAsFavourite;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to Favorites'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from Favorites'**
  String get removedFromFavorites;

  /// No description provided for @myFavorites.
  ///
  /// In en, this message translates to:
  /// **'My favorites'**
  String get myFavorites;

  /// No description provided for @my.
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get my;

  /// No description provided for @myDishes.
  ///
  /// In en, this message translates to:
  /// **'My dishes'**
  String get myDishes;

  /// No description provided for @dishes.
  ///
  /// In en, this message translates to:
  /// **'dishes'**
  String get dishes;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @showMy.
  ///
  /// In en, this message translates to:
  /// **'Show my'**
  String get showMy;

  /// No description provided for @qrCodeSubtext_1.
  ///
  /// In en, this message translates to:
  /// **'Keep the barcode right in front of your camera and make sure it is within the indicated area.'**
  String get qrCodeSubtext_1;

  /// No description provided for @qrCodeSubtext_2.
  ///
  /// In en, this message translates to:
  /// **'If the barcode is identified you will hear a bleep '**
  String get qrCodeSubtext_2;

  /// No description provided for @qrCodeSubtext_3.
  ///
  /// In en, this message translates to:
  /// **'If the camera image is blurry, then move the product slightly around to help the camera refocus'**
  String get qrCodeSubtext_3;

  /// No description provided for @scanOtherProduct.
  ///
  /// In en, this message translates to:
  /// **'Scan other product'**
  String get scanOtherProduct;

  /// No description provided for @sorryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Sorry, but we can not find this barcode in our system'**
  String get sorryNotFound;

  /// No description provided for @scanYourProduct.
  ///
  /// In en, this message translates to:
  /// **'Scan your barcode'**
  String get scanYourProduct;

  /// No description provided for @barCodeResultCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories: '**
  String get barCodeResultCalories;

  /// No description provided for @barCodeResultPerServing.
  ///
  /// In en, this message translates to:
  /// **'Per serving : '**
  String get barCodeResultPerServing;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @allowCameraMessage.
  ///
  /// In en, this message translates to:
  /// **'To use the barcode scanner, please allow Camera usage in settings'**
  String get allowCameraMessage;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selected;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect all'**
  String get deselectAll;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addFoodItem.
  ///
  /// In en, this message translates to:
  /// **'Add food item'**
  String get addFoodItem;

  /// No description provided for @saveToMyDishes.
  ///
  /// In en, this message translates to:
  /// **'Save to my dishes'**
  String get saveToMyDishes;

  /// No description provided for @addToDishes.
  ///
  /// In en, this message translates to:
  /// **'Add to my dishes'**
  String get addToDishes;

  /// No description provided for @viewRecipe.
  ///
  /// In en, this message translates to:
  /// **'View recipe'**
  String get viewRecipe;

  /// No description provided for @ingredientsBasedOn.
  ///
  /// In en, this message translates to:
  /// **'ingredients based on'**
  String get ingredientsBasedOn;

  /// Displays the number of portions for a meal.
  ///
  /// In en, this message translates to:
  /// **'{numberOfPortion} portion meal'**
  String portionMeal(String numberOfPortion);

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get total;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for food'**
  String get searchHint;

  /// No description provided for @searchFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchFilterAll;

  /// No description provided for @searchFilterProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get searchFilterProducts;

  /// No description provided for @searchFilterRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get searchFilterRecipes;

  /// No description provided for @searchFilterMy.
  ///
  /// In en, this message translates to:
  /// **'My Food'**
  String get searchFilterMy;

  /// No description provided for @inbetweens.
  ///
  /// In en, this message translates to:
  /// **'Inbetweens & snacks'**
  String get inbetweens;

  /// No description provided for @inbetweensShort.
  ///
  /// In en, this message translates to:
  /// **'Inbetweens'**
  String get inbetweensShort;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'favorites'**
  String get favorites;

  /// No description provided for @allMy.
  ///
  /// In en, this message translates to:
  /// **'All my'**
  String get allMy;

  /// No description provided for @showNutritionValue.
  ///
  /// In en, this message translates to:
  /// **'Show nutrition value'**
  String get showNutritionValue;

  /// Message indicating that the user does not have any of a certain type yet.
  ///
  /// In en, this message translates to:
  /// **'You have no {text} yet'**
  String youHaveNo(String text);

  /// No description provided for @favoritesExplain.
  ///
  /// In en, this message translates to:
  /// **'Favorites help you quickly log your most used food items'**
  String get favoritesExplain;

  /// No description provided for @favoritesList.
  ///
  /// In en, this message translates to:
  /// **'1. Search a food item \n2. View its details \n3. Tap the star on the right side to bookmark it as your favorite'**
  String get favoritesList;

  /// No description provided for @dishesExplain.
  ///
  /// In en, this message translates to:
  /// **'My dishes help you quickly log your most eaten meals'**
  String get dishesExplain;

  /// No description provided for @dishesList.
  ///
  /// In en, this message translates to:
  /// **'1. Log the desired food items \n2. Create a My dish directly from your log summary'**
  String get dishesList;

  /// No description provided for @groupPreferences.
  ///
  /// In en, this message translates to:
  /// **'Group Preferences'**
  String get groupPreferences;

  /// No description provided for @groupRules.
  ///
  /// In en, this message translates to:
  /// **'Group Rules'**
  String get groupRules;

  /// No description provided for @wouldYouLikeToJoinSupportGroup.
  ///
  /// In en, this message translates to:
  /// **'Would you like to join a support group?'**
  String get wouldYouLikeToJoinSupportGroup;

  /// No description provided for @genderPreferencesQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you have a gender preference for your support group?'**
  String get genderPreferencesQuestion;

  /// No description provided for @nicknamePreferencesQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which name do you want to use within your support group?'**
  String get nicknamePreferencesQuestion;

  /// No description provided for @nicknamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get nicknamePlaceholder;

  /// No description provided for @weAreLookingForAMatch.
  ///
  /// In en, this message translates to:
  /// **'We are looking for a match'**
  String get weAreLookingForAMatch;

  /// No description provided for @weAreLookingForAGroupSince.
  ///
  /// In en, this message translates to:
  /// **'We are looking for a group that matches your preferences since'**
  String get weAreLookingForAGroupSince;

  /// No description provided for @genderPreference.
  ///
  /// In en, this message translates to:
  /// **'Gender preference'**
  String get genderPreference;

  /// No description provided for @timezone.
  ///
  /// In en, this message translates to:
  /// **'Time zone'**
  String get timezone;

  /// No description provided for @yourNickname.
  ///
  /// In en, this message translates to:
  /// **'Your Nickname'**
  String get yourNickname;

  /// No description provided for @partOfGroup.
  ///
  /// In en, this message translates to:
  /// **'Part of group'**
  String get partOfGroup;

  /// No description provided for @iNoLongerWantToJoin.
  ///
  /// In en, this message translates to:
  /// **'I no longer want to join a group'**
  String get iNoLongerWantToJoin;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Message indicating that no group matching the user's preferences has been found since a specific date and time.
  ///
  /// In en, this message translates to:
  /// **'We have not yet been able to find a group that matches your preferences since {dateTime}\n\nTo speed up the process you could adjust your group gender preference to ‘no preference’'**
  String weHaveNotYetFound(String dateTime);

  /// No description provided for @goodNews.
  ///
  /// In en, this message translates to:
  /// **'Good news!'**
  String get goodNews;

  /// No description provided for @youHaveBeenAddedToGroup.
  ///
  /// In en, this message translates to:
  /// **'You have been added to a group matching your preferences. Sign up for a group session and use the chat to meet your fellow group members'**
  String get youHaveBeenAddedToGroup;

  /// No description provided for @readTheGroupRules.
  ///
  /// In en, this message translates to:
  /// **'Read the group rules'**
  String get readTheGroupRules;

  /// No description provided for @leaveGroup.
  ///
  /// In en, this message translates to:
  /// **'Leave group'**
  String get leaveGroup;

  /// No description provided for @notYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get notYet;

  /// No description provided for @whatIsYourTimezone.
  ///
  /// In en, this message translates to:
  /// **'What is your time zone?'**
  String get whatIsYourTimezone;

  /// No description provided for @searchTimezone.
  ///
  /// In en, this message translates to:
  /// **'Search time zone'**
  String get searchTimezone;

  /// No description provided for @groupRulesOneTitle.
  ///
  /// In en, this message translates to:
  /// **'Feeling safe in a trusting environment'**
  String get groupRulesOneTitle;

  /// No description provided for @groupRulesAttention.
  ///
  /// In en, this message translates to:
  /// **'Please read the 14 group rules carefully'**
  String get groupRulesAttention;

  /// No description provided for @groupRulesOneParagraphOne.
  ///
  /// In en, this message translates to:
  /// **'It is very important for all group meetings that you uphold the group rules. These group rules help ensure that a safe and trusting environment is created for each and every member.'**
  String get groupRulesOneParagraphOne;

  /// No description provided for @groupRulesOneParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'Your group should provide a place that you feel comfortable, and can open up, in. It gives you the opportunity to discuss things that are on your mind in a trusting environment, outside of the chaos of everyday life.'**
  String get groupRulesOneParagraphTwo;

  /// No description provided for @continueToTheRules.
  ///
  /// In en, this message translates to:
  /// **'Continue to the rules'**
  String get continueToTheRules;

  /// No description provided for @yesIAgree.
  ///
  /// In en, this message translates to:
  /// **'Yes, I agree'**
  String get yesIAgree;

  /// No description provided for @supportGroupPreferences.
  ///
  /// In en, this message translates to:
  /// **'Support Group Preferences'**
  String get supportGroupPreferences;

  /// No description provided for @groupRulesTwoParagraphOne.
  ///
  /// In en, this message translates to:
  /// **'Everything that is discussed within the group, stays within the group. Every member strives to create a friendly atmosphere, in which all can feel comfortable in.'**
  String get groupRulesTwoParagraphOne;

  /// No description provided for @groupRulesTwoParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'We treat each other with respect and are kind to one another.'**
  String get groupRulesTwoParagraphTwo;

  /// No description provided for @groupRulesTwoParagraphThree.
  ///
  /// In en, this message translates to:
  /// **'We let each other talk and do not criticize one another.'**
  String get groupRulesTwoParagraphThree;

  /// No description provided for @groupRulesThreeParagraphOne.
  ///
  /// In en, this message translates to:
  /// **'Together, we ensure that all members get the same opportunity to share.'**
  String get groupRulesThreeParagraphOne;

  /// No description provided for @groupRulesThreeParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'We actively listen – sometimes just listening to one another is worth more than constant comments and advice.'**
  String get groupRulesThreeParagraphTwo;

  /// No description provided for @groupRulesThreeParagraphThree.
  ///
  /// In en, this message translates to:
  /// **'Every topic, every problem, will be taken seriously.'**
  String get groupRulesThreeParagraphThree;

  /// No description provided for @groupRulesFourParagraphOnePartOne.
  ///
  /// In en, this message translates to:
  /// **'We send'**
  String get groupRulesFourParagraphOnePartOne;

  /// No description provided for @groupRulesFourParagraphOnePartTwo.
  ///
  /// In en, this message translates to:
  /// **'We use these to express/phrase our own emotions, opinions, assumptions, and perceptions. Therefore, we avoid phrases such as'**
  String get groupRulesFourParagraphOnePartTwo;

  /// No description provided for @groupRulesFourParagraphOnePartThree.
  ///
  /// In en, this message translates to:
  /// **'Instead, a sentence could start with'**
  String get groupRulesFourParagraphOnePartThree;

  /// No description provided for @groupRulesFourParagraphOneItalicOne.
  ///
  /// In en, this message translates to:
  /// **'“Me-messages”.'**
  String get groupRulesFourParagraphOneItalicOne;

  /// No description provided for @groupRulesFourParagraphOneItalicTwo.
  ///
  /// In en, this message translates to:
  /// **'“you must/you are”.'**
  String get groupRulesFourParagraphOneItalicTwo;

  /// No description provided for @groupRulesFourParagraphOneItalicThree.
  ///
  /// In en, this message translates to:
  /// **'“I have had positive experiences with.../I found it helpful when...”.'**
  String get groupRulesFourParagraphOneItalicThree;

  /// No description provided for @groupRulesFourParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'It is helpful to regularly be aware of one self – your body, your thoughts, your feelings.'**
  String get groupRulesFourParagraphTwo;

  /// No description provided for @groupRulesFiveParagraphOne.
  ///
  /// In en, this message translates to:
  /// **'We also talk to each other, not about each other. Absent group members will not be the subject of conversation.'**
  String get groupRulesFiveParagraphOne;

  /// No description provided for @groupRulesFiveParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'Individual responsibility: every member of a group is responsible for what they do and/or say. Appreciation and respect for yourself and others is important, that means I respect my own boundaries that I set for myself as well as those of my group members.'**
  String get groupRulesFiveParagraphTwo;

  /// No description provided for @groupRulesSixParagraphOne.
  ///
  /// In en, this message translates to:
  /// **'The camera should remain on during sessions so that you can all see each other and no member is forgotten.'**
  String get groupRulesSixParagraphOne;

  /// No description provided for @groupRulesSixParagraphTwo.
  ///
  /// In en, this message translates to:
  /// **'Take some time and relax before a session.'**
  String get groupRulesSixParagraphTwo;

  /// No description provided for @groupRulesSixParagraphThree.
  ///
  /// In en, this message translates to:
  /// **'Be patient with others, but especially with yourself – be kind to yourself.'**
  String get groupRulesSixParagraphThree;

  /// No description provided for @groupRulesSixParagraphFour.
  ///
  /// In en, this message translates to:
  /// **'Last but not least: Have fun!'**
  String get groupRulesSixParagraphFour;

  /// No description provided for @noPreference.
  ///
  /// In en, this message translates to:
  /// **'no Preference'**
  String get noPreference;

  /// No description provided for @femaleOnly.
  ///
  /// In en, this message translates to:
  /// **'female only'**
  String get femaleOnly;

  /// No description provided for @maleOnly.
  ///
  /// In en, this message translates to:
  /// **'male only'**
  String get maleOnly;

  /// No description provided for @mixed.
  ///
  /// In en, this message translates to:
  /// **'mixed'**
  String get mixed;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @woman.
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get woman;

  /// No description provided for @man.
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get man;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @at.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get at;

  /// No description provided for @joinAGroup.
  ///
  /// In en, this message translates to:
  /// **'Join a group'**
  String get joinAGroup;

  /// No description provided for @unavailableGroupPrefsLabel.
  ///
  /// In en, this message translates to:
  /// **'As soon as you have finished the Education lesson on “Surrounding yourself with people who get it”, you can join a support group'**
  String get unavailableGroupPrefsLabel;

  /// No description provided for @findingMatchingGroup.
  ///
  /// In en, this message translates to:
  /// **'Finding a matching group'**
  String get findingMatchingGroup;

  /// No description provided for @moreInformationInPreferences.
  ///
  /// In en, this message translates to:
  /// **'More information in Preferences'**
  String get moreInformationInPreferences;

  /// No description provided for @bookYourSeat.
  ///
  /// In en, this message translates to:
  /// **'Book your seat'**
  String get bookYourSeat;

  /// No description provided for @comingUpThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Coming up this week'**
  String get comingUpThisWeek;

  /// No description provided for @happeningNow.
  ///
  /// In en, this message translates to:
  /// **'Happening Now'**
  String get happeningNow;

  /// No description provided for @joinSession.
  ///
  /// In en, this message translates to:
  /// **'Join session'**
  String get joinSession;

  /// Indicates a booking on a specific day and time range.
  ///
  /// In en, this message translates to:
  /// **'Booked {day} from {startTime} to {endTime}'**
  String bookedFromTo(String day, String startTime, String endTime);

  /// Displays a day and time range with a newline between day and time information.
  ///
  /// In en, this message translates to:
  /// **'{day}\nfrom {startTime} to {endTime}'**
  String dayFromTo(String day, String startTime, String endTime);

  /// No description provided for @prepareForSession.
  ///
  /// In en, this message translates to:
  /// **'Prepare for session'**
  String get prepareForSession;

  /// Indicates the preparation time required for a session.
  ///
  /// In en, this message translates to:
  /// **'Prepare for this session ({times} mins)'**
  String prepareTakes(String times);

  /// No description provided for @timeslotCancelled.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this time slot is canceled'**
  String get timeslotCancelled;

  /// No description provided for @timeslotMissed.
  ///
  /// In en, this message translates to:
  /// **'Sorry, you missed this time slot'**
  String get timeslotMissed;

  /// No description provided for @chooseAnotherTimeslot.
  ///
  /// In en, this message translates to:
  /// **'Choose another time slot'**
  String get chooseAnotherTimeslot;

  /// No description provided for @noOtherTimeslotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No other time slots are available for this week. Next week’s topic is coming soon'**
  String get noOtherTimeslotsAvailable;

  /// Indicates that the session might be canceled due to insufficient user sign-ups.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No users have signed up to this session, so it might be canceled.} =1{Only 1 user has signed up to this session, so it might be canceled.} other{Less than {count} users have signed up to this session, so it might be canceled.}}'**
  String noMinMemberCount(int count);

  /// No description provided for @noGroupThisWeek.
  ///
  /// In en, this message translates to:
  /// **'No group sessions this week.'**
  String get noGroupThisWeek;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'on'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'off'**
  String get off;

  /// No description provided for @noMoodRecords.
  ///
  /// In en, this message translates to:
  /// **'You have no records for the selected day'**
  String get noMoodRecords;

  /// No description provided for @yourSupportSystem.
  ///
  /// In en, this message translates to:
  /// **'Your Support System'**
  String get yourSupportSystem;

  /// No description provided for @supportGroupIntroDesc.
  ///
  /// In en, this message translates to:
  /// **'Having a support group increases the likelihood of staying on track and reaching sustainable weight loss. \nSurround yourself with people who get it. Chat with fellow members anytime. In the weekly sessions you can discuss, learn new things and share your experiences. '**
  String get supportGroupIntroDesc;

  /// No description provided for @yesILikeToJoin.
  ///
  /// In en, this message translates to:
  /// **'Yes, I would like to join a support group'**
  String get yesILikeToJoin;

  /// No description provided for @joinLater.
  ///
  /// In en, this message translates to:
  /// **'I may join later'**
  String get joinLater;

  /// No description provided for @theSupportGroup.
  ///
  /// In en, this message translates to:
  /// **'The Support Group'**
  String get theSupportGroup;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get reportIssue;

  /// No description provided for @discussion.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussion;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get left;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @sessionIsInProgress.
  ///
  /// In en, this message translates to:
  /// **'Session is in progress'**
  String get sessionIsInProgress;

  /// No description provided for @failedToJoinSession.
  ///
  /// In en, this message translates to:
  /// **'Fail when trying to join session'**
  String get failedToJoinSession;

  /// No description provided for @disconnectedFromSession.
  ///
  /// In en, this message translates to:
  /// **'You were disconnected from the session'**
  String get disconnectedFromSession;

  /// Describes the state of the microphone.
  ///
  /// In en, this message translates to:
  /// **'Your microphone was {micState}'**
  String micState(String micState);

  /// No description provided for @toggleSpeakerError.
  ///
  /// In en, this message translates to:
  /// **'Device doesn’t support speaker toggle'**
  String get toggleSpeakerError;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @stopVideo.
  ///
  /// In en, this message translates to:
  /// **'Stop video'**
  String get stopVideo;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @sessionLeaveDialogText.
  ///
  /// In en, this message translates to:
  /// **'When you hang up, you might not be able to rejoin this group session'**
  String get sessionLeaveDialogText;

  /// No description provided for @sessionEndDialogText.
  ///
  /// In en, this message translates to:
  /// **'Your session has ended, thanks for participating'**
  String get sessionEndDialogText;

  /// No description provided for @leaveSession.
  ///
  /// In en, this message translates to:
  /// **'Leave the session anyway'**
  String get leaveSession;

  /// No description provided for @stayInTheSession.
  ///
  /// In en, this message translates to:
  /// **'Stay in the session'**
  String get stayInTheSession;

  /// No description provided for @signatureErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with your session, try go back and return later'**
  String get signatureErrorMessage;

  /// No description provided for @sessionAlreadyEnded.
  ///
  /// In en, this message translates to:
  /// **'Your session has already ended, you can’t join'**
  String get sessionAlreadyEnded;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @badConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your connection is poor'**
  String get badConnectionMessage;

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// No description provided for @noMicrophoneAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Access Microphone'**
  String get noMicrophoneAccessTitle;

  /// No description provided for @noMicrophoneAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Please turn on the toggle in system settings to grant permission'**
  String get noMicrophoneAccessDescription;

  /// No description provided for @noCameraAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Access Camera'**
  String get noCameraAccessTitle;

  /// No description provided for @noCameraAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Please turn on the toggle in system settings to grant permission'**
  String get noCameraAccessDescription;

  /// No description provided for @sessionGreeting.
  ///
  /// In en, this message translates to:
  /// **'Great to see that you are going to be joining the session'**
  String get sessionGreeting;

  /// No description provided for @goodToKnow.
  ///
  /// In en, this message translates to:
  /// **'Good to know'**
  String get goodToKnow;

  /// No description provided for @warningOne.
  ///
  /// In en, this message translates to:
  /// **'Your camera will be on and your mic will be unmuted when you enter the session'**
  String get warningOne;

  /// No description provided for @warningTwo.
  ///
  /// In en, this message translates to:
  /// **'You are expected to be aware and follow the'**
  String get warningTwo;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @sessionWillStartIn.
  ///
  /// In en, this message translates to:
  /// **'The session will start in'**
  String get sessionWillStartIn;

  /// No description provided for @sessionStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'The session has already started'**
  String get sessionStartedMessage;

  /// No description provided for @enterSession.
  ///
  /// In en, this message translates to:
  /// **'Enter session'**
  String get enterSession;

  /// No description provided for @pickADateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Pick a date and time'**
  String get pickADateAndTime;

  /// Indicates a time range from startTime to endTime.
  ///
  /// In en, this message translates to:
  /// **'From {startTime} to {endTime}'**
  String fromTo(String startTime, String endTime);

  /// Indicates a time range from startTime to endTime, with 'from' and 'to' in lowercase.
  ///
  /// In en, this message translates to:
  /// **'from {startTime} to {endTime}'**
  String fromToLower(String startTime, String endTime);

  /// Indicates the number of available seats out of the total number of seats.
  ///
  /// In en, this message translates to:
  /// **'{number} of {totalNumber} places available'**
  String numberOfAvailableSeats(String number, String totalNumber);

  /// No description provided for @passedSession.
  ///
  /// In en, this message translates to:
  /// **'Past session'**
  String get passedSession;

  /// No description provided for @cancelledSession.
  ///
  /// In en, this message translates to:
  /// **'Canceled session'**
  String get cancelledSession;

  /// No description provided for @minimumNotReached.
  ///
  /// In en, this message translates to:
  /// **'Minimum not reached'**
  String get minimumNotReached;

  /// No description provided for @noMoreSeatAvailable.
  ///
  /// In en, this message translates to:
  /// **'No more places available'**
  String get noMoreSeatAvailable;

  /// No description provided for @bookedForYou.
  ///
  /// In en, this message translates to:
  /// **'Booked for you'**
  String get bookedForYou;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelBooking;

  /// No description provided for @sessionWarning_1.
  ///
  /// In en, this message translates to:
  /// **'If less than four places are booked, the session will be canceled'**
  String get sessionWarning_1;

  /// No description provided for @sessionWarning_2.
  ///
  /// In en, this message translates to:
  /// **'If you can’t make it, please be sure to cancel your booking'**
  String get sessionWarning_2;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This program is not psychotherapy and cannot replace psychotherapy. \n\nIf you have an acute mental health crisis or feel you need psychological support or are having suicidal thoughts, please seek medical or psychological help immediately.\n\nIn an emergency, you can also contact the following numbers, which you can reach 24h/day toll-free:'**
  String get emergencySubtitle;

  /// No description provided for @subjectReport.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subjectReport;

  /// No description provided for @descriptionReport.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionReport;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report issue'**
  String get reportTitle;

  /// No description provided for @reportSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Please describe the matter.'**
  String get reportSubTitle;

  /// No description provided for @reportSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'We have received your report and will act accordingly on it'**
  String get reportSuccessTitle;

  /// No description provided for @errorReportMessage.
  ///
  /// In en, this message translates to:
  /// **'Text message must be at least one symbol and less than 500 symbols'**
  String get errorReportMessage;

  /// No description provided for @errorSubjectMessage.
  ///
  /// In en, this message translates to:
  /// **'Text message must be at least one symbol and less than 30 symbols'**
  String get errorSubjectMessage;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Field is required'**
  String get requiredField;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @changeYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Change your email'**
  String get changeYourEmail;

  /// No description provided for @changeYourEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your new email address and confirm with your password.'**
  String get changeYourEmailDescription;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @emailChangeConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Email address change confirmed'**
  String get emailChangeConfirmedTitle;

  /// No description provided for @emailChangeConfirmedBody1.
  ///
  /// In en, this message translates to:
  /// **'Your email address has been successfully updated.'**
  String get emailChangeConfirmedBody1;

  /// No description provided for @emailChangeConfirmedBody2.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an email to your new address. Please click the link to verify.'**
  String get emailChangeConfirmedBody2;

  /// Message indicating that a user's preference has been updated.
  ///
  /// In en, this message translates to:
  /// **'Your {prefName} preferences have been updated'**
  String yourPreferencesUpdated(String prefName);

  /// No description provided for @createNew.
  ///
  /// In en, this message translates to:
  /// **'Create new'**
  String get createNew;

  /// No description provided for @updateExist.
  ///
  /// In en, this message translates to:
  /// **'Update existing'**
  String get updateExist;

  /// No description provided for @existMealText.
  ///
  /// In en, this message translates to:
  /// **'You want to create a new meal or edit an existing one?'**
  String get existMealText;

  /// Prompt for choosing a date related to a specific meal category.
  ///
  /// In en, this message translates to:
  /// **'Choose date for {mealCategory}'**
  String chooseDateFor(String mealCategory);

  /// No description provided for @youCanChangeTheDate.
  ///
  /// In en, this message translates to:
  /// **'You can change the date and/or plan it on multiple days. Don’t forget to save any changes you have made'**
  String get youCanChangeTheDate;

  /// Displays the week number in uppercase format.
  ///
  /// In en, this message translates to:
  /// **'WEEK {number}'**
  String weekWithNumber(String number);

  /// Displays the week number with the first letter capitalized.
  ///
  /// In en, this message translates to:
  /// **'Week {number}'**
  String capitalizeWeekWithNumber(String number);

  /// Displays the range of dates in a week.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to} {month}'**
  String weekDates(String from, String to, String month);

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes have been saved'**
  String get changesSaved;

  /// No description provided for @thisMealPlannedFor.
  ///
  /// In en, this message translates to:
  /// **'This meal is planned for'**
  String get thisMealPlannedFor;

  /// No description provided for @saveDateError.
  ///
  /// In en, this message translates to:
  /// **'You first have to select another date before you can deselect this one'**
  String get saveDateError;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @yesReplace.
  ///
  /// In en, this message translates to:
  /// **'Yes replace'**
  String get yesReplace;

  /// Indicates that a meal category has already been planned for the day.
  ///
  /// In en, this message translates to:
  /// **'You have already planned a {mealCategory} for this day:'**
  String youAlreadyPlanned(String mealCategory);

  /// Indicates the number of additional dates.
  ///
  /// In en, this message translates to:
  /// **'and {number} other dates'**
  String andOtherDates(String number);

  /// Displays a message indicating that a meal category has already been planned.
  ///
  /// In en, this message translates to:
  /// **'{mealCategory} ALREADY PLANNED'**
  String alreadyPlannedCategory(String mealCategory);

  /// No description provided for @replaceWith.
  ///
  /// In en, this message translates to:
  /// **'Replace with?'**
  String get replaceWith;

  /// No description provided for @nothingOnTheMenu.
  ///
  /// In en, this message translates to:
  /// **'Nothing on the menu yet'**
  String get nothingOnTheMenu;

  /// No description provided for @mindTraining.
  ///
  /// In en, this message translates to:
  /// **'Mind training'**
  String get mindTraining;

  /// No description provided for @learnMoreButton.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMoreButton;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// Indicates when something will unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlocks on {date}'**
  String unlocksOn(String date);

  /// No description provided for @unlocksAfterCompletionExercise.
  ///
  /// In en, this message translates to:
  /// **'Unlocks after completion of previous exercise'**
  String get unlocksAfterCompletionExercise;

  /// No description provided for @intro.
  ///
  /// In en, this message translates to:
  /// **'Intro'**
  String get intro;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// No description provided for @startExercise.
  ///
  /// In en, this message translates to:
  /// **'Start exercise'**
  String get startExercise;

  /// Shows the number of minutes
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} min} other {{count} mins}}'**
  String countMins(int count);

  /// No description provided for @chooseAnExercise.
  ///
  /// In en, this message translates to:
  /// **'Choose an exercise'**
  String get chooseAnExercise;

  /// No description provided for @completedExerciseMessage1.
  ///
  /// In en, this message translates to:
  /// **'Great! You completed'**
  String get completedExerciseMessage1;

  /// Shows the number of completed exercises
  ///
  /// In en, this message translates to:
  /// **'{count} exercise'**
  String completedExerciseMessage2(String count);

  /// No description provided for @completedIntroductionMessage2.
  ///
  /// In en, this message translates to:
  /// **'the introduction to'**
  String get completedIntroductionMessage2;

  /// No description provided for @chooseTechnique.
  ///
  /// In en, this message translates to:
  /// **'Choose technique'**
  String get chooseTechnique;

  /// No description provided for @chooseExercise.
  ///
  /// In en, this message translates to:
  /// **'Choose exercise'**
  String get chooseExercise;

  /// No description provided for @selectedExercise.
  ///
  /// In en, this message translates to:
  /// **'Selected exercise'**
  String get selectedExercise;

  /// No description provided for @skipIntro.
  ///
  /// In en, this message translates to:
  /// **'Skip intro'**
  String get skipIntro;

  /// No description provided for @selectMoodText.
  ///
  /// In en, this message translates to:
  /// **'How do you feel?'**
  String get selectMoodText;

  /// No description provided for @selectMoodSubtext.
  ///
  /// In en, this message translates to:
  /// **'You can choose what information to fill.'**
  String get selectMoodSubtext;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @specifyEmotion.
  ///
  /// In en, this message translates to:
  /// **'Specify emotion(s)'**
  String get specifyEmotion;

  /// No description provided for @withWho.
  ///
  /// In en, this message translates to:
  /// **'With whom'**
  String get withWho;

  /// No description provided for @where.
  ///
  /// In en, this message translates to:
  /// **'Where'**
  String get where;

  /// No description provided for @makeChoice.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get makeChoice;

  /// No description provided for @personalNote.
  ///
  /// In en, this message translates to:
  /// **'Personal note'**
  String get personalNote;

  /// No description provided for @moodOptionPageEmotionTitle.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get moodOptionPageEmotionTitle;

  /// No description provided for @descriptionEmotions.
  ///
  /// In en, this message translates to:
  /// **'Choose up to three emotions'**
  String get descriptionEmotions;

  /// No description provided for @deleteMood.
  ///
  /// In en, this message translates to:
  /// **'Delete mood'**
  String get deleteMood;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let’s go'**
  String get letsGo;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'That’s incorrect'**
  String get incorrect;

  /// No description provided for @assignmentAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment added to your calendar'**
  String get assignmentAddedTitle;

  /// Message informing the user to complete an assignment before a certain date
  ///
  /// In en, this message translates to:
  /// **'Please aim to finish it before {date}'**
  String assignmentAddedText(String date);

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get reflection;

  /// No description provided for @reflections.
  ///
  /// In en, this message translates to:
  /// **'Reflections'**
  String get reflections;

  /// No description provided for @seeLesson.
  ///
  /// In en, this message translates to:
  /// **'See lesson'**
  String get seeLesson;

  /// No description provided for @allAssignmentsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All assignments have been completed'**
  String get allAssignmentsCompleted;

  /// No description provided for @errorOpenTextMessage.
  ///
  /// In en, this message translates to:
  /// **'Text message must be at least one symbol and less than 20,000 symbols'**
  String get errorOpenTextMessage;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'this week'**
  String get thisWeek;

  /// No description provided for @doneToday.
  ///
  /// In en, this message translates to:
  /// **'Done today'**
  String get doneToday;

  /// Message indicating the deadline by which a task should be completed
  ///
  /// In en, this message translates to:
  /// **'Complete before {date}'**
  String completeBefore(String date);

  /// Message indicating the completion date of a task
  ///
  /// In en, this message translates to:
  /// **'Completed on {date}'**
  String completedOn(String date);

  /// No description provided for @pastReflections.
  ///
  /// In en, this message translates to:
  /// **'Past reflections'**
  String get pastReflections;

  /// No description provided for @iWantToLogMy.
  ///
  /// In en, this message translates to:
  /// **'I want to log my'**
  String get iWantToLogMy;

  /// No description provided for @logMealServingTitle.
  ///
  /// In en, this message translates to:
  /// **'Select serving size'**
  String get logMealServingTitle;

  /// No description provided for @descriptionTime.
  ///
  /// In en, this message translates to:
  /// **'Choose the time'**
  String get descriptionTime;

  /// No description provided for @descriptionWithWhom.
  ///
  /// In en, this message translates to:
  /// **'Choose with whom you were'**
  String get descriptionWithWhom;

  /// No description provided for @descriptionWhere.
  ///
  /// In en, this message translates to:
  /// **'Choose where you were'**
  String get descriptionWhere;

  /// No description provided for @descriptionFood.
  ///
  /// In en, this message translates to:
  /// **'Choose what food you were eating?'**
  String get descriptionFood;

  /// No description provided for @logWeight.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get logWeight;

  /// No description provided for @foodLoggingUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Food logging unlocked'**
  String get foodLoggingUnlocked;

  /// No description provided for @youCanStartLogging.
  ///
  /// In en, this message translates to:
  /// **'You can start logging your meals right now'**
  String get youCanStartLogging;

  /// No description provided for @reportIssueAndEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Report issue and emergency'**
  String get reportIssueAndEmergencyTitle;

  /// No description provided for @groupChat.
  ///
  /// In en, this message translates to:
  /// **'Group chat'**
  String get groupChat;

  /// No description provided for @groupChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Group members'**
  String get groupChatTitle;

  /// Message indicating the number of members in the support group
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{There are no members in your support group} =1{There is 1 member in your support group} other{There are {count} members in your support group}}'**
  String groupChatLabel(int count);

  /// No description provided for @copyGroupMessage.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyGroupMessage;

  /// No description provided for @removeGroupMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeGroupMessage;

  /// No description provided for @reportGroupMessage.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportGroupMessage;

  /// No description provided for @snackMassageCopy.
  ///
  /// In en, this message translates to:
  /// **'Message text has been copied to clipboard'**
  String get snackMassageCopy;

  /// No description provided for @messageRemoved.
  ///
  /// In en, this message translates to:
  /// **'This message was deleted'**
  String get messageRemoved;

  /// No description provided for @membersEmpty.
  ///
  /// In en, this message translates to:
  /// **'This group chat does not have members'**
  String get membersEmpty;

  /// No description provided for @messageLengthRestriction.
  ///
  /// In en, this message translates to:
  /// **'A text message may contain up to 1,024 characters. Please make your message shorter'**
  String get messageLengthRestriction;

  /// No description provided for @yourUser.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get yourUser;

  /// No description provided for @passwordValidationRule4.
  ///
  /// In en, this message translates to:
  /// **'at least 1 capital character'**
  String get passwordValidationRule4;

  /// No description provided for @pleaseEnterRegistrationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter registration code'**
  String get pleaseEnterRegistrationCode;

  /// No description provided for @pleaseEnterValidRegistrationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid registration code'**
  String get pleaseEnterValidRegistrationCode;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @recipe.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipe;

  /// No description provided for @recipeDetails.
  ///
  /// In en, this message translates to:
  /// **'Recipe details'**
  String get recipeDetails;

  /// No description provided for @myDish.
  ///
  /// In en, this message translates to:
  /// **'My dish'**
  String get myDish;

  /// No description provided for @editMyDish.
  ///
  /// In en, this message translates to:
  /// **'Edit my dish'**
  String get editMyDish;

  /// No description provided for @serving.
  ///
  /// In en, this message translates to:
  /// **'serving'**
  String get serving;

  /// No description provided for @logList.
  ///
  /// In en, this message translates to:
  /// **'log'**
  String get logList;

  /// No description provided for @clearMealList.
  ///
  /// In en, this message translates to:
  /// **'Clear log list'**
  String get clearMealList;

  /// No description provided for @logListEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet\n What did you have for lunch?'**
  String get logListEmptyMessage;

  /// No description provided for @backToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Back to dashboard'**
  String get backToDashboard;

  /// No description provided for @finishMealLogging.
  ///
  /// In en, this message translates to:
  /// **'Finish meal'**
  String get finishMealLogging;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @logYourWeight.
  ///
  /// In en, this message translates to:
  /// **'Log your weight'**
  String get logYourWeight;

  /// No description provided for @mealLog.
  ///
  /// In en, this message translates to:
  /// **'Meal log'**
  String get mealLog;

  /// No description provided for @planYourMeals.
  ///
  /// In en, this message translates to:
  /// **'Plan your meals'**
  String get planYourMeals;

  /// No description provided for @planThisMeal.
  ///
  /// In en, this message translates to:
  /// **'Plan this meal'**
  String get planThisMeal;

  /// No description provided for @diary.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get diary;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get today;

  /// No description provided for @physicalActivities.
  ///
  /// In en, this message translates to:
  /// **'Physical activity'**
  String get physicalActivities;

  /// No description provided for @physicalActivitiesPreferences.
  ///
  /// In en, this message translates to:
  /// **'Physical preferences'**
  String get physicalActivitiesPreferences;

  /// No description provided for @trainingFrequency.
  ///
  /// In en, this message translates to:
  /// **'Training frequency'**
  String get trainingFrequency;

  /// No description provided for @trainingFocus.
  ///
  /// In en, this message translates to:
  /// **'Training focus'**
  String get trainingFocus;

  /// No description provided for @didItWorkOutForYou.
  ///
  /// In en, this message translates to:
  /// **'Did it work out for you?'**
  String get didItWorkOutForYou;

  /// No description provided for @foodPreferencesDesc.
  ///
  /// In en, this message translates to:
  /// **'We love to offer you personal and relevant food recommendations.'**
  String get foodPreferencesDesc;

  /// No description provided for @foodPreferencesItemOne.
  ///
  /// In en, this message translates to:
  /// **'Food items you don’t eat due to religious or personal reasons'**
  String get foodPreferencesItemOne;

  /// No description provided for @foodPreferencesItemTwo.
  ///
  /// In en, this message translates to:
  /// **'If you want to reduce your meat / fish intake'**
  String get foodPreferencesItemTwo;

  /// No description provided for @foodPreferencesItemThree.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get foodPreferencesItemThree;

  /// No description provided for @foodPreferencesItemFour.
  ///
  /// In en, this message translates to:
  /// **'Food you dislike'**
  String get foodPreferencesItemFour;

  /// No description provided for @physicalActivitiesPreferencesDesc.
  ///
  /// In en, this message translates to:
  /// **'We love to offer you personal and relevant physical activities.'**
  String get physicalActivitiesPreferencesDesc;

  /// No description provided for @physicalActivitiesPreferencesItemOne.
  ///
  /// In en, this message translates to:
  /// **'Do you already exercise?'**
  String get physicalActivitiesPreferencesItemOne;

  /// No description provided for @physicalActivitiesPreferencesItemTwo.
  ///
  /// In en, this message translates to:
  /// **'How often can you train per week?'**
  String get physicalActivitiesPreferencesItemTwo;

  /// No description provided for @physicalActivitiesPreferencesItemThree.
  ///
  /// In en, this message translates to:
  /// **'What would you like to work on?'**
  String get physicalActivitiesPreferencesItemThree;

  /// No description provided for @physicalActivitiesFrequencyTitle.
  ///
  /// In en, this message translates to:
  /// **'How often do you want to train per week?'**
  String get physicalActivitiesFrequencyTitle;

  /// No description provided for @physicalActivitiesFrequencyItemOne.
  ///
  /// In en, this message translates to:
  /// **'1 time'**
  String get physicalActivitiesFrequencyItemOne;

  /// No description provided for @physicalActivitiesFrequencyItemTwo.
  ///
  /// In en, this message translates to:
  /// **'2 times'**
  String get physicalActivitiesFrequencyItemTwo;

  /// No description provided for @physicalActivitiesFrequencyItemThree.
  ///
  /// In en, this message translates to:
  /// **'3 times'**
  String get physicalActivitiesFrequencyItemThree;

  /// No description provided for @physicalActivitiesFrequencyItemFour.
  ///
  /// In en, this message translates to:
  /// **'4 times'**
  String get physicalActivitiesFrequencyItemFour;

  /// No description provided for @physicalActivitiesFrequencyItemFive.
  ///
  /// In en, this message translates to:
  /// **'5 times'**
  String get physicalActivitiesFrequencyItemFive;

  /// No description provided for @physicalActivitiesFrequencyItemSix.
  ///
  /// In en, this message translates to:
  /// **'Currently not able to exercise'**
  String get physicalActivitiesFrequencyItemSix;

  /// No description provided for @physicalActivitiesFrequencyZero.
  ///
  /// In en, this message translates to:
  /// **'I am currently not able to exercise'**
  String get physicalActivitiesFrequencyZero;

  /// No description provided for @physicalActivitiesNoActivities.
  ///
  /// In en, this message translates to:
  /// **'No activities:'**
  String get physicalActivitiesNoActivities;

  /// No description provided for @whatWouldYouLikeToStartWorkingOn.
  ///
  /// In en, this message translates to:
  /// **'What would you like to start working on?'**
  String get whatWouldYouLikeToStartWorkingOn;

  /// No description provided for @buildUpMuscle.
  ///
  /// In en, this message translates to:
  /// **'Build up muscle'**
  String get buildUpMuscle;

  /// No description provided for @inceaseYourStamina.
  ///
  /// In en, this message translates to:
  /// **'Increase your stamina'**
  String get inceaseYourStamina;

  /// No description provided for @youCanAlsoOptionally.
  ///
  /// In en, this message translates to:
  /// **'You can also optionally work on your body’s mobility.'**
  String get youCanAlsoOptionally;

  /// No description provided for @moreFlexibility.
  ///
  /// In en, this message translates to:
  /// **'Become more flexible'**
  String get moreFlexibility;

  /// No description provided for @physicalActivitiesCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Why it is important to exercise?'**
  String get physicalActivitiesCompletedTitle;

  /// No description provided for @physicalActivitiesCompletedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your preference have been added to your profile. You can update them later.'**
  String get physicalActivitiesCompletedDesc;

  /// No description provided for @physicalActivitiesUnlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Physical activities unlocked.'**
  String get physicalActivitiesUnlockedTitle;

  /// No description provided for @physicalActivitiesUnlockedText.
  ///
  /// In en, this message translates to:
  /// **'You will get recommended exercises based on your preferences.'**
  String get physicalActivitiesUnlockedText;

  /// No description provided for @physicalExercises.
  ///
  /// In en, this message translates to:
  /// **'Physical exercises'**
  String get physicalExercises;

  /// No description provided for @perWeek.
  ///
  /// In en, this message translates to:
  /// **'per week'**
  String get perWeek;

  /// No description provided for @supportGroup.
  ///
  /// In en, this message translates to:
  /// **'Support group'**
  String get supportGroup;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @preferableInTheMorning.
  ///
  /// In en, this message translates to:
  /// **'Preferably in the morning'**
  String get preferableInTheMorning;

  /// No description provided for @noWeightLogged.
  ///
  /// In en, this message translates to:
  /// **'No weight logged'**
  String get noWeightLogged;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @todaysWeight.
  ///
  /// In en, this message translates to:
  /// **'Today\'s weight'**
  String get todaysWeight;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @nutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutrition;

  /// No description provided for @mind.
  ///
  /// In en, this message translates to:
  /// **'Mind'**
  String get mind;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @noMealsLogged.
  ///
  /// In en, this message translates to:
  /// **'No meals logged'**
  String get noMealsLogged;

  /// No description provided for @noMealsPlanned.
  ///
  /// In en, this message translates to:
  /// **'No meals planned'**
  String get noMealsPlanned;

  /// No description provided for @noMealsLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get noMealsLoggedYet;

  /// No description provided for @noMealsPlannedYet.
  ///
  /// In en, this message translates to:
  /// **'No meals planned yet'**
  String get noMealsPlannedYet;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @addToMyDishes.
  ///
  /// In en, this message translates to:
  /// **'Add to My dishes'**
  String get addToMyDishes;

  /// No description provided for @addToMyDishedAs.
  ///
  /// In en, this message translates to:
  /// **'Add to My dishes as'**
  String get addToMyDishedAs;

  /// No description provided for @giveNameToThisDish.
  ///
  /// In en, this message translates to:
  /// **'Name this dish'**
  String get giveNameToThisDish;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cookingTime.
  ///
  /// In en, this message translates to:
  /// **'Cooking\ntime'**
  String get cookingTime;

  /// No description provided for @preparation.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get preparation;

  /// No description provided for @preparationTime.
  ///
  /// In en, this message translates to:
  /// **'Preparation\ntime'**
  String get preparationTime;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @portions.
  ///
  /// In en, this message translates to:
  /// **'Portions'**
  String get portions;

  /// No description provided for @howToPrepare.
  ///
  /// In en, this message translates to:
  /// **'How to prepare'**
  String get howToPrepare;

  /// No description provided for @searchEmptyResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorry no results for this one'**
  String get searchEmptyResultTitle;

  /// No description provided for @searchEmptyResultText.
  ///
  /// In en, this message translates to:
  /// **'Maybe check your spelling or try another term'**
  String get searchEmptyResultText;

  /// No description provided for @createMyDish.
  ///
  /// In en, this message translates to:
  /// **'Create my dish'**
  String get createMyDish;

  /// No description provided for @logItem.
  ///
  /// In en, this message translates to:
  /// **'Log item'**
  String get logItem;

  /// No description provided for @deleteDish.
  ///
  /// In en, this message translates to:
  /// **'Delete this dish'**
  String get deleteDish;

  /// No description provided for @deleteModalMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action is not reversible'**
  String get deleteModalMessage;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yesDelete;

  /// No description provided for @deleteMealModalMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this meal?'**
  String get deleteMealModalMessage;

  /// Message indicating the action to remove a meal category
  ///
  /// In en, this message translates to:
  /// **'Remove this {mealCategory}'**
  String deleteMultiDateMealModalMessage(String mealCategory);

  /// No description provided for @deleteMultiDateMealModalExplain.
  ///
  /// In en, this message translates to:
  /// **'You planned this meal on multiple dates. \nIt will be removed from all days'**
  String get deleteMultiDateMealModalExplain;

  /// No description provided for @deleteMultiDateMealModalExplain2.
  ///
  /// In en, this message translates to:
  /// **'If you wan to remove it from specific days, then you can do that in the datepicker'**
  String get deleteMultiDateMealModalExplain2;

  /// No description provided for @openDatepicker.
  ///
  /// In en, this message translates to:
  /// **'Open datepicker'**
  String get openDatepicker;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @recommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendations;

  /// No description provided for @noCancel.
  ///
  /// In en, this message translates to:
  /// **'No, cancel'**
  String get noCancel;

  /// No description provided for @recentSearch.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearch;

  /// No description provided for @dishWasSaved.
  ///
  /// In en, this message translates to:
  /// **'Dish was saved'**
  String get dishWasSaved;

  /// No description provided for @foodItemWasAddedToDish.
  ///
  /// In en, this message translates to:
  /// **'Food item was added to the dish'**
  String get foodItemWasAddedToDish;

  /// No description provided for @foodItemWasDeletedFromDish.
  ///
  /// In en, this message translates to:
  /// **'Food item was removed from the dish'**
  String get foodItemWasDeletedFromDish;

  /// No description provided for @invalidDishNameMessage.
  ///
  /// In en, this message translates to:
  /// **'Give this dish a name please'**
  String get invalidDishNameMessage;

  /// No description provided for @invalidDishServingsAmountMessage.
  ///
  /// In en, this message translates to:
  /// **'Serving size can\'t be empty'**
  String get invalidDishServingsAmountMessage;

  /// No description provided for @invalidDishSelectedMealCategory.
  ///
  /// In en, this message translates to:
  /// **'At least one meal category should be selected'**
  String get invalidDishSelectedMealCategory;

  /// No description provided for @invalidDishPortionsAmountMessage.
  ///
  /// In en, this message translates to:
  /// **'Portions can\'t be empty'**
  String get invalidDishPortionsAmountMessage;

  /// No description provided for @availableIn.
  ///
  /// In en, this message translates to:
  /// **'Available in'**
  String get availableIn;

  /// No description provided for @psychology.
  ///
  /// In en, this message translates to:
  /// **'psychology'**
  String get psychology;

  /// No description provided for @medical.
  ///
  /// In en, this message translates to:
  /// **'medical'**
  String get medical;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'community'**
  String get community;

  /// No description provided for @invalidCreateDishFromMealMessage.
  ///
  /// In en, this message translates to:
  /// **'A dish cannot contain other dishes or recipes. Please remove dishes or recipes and try again'**
  String get invalidCreateDishFromMealMessage;

  /// No description provided for @readText.
  ///
  /// In en, this message translates to:
  /// **'Read text version'**
  String get readText;

  /// No description provided for @backToToday.
  ///
  /// In en, this message translates to:
  /// **'Back to today'**
  String get backToToday;

  /// No description provided for @backToEducation.
  ///
  /// In en, this message translates to:
  /// **'Back to education'**
  String get backToEducation;

  /// No description provided for @backToThePool.
  ///
  /// In en, this message translates to:
  /// **'Back to the pool'**
  String get backToThePool;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @todo.
  ///
  /// In en, this message translates to:
  /// **'Todo'**
  String get todo;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @physicalActivity.
  ///
  /// In en, this message translates to:
  /// **'Physical activity'**
  String get physicalActivity;

  /// No description provided for @selectYourProgram.
  ///
  /// In en, this message translates to:
  /// **'Select your program'**
  String get selectYourProgram;

  /// No description provided for @selectExerciseType.
  ///
  /// In en, this message translates to:
  /// **'Exercise type'**
  String get selectExerciseType;

  /// No description provided for @yourOwnActivity.
  ///
  /// In en, this message translates to:
  /// **'Your own activity'**
  String get yourOwnActivity;

  /// Message indicating the number of exercises contained
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Contains the following {count} exercise} other{Contains the following {count} exercises}}'**
  String countExercises(int count);

  /// No description provided for @strength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get strength;

  /// No description provided for @endurance.
  ///
  /// In en, this message translates to:
  /// **'Endurance'**
  String get endurance;

  /// No description provided for @mobility.
  ///
  /// In en, this message translates to:
  /// **'Mobility'**
  String get mobility;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get yourLocation;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @outdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get outdoor;

  /// No description provided for @desiredDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Desired difficulty'**
  String get desiredDifficulty;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @logActivity.
  ///
  /// In en, this message translates to:
  /// **'Log activity'**
  String get logActivity;

  /// No description provided for @whatPhysicalActivityDidYouDo.
  ///
  /// In en, this message translates to:
  /// **'What physical activity did you do?'**
  String get whatPhysicalActivityDidYouDo;

  /// No description provided for @errorActivityMessage.
  ///
  /// In en, this message translates to:
  /// **'Text activity name must be less than 30 symbols'**
  String get errorActivityMessage;

  /// No description provided for @strengthPrograms.
  ///
  /// In en, this message translates to:
  /// **'Strength programs'**
  String get strengthPrograms;

  /// No description provided for @yourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get yourProfile;

  /// No description provided for @reportAbuse.
  ///
  /// In en, this message translates to:
  /// **'Report abuse'**
  String get reportAbuse;

  /// No description provided for @inCaseOfEmergency.
  ///
  /// In en, this message translates to:
  /// **'In case of emergency'**
  String get inCaseOfEmergency;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalDetails;

  /// No description provided for @testResults.
  ///
  /// In en, this message translates to:
  /// **'Test results'**
  String get testResults;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @useFaceOrTouchId.
  ///
  /// In en, this message translates to:
  /// **'Use Face or touch ID'**
  String get useFaceOrTouchId;

  /// No description provided for @requireLoginEachTime.
  ///
  /// In en, this message translates to:
  /// **'Require login each time app is used'**
  String get requireLoginEachTime;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// No description provided for @groupSessions.
  ///
  /// In en, this message translates to:
  /// **'Support group'**
  String get groupSessions;

  /// No description provided for @foodPreferences.
  ///
  /// In en, this message translates to:
  /// **'Food preferences'**
  String get foodPreferences;

  /// No description provided for @dontEat.
  ///
  /// In en, this message translates to:
  /// **'Don\'t eat'**
  String get dontEat;

  /// No description provided for @dontLike.
  ///
  /// In en, this message translates to:
  /// **'Don\'t like'**
  String get dontLike;

  /// No description provided for @howHard.
  ///
  /// In en, this message translates to:
  /// **'How hard was this program for you?'**
  String get howHard;

  /// No description provided for @veryEasy.
  ///
  /// In en, this message translates to:
  /// **'very easy'**
  String get veryEasy;

  /// No description provided for @veryHard.
  ///
  /// In en, this message translates to:
  /// **'very hard'**
  String get veryHard;

  /// No description provided for @rotateDevice.
  ///
  /// In en, this message translates to:
  /// **'Please rotate your device and use your LeanOnMe phone stand'**
  String get rotateDevice;

  /// No description provided for @skipExplanation.
  ///
  /// In en, this message translates to:
  /// **'Skip explanation'**
  String get skipExplanation;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// Message indicating the progress of exercises completed
  ///
  /// In en, this message translates to:
  /// **'Great! You completed\nexercise {currentIndex} of {length}'**
  String exerciseCompleteMessage(String currentIndex, String length);

  /// No description provided for @activitiesForThisWeek.
  ///
  /// In en, this message translates to:
  /// **'activities for this week'**
  String get activitiesForThisWeek;

  /// No description provided for @didYouLikeThisProgram.
  ///
  /// In en, this message translates to:
  /// **'Did you like the program?'**
  String get didYouLikeThisProgram;

  /// No description provided for @backToTodayNotLogged.
  ///
  /// In en, this message translates to:
  /// **'Back to today (not logged)'**
  String get backToTodayNotLogged;

  /// No description provided for @notReally.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get notReally;

  /// No description provided for @yesYes.
  ///
  /// In en, this message translates to:
  /// **'Yes!'**
  String get yesYes;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @alternatives.
  ///
  /// In en, this message translates to:
  /// **'Alternatives'**
  String get alternatives;

  /// Information about the equipment used
  ///
  /// In en, this message translates to:
  /// **'Equipment: {equipment}'**
  String equipment(String equipment);

  /// Information about the target muscles worked
  ///
  /// In en, this message translates to:
  /// **'Target muscles: {targetMuscles}'**
  String targetMuscles(String targetMuscles);

  /// No description provided for @breakBetweenExercises.
  ///
  /// In en, this message translates to:
  /// **'short break before next exercise'**
  String get breakBetweenExercises;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'in progress'**
  String get inProgress;

  /// Prompt to log an item under a specific meal category
  ///
  /// In en, this message translates to:
  /// **'Log as {mealCategory}'**
  String logAs(String mealCategory);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @plannedMeals.
  ///
  /// In en, this message translates to:
  /// **'planned meals'**
  String get plannedMeals;

  /// No description provided for @loggedMeals.
  ///
  /// In en, this message translates to:
  /// **'logged meals'**
  String get loggedMeals;

  /// No description provided for @hey.
  ///
  /// In en, this message translates to:
  /// **'Hey'**
  String get hey;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @missed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missed;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get saved;

  /// No description provided for @notEnrolledInGroup.
  ///
  /// In en, this message translates to:
  /// **'You are currently not enrolled in a group'**
  String get notEnrolledInGroup;

  /// No description provided for @supportGroupPaidSubscriptionNotGrouped.
  ///
  /// In en, this message translates to:
  /// **'You have a paid subscription, but are currently not enrolled in a group'**
  String get supportGroupPaidSubscriptionNotGrouped;

  /// No description provided for @supportGroupTrialSubscriptionNotGrouped.
  ///
  /// In en, this message translates to:
  /// **'You are currently in your free trial period. This feature will be available with a paid subscription. Once your free trial is over, you can enrol here or in your profile'**
  String get supportGroupTrialSubscriptionNotGrouped;

  /// No description provided for @updateRequired.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get updateRequired;

  /// No description provided for @updateRequiredBodyText1.
  ///
  /// In en, this message translates to:
  /// **'To ensure a seamless experience and access to new features, It\'s essential to update to the latest version of LeanOnMe'**
  String get updateRequiredBodyText1;

  /// No description provided for @updateRequiredBodyText2.
  ///
  /// In en, this message translates to:
  /// **'The previous version is no longer supported'**
  String get updateRequiredBodyText2;

  /// No description provided for @updatePoliciesDocuments.
  ///
  /// In en, this message translates to:
  /// **'Important Update: Our Policies Have Changed'**
  String get updatePoliciesDocuments;

  /// No description provided for @updatePoliciesDocumentsBodyText1.
  ///
  /// In en, this message translates to:
  /// **'To continue using our app, please review and accept the following documents'**
  String get updatePoliciesDocumentsBodyText1;

  /// No description provided for @updatePoliciesDocumentsBodyText2.
  ///
  /// In en, this message translates to:
  /// **'If you do not agree with the new terms, you can delete your account by contacting our support at'**
  String get updatePoliciesDocumentsBodyText2;

  /// No description provided for @nextWeekTopic.
  ///
  /// In en, this message translates to:
  /// **'The topic for next week’s session will be made available soon'**
  String get nextWeekTopic;

  /// No description provided for @registrationCodePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your access code'**
  String get registrationCodePlaceholder;

  /// No description provided for @registrationCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter access code'**
  String get registrationCodeTitle;

  /// No description provided for @registrationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter the access code you received via email.'**
  String get registrationCodeLabel;

  /// No description provided for @checkAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Check code'**
  String get checkAccessCode;

  /// No description provided for @noAccessCodeYet.
  ///
  /// In en, this message translates to:
  /// **'No access code yet? '**
  String get noAccessCodeYet;

  /// No description provided for @physicalActivitiesPreferencesLabel.
  ///
  /// In en, this message translates to:
  /// **'Physical activities preferences'**
  String get physicalActivitiesPreferencesLabel;

  /// No description provided for @requestCode.
  ///
  /// In en, this message translates to:
  /// **'Request code'**
  String get requestCode;

  /// No description provided for @calorie.
  ///
  /// In en, this message translates to:
  /// **'calorie'**
  String get calorie;

  /// No description provided for @dencity.
  ///
  /// In en, this message translates to:
  /// **'dencity'**
  String get dencity;

  /// No description provided for @protein.
  ///
  /// In en, this message translates to:
  /// **'protein'**
  String get protein;

  /// No description provided for @degree.
  ///
  /// In en, this message translates to:
  /// **'degree'**
  String get degree;

  /// No description provided for @fiber.
  ///
  /// In en, this message translates to:
  /// **'fiber'**
  String get fiber;

  /// No description provided for @dailyCalorieBudget.
  ///
  /// In en, this message translates to:
  /// **'Daily calorie budget'**
  String get dailyCalorieBudget;

  /// No description provided for @dailyCalorieBudgetDescription.
  ///
  /// In en, this message translates to:
  /// **'Your daily calorie budget shows your estimated calorie intake necessary to lose weight. Importantly, the better your diets calorie density, protein score, and fiber content is, the easier it will feel to naturally eat calories within this range.'**
  String get dailyCalorieBudgetDescription;

  /// No description provided for @dailyCalorieBudgetLink.
  ///
  /// In en, this message translates to:
  /// **'What’s Missing If You Track Calories Alone.'**
  String get dailyCalorieBudgetLink;

  /// No description provided for @calorieDensityHighQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'Nice work! This is a very filling meal. The combination of items you chose will help you fight excessive hunger and cravings!'**
  String get calorieDensityHighQualityDescription;

  /// No description provided for @calorieDensityHighQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Very Filling'**
  String get calorieDensityHighQualityLabel;

  /// No description provided for @calorieDensityMidQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'The density of this meal is average. If you struggle with excessive hunger throughout the day, consider adding more low dense options!'**
  String get calorieDensityMidQualityDescription;

  /// No description provided for @calorieDensityMidQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Somewhat Filling'**
  String get calorieDensityMidQualityLabel;

  /// No description provided for @calorieDensityLowQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'The density of the meal you logged is high. A daily density at this level will make it more likely you eat in excess today.'**
  String get calorieDensityLowQualityDescription;

  /// No description provided for @calorieDensityLowQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Not Filling'**
  String get calorieDensityLowQualityLabel;

  /// No description provided for @proteinDegreeLowQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'The percentage of protein in this meal is very low. You will likely struggle with excessive hunger and cravings throughout the day. Increasing the portion of protein in this meal above 25% will improve it.'**
  String get proteinDegreeLowQualityDescription;

  /// No description provided for @proteinDegreeLowQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Needs Improvement'**
  String get proteinDegreeLowQualityLabel;

  /// No description provided for @proteinDegreeLowMidQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'The percentage of protein in this meal is slightly low. You may struggle with excessive hunger and cravings throughout the day. Increasing the portion of protein in this meal above 25% will improve it.'**
  String get proteinDegreeLowMidQualityDescription;

  /// No description provided for @proteinDegreeLowMidQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Could be better'**
  String get proteinDegreeLowMidQualityLabel;

  /// No description provided for @proteinDegreeMidQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'The percentage of protein in this meal is okay. If you struggle with excessive hunger and cravings throughout the day, increasing the portion of protein in this meal above 25% will improve it.'**
  String get proteinDegreeMidQualityDescription;

  /// No description provided for @proteinDegreeMidQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get proteinDegreeMidQualityLabel;

  /// No description provided for @proteinDegreeHighQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'Nice work! The protein content of this meal will help you fight excessive hunger and cravings throughout your day!'**
  String get proteinDegreeHighQualityDescription;

  /// No description provided for @proteinDegreeHighQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get proteinDegreeHighQualityLabel;

  /// No description provided for @fiberHighQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'High quality'**
  String get fiberHighQualityLabel;

  /// No description provided for @fiberMidQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Mixed quality'**
  String get fiberMidQualityLabel;

  /// No description provided for @fiberLowQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Low quality'**
  String get fiberLowQualityLabel;

  /// No description provided for @notSignificant.
  ///
  /// In en, this message translates to:
  /// **'Not significant'**
  String get notSignificant;

  /// No description provided for @insignificant.
  ///
  /// In en, this message translates to:
  /// **'Insignificant'**
  String get insignificant;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @pool.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get pool;

  /// No description provided for @mindDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Mind training'**
  String get mindDashboardTitle;

  /// No description provided for @mindDashboardBtn.
  ///
  /// In en, this message translates to:
  /// **'Choose exercise'**
  String get mindDashboardBtn;

  /// No description provided for @maintenanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenanceLabel;

  /// No description provided for @maintenancePageTitle.
  ///
  /// In en, this message translates to:
  /// **'We’ll be back soon!'**
  String get maintenancePageTitle;

  /// No description provided for @maintenancePageDescription.
  ///
  /// In en, this message translates to:
  /// **'We’re currently releasing exciting new content, if you’ve opted in, you’ll receive a push notification when we’re back online.\n\nSubscribe to our newsletter to get a sneak peak at what’s coming up!'**
  String get maintenancePageDescription;

  /// No description provided for @noAlternativesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No alternatives available'**
  String get noAlternativesAvailable;

  /// No description provided for @chooseAlternative.
  ///
  /// In en, this message translates to:
  /// **'Choose alternative'**
  String get chooseAlternative;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
