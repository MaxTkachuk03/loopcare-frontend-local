import 'dart:convert';

import 'app_localizations.dart';

import 'package:crowdin_sdk/crowdin_sdk.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CrowdinLocalization extends AppLocalizations {
  final AppLocalizations _fallbackTexts;
  
  CrowdinLocalization(String locale, AppLocalizations fallbackTexts) : _fallbackTexts = fallbackTexts, super(locale);

  static const LocalizationsDelegate<AppLocalizations> delegate = _CrowdinLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <
      LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = AppLocalizations.supportedLocales;
 
	@override
  String get errorValidationIosMinVersionNotANumber => Crowdin.getText(localeName, 'errorValidationIosMinVersionNotANumber') ?? _fallbackTexts.errorValidationIosMinVersionNotANumber;

	@override
  String get errorValidationIosMinVersionNotAnInteger => Crowdin.getText(localeName, 'errorValidationIosMinVersionNotAnInteger') ?? _fallbackTexts.errorValidationIosMinVersionNotAnInteger;

	@override
  String get errorValidationIosMinVersionNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationIosMinVersionNotAPositiveNumber') ?? _fallbackTexts.errorValidationIosMinVersionNotAPositiveNumber;

	@override
  String get errorValidationAndroidMinVersionNotANumber => Crowdin.getText(localeName, 'errorValidationAndroidMinVersionNotANumber') ?? _fallbackTexts.errorValidationAndroidMinVersionNotANumber;

	@override
  String get errorValidationAndroidMinVersionNotAnInteger => Crowdin.getText(localeName, 'errorValidationAndroidMinVersionNotAnInteger') ?? _fallbackTexts.errorValidationAndroidMinVersionNotAnInteger;

	@override
  String get errorValidationAndroidMinVersionNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationAndroidMinVersionNotAPositiveNumber') ?? _fallbackTexts.errorValidationAndroidMinVersionNotAPositiveNumber;

	@override
  String get errorValidationTermsAndConditionsVersionNotANumber => Crowdin.getText(localeName, 'errorValidationTermsAndConditionsVersionNotANumber') ?? _fallbackTexts.errorValidationTermsAndConditionsVersionNotANumber;

	@override
  String get errorValidationTermsAndConditionsVersionNotAnInteger => Crowdin.getText(localeName, 'errorValidationTermsAndConditionsVersionNotAnInteger') ?? _fallbackTexts.errorValidationTermsAndConditionsVersionNotAnInteger;

	@override
  String get errorValidationTermsAndConditionsVersionNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationTermsAndConditionsVersionNotAPositiveNumber') ?? _fallbackTexts.errorValidationTermsAndConditionsVersionNotAPositiveNumber;

	@override
  String get errorValidationPrivacyPolicyVersionNotANumber => Crowdin.getText(localeName, 'errorValidationPrivacyPolicyVersionNotANumber') ?? _fallbackTexts.errorValidationPrivacyPolicyVersionNotANumber;

	@override
  String get errorValidationPrivacyPolicyVersionNotAnInteger => Crowdin.getText(localeName, 'errorValidationPrivacyPolicyVersionNotAnInteger') ?? _fallbackTexts.errorValidationPrivacyPolicyVersionNotAnInteger;

	@override
  String get errorValidationPrivacyPolicyVersionNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationPrivacyPolicyVersionNotAPositiveNumber') ?? _fallbackTexts.errorValidationPrivacyPolicyVersionNotAPositiveNumber;

	@override
  String get errorValidationRefreshTokenNotAJwt => Crowdin.getText(localeName, 'errorValidationRefreshTokenNotAJwt') ?? _fallbackTexts.errorValidationRefreshTokenNotAJwt;

	@override
  String get errorValidationVersionEmpty => Crowdin.getText(localeName, 'errorValidationVersionEmpty') ?? _fallbackTexts.errorValidationVersionEmpty;

	@override
  String get errorValidationVersionNotAString => Crowdin.getText(localeName, 'errorValidationVersionNotAString') ?? _fallbackTexts.errorValidationVersionNotAString;

	@override
  String get errorValidationNotificationTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationNotificationTypeInvalidEnum') ?? _fallbackTexts.errorValidationNotificationTypeInvalidEnum;

	@override
  String get errorValidationPurchaseTokenEmpty => Crowdin.getText(localeName, 'errorValidationPurchaseTokenEmpty') ?? _fallbackTexts.errorValidationPurchaseTokenEmpty;

	@override
  String get errorValidationPurchaseTokenNotAString => Crowdin.getText(localeName, 'errorValidationPurchaseTokenNotAString') ?? _fallbackTexts.errorValidationPurchaseTokenNotAString;

	@override
  String get errorValidationSubscriptionIdEmpty => Crowdin.getText(localeName, 'errorValidationSubscriptionIdEmpty') ?? _fallbackTexts.errorValidationSubscriptionIdEmpty;

	@override
  String get errorValidationSubscriptionIdNotAString => Crowdin.getText(localeName, 'errorValidationSubscriptionIdNotAString') ?? _fallbackTexts.errorValidationSubscriptionIdNotAString;

	@override
  String get errorValidationPackageNameEmpty => Crowdin.getText(localeName, 'errorValidationPackageNameEmpty') ?? _fallbackTexts.errorValidationPackageNameEmpty;

	@override
  String get errorValidationPackageNameNotAString => Crowdin.getText(localeName, 'errorValidationPackageNameNotAString') ?? _fallbackTexts.errorValidationPackageNameNotAString;

	@override
  String get errorValidationEventTimeMillisNotANumberString => Crowdin.getText(localeName, 'errorValidationEventTimeMillisNotANumberString') ?? _fallbackTexts.errorValidationEventTimeMillisNotANumberString;

	@override
  String get errorValidationSubscriptionNotificationEmptyObject => Crowdin.getText(localeName, 'errorValidationSubscriptionNotificationEmptyObject') ?? _fallbackTexts.errorValidationSubscriptionNotificationEmptyObject;

	@override
  String get errorValidationFilenameStringTooShort => Crowdin.getText(localeName, 'errorValidationFilenameStringTooShort') ?? _fallbackTexts.errorValidationFilenameStringTooShort;

	@override
  String get errorValidationFilenameNotAString => Crowdin.getText(localeName, 'errorValidationFilenameNotAString') ?? _fallbackTexts.errorValidationFilenameNotAString;

	@override
  String get errorValidationFilenameEmpty => Crowdin.getText(localeName, 'errorValidationFilenameEmpty') ?? _fallbackTexts.errorValidationFilenameEmpty;

	@override
  String get errorValidationMimetypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationMimetypeInvalidEnum') ?? _fallbackTexts.errorValidationMimetypeInvalidEnum;

	@override
  String get errorValidationMimetypeNotAString => Crowdin.getText(localeName, 'errorValidationMimetypeNotAString') ?? _fallbackTexts.errorValidationMimetypeNotAString;

	@override
  String get errorValidationMimetypeEmpty => Crowdin.getText(localeName, 'errorValidationMimetypeEmpty') ?? _fallbackTexts.errorValidationMimetypeEmpty;

	@override
  String get errorValidationFieldnameInvalidEnum => Crowdin.getText(localeName, 'errorValidationFieldnameInvalidEnum') ?? _fallbackTexts.errorValidationFieldnameInvalidEnum;

	@override
  String get errorValidationFieldnameEmpty => Crowdin.getText(localeName, 'errorValidationFieldnameEmpty') ?? _fallbackTexts.errorValidationFieldnameEmpty;

	@override
  String get errorValidationFieldnameNotAString => Crowdin.getText(localeName, 'errorValidationFieldnameNotAString') ?? _fallbackTexts.errorValidationFieldnameNotAString;

	@override
  String get errorValidationPasswordPasswordTooWeak => Crowdin.getText(localeName, 'errorValidationPasswordPasswordTooWeak') ?? _fallbackTexts.errorValidationPasswordPasswordTooWeak;

	@override
  String get errorValidationPasswordEmpty => Crowdin.getText(localeName, 'errorValidationPasswordEmpty') ?? _fallbackTexts.errorValidationPasswordEmpty;

	@override
  String get errorValidationPasswordNotAString => Crowdin.getText(localeName, 'errorValidationPasswordNotAString') ?? _fallbackTexts.errorValidationPasswordNotAString;

	@override
  String get errorValidationEmailStringTooLong => Crowdin.getText(localeName, 'errorValidationEmailStringTooLong') ?? _fallbackTexts.errorValidationEmailStringTooLong;

	@override
  String get errorValidationEmailStringTooShort => Crowdin.getText(localeName, 'errorValidationEmailStringTooShort') ?? _fallbackTexts.errorValidationEmailStringTooShort;

	@override
  String get errorValidationEmailInvalidEmail => Crowdin.getText(localeName, 'errorValidationEmailInvalidEmail') ?? _fallbackTexts.errorValidationEmailInvalidEmail;

	@override
  String get errorValidationEmailNotAString => Crowdin.getText(localeName, 'errorValidationEmailNotAString') ?? _fallbackTexts.errorValidationEmailNotAString;

	@override
  String get errorValidationNameStringTooLong => Crowdin.getText(localeName, 'errorValidationNameStringTooLong') ?? _fallbackTexts.errorValidationNameStringTooLong;

	@override
  String get errorValidationNameStringTooShort => Crowdin.getText(localeName, 'errorValidationNameStringTooShort') ?? _fallbackTexts.errorValidationNameStringTooShort;

	@override
  String get errorValidationNameEmpty => Crowdin.getText(localeName, 'errorValidationNameEmpty') ?? _fallbackTexts.errorValidationNameEmpty;

	@override
  String get errorValidationNameNotAString => Crowdin.getText(localeName, 'errorValidationNameNotAString') ?? _fallbackTexts.errorValidationNameNotAString;

	@override
  String get errorValidationInvitationTokenEmpty => Crowdin.getText(localeName, 'errorValidationInvitationTokenEmpty') ?? _fallbackTexts.errorValidationInvitationTokenEmpty;

	@override
  String get errorValidationInvitationTokenNotAString => Crowdin.getText(localeName, 'errorValidationInvitationTokenNotAString') ?? _fallbackTexts.errorValidationInvitationTokenNotAString;

	@override
  String get errorValidationInvitationTokenNotAJwt => Crowdin.getText(localeName, 'errorValidationInvitationTokenNotAJwt') ?? _fallbackTexts.errorValidationInvitationTokenNotAJwt;

	@override
  String get errorValidationNumberOfUnitsEmpty => Crowdin.getText(localeName, 'errorValidationNumberOfUnitsEmpty') ?? _fallbackTexts.errorValidationNumberOfUnitsEmpty;

	@override
  String get errorValidationNumberOfUnitsNotANumber => Crowdin.getText(localeName, 'errorValidationNumberOfUnitsNotANumber') ?? _fallbackTexts.errorValidationNumberOfUnitsNotANumber;

	@override
  String get errorValidationNumberOfUnitsNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationNumberOfUnitsNotAPositiveNumber') ?? _fallbackTexts.errorValidationNumberOfUnitsNotAPositiveNumber;

	@override
  String get errorValidationNumberOfUnitsNumberTooBig => Crowdin.getText(localeName, 'errorValidationNumberOfUnitsNumberTooBig') ?? _fallbackTexts.errorValidationNumberOfUnitsNumberTooBig;

	@override
  String get errorValidationNumberOfUnitsNumberTooSmall => Crowdin.getText(localeName, 'errorValidationNumberOfUnitsNumberTooSmall') ?? _fallbackTexts.errorValidationNumberOfUnitsNumberTooSmall;

	@override
  String get errorValidationFoodItemIdEmpty => Crowdin.getText(localeName, 'errorValidationFoodItemIdEmpty') ?? _fallbackTexts.errorValidationFoodItemIdEmpty;

	@override
  String get errorValidationFoodItemIdNotANumberString => Crowdin.getText(localeName, 'errorValidationFoodItemIdNotANumberString') ?? _fallbackTexts.errorValidationFoodItemIdNotANumberString;

	@override
  String get errorValidationServingIdEmpty => Crowdin.getText(localeName, 'errorValidationServingIdEmpty') ?? _fallbackTexts.errorValidationServingIdEmpty;

	@override
  String get errorValidationServingIdNotANumberString => Crowdin.getText(localeName, 'errorValidationServingIdNotANumberString') ?? _fallbackTexts.errorValidationServingIdNotANumberString;

	@override
  String get errorValidationMealCategoriesEmpty => Crowdin.getText(localeName, 'errorValidationMealCategoriesEmpty') ?? _fallbackTexts.errorValidationMealCategoriesEmpty;

	@override
  String get errorValidationMealCategoriesNotAnArray => Crowdin.getText(localeName, 'errorValidationMealCategoriesNotAnArray') ?? _fallbackTexts.errorValidationMealCategoriesNotAnArray;

	@override
  String get errorValidationMealCategoriesEmptyArray => Crowdin.getText(localeName, 'errorValidationMealCategoriesEmptyArray') ?? _fallbackTexts.errorValidationMealCategoriesEmptyArray;

	@override
  String get errorValidationMealCategoriesInvalidEnum => Crowdin.getText(localeName, 'errorValidationMealCategoriesInvalidEnum') ?? _fallbackTexts.errorValidationMealCategoriesInvalidEnum;

	@override
  String get errorValidationNicknameEmpty => Crowdin.getText(localeName, 'errorValidationNicknameEmpty') ?? _fallbackTexts.errorValidationNicknameEmpty;

	@override
  String get errorValidationNicknameNotAString => Crowdin.getText(localeName, 'errorValidationNicknameNotAString') ?? _fallbackTexts.errorValidationNicknameNotAString;

	@override
  String get errorValidationNicknameStringTooLong => Crowdin.getText(localeName, 'errorValidationNicknameStringTooLong') ?? _fallbackTexts.errorValidationNicknameStringTooLong;

	@override
  String get errorValidationNicknameStringTooShort => Crowdin.getText(localeName, 'errorValidationNicknameStringTooShort') ?? _fallbackTexts.errorValidationNicknameStringTooShort;

	@override
  String get errorValidationGenderPreferenceEmpty => Crowdin.getText(localeName, 'errorValidationGenderPreferenceEmpty') ?? _fallbackTexts.errorValidationGenderPreferenceEmpty;

	@override
  String get errorValidationGenderPreferenceInvalidEnum => Crowdin.getText(localeName, 'errorValidationGenderPreferenceInvalidEnum') ?? _fallbackTexts.errorValidationGenderPreferenceInvalidEnum;

	@override
  String get errorValidationTimezoneEmpty => Crowdin.getText(localeName, 'errorValidationTimezoneEmpty') ?? _fallbackTexts.errorValidationTimezoneEmpty;

	@override
  String get errorValidationTimezoneNotAString => Crowdin.getText(localeName, 'errorValidationTimezoneNotAString') ?? _fallbackTexts.errorValidationTimezoneNotAString;

	@override
  String get errorValidationRulesAcceptedNotABoolean => Crowdin.getText(localeName, 'errorValidationRulesAcceptedNotABoolean') ?? _fallbackTexts.errorValidationRulesAcceptedNotABoolean;

	@override
  String get errorValidationMealIdEmpty => Crowdin.getText(localeName, 'errorValidationMealIdEmpty') ?? _fallbackTexts.errorValidationMealIdEmpty;

	@override
  String get errorValidationMealIdNotANumber => Crowdin.getText(localeName, 'errorValidationMealIdNotANumber') ?? _fallbackTexts.errorValidationMealIdNotANumber;

	@override
  String get errorValidationMealIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationMealIdNotAnInteger') ?? _fallbackTexts.errorValidationMealIdNotAnInteger;

	@override
  String get errorValidationMealIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationMealIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationMealIdNotAPositiveNumber;

	@override
  String get errorValidationMealRecipeIdEmpty => Crowdin.getText(localeName, 'errorValidationMealRecipeIdEmpty') ?? _fallbackTexts.errorValidationMealRecipeIdEmpty;

	@override
  String get errorValidationMealRecipeIdNotANumber => Crowdin.getText(localeName, 'errorValidationMealRecipeIdNotANumber') ?? _fallbackTexts.errorValidationMealRecipeIdNotANumber;

	@override
  String get errorValidationMealRecipeIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationMealRecipeIdNotAnInteger') ?? _fallbackTexts.errorValidationMealRecipeIdNotAnInteger;

	@override
  String get errorValidationMealRecipeIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationMealRecipeIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationMealRecipeIdNotAPositiveNumber;

	@override
  String get errorValidationTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationTypeInvalidEnum') ?? _fallbackTexts.errorValidationTypeInvalidEnum;

	@override
  String get errorValidationMealCategoryInvalidEnum => Crowdin.getText(localeName, 'errorValidationMealCategoryInvalidEnum') ?? _fallbackTexts.errorValidationMealCategoryInvalidEnum;

	@override
  String get errorValidationStartDateNotAString => Crowdin.getText(localeName, 'errorValidationStartDateNotAString') ?? _fallbackTexts.errorValidationStartDateNotAString;

	@override
  String get errorValidationStartDateNotADateString => Crowdin.getText(localeName, 'errorValidationStartDateNotADateString') ?? _fallbackTexts.errorValidationStartDateNotADateString;

	@override
  String get errorValidationEndDateNotAString => Crowdin.getText(localeName, 'errorValidationEndDateNotAString') ?? _fallbackTexts.errorValidationEndDateNotAString;

	@override
  String get errorValidationEndDateNotADateString => Crowdin.getText(localeName, 'errorValidationEndDateNotADateString') ?? _fallbackTexts.errorValidationEndDateNotADateString;

	@override
  String get errorValidationPregnantEmpty => Crowdin.getText(localeName, 'errorValidationPregnantEmpty') ?? _fallbackTexts.errorValidationPregnantEmpty;

	@override
  String get errorValidationPregnantNotABoolean => Crowdin.getText(localeName, 'errorValidationPregnantNotABoolean') ?? _fallbackTexts.errorValidationPregnantNotABoolean;

	@override
  String get errorValidationMedicinesNotAnArray => Crowdin.getText(localeName, 'errorValidationMedicinesNotAnArray') ?? _fallbackTexts.errorValidationMedicinesNotAnArray;

	@override
  String get errorValidationMedicinesEmptyArray => Crowdin.getText(localeName, 'errorValidationMedicinesEmptyArray') ?? _fallbackTexts.errorValidationMedicinesEmptyArray;

	@override
  String get errorValidationUseSemaglutideMedicationNotAString => Crowdin.getText(localeName, 'errorValidationUseSemaglutideMedicationNotAString') ?? _fallbackTexts.errorValidationUseSemaglutideMedicationNotAString;

	@override
  String get errorValidationHowLongTakeSemaglutideMedicationNotAString => Crowdin.getText(localeName, 'errorValidationHowLongTakeSemaglutideMedicationNotAString') ?? _fallbackTexts.errorValidationHowLongTakeSemaglutideMedicationNotAString;

	@override
  String get errorValidationHowLongSemaglutideTreatmentLastNotAString => Crowdin.getText(localeName, 'errorValidationHowLongSemaglutideTreatmentLastNotAString') ?? _fallbackTexts.errorValidationHowLongSemaglutideTreatmentLastNotAString;

	@override
  String get errorValidationIsUseSemaglutideMedicationNotABoolean => Crowdin.getText(localeName, 'errorValidationIsUseSemaglutideMedicationNotABoolean') ?? _fallbackTexts.errorValidationIsUseSemaglutideMedicationNotABoolean;

	@override
  String get errorValidationObesityNotABoolean => Crowdin.getText(localeName, 'errorValidationObesityNotABoolean') ?? _fallbackTexts.errorValidationObesityNotABoolean;

	@override
  String get errorValidationObesityEmpty => Crowdin.getText(localeName, 'errorValidationObesityEmpty') ?? _fallbackTexts.errorValidationObesityEmpty;

	@override
  String get errorValidationThyroidDiseaseEmpty => Crowdin.getText(localeName, 'errorValidationThyroidDiseaseEmpty') ?? _fallbackTexts.errorValidationThyroidDiseaseEmpty;

	@override
  String get errorValidationThyroidDiseaseNotABoolean => Crowdin.getText(localeName, 'errorValidationThyroidDiseaseNotABoolean') ?? _fallbackTexts.errorValidationThyroidDiseaseNotABoolean;

	@override
  String get errorValidationMetabolicDiseaseEmpty => Crowdin.getText(localeName, 'errorValidationMetabolicDiseaseEmpty') ?? _fallbackTexts.errorValidationMetabolicDiseaseEmpty;

	@override
  String get errorValidationMetabolicDiseaseNotABoolean => Crowdin.getText(localeName, 'errorValidationMetabolicDiseaseNotABoolean') ?? _fallbackTexts.errorValidationMetabolicDiseaseNotABoolean;

	@override
  String get errorValidationHypertensionEmpty => Crowdin.getText(localeName, 'errorValidationHypertensionEmpty') ?? _fallbackTexts.errorValidationHypertensionEmpty;

	@override
  String get errorValidationHypertensionNotABoolean => Crowdin.getText(localeName, 'errorValidationHypertensionNotABoolean') ?? _fallbackTexts.errorValidationHypertensionNotABoolean;

	@override
  String get errorValidationCardiovascularDiseaseEmpty => Crowdin.getText(localeName, 'errorValidationCardiovascularDiseaseEmpty') ?? _fallbackTexts.errorValidationCardiovascularDiseaseEmpty;

	@override
  String get errorValidationCardiovascularDiseaseNotABoolean => Crowdin.getText(localeName, 'errorValidationCardiovascularDiseaseNotABoolean') ?? _fallbackTexts.errorValidationCardiovascularDiseaseNotABoolean;

	@override
  String get errorValidationStomachReductionEmpty => Crowdin.getText(localeName, 'errorValidationStomachReductionEmpty') ?? _fallbackTexts.errorValidationStomachReductionEmpty;

	@override
  String get errorValidationStomachReductionNotABoolean => Crowdin.getText(localeName, 'errorValidationStomachReductionNotABoolean') ?? _fallbackTexts.errorValidationStomachReductionNotABoolean;

	@override
  String get errorValidationDiabetesEmpty => Crowdin.getText(localeName, 'errorValidationDiabetesEmpty') ?? _fallbackTexts.errorValidationDiabetesEmpty;

	@override
  String get errorValidationDiabetesNotAString => Crowdin.getText(localeName, 'errorValidationDiabetesNotAString') ?? _fallbackTexts.errorValidationDiabetesNotAString;

	@override
  String get errorValidationRenalFailureEmpty => Crowdin.getText(localeName, 'errorValidationRenalFailureEmpty') ?? _fallbackTexts.errorValidationRenalFailureEmpty;

	@override
  String get errorValidationRenalFailureNotABoolean => Crowdin.getText(localeName, 'errorValidationRenalFailureNotABoolean') ?? _fallbackTexts.errorValidationRenalFailureNotABoolean;

	@override
  String get errorValidationAsthmaEmpty => Crowdin.getText(localeName, 'errorValidationAsthmaEmpty') ?? _fallbackTexts.errorValidationAsthmaEmpty;

	@override
  String get errorValidationAsthmaNotABoolean => Crowdin.getText(localeName, 'errorValidationAsthmaNotABoolean') ?? _fallbackTexts.errorValidationAsthmaNotABoolean;

	@override
  String get errorValidationLiverDiseaseEmpty => Crowdin.getText(localeName, 'errorValidationLiverDiseaseEmpty') ?? _fallbackTexts.errorValidationLiverDiseaseEmpty;

	@override
  String get errorValidationLiverDiseaseNotABoolean => Crowdin.getText(localeName, 'errorValidationLiverDiseaseNotABoolean') ?? _fallbackTexts.errorValidationLiverDiseaseNotABoolean;

	@override
  String get errorValidationSleepApneaSyndromeEmpty => Crowdin.getText(localeName, 'errorValidationSleepApneaSyndromeEmpty') ?? _fallbackTexts.errorValidationSleepApneaSyndromeEmpty;

	@override
  String get errorValidationSleepApneaSyndromeNotABoolean => Crowdin.getText(localeName, 'errorValidationSleepApneaSyndromeNotABoolean') ?? _fallbackTexts.errorValidationSleepApneaSyndromeNotABoolean;

	@override
  String get errorValidationLocomotorSystemDiseaseEmpty => Crowdin.getText(localeName, 'errorValidationLocomotorSystemDiseaseEmpty') ?? _fallbackTexts.errorValidationLocomotorSystemDiseaseEmpty;

	@override
  String get errorValidationLocomotorSystemDiseaseNotABoolean => Crowdin.getText(localeName, 'errorValidationLocomotorSystemDiseaseNotABoolean') ?? _fallbackTexts.errorValidationLocomotorSystemDiseaseNotABoolean;

	@override
  String get errorValidationTreatedByPsychiatristEmpty => Crowdin.getText(localeName, 'errorValidationTreatedByPsychiatristEmpty') ?? _fallbackTexts.errorValidationTreatedByPsychiatristEmpty;

	@override
  String get errorValidationTreatedByPsychiatristNotABoolean => Crowdin.getText(localeName, 'errorValidationTreatedByPsychiatristNotABoolean') ?? _fallbackTexts.errorValidationTreatedByPsychiatristNotABoolean;

	@override
  String get errorValidationItemStateNotFromDefinedList => Crowdin.getText(localeName, 'errorValidationItemStateNotFromDefinedList') ?? _fallbackTexts.errorValidationItemStateNotFromDefinedList;

	@override
  String get errorValidationItemStateNotAString => Crowdin.getText(localeName, 'errorValidationItemStateNotAString') ?? _fallbackTexts.errorValidationItemStateNotAString;

	@override
  String get errorValidationHatesEmpty => Crowdin.getText(localeName, 'errorValidationHatesEmpty') ?? _fallbackTexts.errorValidationHatesEmpty;

	@override
  String get errorValidationHatesNotAnArray => Crowdin.getText(localeName, 'errorValidationHatesNotAnArray') ?? _fallbackTexts.errorValidationHatesNotAnArray;

	@override
  String get errorValidationHatesNotANumber => Crowdin.getText(localeName, 'errorValidationHatesNotANumber') ?? _fallbackTexts.errorValidationHatesNotANumber;

	@override
  String get errorValidationHatesNotAnInteger => Crowdin.getText(localeName, 'errorValidationHatesNotAnInteger') ?? _fallbackTexts.errorValidationHatesNotAnInteger;

	@override
  String get errorValidationHatesNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationHatesNotAPositiveNumber') ?? _fallbackTexts.errorValidationHatesNotAPositiveNumber;

	@override
  String get errorValidationAllergicEmpty => Crowdin.getText(localeName, 'errorValidationAllergicEmpty') ?? _fallbackTexts.errorValidationAllergicEmpty;

	@override
  String get errorValidationAllergicNotAnArray => Crowdin.getText(localeName, 'errorValidationAllergicNotAnArray') ?? _fallbackTexts.errorValidationAllergicNotAnArray;

	@override
  String get errorValidationAllergicNotANumber => Crowdin.getText(localeName, 'errorValidationAllergicNotANumber') ?? _fallbackTexts.errorValidationAllergicNotANumber;

	@override
  String get errorValidationAllergicNotAnInteger => Crowdin.getText(localeName, 'errorValidationAllergicNotAnInteger') ?? _fallbackTexts.errorValidationAllergicNotAnInteger;

	@override
  String get errorValidationAllergicNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationAllergicNotAPositiveNumber') ?? _fallbackTexts.errorValidationAllergicNotAPositiveNumber;

	@override
  String get errorValidationDislikeEmpty => Crowdin.getText(localeName, 'errorValidationDislikeEmpty') ?? _fallbackTexts.errorValidationDislikeEmpty;

	@override
  String get errorValidationDislikeNotAnArray => Crowdin.getText(localeName, 'errorValidationDislikeNotAnArray') ?? _fallbackTexts.errorValidationDislikeNotAnArray;

	@override
  String get errorValidationDislikeNotANumber => Crowdin.getText(localeName, 'errorValidationDislikeNotANumber') ?? _fallbackTexts.errorValidationDislikeNotANumber;

	@override
  String get errorValidationDislikeNotAnInteger => Crowdin.getText(localeName, 'errorValidationDislikeNotAnInteger') ?? _fallbackTexts.errorValidationDislikeNotAnInteger;

	@override
  String get errorValidationDislikeNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationDislikeNotAPositiveNumber') ?? _fallbackTexts.errorValidationDislikeNotAPositiveNumber;

	@override
  String get errorValidationQuestionIdEmpty => Crowdin.getText(localeName, 'errorValidationQuestionIdEmpty') ?? _fallbackTexts.errorValidationQuestionIdEmpty;

	@override
  String get errorValidationQuestionIdNotANumber => Crowdin.getText(localeName, 'errorValidationQuestionIdNotANumber') ?? _fallbackTexts.errorValidationQuestionIdNotANumber;

	@override
  String get errorValidationQuestionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationQuestionIdNotAnInteger') ?? _fallbackTexts.errorValidationQuestionIdNotAnInteger;

	@override
  String get errorValidationQuestionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationQuestionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationQuestionIdNotAPositiveNumber;

	@override
  String get errorValidationOptionIdEmpty => Crowdin.getText(localeName, 'errorValidationOptionIdEmpty') ?? _fallbackTexts.errorValidationOptionIdEmpty;

	@override
  String get errorValidationOptionIdNotANumber => Crowdin.getText(localeName, 'errorValidationOptionIdNotANumber') ?? _fallbackTexts.errorValidationOptionIdNotANumber;

	@override
  String get errorValidationOptionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationOptionIdNotAnInteger') ?? _fallbackTexts.errorValidationOptionIdNotAnInteger;

	@override
  String get errorValidationOptionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationOptionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationOptionIdNotAPositiveNumber;

	@override
  String get errorValidationAnswersEmpty => Crowdin.getText(localeName, 'errorValidationAnswersEmpty') ?? _fallbackTexts.errorValidationAnswersEmpty;

	@override
  String get errorValidationAnswersNotAnArray => Crowdin.getText(localeName, 'errorValidationAnswersNotAnArray') ?? _fallbackTexts.errorValidationAnswersNotAnArray;

	@override
  String get errorValidationAnswersEmptyArray => Crowdin.getText(localeName, 'errorValidationAnswersEmptyArray') ?? _fallbackTexts.errorValidationAnswersEmptyArray;

	@override
  String get errorValidationIsConsentApprovedEmpty => Crowdin.getText(localeName, 'errorValidationIsConsentApprovedEmpty') ?? _fallbackTexts.errorValidationIsConsentApprovedEmpty;

	@override
  String get errorValidationIsConsentApprovedNotABoolean => Crowdin.getText(localeName, 'errorValidationIsConsentApprovedNotABoolean') ?? _fallbackTexts.errorValidationIsConsentApprovedNotABoolean;

	@override
  String get errorValidationIsLegalApprovedEmpty => Crowdin.getText(localeName, 'errorValidationIsLegalApprovedEmpty') ?? _fallbackTexts.errorValidationIsLegalApprovedEmpty;

	@override
  String get errorValidationIsLegalApprovedNotABoolean => Crowdin.getText(localeName, 'errorValidationIsLegalApprovedNotABoolean') ?? _fallbackTexts.errorValidationIsLegalApprovedNotABoolean;

	@override
  String get errorValidationHeightEmpty => Crowdin.getText(localeName, 'errorValidationHeightEmpty') ?? _fallbackTexts.errorValidationHeightEmpty;

	@override
  String get errorValidationHeightNotANumber => Crowdin.getText(localeName, 'errorValidationHeightNotANumber') ?? _fallbackTexts.errorValidationHeightNotANumber;

	@override
  String get errorValidationHeightNumberTooBig => Crowdin.getText(localeName, 'errorValidationHeightNumberTooBig') ?? _fallbackTexts.errorValidationHeightNumberTooBig;

	@override
  String get errorValidationHeightNumberTooSmall => Crowdin.getText(localeName, 'errorValidationHeightNumberTooSmall') ?? _fallbackTexts.errorValidationHeightNumberTooSmall;

	@override
  String get errorValidationBirthDateEmpty => Crowdin.getText(localeName, 'errorValidationBirthDateEmpty') ?? _fallbackTexts.errorValidationBirthDateEmpty;

	@override
  String get errorValidationBirthDateNotADateString => Crowdin.getText(localeName, 'errorValidationBirthDateNotADateString') ?? _fallbackTexts.errorValidationBirthDateNotADateString;

	@override
  String get errorValidationWeightEmpty => Crowdin.getText(localeName, 'errorValidationWeightEmpty') ?? _fallbackTexts.errorValidationWeightEmpty;

	@override
  String get errorValidationWeightNotANumber => Crowdin.getText(localeName, 'errorValidationWeightNotANumber') ?? _fallbackTexts.errorValidationWeightNotANumber;

	@override
  String get errorValidationWeightNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationWeightNotAPositiveNumber') ?? _fallbackTexts.errorValidationWeightNotAPositiveNumber;

	@override
  String get errorValidationBmiEmpty => Crowdin.getText(localeName, 'errorValidationBmiEmpty') ?? _fallbackTexts.errorValidationBmiEmpty;

	@override
  String get errorValidationBmiNotANumber => Crowdin.getText(localeName, 'errorValidationBmiNotANumber') ?? _fallbackTexts.errorValidationBmiNotANumber;

	@override
  String get errorValidationBmiNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationBmiNotAPositiveNumber') ?? _fallbackTexts.errorValidationBmiNotAPositiveNumber;

	@override
  String get errorValidationGenderEmpty => Crowdin.getText(localeName, 'errorValidationGenderEmpty') ?? _fallbackTexts.errorValidationGenderEmpty;

	@override
  String get errorValidationGenderNotAString => Crowdin.getText(localeName, 'errorValidationGenderNotAString') ?? _fallbackTexts.errorValidationGenderNotAString;

	@override
  String get errorValidationGenderInvalidEnum => Crowdin.getText(localeName, 'errorValidationGenderInvalidEnum') ?? _fallbackTexts.errorValidationGenderInvalidEnum;

	@override
  String get errorValidationSexEmpty => Crowdin.getText(localeName, 'errorValidationSexEmpty') ?? _fallbackTexts.errorValidationSexEmpty;

	@override
  String get errorValidationSexNotAString => Crowdin.getText(localeName, 'errorValidationSexNotAString') ?? _fallbackTexts.errorValidationSexNotAString;

	@override
  String get errorValidationSexInvalidEnum => Crowdin.getText(localeName, 'errorValidationSexInvalidEnum') ?? _fallbackTexts.errorValidationSexInvalidEnum;

	@override
  String get errorValidationHappinessEmpty => Crowdin.getText(localeName, 'errorValidationHappinessEmpty') ?? _fallbackTexts.errorValidationHappinessEmpty;

	@override
  String get errorValidationHappinessInvalidEnum => Crowdin.getText(localeName, 'errorValidationHappinessInvalidEnum') ?? _fallbackTexts.errorValidationHappinessInvalidEnum;

	@override
  String get errorValidationMentalHealthTestEmptyObject => Crowdin.getText(localeName, 'errorValidationMentalHealthTestEmptyObject') ?? _fallbackTexts.errorValidationMentalHealthTestEmptyObject;

	@override
  String get errorValidationMedicalOnboardingEmptyObject => Crowdin.getText(localeName, 'errorValidationMedicalOnboardingEmptyObject') ?? _fallbackTexts.errorValidationMedicalOnboardingEmptyObject;

	@override
  String get errorValidationCustomerIoIdEmpty => Crowdin.getText(localeName, 'errorValidationCustomerIoIdEmpty') ?? _fallbackTexts.errorValidationCustomerIoIdEmpty;

	@override
  String get errorValidationCustomerIoIdNotAString => Crowdin.getText(localeName, 'errorValidationCustomerIoIdNotAString') ?? _fallbackTexts.errorValidationCustomerIoIdNotAString;

	@override
  String get errorValidationNameLettersAndNumbersRequired => Crowdin.getText(localeName, 'errorValidationNameLettersAndNumbersRequired') ?? _fallbackTexts.errorValidationNameLettersAndNumbersRequired;

	@override
  String get errorValidationBucketStringTooShort => Crowdin.getText(localeName, 'errorValidationBucketStringTooShort') ?? _fallbackTexts.errorValidationBucketStringTooShort;

	@override
  String get errorValidationBucketLettersAndNumbersRequired => Crowdin.getText(localeName, 'errorValidationBucketLettersAndNumbersRequired') ?? _fallbackTexts.errorValidationBucketLettersAndNumbersRequired;

	@override
  String get errorValidationBucketEmpty => Crowdin.getText(localeName, 'errorValidationBucketEmpty') ?? _fallbackTexts.errorValidationBucketEmpty;

	@override
  String get errorValidationBucketNotAString => Crowdin.getText(localeName, 'errorValidationBucketNotAString') ?? _fallbackTexts.errorValidationBucketNotAString;

	@override
  String get errorValidationDistributionUrlNotUrlAddress => Crowdin.getText(localeName, 'errorValidationDistributionUrlNotUrlAddress') ?? _fallbackTexts.errorValidationDistributionUrlNotUrlAddress;

	@override
  String get errorValidationDistributionUrlEmpty => Crowdin.getText(localeName, 'errorValidationDistributionUrlEmpty') ?? _fallbackTexts.errorValidationDistributionUrlEmpty;

	@override
  String get errorValidationDistributionUrlNotAString => Crowdin.getText(localeName, 'errorValidationDistributionUrlNotAString') ?? _fallbackTexts.errorValidationDistributionUrlNotAString;

	@override
  String get errorValidationTypeNotAString => Crowdin.getText(localeName, 'errorValidationTypeNotAString') ?? _fallbackTexts.errorValidationTypeNotAString;

	@override
  String get errorValidationAccountIdEmpty => Crowdin.getText(localeName, 'errorValidationAccountIdEmpty') ?? _fallbackTexts.errorValidationAccountIdEmpty;

	@override
  String get errorValidationAccountIdNotANumber => Crowdin.getText(localeName, 'errorValidationAccountIdNotANumber') ?? _fallbackTexts.errorValidationAccountIdNotANumber;

	@override
  String get errorValidationAccountIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationAccountIdNotAnInteger') ?? _fallbackTexts.errorValidationAccountIdNotAnInteger;

	@override
  String get errorValidationAccountIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationAccountIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationAccountIdNotAPositiveNumber;

	@override
  String get errorValidationProductIdEmpty => Crowdin.getText(localeName, 'errorValidationProductIdEmpty') ?? _fallbackTexts.errorValidationProductIdEmpty;

	@override
  String get errorValidationProductIdNotANumber => Crowdin.getText(localeName, 'errorValidationProductIdNotANumber') ?? _fallbackTexts.errorValidationProductIdNotANumber;

	@override
  String get errorValidationProductIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationProductIdNotAnInteger') ?? _fallbackTexts.errorValidationProductIdNotAnInteger;

	@override
  String get errorValidationProductIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationProductIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationProductIdNotAPositiveNumber;

	@override
  String get errorValidationStateInvalidEnum => Crowdin.getText(localeName, 'errorValidationStateInvalidEnum') ?? _fallbackTexts.errorValidationStateInvalidEnum;

	@override
  String get errorValidationExpiresAtEmpty => Crowdin.getText(localeName, 'errorValidationExpiresAtEmpty') ?? _fallbackTexts.errorValidationExpiresAtEmpty;

	@override
  String get errorValidationExpiresAtNotADate => Crowdin.getText(localeName, 'errorValidationExpiresAtNotADate') ?? _fallbackTexts.errorValidationExpiresAtNotADate;

	@override
  String get errorValidationCreatedAtEmpty => Crowdin.getText(localeName, 'errorValidationCreatedAtEmpty') ?? _fallbackTexts.errorValidationCreatedAtEmpty;

	@override
  String get errorValidationCreatedAtNotADate => Crowdin.getText(localeName, 'errorValidationCreatedAtNotADate') ?? _fallbackTexts.errorValidationCreatedAtNotADate;

	@override
  String get errorValidationReceiptEmpty => Crowdin.getText(localeName, 'errorValidationReceiptEmpty') ?? _fallbackTexts.errorValidationReceiptEmpty;

	@override
  String get errorValidationReceiptNotAString => Crowdin.getText(localeName, 'errorValidationReceiptNotAString') ?? _fallbackTexts.errorValidationReceiptNotAString;

	@override
  String get errorValidationTransactionIdEmpty => Crowdin.getText(localeName, 'errorValidationTransactionIdEmpty') ?? _fallbackTexts.errorValidationTransactionIdEmpty;

	@override
  String get errorValidationTransactionIdNotANumberString => Crowdin.getText(localeName, 'errorValidationTransactionIdNotANumberString') ?? _fallbackTexts.errorValidationTransactionIdNotANumberString;

	@override
  String get errorValidationBaseTransactionIdEmpty => Crowdin.getText(localeName, 'errorValidationBaseTransactionIdEmpty') ?? _fallbackTexts.errorValidationBaseTransactionIdEmpty;

	@override
  String get errorValidationBaseTransactionIdNotANumberString => Crowdin.getText(localeName, 'errorValidationBaseTransactionIdNotANumberString') ?? _fallbackTexts.errorValidationBaseTransactionIdNotANumberString;

	@override
  String get errorValidationLinkedPurchaseTokenEmpty => Crowdin.getText(localeName, 'errorValidationLinkedPurchaseTokenEmpty') ?? _fallbackTexts.errorValidationLinkedPurchaseTokenEmpty;

	@override
  String get errorValidationLinkedPurchaseTokenNotAString => Crowdin.getText(localeName, 'errorValidationLinkedPurchaseTokenNotAString') ?? _fallbackTexts.errorValidationLinkedPurchaseTokenNotAString;

	@override
  String get errorValidationDataEmptyObject => Crowdin.getText(localeName, 'errorValidationDataEmptyObject') ?? _fallbackTexts.errorValidationDataEmptyObject;

	@override
  String get errorValidationSignedPayloadNotAJwt => Crowdin.getText(localeName, 'errorValidationSignedPayloadNotAJwt') ?? _fallbackTexts.errorValidationSignedPayloadNotAJwt;

	@override
  String get errorValidationSignedPayloadEmpty => Crowdin.getText(localeName, 'errorValidationSignedPayloadEmpty') ?? _fallbackTexts.errorValidationSignedPayloadEmpty;

	@override
  String get errorValidationMessageIdEmpty => Crowdin.getText(localeName, 'errorValidationMessageIdEmpty') ?? _fallbackTexts.errorValidationMessageIdEmpty;

	@override
  String get errorValidationMessageIdNotANumberString => Crowdin.getText(localeName, 'errorValidationMessageIdNotANumberString') ?? _fallbackTexts.errorValidationMessageIdNotANumberString;

	@override
  String get errorValidationDataEmpty => Crowdin.getText(localeName, 'errorValidationDataEmpty') ?? _fallbackTexts.errorValidationDataEmpty;

	@override
  String get errorValidationDataNotBase64Encoded => Crowdin.getText(localeName, 'errorValidationDataNotBase64Encoded') ?? _fallbackTexts.errorValidationDataNotBase64Encoded;

	@override
  String get errorValidationDataNotAString => Crowdin.getText(localeName, 'errorValidationDataNotAString') ?? _fallbackTexts.errorValidationDataNotAString;

	@override
  String get errorValidationMessageEmptyObject => Crowdin.getText(localeName, 'errorValidationMessageEmptyObject') ?? _fallbackTexts.errorValidationMessageEmptyObject;

	@override
  String get errorValidationSubscriptionEmpty => Crowdin.getText(localeName, 'errorValidationSubscriptionEmpty') ?? _fallbackTexts.errorValidationSubscriptionEmpty;

	@override
  String get errorValidationSubscriptionNotAString => Crowdin.getText(localeName, 'errorValidationSubscriptionNotAString') ?? _fallbackTexts.errorValidationSubscriptionNotAString;

	@override
  String get errorValidationProductIdNotAString => Crowdin.getText(localeName, 'errorValidationProductIdNotAString') ?? _fallbackTexts.errorValidationProductIdNotAString;

	@override
  String get errorValidationOfferIdEmpty => Crowdin.getText(localeName, 'errorValidationOfferIdEmpty') ?? _fallbackTexts.errorValidationOfferIdEmpty;

	@override
  String get errorValidationOfferIdNotAString => Crowdin.getText(localeName, 'errorValidationOfferIdNotAString') ?? _fallbackTexts.errorValidationOfferIdNotAString;

	@override
  String get errorValidationAccountTokenEmpty => Crowdin.getText(localeName, 'errorValidationAccountTokenEmpty') ?? _fallbackTexts.errorValidationAccountTokenEmpty;

	@override
  String get errorValidationAccountTokenNotAString => Crowdin.getText(localeName, 'errorValidationAccountTokenNotAString') ?? _fallbackTexts.errorValidationAccountTokenNotAString;

	@override
  String get errorValidationAccountTokenNotUuidV4 => Crowdin.getText(localeName, 'errorValidationAccountTokenNotUuidV4') ?? _fallbackTexts.errorValidationAccountTokenNotUuidV4;

	@override
  String get errorValidationVendorInvalidEnum => Crowdin.getText(localeName, 'errorValidationVendorInvalidEnum') ?? _fallbackTexts.errorValidationVendorInvalidEnum;

	@override
  String get errorValidationLiveTogetherEmpty => Crowdin.getText(localeName, 'errorValidationLiveTogetherEmpty') ?? _fallbackTexts.errorValidationLiveTogetherEmpty;

	@override
  String get errorValidationLiveTogetherNotABoolean => Crowdin.getText(localeName, 'errorValidationLiveTogetherNotABoolean') ?? _fallbackTexts.errorValidationLiveTogetherNotABoolean;

	@override
  String get errorValidationRelationEmpty => Crowdin.getText(localeName, 'errorValidationRelationEmpty') ?? _fallbackTexts.errorValidationRelationEmpty;

	@override
  String get errorValidationRelationNotAString => Crowdin.getText(localeName, 'errorValidationRelationNotAString') ?? _fallbackTexts.errorValidationRelationNotAString;

	@override
  String get errorValidationRelationInvalidEnum => Crowdin.getText(localeName, 'errorValidationRelationInvalidEnum') ?? _fallbackTexts.errorValidationRelationInvalidEnum;

	@override
  String get errorValidationEmailEmpty => Crowdin.getText(localeName, 'errorValidationEmailEmpty') ?? _fallbackTexts.errorValidationEmailEmpty;

	@override
  String get errorValidationRegistrationTokenEmpty => Crowdin.getText(localeName, 'errorValidationRegistrationTokenEmpty') ?? _fallbackTexts.errorValidationRegistrationTokenEmpty;

	@override
  String get errorValidationRegistrationTokenNotAString => Crowdin.getText(localeName, 'errorValidationRegistrationTokenNotAString') ?? _fallbackTexts.errorValidationRegistrationTokenNotAString;

	@override
  String get errorValidationRegistrationTokenNotAJwt => Crowdin.getText(localeName, 'errorValidationRegistrationTokenNotAJwt') ?? _fallbackTexts.errorValidationRegistrationTokenNotAJwt;

	@override
  String get errorValidationPasswordTokenEmpty => Crowdin.getText(localeName, 'errorValidationPasswordTokenEmpty') ?? _fallbackTexts.errorValidationPasswordTokenEmpty;

	@override
  String get errorValidationPasswordTokenNotAString => Crowdin.getText(localeName, 'errorValidationPasswordTokenNotAString') ?? _fallbackTexts.errorValidationPasswordTokenNotAString;

	@override
  String get errorValidationPasswordTokenNotAJwt => Crowdin.getText(localeName, 'errorValidationPasswordTokenNotAJwt') ?? _fallbackTexts.errorValidationPasswordTokenNotAJwt;

	@override
  String get errorValidationBuddyIdEmpty => Crowdin.getText(localeName, 'errorValidationBuddyIdEmpty') ?? _fallbackTexts.errorValidationBuddyIdEmpty;

	@override
  String get errorValidationBuddyIdNotANumber => Crowdin.getText(localeName, 'errorValidationBuddyIdNotANumber') ?? _fallbackTexts.errorValidationBuddyIdNotANumber;

	@override
  String get errorValidationBuddyIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationBuddyIdNotAnInteger') ?? _fallbackTexts.errorValidationBuddyIdNotAnInteger;

	@override
  String get errorValidationBuddyIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationBuddyIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationBuddyIdNotAPositiveNumber;

	@override
  String get errorValidationIdEmpty => Crowdin.getText(localeName, 'errorValidationIdEmpty') ?? _fallbackTexts.errorValidationIdEmpty;

	@override
  String get errorValidationIdNotANumber => Crowdin.getText(localeName, 'errorValidationIdNotANumber') ?? _fallbackTexts.errorValidationIdNotANumber;

	@override
  String get errorValidationIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationIdNotAnInteger') ?? _fallbackTexts.errorValidationIdNotAnInteger;

	@override
  String get errorValidationIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationIdNotAPositiveNumber;

	@override
  String get errorValidationDishIdEmpty => Crowdin.getText(localeName, 'errorValidationDishIdEmpty') ?? _fallbackTexts.errorValidationDishIdEmpty;

	@override
  String get errorValidationDishIdNotANumber => Crowdin.getText(localeName, 'errorValidationDishIdNotANumber') ?? _fallbackTexts.errorValidationDishIdNotANumber;

	@override
  String get errorValidationDishIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationDishIdNotAnInteger') ?? _fallbackTexts.errorValidationDishIdNotAnInteger;

	@override
  String get errorValidationDishIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationDishIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationDishIdNotAPositiveNumber;

	@override
  String get errorValidationMealCategoriesNotAString => Crowdin.getText(localeName, 'errorValidationMealCategoriesNotAString') ?? _fallbackTexts.errorValidationMealCategoriesNotAString;

	@override
  String get errorValidationNumberOfServingsEmpty => Crowdin.getText(localeName, 'errorValidationNumberOfServingsEmpty') ?? _fallbackTexts.errorValidationNumberOfServingsEmpty;

	@override
  String get errorValidationNumberOfServingsNotANumber => Crowdin.getText(localeName, 'errorValidationNumberOfServingsNotANumber') ?? _fallbackTexts.errorValidationNumberOfServingsNotANumber;

	@override
  String get errorValidationNumberOfServingsNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationNumberOfServingsNotAPositiveNumber') ?? _fallbackTexts.errorValidationNumberOfServingsNotAPositiveNumber;

	@override
  String get errorValidationExternalFoodItemIdEmpty => Crowdin.getText(localeName, 'errorValidationExternalFoodItemIdEmpty') ?? _fallbackTexts.errorValidationExternalFoodItemIdEmpty;

	@override
  String get errorValidationExternalFoodItemIdNotANumberString => Crowdin.getText(localeName, 'errorValidationExternalFoodItemIdNotANumberString') ?? _fallbackTexts.errorValidationExternalFoodItemIdNotANumberString;

	@override
  String get errorValidationFoodItemsEmpty => Crowdin.getText(localeName, 'errorValidationFoodItemsEmpty') ?? _fallbackTexts.errorValidationFoodItemsEmpty;

	@override
  String get errorValidationFoodItemsNotAnArray => Crowdin.getText(localeName, 'errorValidationFoodItemsNotAnArray') ?? _fallbackTexts.errorValidationFoodItemsNotAnArray;

	@override
  String get errorValidationFoodItemsEmptyArray => Crowdin.getText(localeName, 'errorValidationFoodItemsEmptyArray') ?? _fallbackTexts.errorValidationFoodItemsEmptyArray;

	@override
  String get errorValidationInternalFoodItemIdEmpty => Crowdin.getText(localeName, 'errorValidationInternalFoodItemIdEmpty') ?? _fallbackTexts.errorValidationInternalFoodItemIdEmpty;

	@override
  String get errorValidationInternalFoodItemIdNotANumber => Crowdin.getText(localeName, 'errorValidationInternalFoodItemIdNotANumber') ?? _fallbackTexts.errorValidationInternalFoodItemIdNotANumber;

	@override
  String get errorValidationInternalFoodItemIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationInternalFoodItemIdNotAnInteger') ?? _fallbackTexts.errorValidationInternalFoodItemIdNotAnInteger;

	@override
  String get errorValidationInternalFoodItemIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationInternalFoodItemIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationInternalFoodItemIdNotAPositiveNumber;

	@override
  String get errorValidationMealRecipeIdNumberTooBig => Crowdin.getText(localeName, 'errorValidationMealRecipeIdNumberTooBig') ?? _fallbackTexts.errorValidationMealRecipeIdNumberTooBig;

	@override
  String get errorValidationMealRecipeIdNumberTooSmall => Crowdin.getText(localeName, 'errorValidationMealRecipeIdNumberTooSmall') ?? _fallbackTexts.errorValidationMealRecipeIdNumberTooSmall;

	@override
  String get errorValidationRecipeIdNotANumber => Crowdin.getText(localeName, 'errorValidationRecipeIdNotANumber') ?? _fallbackTexts.errorValidationRecipeIdNotANumber;

	@override
  String get errorValidationRecipeIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationRecipeIdNotAnInteger') ?? _fallbackTexts.errorValidationRecipeIdNotAnInteger;

	@override
  String get errorValidationRecipeIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationRecipeIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationRecipeIdNotAPositiveNumber;

	@override
  String get errorValidationRecipeIdNumberTooBig => Crowdin.getText(localeName, 'errorValidationRecipeIdNumberTooBig') ?? _fallbackTexts.errorValidationRecipeIdNumberTooBig;

	@override
  String get errorValidationRecipeIdNumberTooSmall => Crowdin.getText(localeName, 'errorValidationRecipeIdNumberTooSmall') ?? _fallbackTexts.errorValidationRecipeIdNumberTooSmall;

	@override
  String get errorValidationRegionInvalidEnum => Crowdin.getText(localeName, 'errorValidationRegionInvalidEnum') ?? _fallbackTexts.errorValidationRegionInvalidEnum;

	@override
  String get errorValidationBarcodeEmpty => Crowdin.getText(localeName, 'errorValidationBarcodeEmpty') ?? _fallbackTexts.errorValidationBarcodeEmpty;

	@override
  String get errorValidationBarcodeNotAString => Crowdin.getText(localeName, 'errorValidationBarcodeNotAString') ?? _fallbackTexts.errorValidationBarcodeNotAString;

	@override
  String get errorValidationBarcodeStringTooLong => Crowdin.getText(localeName, 'errorValidationBarcodeStringTooLong') ?? _fallbackTexts.errorValidationBarcodeStringTooLong;

	@override
  String get errorValidationBarcodeStringTooShort => Crowdin.getText(localeName, 'errorValidationBarcodeStringTooShort') ?? _fallbackTexts.errorValidationBarcodeStringTooShort;

	@override
  String get errorValidationExternalFoodItemIdNotAString => Crowdin.getText(localeName, 'errorValidationExternalFoodItemIdNotAString') ?? _fallbackTexts.errorValidationExternalFoodItemIdNotAString;

	@override
  String get errorValidationServingIdNotAString => Crowdin.getText(localeName, 'errorValidationServingIdNotAString') ?? _fallbackTexts.errorValidationServingIdNotAString;

	@override
  String get errorValidationFoodItemsArraySizeTooSmall => Crowdin.getText(localeName, 'errorValidationFoodItemsArraySizeTooSmall') ?? _fallbackTexts.errorValidationFoodItemsArraySizeTooSmall;

	@override
  String get errorValidationInternalRecipeIdEmpty => Crowdin.getText(localeName, 'errorValidationInternalRecipeIdEmpty') ?? _fallbackTexts.errorValidationInternalRecipeIdEmpty;

	@override
  String get errorValidationInternalRecipeIdNotANumber => Crowdin.getText(localeName, 'errorValidationInternalRecipeIdNotANumber') ?? _fallbackTexts.errorValidationInternalRecipeIdNotANumber;

	@override
  String get errorValidationInternalRecipeIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationInternalRecipeIdNotAnInteger') ?? _fallbackTexts.errorValidationInternalRecipeIdNotAnInteger;

	@override
  String get errorValidationInternalRecipeIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationInternalRecipeIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationInternalRecipeIdNotAPositiveNumber;

	@override
  String get errorValidationLoggingDateEmpty => Crowdin.getText(localeName, 'errorValidationLoggingDateEmpty') ?? _fallbackTexts.errorValidationLoggingDateEmpty;

	@override
  String get errorValidationLoggingDateNotADateString => Crowdin.getText(localeName, 'errorValidationLoggingDateNotADateString') ?? _fallbackTexts.errorValidationLoggingDateNotADateString;

	@override
  String get errorValidationMealCategoryEmpty => Crowdin.getText(localeName, 'errorValidationMealCategoryEmpty') ?? _fallbackTexts.errorValidationMealCategoryEmpty;

	@override
  String get errorValidationInternalFoodItemIdNotANumberString => Crowdin.getText(localeName, 'errorValidationInternalFoodItemIdNotANumberString') ?? _fallbackTexts.errorValidationInternalFoodItemIdNotANumberString;

	@override
  String get errorValidationDateEmpty => Crowdin.getText(localeName, 'errorValidationDateEmpty') ?? _fallbackTexts.errorValidationDateEmpty;

	@override
  String get errorValidationDateNotADateString => Crowdin.getText(localeName, 'errorValidationDateNotADateString') ?? _fallbackTexts.errorValidationDateNotADateString;

	@override
  String get errorValidationQueryEmpty => Crowdin.getText(localeName, 'errorValidationQueryEmpty') ?? _fallbackTexts.errorValidationQueryEmpty;

	@override
  String get errorValidationQueryNotAString => Crowdin.getText(localeName, 'errorValidationQueryNotAString') ?? _fallbackTexts.errorValidationQueryNotAString;

	@override
  String get errorValidationQueryStringTooShort => Crowdin.getText(localeName, 'errorValidationQueryStringTooShort') ?? _fallbackTexts.errorValidationQueryStringTooShort;

	@override
  String get errorValidationModesEmpty => Crowdin.getText(localeName, 'errorValidationModesEmpty') ?? _fallbackTexts.errorValidationModesEmpty;

	@override
  String get errorValidationModesNotFromDefinedList => Crowdin.getText(localeName, 'errorValidationModesNotFromDefinedList') ?? _fallbackTexts.errorValidationModesNotFromDefinedList;

	@override
  String get errorValidationPageNotANumber => Crowdin.getText(localeName, 'errorValidationPageNotANumber') ?? _fallbackTexts.errorValidationPageNotANumber;

	@override
  String get errorValidationPageNotAnInteger => Crowdin.getText(localeName, 'errorValidationPageNotAnInteger') ?? _fallbackTexts.errorValidationPageNotAnInteger;

	@override
  String get errorValidationPageNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationPageNotAPositiveNumber') ?? _fallbackTexts.errorValidationPageNotAPositiveNumber;

	@override
  String get errorValidationPageSizeNotANumber => Crowdin.getText(localeName, 'errorValidationPageSizeNotANumber') ?? _fallbackTexts.errorValidationPageSizeNotANumber;

	@override
  String get errorValidationPageSizeNotAnInteger => Crowdin.getText(localeName, 'errorValidationPageSizeNotAnInteger') ?? _fallbackTexts.errorValidationPageSizeNotAnInteger;

	@override
  String get errorValidationPageSizeNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationPageSizeNotAPositiveNumber') ?? _fallbackTexts.errorValidationPageSizeNotAPositiveNumber;

	@override
  String get errorValidationPageSizeNumberTooBig => Crowdin.getText(localeName, 'errorValidationPageSizeNumberTooBig') ?? _fallbackTexts.errorValidationPageSizeNumberTooBig;

	@override
  String get errorValidationPlanningDatesDateTooSmall => Crowdin.getText(localeName, 'errorValidationPlanningDatesDateTooSmall') ?? _fallbackTexts.errorValidationPlanningDatesDateTooSmall;

	@override
  String get errorValidationPlanningDatesDateTooBig => Crowdin.getText(localeName, 'errorValidationPlanningDatesDateTooBig') ?? _fallbackTexts.errorValidationPlanningDatesDateTooBig;

	@override
  String get errorValidationPlanningDatesEmpty => Crowdin.getText(localeName, 'errorValidationPlanningDatesEmpty') ?? _fallbackTexts.errorValidationPlanningDatesEmpty;

	@override
  String get errorValidationPlanningDatesEmptyArray => Crowdin.getText(localeName, 'errorValidationPlanningDatesEmptyArray') ?? _fallbackTexts.errorValidationPlanningDatesEmptyArray;

	@override
  String get errorValidationPlanningDatesNotADateString => Crowdin.getText(localeName, 'errorValidationPlanningDatesNotADateString') ?? _fallbackTexts.errorValidationPlanningDatesNotADateString;

	@override
  String get errorValidationStartDateDateEmptyPeriod => Crowdin.getText(localeName, 'errorValidationStartDateDateEmptyPeriod') ?? _fallbackTexts.errorValidationStartDateDateEmptyPeriod;

	@override
  String get errorValidationPlannedMealIdEmpty => Crowdin.getText(localeName, 'errorValidationPlannedMealIdEmpty') ?? _fallbackTexts.errorValidationPlannedMealIdEmpty;

	@override
  String get errorValidationPlannedMealIdNotANumber => Crowdin.getText(localeName, 'errorValidationPlannedMealIdNotANumber') ?? _fallbackTexts.errorValidationPlannedMealIdNotANumber;

	@override
  String get errorValidationPlannedMealIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationPlannedMealIdNotAnInteger') ?? _fallbackTexts.errorValidationPlannedMealIdNotAnInteger;

	@override
  String get errorValidationPlannedMealIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationPlannedMealIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationPlannedMealIdNotAPositiveNumber;

	@override
  String get errorValidationLoggingDateDateTooBig => Crowdin.getText(localeName, 'errorValidationLoggingDateDateTooBig') ?? _fallbackTexts.errorValidationLoggingDateDateTooBig;

	@override
  String get errorValidationLoggingDateDateTooSmall => Crowdin.getText(localeName, 'errorValidationLoggingDateDateTooSmall') ?? _fallbackTexts.errorValidationLoggingDateDateTooSmall;

	@override
  String get errorValidationLimitNumberTooSmall => Crowdin.getText(localeName, 'errorValidationLimitNumberTooSmall') ?? _fallbackTexts.errorValidationLimitNumberTooSmall;

	@override
  String get errorValidationLimitNotAnInteger => Crowdin.getText(localeName, 'errorValidationLimitNotAnInteger') ?? _fallbackTexts.errorValidationLimitNotAnInteger;

	@override
  String get errorValidationLimitNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationLimitNotAPositiveNumber') ?? _fallbackTexts.errorValidationLimitNotAPositiveNumber;

	@override
  String get errorValidationLimitNotANumber => Crowdin.getText(localeName, 'errorValidationLimitNotANumber') ?? _fallbackTexts.errorValidationLimitNotANumber;

	@override
  String get errorValidationUrlNotAString => Crowdin.getText(localeName, 'errorValidationUrlNotAString') ?? _fallbackTexts.errorValidationUrlNotAString;

	@override
  String get errorValidationUrlNotUrlAddress => Crowdin.getText(localeName, 'errorValidationUrlNotUrlAddress') ?? _fallbackTexts.errorValidationUrlNotUrlAddress;

	@override
  String get errorValidationDataArraySizeTooSmall => Crowdin.getText(localeName, 'errorValidationDataArraySizeTooSmall') ?? _fallbackTexts.errorValidationDataArraySizeTooSmall;

	@override
  String get errorValidationDataNotAnArray => Crowdin.getText(localeName, 'errorValidationDataNotAnArray') ?? _fallbackTexts.errorValidationDataNotAnArray;

	@override
  String get errorValidationDateNotAString => Crowdin.getText(localeName, 'errorValidationDateNotAString') ?? _fallbackTexts.errorValidationDateNotAString;

	@override
  String get errorValidationDateDateTooSmall => Crowdin.getText(localeName, 'errorValidationDateDateTooSmall') ?? _fallbackTexts.errorValidationDateDateTooSmall;

	@override
  String get errorValidationDateDateTooBig => Crowdin.getText(localeName, 'errorValidationDateDateTooBig') ?? _fallbackTexts.errorValidationDateDateTooBig;

	@override
  String get errorValidationWeightNumberTooBig => Crowdin.getText(localeName, 'errorValidationWeightNumberTooBig') ?? _fallbackTexts.errorValidationWeightNumberTooBig;

	@override
  String get errorValidationStartDateDateTooBig => Crowdin.getText(localeName, 'errorValidationStartDateDateTooBig') ?? _fallbackTexts.errorValidationStartDateDateTooBig;

	@override
  String get errorValidationEndDateDateTooBig => Crowdin.getText(localeName, 'errorValidationEndDateDateTooBig') ?? _fallbackTexts.errorValidationEndDateDateTooBig;

	@override
  String get errorValidationStateNotAString => Crowdin.getText(localeName, 'errorValidationStateNotAString') ?? _fallbackTexts.errorValidationStateNotAString;

	@override
  String get errorValidationGenderPreferenceIdEmpty => Crowdin.getText(localeName, 'errorValidationGenderPreferenceIdEmpty') ?? _fallbackTexts.errorValidationGenderPreferenceIdEmpty;

	@override
  String get errorValidationGenderPreferenceIdNotANumber => Crowdin.getText(localeName, 'errorValidationGenderPreferenceIdNotANumber') ?? _fallbackTexts.errorValidationGenderPreferenceIdNotANumber;

	@override
  String get errorValidationGenderPreferenceIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationGenderPreferenceIdNotAnInteger') ?? _fallbackTexts.errorValidationGenderPreferenceIdNotAnInteger;

	@override
  String get errorValidationGenderPreferenceIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationGenderPreferenceIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationGenderPreferenceIdNotAPositiveNumber;

	@override
  String get errorValidationTypeIdEmpty => Crowdin.getText(localeName, 'errorValidationTypeIdEmpty') ?? _fallbackTexts.errorValidationTypeIdEmpty;

	@override
  String get errorValidationTypeIdNotANumber => Crowdin.getText(localeName, 'errorValidationTypeIdNotANumber') ?? _fallbackTexts.errorValidationTypeIdNotANumber;

	@override
  String get errorValidationTypeIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationTypeIdNotAnInteger') ?? _fallbackTexts.errorValidationTypeIdNotAnInteger;

	@override
  String get errorValidationTypeIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationTypeIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationTypeIdNotAPositiveNumber;

	@override
  String get errorValidationBmiRangeNotAString => Crowdin.getText(localeName, 'errorValidationBmiRangeNotAString') ?? _fallbackTexts.errorValidationBmiRangeNotAString;

	@override
  String get errorValidationBmiRangeInvalidEnum => Crowdin.getText(localeName, 'errorValidationBmiRangeInvalidEnum') ?? _fallbackTexts.errorValidationBmiRangeInvalidEnum;

	@override
  String get errorValidationAgeRangeNotAString => Crowdin.getText(localeName, 'errorValidationAgeRangeNotAString') ?? _fallbackTexts.errorValidationAgeRangeNotAString;

	@override
  String get errorValidationAgeRangeInvalidEnum => Crowdin.getText(localeName, 'errorValidationAgeRangeInvalidEnum') ?? _fallbackTexts.errorValidationAgeRangeInvalidEnum;

	@override
  String get errorValidationTimezoneStringTooShort => Crowdin.getText(localeName, 'errorValidationTimezoneStringTooShort') ?? _fallbackTexts.errorValidationTimezoneStringTooShort;

	@override
  String get errorValidationGroupIdEmpty => Crowdin.getText(localeName, 'errorValidationGroupIdEmpty') ?? _fallbackTexts.errorValidationGroupIdEmpty;

	@override
  String get errorValidationGroupIdNotANumber => Crowdin.getText(localeName, 'errorValidationGroupIdNotANumber') ?? _fallbackTexts.errorValidationGroupIdNotANumber;

	@override
  String get errorValidationGroupIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationGroupIdNotAnInteger') ?? _fallbackTexts.errorValidationGroupIdNotAnInteger;

	@override
  String get errorValidationGroupIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationGroupIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationGroupIdNotAPositiveNumber;

	@override
  String get errorValidationGroupSessionIdEmpty => Crowdin.getText(localeName, 'errorValidationGroupSessionIdEmpty') ?? _fallbackTexts.errorValidationGroupSessionIdEmpty;

	@override
  String get errorValidationGroupSessionIdNotANumber => Crowdin.getText(localeName, 'errorValidationGroupSessionIdNotANumber') ?? _fallbackTexts.errorValidationGroupSessionIdNotANumber;

	@override
  String get errorValidationGroupSessionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationGroupSessionIdNotAnInteger') ?? _fallbackTexts.errorValidationGroupSessionIdNotAnInteger;

	@override
  String get errorValidationGroupSessionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationGroupSessionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationGroupSessionIdNotAPositiveNumber;

	@override
  String get errorValidationEventInvalidEnum => Crowdin.getText(localeName, 'errorValidationEventInvalidEnum') ?? _fallbackTexts.errorValidationEventInvalidEnum;

	@override
  String get errorValidationEventNotAString => Crowdin.getText(localeName, 'errorValidationEventNotAString') ?? _fallbackTexts.errorValidationEventNotAString;

	@override
  String get errorValidationEventEmpty => Crowdin.getText(localeName, 'errorValidationEventEmpty') ?? _fallbackTexts.errorValidationEventEmpty;

	@override
  String get errorValidationStartDateNotAnIsoDateString => Crowdin.getText(localeName, 'errorValidationStartDateNotAnIsoDateString') ?? _fallbackTexts.errorValidationStartDateNotAnIsoDateString;

	@override
  String get errorValidationEndDateNotAnIsoDateString => Crowdin.getText(localeName, 'errorValidationEndDateNotAnIsoDateString') ?? _fallbackTexts.errorValidationEndDateNotAnIsoDateString;

	@override
  String get errorValidationStatusEmpty => Crowdin.getText(localeName, 'errorValidationStatusEmpty') ?? _fallbackTexts.errorValidationStatusEmpty;

	@override
  String get errorValidationStatusNotAString => Crowdin.getText(localeName, 'errorValidationStatusNotAString') ?? _fallbackTexts.errorValidationStatusNotAString;

	@override
  String get errorValidationStatusInvalidEnum => Crowdin.getText(localeName, 'errorValidationStatusInvalidEnum') ?? _fallbackTexts.errorValidationStatusInvalidEnum;

	@override
  String get errorValidationTopicStringTooLong => Crowdin.getText(localeName, 'errorValidationTopicStringTooLong') ?? _fallbackTexts.errorValidationTopicStringTooLong;

	@override
  String get errorValidationTopicStringTooShort => Crowdin.getText(localeName, 'errorValidationTopicStringTooShort') ?? _fallbackTexts.errorValidationTopicStringTooShort;

	@override
  String get errorValidationTopicNotAString => Crowdin.getText(localeName, 'errorValidationTopicNotAString') ?? _fallbackTexts.errorValidationTopicNotAString;

	@override
  String get errorValidationPasswordStringTooLong => Crowdin.getText(localeName, 'errorValidationPasswordStringTooLong') ?? _fallbackTexts.errorValidationPasswordStringTooLong;

	@override
  String get errorValidationPasswordStringTooShort => Crowdin.getText(localeName, 'errorValidationPasswordStringTooShort') ?? _fallbackTexts.errorValidationPasswordStringTooShort;

	@override
  String get errorValidationGroupSessionProgramIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationGroupSessionProgramIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationGroupSessionProgramIdNotAPositiveNumber;

	@override
  String get errorValidationGroupSessionProgramIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationGroupSessionProgramIdNotAnInteger') ?? _fallbackTexts.errorValidationGroupSessionProgramIdNotAnInteger;

	@override
  String get errorValidationGroupSessionProgramIdNotANumber => Crowdin.getText(localeName, 'errorValidationGroupSessionProgramIdNotANumber') ?? _fallbackTexts.errorValidationGroupSessionProgramIdNotANumber;

	@override
  String get errorValidationPreparationNotAString => Crowdin.getText(localeName, 'errorValidationPreparationNotAString') ?? _fallbackTexts.errorValidationPreparationNotAString;

	@override
  String get errorValidationPreparationEmpty => Crowdin.getText(localeName, 'errorValidationPreparationEmpty') ?? _fallbackTexts.errorValidationPreparationEmpty;

	@override
  String get errorValidationTitleNotAString => Crowdin.getText(localeName, 'errorValidationTitleNotAString') ?? _fallbackTexts.errorValidationTitleNotAString;

	@override
  String get errorValidationTitleEmpty => Crowdin.getText(localeName, 'errorValidationTitleEmpty') ?? _fallbackTexts.errorValidationTitleEmpty;

	@override
  String get errorValidationEventsNotAnArray => Crowdin.getText(localeName, 'errorValidationEventsNotAnArray') ?? _fallbackTexts.errorValidationEventsNotAnArray;

	@override
  String get errorValidationImageNotAString => Crowdin.getText(localeName, 'errorValidationImageNotAString') ?? _fallbackTexts.errorValidationImageNotAString;

	@override
  String get errorValidationImageEmpty => Crowdin.getText(localeName, 'errorValidationImageEmpty') ?? _fallbackTexts.errorValidationImageEmpty;

	@override
  String get errorValidationStartNotAString => Crowdin.getText(localeName, 'errorValidationStartNotAString') ?? _fallbackTexts.errorValidationStartNotAString;

	@override
  String get errorValidationStartEmpty => Crowdin.getText(localeName, 'errorValidationStartEmpty') ?? _fallbackTexts.errorValidationStartEmpty;

	@override
  String get errorValidationPromptNotAString => Crowdin.getText(localeName, 'errorValidationPromptNotAString') ?? _fallbackTexts.errorValidationPromptNotAString;

	@override
  String get errorValidationVideoNotAString => Crowdin.getText(localeName, 'errorValidationVideoNotAString') ?? _fallbackTexts.errorValidationVideoNotAString;

	@override
  String get errorValidationDurationNotAnInteger => Crowdin.getText(localeName, 'errorValidationDurationNotAnInteger') ?? _fallbackTexts.errorValidationDurationNotAnInteger;

	@override
  String get errorValidationDurationNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationDurationNotAPositiveNumber') ?? _fallbackTexts.errorValidationDurationNotAPositiveNumber;

	@override
  String get errorValidationDurationNotANumber => Crowdin.getText(localeName, 'errorValidationDurationNotANumber') ?? _fallbackTexts.errorValidationDurationNotANumber;

	@override
  String get errorValidationSessionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationSessionIdNotAnInteger') ?? _fallbackTexts.errorValidationSessionIdNotAnInteger;

	@override
  String get errorValidationSessionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationSessionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationSessionIdNotAPositiveNumber;

	@override
  String get errorValidationSessionIdNotANumber => Crowdin.getText(localeName, 'errorValidationSessionIdNotANumber') ?? _fallbackTexts.errorValidationSessionIdNotANumber;

	@override
  String get errorValidationTypeEmpty => Crowdin.getText(localeName, 'errorValidationTypeEmpty') ?? _fallbackTexts.errorValidationTypeEmpty;

	@override
  String get errorValidationImagePathStringTooShort => Crowdin.getText(localeName, 'errorValidationImagePathStringTooShort') ?? _fallbackTexts.errorValidationImagePathStringTooShort;

	@override
  String get errorValidationImagePathNotAString => Crowdin.getText(localeName, 'errorValidationImagePathNotAString') ?? _fallbackTexts.errorValidationImagePathNotAString;

	@override
  String get errorValidationImagePathEmpty => Crowdin.getText(localeName, 'errorValidationImagePathEmpty') ?? _fallbackTexts.errorValidationImagePathEmpty;

	@override
  String get errorValidationDifficultyNotAString => Crowdin.getText(localeName, 'errorValidationDifficultyNotAString') ?? _fallbackTexts.errorValidationDifficultyNotAString;

	@override
  String get errorValidationDifficultyInvalidEnum => Crowdin.getText(localeName, 'errorValidationDifficultyInvalidEnum') ?? _fallbackTexts.errorValidationDifficultyInvalidEnum;

	@override
  String get errorValidationPlaceNotAString => Crowdin.getText(localeName, 'errorValidationPlaceNotAString') ?? _fallbackTexts.errorValidationPlaceNotAString;

	@override
  String get errorValidationPlaceInvalidEnum => Crowdin.getText(localeName, 'errorValidationPlaceInvalidEnum') ?? _fallbackTexts.errorValidationPlaceInvalidEnum;

	@override
  String get errorValidationPhysicalProgramIdEmpty => Crowdin.getText(localeName, 'errorValidationPhysicalProgramIdEmpty') ?? _fallbackTexts.errorValidationPhysicalProgramIdEmpty;

	@override
  String get errorValidationPhysicalProgramIdNotANumber => Crowdin.getText(localeName, 'errorValidationPhysicalProgramIdNotANumber') ?? _fallbackTexts.errorValidationPhysicalProgramIdNotANumber;

	@override
  String get errorValidationPhysicalProgramIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationPhysicalProgramIdNotAnInteger') ?? _fallbackTexts.errorValidationPhysicalProgramIdNotAnInteger;

	@override
  String get errorValidationPhysicalProgramIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationPhysicalProgramIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationPhysicalProgramIdNotAPositiveNumber;

	@override
  String get errorValidationScoreEmpty => Crowdin.getText(localeName, 'errorValidationScoreEmpty') ?? _fallbackTexts.errorValidationScoreEmpty;

	@override
  String get errorValidationScoreNotANumber => Crowdin.getText(localeName, 'errorValidationScoreNotANumber') ?? _fallbackTexts.errorValidationScoreNotANumber;

	@override
  String get errorValidationScoreNumberTooBig => Crowdin.getText(localeName, 'errorValidationScoreNumberTooBig') ?? _fallbackTexts.errorValidationScoreNumberTooBig;

	@override
  String get errorValidationScoreNumberTooSmall => Crowdin.getText(localeName, 'errorValidationScoreNumberTooSmall') ?? _fallbackTexts.errorValidationScoreNumberTooSmall;

	@override
  String get errorValidationLikeEmpty => Crowdin.getText(localeName, 'errorValidationLikeEmpty') ?? _fallbackTexts.errorValidationLikeEmpty;

	@override
  String get errorValidationLikeNotABoolean => Crowdin.getText(localeName, 'errorValidationLikeNotABoolean') ?? _fallbackTexts.errorValidationLikeNotABoolean;

	@override
  String get errorValidationTrainingFrequencyEmpty => Crowdin.getText(localeName, 'errorValidationTrainingFrequencyEmpty') ?? _fallbackTexts.errorValidationTrainingFrequencyEmpty;

	@override
  String get errorValidationTrainingFrequencyNotAString => Crowdin.getText(localeName, 'errorValidationTrainingFrequencyNotAString') ?? _fallbackTexts.errorValidationTrainingFrequencyNotAString;

	@override
  String get errorValidationTrainingFrequencyInvalidEnum => Crowdin.getText(localeName, 'errorValidationTrainingFrequencyInvalidEnum') ?? _fallbackTexts.errorValidationTrainingFrequencyInvalidEnum;

	@override
  String get errorValidationTrainingTargetsEmpty => Crowdin.getText(localeName, 'errorValidationTrainingTargetsEmpty') ?? _fallbackTexts.errorValidationTrainingTargetsEmpty;

	@override
  String get errorValidationTrainingTargetsNotAString => Crowdin.getText(localeName, 'errorValidationTrainingTargetsNotAString') ?? _fallbackTexts.errorValidationTrainingTargetsNotAString;

	@override
  String get errorValidationTrainingTargetsInvalidEnum => Crowdin.getText(localeName, 'errorValidationTrainingTargetsInvalidEnum') ?? _fallbackTexts.errorValidationTrainingTargetsInvalidEnum;

	@override
  String get errorValidationFlexibleEmpty => Crowdin.getText(localeName, 'errorValidationFlexibleEmpty') ?? _fallbackTexts.errorValidationFlexibleEmpty;

	@override
  String get errorValidationFlexibleNotABoolean => Crowdin.getText(localeName, 'errorValidationFlexibleNotABoolean') ?? _fallbackTexts.errorValidationFlexibleNotABoolean;

	@override
  String get errorValidationImageStringTooShort => Crowdin.getText(localeName, 'errorValidationImageStringTooShort') ?? _fallbackTexts.errorValidationImageStringTooShort;

	@override
  String get errorValidationVideoStringTooShort => Crowdin.getText(localeName, 'errorValidationVideoStringTooShort') ?? _fallbackTexts.errorValidationVideoStringTooShort;

	@override
  String get errorValidationVideoEmpty => Crowdin.getText(localeName, 'errorValidationVideoEmpty') ?? _fallbackTexts.errorValidationVideoEmpty;

	@override
  String get errorValidationDurationNotAString => Crowdin.getText(localeName, 'errorValidationDurationNotAString') ?? _fallbackTexts.errorValidationDurationNotAString;

	@override
  String get errorValidationDurationEmpty => Crowdin.getText(localeName, 'errorValidationDurationEmpty') ?? _fallbackTexts.errorValidationDurationEmpty;

	@override
  String get errorValidationSkipToNotAString => Crowdin.getText(localeName, 'errorValidationSkipToNotAString') ?? _fallbackTexts.errorValidationSkipToNotAString;

	@override
  String get errorValidationSkipToEmpty => Crowdin.getText(localeName, 'errorValidationSkipToEmpty') ?? _fallbackTexts.errorValidationSkipToEmpty;

	@override
  String get errorValidationExerciseIdEmpty => Crowdin.getText(localeName, 'errorValidationExerciseIdEmpty') ?? _fallbackTexts.errorValidationExerciseIdEmpty;

	@override
  String get errorValidationExerciseIdNotANumber => Crowdin.getText(localeName, 'errorValidationExerciseIdNotANumber') ?? _fallbackTexts.errorValidationExerciseIdNotANumber;

	@override
  String get errorValidationExerciseIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationExerciseIdNotAnInteger') ?? _fallbackTexts.errorValidationExerciseIdNotAnInteger;

	@override
  String get errorValidationExerciseIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationExerciseIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationExerciseIdNotAPositiveNumber;

	@override
  String get errorValidationCategoryInvalidEnum => Crowdin.getText(localeName, 'errorValidationCategoryInvalidEnum') ?? _fallbackTexts.errorValidationCategoryInvalidEnum;

	@override
  String get errorValidationLocationInvalidEnum => Crowdin.getText(localeName, 'errorValidationLocationInvalidEnum') ?? _fallbackTexts.errorValidationLocationInvalidEnum;

	@override
  String get errorValidationEquipmentStringTooShort => Crowdin.getText(localeName, 'errorValidationEquipmentStringTooShort') ?? _fallbackTexts.errorValidationEquipmentStringTooShort;

	@override
  String get errorValidationEquipmentNotAString => Crowdin.getText(localeName, 'errorValidationEquipmentNotAString') ?? _fallbackTexts.errorValidationEquipmentNotAString;

	@override
  String get errorValidationEquipmentEmpty => Crowdin.getText(localeName, 'errorValidationEquipmentEmpty') ?? _fallbackTexts.errorValidationEquipmentEmpty;

	@override
  String get errorValidationTargetMusclesStringTooShort => Crowdin.getText(localeName, 'errorValidationTargetMusclesStringTooShort') ?? _fallbackTexts.errorValidationTargetMusclesStringTooShort;

	@override
  String get errorValidationTargetMusclesNotAString => Crowdin.getText(localeName, 'errorValidationTargetMusclesNotAString') ?? _fallbackTexts.errorValidationTargetMusclesNotAString;

	@override
  String get errorValidationTargetMusclesEmpty => Crowdin.getText(localeName, 'errorValidationTargetMusclesEmpty') ?? _fallbackTexts.errorValidationTargetMusclesEmpty;

	@override
  String get errorValidationDurationStringTooShort => Crowdin.getText(localeName, 'errorValidationDurationStringTooShort') ?? _fallbackTexts.errorValidationDurationStringTooShort;

	@override
  String get errorValidationVideoNotUrlAddress => Crowdin.getText(localeName, 'errorValidationVideoNotUrlAddress') ?? _fallbackTexts.errorValidationVideoNotUrlAddress;

	@override
  String get errorValidationProgramIdEmpty => Crowdin.getText(localeName, 'errorValidationProgramIdEmpty') ?? _fallbackTexts.errorValidationProgramIdEmpty;

	@override
  String get errorValidationProgramIdNotANumber => Crowdin.getText(localeName, 'errorValidationProgramIdNotANumber') ?? _fallbackTexts.errorValidationProgramIdNotANumber;

	@override
  String get errorValidationProgramIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationProgramIdNotAnInteger') ?? _fallbackTexts.errorValidationProgramIdNotAnInteger;

	@override
  String get errorValidationProgramIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationProgramIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationProgramIdNotAPositiveNumber;

	@override
  String get errorValidationImageNotUrlAddress => Crowdin.getText(localeName, 'errorValidationImageNotUrlAddress') ?? _fallbackTexts.errorValidationImageNotUrlAddress;

	@override
  String get errorValidationOrderNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationOrderNotAPositiveNumber') ?? _fallbackTexts.errorValidationOrderNotAPositiveNumber;

	@override
  String get errorValidationOrderNotAnInteger => Crowdin.getText(localeName, 'errorValidationOrderNotAnInteger') ?? _fallbackTexts.errorValidationOrderNotAnInteger;

	@override
  String get errorValidationModuleIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationModuleIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationModuleIdNotAPositiveNumber;

	@override
  String get errorValidationModuleIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationModuleIdNotAnInteger') ?? _fallbackTexts.errorValidationModuleIdNotAnInteger;

	@override
  String get errorValidationModuleIdNotANumber => Crowdin.getText(localeName, 'errorValidationModuleIdNotANumber') ?? _fallbackTexts.errorValidationModuleIdNotANumber;

	@override
  String get errorValidationModuleIdEmpty => Crowdin.getText(localeName, 'errorValidationModuleIdEmpty') ?? _fallbackTexts.errorValidationModuleIdEmpty;

	@override
  String get errorValidationExternalIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationExternalIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationExternalIdNotAPositiveNumber;

	@override
  String get errorValidationExternalIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationExternalIdNotAnInteger') ?? _fallbackTexts.errorValidationExternalIdNotAnInteger;

	@override
  String get errorValidationExternalIdNotANumber => Crowdin.getText(localeName, 'errorValidationExternalIdNotANumber') ?? _fallbackTexts.errorValidationExternalIdNotANumber;

	@override
  String get errorValidationExternalIdEmpty => Crowdin.getText(localeName, 'errorValidationExternalIdEmpty') ?? _fallbackTexts.errorValidationExternalIdEmpty;

	@override
  String get errorValidationStreamTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationStreamTypeInvalidEnum') ?? _fallbackTexts.errorValidationStreamTypeInvalidEnum;

	@override
  String get errorValidationStreamTypeEmpty => Crowdin.getText(localeName, 'errorValidationStreamTypeEmpty') ?? _fallbackTexts.errorValidationStreamTypeEmpty;

	@override
  String get errorValidationIconTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationIconTypeInvalidEnum') ?? _fallbackTexts.errorValidationIconTypeInvalidEnum;

	@override
  String get errorValidationIconTypeEmpty => Crowdin.getText(localeName, 'errorValidationIconTypeEmpty') ?? _fallbackTexts.errorValidationIconTypeEmpty;

	@override
  String get errorValidationIsRootItemNotABoolean => Crowdin.getText(localeName, 'errorValidationIsRootItemNotABoolean') ?? _fallbackTexts.errorValidationIsRootItemNotABoolean;

	@override
  String get errorValidationIsRootItemEmpty => Crowdin.getText(localeName, 'errorValidationIsRootItemEmpty') ?? _fallbackTexts.errorValidationIsRootItemEmpty;

	@override
  String get errorValidationLessonExternalIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationLessonExternalIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationLessonExternalIdNotAPositiveNumber;

	@override
  String get errorValidationLessonExternalIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationLessonExternalIdNotAnInteger') ?? _fallbackTexts.errorValidationLessonExternalIdNotAnInteger;

	@override
  String get errorValidationLessonExternalIdNotANumber => Crowdin.getText(localeName, 'errorValidationLessonExternalIdNotANumber') ?? _fallbackTexts.errorValidationLessonExternalIdNotANumber;

	@override
  String get errorValidationLessonExternalIdEmpty => Crowdin.getText(localeName, 'errorValidationLessonExternalIdEmpty') ?? _fallbackTexts.errorValidationLessonExternalIdEmpty;

	@override
  String get errorValidationUnlocksItemExternalIdsNotANumber => Crowdin.getText(localeName, 'errorValidationUnlocksItemExternalIdsNotANumber') ?? _fallbackTexts.errorValidationUnlocksItemExternalIdsNotANumber;

	@override
  String get errorValidationUnlocksItemExternalIdsNotAnArray => Crowdin.getText(localeName, 'errorValidationUnlocksItemExternalIdsNotAnArray') ?? _fallbackTexts.errorValidationUnlocksItemExternalIdsNotAnArray;

	@override
  String get errorValidationUnlocksItemExternalIdsEmpty => Crowdin.getText(localeName, 'errorValidationUnlocksItemExternalIdsEmpty') ?? _fallbackTexts.errorValidationUnlocksItemExternalIdsEmpty;

	@override
  String get errorValidationUnlocksFeatureNotAString => Crowdin.getText(localeName, 'errorValidationUnlocksFeatureNotAString') ?? _fallbackTexts.errorValidationUnlocksFeatureNotAString;

	@override
  String get errorValidationUnlocksFeatureNotAnArray => Crowdin.getText(localeName, 'errorValidationUnlocksFeatureNotAnArray') ?? _fallbackTexts.errorValidationUnlocksFeatureNotAnArray;

	@override
  String get errorValidationUnlocksFeatureEmpty => Crowdin.getText(localeName, 'errorValidationUnlocksFeatureEmpty') ?? _fallbackTexts.errorValidationUnlocksFeatureEmpty;

	@override
  String get errorValidationUnlocksReflectionExternalIdNotANumber => Crowdin.getText(localeName, 'errorValidationUnlocksReflectionExternalIdNotANumber') ?? _fallbackTexts.errorValidationUnlocksReflectionExternalIdNotANumber;

	@override
  String get errorValidationUnlocksReflectionExternalIdEmpty => Crowdin.getText(localeName, 'errorValidationUnlocksReflectionExternalIdEmpty') ?? _fallbackTexts.errorValidationUnlocksReflectionExternalIdEmpty;

	@override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber => Crowdin.getText(localeName, 'errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber') ?? _fallbackTexts.errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber;

	@override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdEmpty => Crowdin.getText(localeName, 'errorValidationUnlocksSmartGoalCategoryExternalIdEmpty') ?? _fallbackTexts.errorValidationUnlocksSmartGoalCategoryExternalIdEmpty;

	@override
  String get errorValidationCrossModuleNotABoolean => Crowdin.getText(localeName, 'errorValidationCrossModuleNotABoolean') ?? _fallbackTexts.errorValidationCrossModuleNotABoolean;

	@override
  String get errorValidationCrossModuleEmpty => Crowdin.getText(localeName, 'errorValidationCrossModuleEmpty') ?? _fallbackTexts.errorValidationCrossModuleEmpty;

	@override
  String get errorValidationFeaturePlacementInvalidEnum => Crowdin.getText(localeName, 'errorValidationFeaturePlacementInvalidEnum') ?? _fallbackTexts.errorValidationFeaturePlacementInvalidEnum;

	@override
  String get errorValidationFeaturePlacementEmpty => Crowdin.getText(localeName, 'errorValidationFeaturePlacementEmpty') ?? _fallbackTexts.errorValidationFeaturePlacementEmpty;

	@override
  String get errorValidationModuleItemsNotAnArray => Crowdin.getText(localeName, 'errorValidationModuleItemsNotAnArray') ?? _fallbackTexts.errorValidationModuleItemsNotAnArray;

	@override
  String get errorValidationModuleItemsEmpty => Crowdin.getText(localeName, 'errorValidationModuleItemsEmpty') ?? _fallbackTexts.errorValidationModuleItemsEmpty;

	@override
  String get errorValidationRiverModuleIdEmpty => Crowdin.getText(localeName, 'errorValidationRiverModuleIdEmpty') ?? _fallbackTexts.errorValidationRiverModuleIdEmpty;

	@override
  String get errorValidationRiverModuleIdNotANumber => Crowdin.getText(localeName, 'errorValidationRiverModuleIdNotANumber') ?? _fallbackTexts.errorValidationRiverModuleIdNotANumber;

	@override
  String get errorValidationRiverModuleIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationRiverModuleIdNotAnInteger') ?? _fallbackTexts.errorValidationRiverModuleIdNotAnInteger;

	@override
  String get errorValidationRiverModuleIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationRiverModuleIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationRiverModuleIdNotAPositiveNumber;

	@override
  String get errorValidationRiverModuleItemIdEmpty => Crowdin.getText(localeName, 'errorValidationRiverModuleItemIdEmpty') ?? _fallbackTexts.errorValidationRiverModuleItemIdEmpty;

	@override
  String get errorValidationRiverModuleItemIdNotANumber => Crowdin.getText(localeName, 'errorValidationRiverModuleItemIdNotANumber') ?? _fallbackTexts.errorValidationRiverModuleItemIdNotANumber;

	@override
  String get errorValidationRiverModuleItemIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationRiverModuleItemIdNotAnInteger') ?? _fallbackTexts.errorValidationRiverModuleItemIdNotAnInteger;

	@override
  String get errorValidationRiverModuleItemIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationRiverModuleItemIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationRiverModuleItemIdNotAPositiveNumber;

	@override
  String get errorValidationLanguageNotAString => Crowdin.getText(localeName, 'errorValidationLanguageNotAString') ?? _fallbackTexts.errorValidationLanguageNotAString;

	@override
  String get errorValidationCountryNotAString => Crowdin.getText(localeName, 'errorValidationCountryNotAString') ?? _fallbackTexts.errorValidationCountryNotAString;

	@override
  String get errorValidationTimezoneOffsetNotANumber => Crowdin.getText(localeName, 'errorValidationTimezoneOffsetNotANumber') ?? _fallbackTexts.errorValidationTimezoneOffsetNotANumber;

	@override
  String get errorValidationTimezoneNameNotAString => Crowdin.getText(localeName, 'errorValidationTimezoneNameNotAString') ?? _fallbackTexts.errorValidationTimezoneNameNotAString;

	@override
  String get errorValidationMeasurementSystemNotAString => Crowdin.getText(localeName, 'errorValidationMeasurementSystemNotAString') ?? _fallbackTexts.errorValidationMeasurementSystemNotAString;

	@override
  String get errorValidationRefreshTokenNotAString => Crowdin.getText(localeName, 'errorValidationRefreshTokenNotAString') ?? _fallbackTexts.errorValidationRefreshTokenNotAString;

	@override
  String get errorValidationDiabetesNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationDiabetesNotAPositiveNumber') ?? _fallbackTexts.errorValidationDiabetesNotAPositiveNumber;

	@override
  String get errorValidationDiabetesNotANumber => Crowdin.getText(localeName, 'errorValidationDiabetesNotANumber') ?? _fallbackTexts.errorValidationDiabetesNotANumber;

	@override
  String get errorValidationTextStringTooLong => Crowdin.getText(localeName, 'errorValidationTextStringTooLong') ?? _fallbackTexts.errorValidationTextStringTooLong;

	@override
  String get errorValidationTextStringTooShort => Crowdin.getText(localeName, 'errorValidationTextStringTooShort') ?? _fallbackTexts.errorValidationTextStringTooShort;

	@override
  String get errorValidationTextEmpty => Crowdin.getText(localeName, 'errorValidationTextEmpty') ?? _fallbackTexts.errorValidationTextEmpty;

	@override
  String get errorValidationTextNotAString => Crowdin.getText(localeName, 'errorValidationTextNotAString') ?? _fallbackTexts.errorValidationTextNotAString;

	@override
  String get errorValidationReplyMessageIdNotANumberString => Crowdin.getText(localeName, 'errorValidationReplyMessageIdNotANumberString') ?? _fallbackTexts.errorValidationReplyMessageIdNotANumberString;

	@override
  String get errorValidationMessageIdNotANumber => Crowdin.getText(localeName, 'errorValidationMessageIdNotANumber') ?? _fallbackTexts.errorValidationMessageIdNotANumber;

	@override
  String get errorValidationMessageIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationMessageIdNotAnInteger') ?? _fallbackTexts.errorValidationMessageIdNotAnInteger;

	@override
  String get errorValidationMessageIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationMessageIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationMessageIdNotAPositiveNumber;

	@override
  String get errorValidationTimeEmpty => Crowdin.getText(localeName, 'errorValidationTimeEmpty') ?? _fallbackTexts.errorValidationTimeEmpty;

	@override
  String get errorValidationTimeNotAString => Crowdin.getText(localeName, 'errorValidationTimeNotAString') ?? _fallbackTexts.errorValidationTimeNotAString;

	@override
  String get errorValidationTimeStringTooLong => Crowdin.getText(localeName, 'errorValidationTimeStringTooLong') ?? _fallbackTexts.errorValidationTimeStringTooLong;

	@override
  String get errorValidationTimeStringTooShort => Crowdin.getText(localeName, 'errorValidationTimeStringTooShort') ?? _fallbackTexts.errorValidationTimeStringTooShort;

	@override
  String get errorValidationSubjectEmpty => Crowdin.getText(localeName, 'errorValidationSubjectEmpty') ?? _fallbackTexts.errorValidationSubjectEmpty;

	@override
  String get errorValidationSubjectNotAString => Crowdin.getText(localeName, 'errorValidationSubjectNotAString') ?? _fallbackTexts.errorValidationSubjectNotAString;

	@override
  String get errorValidationSubjectStringTooLong => Crowdin.getText(localeName, 'errorValidationSubjectStringTooLong') ?? _fallbackTexts.errorValidationSubjectStringTooLong;

	@override
  String get errorValidationSubjectStringTooShort => Crowdin.getText(localeName, 'errorValidationSubjectStringTooShort') ?? _fallbackTexts.errorValidationSubjectStringTooShort;

	@override
  String get errorValidationMessageEmpty => Crowdin.getText(localeName, 'errorValidationMessageEmpty') ?? _fallbackTexts.errorValidationMessageEmpty;

	@override
  String get errorValidationMessageNotAString => Crowdin.getText(localeName, 'errorValidationMessageNotAString') ?? _fallbackTexts.errorValidationMessageNotAString;

	@override
  String get errorValidationMessageStringTooLong => Crowdin.getText(localeName, 'errorValidationMessageStringTooLong') ?? _fallbackTexts.errorValidationMessageStringTooLong;

	@override
  String get errorValidationMessageStringTooShort => Crowdin.getText(localeName, 'errorValidationMessageStringTooShort') ?? _fallbackTexts.errorValidationMessageStringTooShort;

	@override
  String get errorValidationAppVersionEmpty => Crowdin.getText(localeName, 'errorValidationAppVersionEmpty') ?? _fallbackTexts.errorValidationAppVersionEmpty;

	@override
  String get errorValidationAppVersionNotAString => Crowdin.getText(localeName, 'errorValidationAppVersionNotAString') ?? _fallbackTexts.errorValidationAppVersionNotAString;

	@override
  String get errorValidationAppVersionStringTooLong => Crowdin.getText(localeName, 'errorValidationAppVersionStringTooLong') ?? _fallbackTexts.errorValidationAppVersionStringTooLong;

	@override
  String get errorValidationAppVersionStringTooShort => Crowdin.getText(localeName, 'errorValidationAppVersionStringTooShort') ?? _fallbackTexts.errorValidationAppVersionStringTooShort;

	@override
  String get errorValidationEmailTokenEmpty => Crowdin.getText(localeName, 'errorValidationEmailTokenEmpty') ?? _fallbackTexts.errorValidationEmailTokenEmpty;

	@override
  String get errorValidationEmailTokenNotAString => Crowdin.getText(localeName, 'errorValidationEmailTokenNotAString') ?? _fallbackTexts.errorValidationEmailTokenNotAString;

	@override
  String get errorValidationEmailTokenNotAJwt => Crowdin.getText(localeName, 'errorValidationEmailTokenNotAJwt') ?? _fallbackTexts.errorValidationEmailTokenNotAJwt;

	@override
  String get errorValidationExtraAccountsCountNumberTooSmall => Crowdin.getText(localeName, 'errorValidationExtraAccountsCountNumberTooSmall') ?? _fallbackTexts.errorValidationExtraAccountsCountNumberTooSmall;

	@override
  String get errorValidationExtraAccountsCountNotAnInteger => Crowdin.getText(localeName, 'errorValidationExtraAccountsCountNotAnInteger') ?? _fallbackTexts.errorValidationExtraAccountsCountNotAnInteger;

	@override
  String get errorValidationExtraAccountsCountNotANumber => Crowdin.getText(localeName, 'errorValidationExtraAccountsCountNotANumber') ?? _fallbackTexts.errorValidationExtraAccountsCountNotANumber;

	@override
  String get errorValidationUidNotAString => Crowdin.getText(localeName, 'errorValidationUidNotAString') ?? _fallbackTexts.errorValidationUidNotAString;

	@override
  String get errorValidationPlatformInvalidEnum => Crowdin.getText(localeName, 'errorValidationPlatformInvalidEnum') ?? _fallbackTexts.errorValidationPlatformInvalidEnum;

	@override
  String get errorValidationPlatformNotAString => Crowdin.getText(localeName, 'errorValidationPlatformNotAString') ?? _fallbackTexts.errorValidationPlatformNotAString;

	@override
  String get errorValidationDeviceIdNotAString => Crowdin.getText(localeName, 'errorValidationDeviceIdNotAString') ?? _fallbackTexts.errorValidationDeviceIdNotAString;

	@override
  String get errorValidationDeviceIdEmpty => Crowdin.getText(localeName, 'errorValidationDeviceIdEmpty') ?? _fallbackTexts.errorValidationDeviceIdEmpty;

	@override
  String get errorValidationDeviceIdStringTooLong => Crowdin.getText(localeName, 'errorValidationDeviceIdStringTooLong') ?? _fallbackTexts.errorValidationDeviceIdStringTooLong;

	@override
  String get errorValidationAdvertisingIdNotAString => Crowdin.getText(localeName, 'errorValidationAdvertisingIdNotAString') ?? _fallbackTexts.errorValidationAdvertisingIdNotAString;

	@override
  String get errorValidationAdvertisingIdEmpty => Crowdin.getText(localeName, 'errorValidationAdvertisingIdEmpty') ?? _fallbackTexts.errorValidationAdvertisingIdEmpty;

	@override
  String get errorValidationAdvertisingIdStringTooLong => Crowdin.getText(localeName, 'errorValidationAdvertisingIdStringTooLong') ?? _fallbackTexts.errorValidationAdvertisingIdStringTooLong;

	@override
  String get errorValidationLimitNumberTooBig => Crowdin.getText(localeName, 'errorValidationLimitNumberTooBig') ?? _fallbackTexts.errorValidationLimitNumberTooBig;

	@override
  String get errorValidationFromMessageIdNotANumberString => Crowdin.getText(localeName, 'errorValidationFromMessageIdNotANumberString') ?? _fallbackTexts.errorValidationFromMessageIdNotANumberString;

	@override
  String get errorValidationChatMessageIdNotAString => Crowdin.getText(localeName, 'errorValidationChatMessageIdNotAString') ?? _fallbackTexts.errorValidationChatMessageIdNotAString;

	@override
  String get errorValidationChatMessageIdNotANumberString => Crowdin.getText(localeName, 'errorValidationChatMessageIdNotANumberString') ?? _fallbackTexts.errorValidationChatMessageIdNotANumberString;

	@override
  String get errorValidationReflectionIdEmpty => Crowdin.getText(localeName, 'errorValidationReflectionIdEmpty') ?? _fallbackTexts.errorValidationReflectionIdEmpty;

	@override
  String get errorValidationReflectionIdNotANumber => Crowdin.getText(localeName, 'errorValidationReflectionIdNotANumber') ?? _fallbackTexts.errorValidationReflectionIdNotANumber;

	@override
  String get errorValidationReflectionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationReflectionIdNotAnInteger') ?? _fallbackTexts.errorValidationReflectionIdNotAnInteger;

	@override
  String get errorValidationReflectionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationReflectionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationReflectionIdNotAPositiveNumber;

	@override
  String get errorValidationReflectionQuestionIdEmpty => Crowdin.getText(localeName, 'errorValidationReflectionQuestionIdEmpty') ?? _fallbackTexts.errorValidationReflectionQuestionIdEmpty;

	@override
  String get errorValidationReflectionQuestionIdNotANumber => Crowdin.getText(localeName, 'errorValidationReflectionQuestionIdNotANumber') ?? _fallbackTexts.errorValidationReflectionQuestionIdNotANumber;

	@override
  String get errorValidationReflectionQuestionIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationReflectionQuestionIdNotAnInteger') ?? _fallbackTexts.errorValidationReflectionQuestionIdNotAnInteger;

	@override
  String get errorValidationReflectionQuestionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationReflectionQuestionIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationReflectionQuestionIdNotAPositiveNumber;

	@override
  String get errorValidationReflectionQuestionOptionIdsNumberTooBig => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNumberTooBig') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNumberTooBig;

	@override
  String get errorValidationReflectionQuestionOptionIdsNumberTooSmall => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNumberTooSmall') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNumberTooSmall;

	@override
  String get errorValidationReflectionQuestionOptionIdsNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNotAPositiveNumber') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNotAPositiveNumber;

	@override
  String get errorValidationReflectionQuestionOptionIdsNotAnInteger => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNotAnInteger') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNotAnInteger;

	@override
  String get errorValidationReflectionQuestionOptionIdsNotANumber => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNotANumber') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNotANumber;

	@override
  String get errorValidationReflectionQuestionOptionIdsEmptyArray => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsEmptyArray') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsEmptyArray;

	@override
  String get errorValidationReflectionQuestionOptionIdsNotAnArray => Crowdin.getText(localeName, 'errorValidationReflectionQuestionOptionIdsNotAnArray') ?? _fallbackTexts.errorValidationReflectionQuestionOptionIdsNotAnArray;

	@override
  String get errorValidationValueNumberTooBig => Crowdin.getText(localeName, 'errorValidationValueNumberTooBig') ?? _fallbackTexts.errorValidationValueNumberTooBig;

	@override
  String get errorValidationValueNumberTooSmall => Crowdin.getText(localeName, 'errorValidationValueNumberTooSmall') ?? _fallbackTexts.errorValidationValueNumberTooSmall;

	@override
  String get errorValidationValueNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationValueNotAPositiveNumber') ?? _fallbackTexts.errorValidationValueNotAPositiveNumber;

	@override
  String get errorValidationValueNotAnInteger => Crowdin.getText(localeName, 'errorValidationValueNotAnInteger') ?? _fallbackTexts.errorValidationValueNotAnInteger;

	@override
  String get errorValidationValueNotANumber => Crowdin.getText(localeName, 'errorValidationValueNotANumber') ?? _fallbackTexts.errorValidationValueNotANumber;

	@override
  String get errorValidationLessonIdEmpty => Crowdin.getText(localeName, 'errorValidationLessonIdEmpty') ?? _fallbackTexts.errorValidationLessonIdEmpty;

	@override
  String get errorValidationLessonIdNotANumber => Crowdin.getText(localeName, 'errorValidationLessonIdNotANumber') ?? _fallbackTexts.errorValidationLessonIdNotANumber;

	@override
  String get errorValidationLessonIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationLessonIdNotAnInteger') ?? _fallbackTexts.errorValidationLessonIdNotAnInteger;

	@override
  String get errorValidationLessonIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationLessonIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationLessonIdNotAPositiveNumber;

	@override
  String get errorValidationLabelNotAString => Crowdin.getText(localeName, 'errorValidationLabelNotAString') ?? _fallbackTexts.errorValidationLabelNotAString;

	@override
  String get errorValidationIsCorrectNotABoolean => Crowdin.getText(localeName, 'errorValidationIsCorrectNotABoolean') ?? _fallbackTexts.errorValidationIsCorrectNotABoolean;

	@override
  String get errorValidationMinValueNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationMinValueNotAPositiveNumber') ?? _fallbackTexts.errorValidationMinValueNotAPositiveNumber;

	@override
  String get errorValidationMinValueNotAnInteger => Crowdin.getText(localeName, 'errorValidationMinValueNotAnInteger') ?? _fallbackTexts.errorValidationMinValueNotAnInteger;

	@override
  String get errorValidationMinValueNotANumber => Crowdin.getText(localeName, 'errorValidationMinValueNotANumber') ?? _fallbackTexts.errorValidationMinValueNotANumber;

	@override
  String get errorValidationMaxValueNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationMaxValueNotAPositiveNumber') ?? _fallbackTexts.errorValidationMaxValueNotAPositiveNumber;

	@override
  String get errorValidationMaxValueNotAnInteger => Crowdin.getText(localeName, 'errorValidationMaxValueNotAnInteger') ?? _fallbackTexts.errorValidationMaxValueNotAnInteger;

	@override
  String get errorValidationMaxValueNotANumber => Crowdin.getText(localeName, 'errorValidationMaxValueNotANumber') ?? _fallbackTexts.errorValidationMaxValueNotANumber;

	@override
  String get errorValidationLowestTextNotAString => Crowdin.getText(localeName, 'errorValidationLowestTextNotAString') ?? _fallbackTexts.errorValidationLowestTextNotAString;

	@override
  String get errorValidationHighestTextNotAString => Crowdin.getText(localeName, 'errorValidationHighestTextNotAString') ?? _fallbackTexts.errorValidationHighestTextNotAString;

	@override
  String get errorValidationScaleNotAnArray => Crowdin.getText(localeName, 'errorValidationScaleNotAnArray') ?? _fallbackTexts.errorValidationScaleNotAnArray;

	@override
  String get errorValidationQuestionNotAString => Crowdin.getText(localeName, 'errorValidationQuestionNotAString') ?? _fallbackTexts.errorValidationQuestionNotAString;

	@override
  String get errorValidationAnswerTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationAnswerTypeInvalidEnum') ?? _fallbackTexts.errorValidationAnswerTypeInvalidEnum;

	@override
  String get errorValidationAnswerTypeNotAString => Crowdin.getText(localeName, 'errorValidationAnswerTypeNotAString') ?? _fallbackTexts.errorValidationAnswerTypeNotAString;

	@override
  String get errorValidationIntroductionNotAString => Crowdin.getText(localeName, 'errorValidationIntroductionNotAString') ?? _fallbackTexts.errorValidationIntroductionNotAString;

	@override
  String get errorValidationFeedbackNotAnArray => Crowdin.getText(localeName, 'errorValidationFeedbackNotAnArray') ?? _fallbackTexts.errorValidationFeedbackNotAnArray;

	@override
  String get errorValidationExtraInstructionNotAString => Crowdin.getText(localeName, 'errorValidationExtraInstructionNotAString') ?? _fallbackTexts.errorValidationExtraInstructionNotAString;

	@override
  String get errorValidationInstructionNotAString => Crowdin.getText(localeName, 'errorValidationInstructionNotAString') ?? _fallbackTexts.errorValidationInstructionNotAString;

	@override
  String get errorValidationCategoryNotAString => Crowdin.getText(localeName, 'errorValidationCategoryNotAString') ?? _fallbackTexts.errorValidationCategoryNotAString;

	@override
  String get errorValidationExternalLessonIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationExternalLessonIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationExternalLessonIdNotAPositiveNumber;

	@override
  String get errorValidationExternalLessonIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationExternalLessonIdNotAnInteger') ?? _fallbackTexts.errorValidationExternalLessonIdNotAnInteger;

	@override
  String get errorValidationExternalLessonIdNotANumber => Crowdin.getText(localeName, 'errorValidationExternalLessonIdNotANumber') ?? _fallbackTexts.errorValidationExternalLessonIdNotANumber;

	@override
  String get errorValidationQuestionsNotAnArray => Crowdin.getText(localeName, 'errorValidationQuestionsNotAnArray') ?? _fallbackTexts.errorValidationQuestionsNotAnArray;

	@override
  String get errorValidationOrderNotANumber => Crowdin.getText(localeName, 'errorValidationOrderNotANumber') ?? _fallbackTexts.errorValidationOrderNotANumber;

	@override
  String get errorValidationOrderEmpty => Crowdin.getText(localeName, 'errorValidationOrderEmpty') ?? _fallbackTexts.errorValidationOrderEmpty;

	@override
  String get errorValidationContentTypeInvalidEnum => Crowdin.getText(localeName, 'errorValidationContentTypeInvalidEnum') ?? _fallbackTexts.errorValidationContentTypeInvalidEnum;

	@override
  String get errorValidationContentTypeNotAString => Crowdin.getText(localeName, 'errorValidationContentTypeNotAString') ?? _fallbackTexts.errorValidationContentTypeNotAString;

	@override
  String get errorValidationContentTypeEmpty => Crowdin.getText(localeName, 'errorValidationContentTypeEmpty') ?? _fallbackTexts.errorValidationContentTypeEmpty;

	@override
  String get errorValidationCardImageUrlNotAString => Crowdin.getText(localeName, 'errorValidationCardImageUrlNotAString') ?? _fallbackTexts.errorValidationCardImageUrlNotAString;

	@override
  String get errorValidationImageUrlNotAString => Crowdin.getText(localeName, 'errorValidationImageUrlNotAString') ?? _fallbackTexts.errorValidationImageUrlNotAString;

	@override
  String get errorValidationAudioUrlNotAString => Crowdin.getText(localeName, 'errorValidationAudioUrlNotAString') ?? _fallbackTexts.errorValidationAudioUrlNotAString;

	@override
  String get errorValidationHtmlUrlNotAString => Crowdin.getText(localeName, 'errorValidationHtmlUrlNotAString') ?? _fallbackTexts.errorValidationHtmlUrlNotAString;

	@override
  String get errorValidationSubtitlesImagesNotAString => Crowdin.getText(localeName, 'errorValidationSubtitlesImagesNotAString') ?? _fallbackTexts.errorValidationSubtitlesImagesNotAString;

	@override
  String get errorValidationConclusionNotAString => Crowdin.getText(localeName, 'errorValidationConclusionNotAString') ?? _fallbackTexts.errorValidationConclusionNotAString;

	@override
  String get errorValidationUnlockTitleNotAString => Crowdin.getText(localeName, 'errorValidationUnlockTitleNotAString') ?? _fallbackTexts.errorValidationUnlockTitleNotAString;

	@override
  String get errorValidationUnlockDescriptionNotAString => Crowdin.getText(localeName, 'errorValidationUnlockDescriptionNotAString') ?? _fallbackTexts.errorValidationUnlockDescriptionNotAString;

	@override
  String get errorValidationAudioEmpty => Crowdin.getText(localeName, 'errorValidationAudioEmpty') ?? _fallbackTexts.errorValidationAudioEmpty;

	@override
  String get errorValidationAudioNotAString => Crowdin.getText(localeName, 'errorValidationAudioNotAString') ?? _fallbackTexts.errorValidationAudioNotAString;

	@override
  String get errorValidationSubtitlesImagesEmpty => Crowdin.getText(localeName, 'errorValidationSubtitlesImagesEmpty') ?? _fallbackTexts.errorValidationSubtitlesImagesEmpty;

	@override
  String get errorValidationCorrectNotAString => Crowdin.getText(localeName, 'errorValidationCorrectNotAString') ?? _fallbackTexts.errorValidationCorrectNotAString;

	@override
  String get errorValidationIncorrectNotAString => Crowdin.getText(localeName, 'errorValidationIncorrectNotAString') ?? _fallbackTexts.errorValidationIncorrectNotAString;

	@override
  String get errorValidationVisualEmpty => Crowdin.getText(localeName, 'errorValidationVisualEmpty') ?? _fallbackTexts.errorValidationVisualEmpty;

	@override
  String get errorValidationVisualNotAString => Crowdin.getText(localeName, 'errorValidationVisualNotAString') ?? _fallbackTexts.errorValidationVisualNotAString;

	@override
  String get errorValidationCompletionTimeNotAString => Crowdin.getText(localeName, 'errorValidationCompletionTimeNotAString') ?? _fallbackTexts.errorValidationCompletionTimeNotAString;

	@override
  String get errorValidationCompletionTimeEmpty => Crowdin.getText(localeName, 'errorValidationCompletionTimeEmpty') ?? _fallbackTexts.errorValidationCompletionTimeEmpty;

	@override
  String get errorValidationLessonsArraySizeTooSmall => Crowdin.getText(localeName, 'errorValidationLessonsArraySizeTooSmall') ?? _fallbackTexts.errorValidationLessonsArraySizeTooSmall;

	@override
  String get errorValidationLessonsNotAnArray => Crowdin.getText(localeName, 'errorValidationLessonsNotAnArray') ?? _fallbackTexts.errorValidationLessonsNotAnArray;

	@override
  String get errorValidationLessonQuizIdEmpty => Crowdin.getText(localeName, 'errorValidationLessonQuizIdEmpty') ?? _fallbackTexts.errorValidationLessonQuizIdEmpty;

	@override
  String get errorValidationLessonQuizIdNotANumber => Crowdin.getText(localeName, 'errorValidationLessonQuizIdNotANumber') ?? _fallbackTexts.errorValidationLessonQuizIdNotANumber;

	@override
  String get errorValidationLessonQuizIdNotAnInteger => Crowdin.getText(localeName, 'errorValidationLessonQuizIdNotAnInteger') ?? _fallbackTexts.errorValidationLessonQuizIdNotAnInteger;

	@override
  String get errorValidationLessonQuizIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorValidationLessonQuizIdNotAPositiveNumber') ?? _fallbackTexts.errorValidationLessonQuizIdNotAPositiveNumber;

	@override
  String get errorValidationLessonQuizQuestionOptionIdsNumberTooBig => Crowdin.getText(localeName, 'errorValidationLessonQuizQuestionOptionIdsNumberTooBig') ?? _fallbackTexts.errorValidationLessonQuizQuestionOptionIdsNumberTooBig;

	@override
  String get errorLessonQuizQuestionOptionIdsNumberTooSmall => Crowdin.getText(localeName, 'errorLessonQuizQuestionOptionIdsNumberTooSmall') ?? _fallbackTexts.errorLessonQuizQuestionOptionIdsNumberTooSmall;

	@override
  String get errorLessonQuizQuestionOptionIdsNotAPositiveNumber => Crowdin.getText(localeName, 'errorLessonQuizQuestionOptionIdsNotAPositiveNumber') ?? _fallbackTexts.errorLessonQuizQuestionOptionIdsNotAPositiveNumber;

	@override
  String get errorLessonQuizQuestionOptionIdsNotAnInteger => Crowdin.getText(localeName, 'errorLessonQuizQuestionOptionIdsNotAnInteger') ?? _fallbackTexts.errorLessonQuizQuestionOptionIdsNotAnInteger;

	@override
  String get errorLessonQuizQuestionOptionIdsNotANumber => Crowdin.getText(localeName, 'errorLessonQuizQuestionOptionIdsNotANumber') ?? _fallbackTexts.errorLessonQuizQuestionOptionIdsNotANumber;

	@override
  String get errorLessonQuizQuestionOptionIdsNotAnArray => Crowdin.getText(localeName, 'errorLessonQuizQuestionOptionIdsNotAnArray') ?? _fallbackTexts.errorLessonQuizQuestionOptionIdsNotAnArray;

	@override
  String get errorLessonQuizQuestionIdEmpty => Crowdin.getText(localeName, 'errorLessonQuizQuestionIdEmpty') ?? _fallbackTexts.errorLessonQuizQuestionIdEmpty;

	@override
  String get errorLessonQuizQuestionIdNotANumber => Crowdin.getText(localeName, 'errorLessonQuizQuestionIdNotANumber') ?? _fallbackTexts.errorLessonQuizQuestionIdNotANumber;

	@override
  String get errorLessonQuizQuestionIdNotAnInteger => Crowdin.getText(localeName, 'errorLessonQuizQuestionIdNotAnInteger') ?? _fallbackTexts.errorLessonQuizQuestionIdNotAnInteger;

	@override
  String get errorLessonQuizQuestionIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorLessonQuizQuestionIdNotAPositiveNumber') ?? _fallbackTexts.errorLessonQuizQuestionIdNotAPositiveNumber;

	@override
  String get errorExplanationTypeInvalidEnum => Crowdin.getText(localeName, 'errorExplanationTypeInvalidEnum') ?? _fallbackTexts.errorExplanationTypeInvalidEnum;

	@override
  String get errorExplanationTypeNotAString => Crowdin.getText(localeName, 'errorExplanationTypeNotAString') ?? _fallbackTexts.errorExplanationTypeNotAString;

	@override
  String get errorExplanationTypeEmpty => Crowdin.getText(localeName, 'errorExplanationTypeEmpty') ?? _fallbackTexts.errorExplanationTypeEmpty;

	@override
  String get errorExplanationSrcNotAString => Crowdin.getText(localeName, 'errorExplanationSrcNotAString') ?? _fallbackTexts.errorExplanationSrcNotAString;

	@override
  String get errorExplanationSrcEmpty => Crowdin.getText(localeName, 'errorExplanationSrcEmpty') ?? _fallbackTexts.errorExplanationSrcEmpty;

	@override
  String get errorExplanationDurationNotAPositiveNumber => Crowdin.getText(localeName, 'errorExplanationDurationNotAPositiveNumber') ?? _fallbackTexts.errorExplanationDurationNotAPositiveNumber;

	@override
  String get errorExplanationDurationNotANumber => Crowdin.getText(localeName, 'errorExplanationDurationNotANumber') ?? _fallbackTexts.errorExplanationDurationNotANumber;

	@override
  String get errorExplanationDurationEmpty => Crowdin.getText(localeName, 'errorExplanationDurationEmpty') ?? _fallbackTexts.errorExplanationDurationEmpty;

	@override
  String get errorExplanationOrientationInvalidEnum => Crowdin.getText(localeName, 'errorExplanationOrientationInvalidEnum') ?? _fallbackTexts.errorExplanationOrientationInvalidEnum;

	@override
  String get errorExplanationOrientationNotAString => Crowdin.getText(localeName, 'errorExplanationOrientationNotAString') ?? _fallbackTexts.errorExplanationOrientationNotAString;

	@override
  String get errorExerciseTypeInvalidEnum => Crowdin.getText(localeName, 'errorExerciseTypeInvalidEnum') ?? _fallbackTexts.errorExerciseTypeInvalidEnum;

	@override
  String get errorExerciseTypeNotAString => Crowdin.getText(localeName, 'errorExerciseTypeNotAString') ?? _fallbackTexts.errorExerciseTypeNotAString;

	@override
  String get errorExerciseTypeEmpty => Crowdin.getText(localeName, 'errorExerciseTypeEmpty') ?? _fallbackTexts.errorExerciseTypeEmpty;

	@override
  String get errorExerciseOrientationInvalidEnum => Crowdin.getText(localeName, 'errorExerciseOrientationInvalidEnum') ?? _fallbackTexts.errorExerciseOrientationInvalidEnum;

	@override
  String get errorExerciseOrientationNotAString => Crowdin.getText(localeName, 'errorExerciseOrientationNotAString') ?? _fallbackTexts.errorExerciseOrientationNotAString;

	@override
  String get errorExerciseOrientationEmpty => Crowdin.getText(localeName, 'errorExerciseOrientationEmpty') ?? _fallbackTexts.errorExerciseOrientationEmpty;

	@override
  String get errorExerciseDurationNotAPositiveNumber => Crowdin.getText(localeName, 'errorExerciseDurationNotAPositiveNumber') ?? _fallbackTexts.errorExerciseDurationNotAPositiveNumber;

	@override
  String get errorExerciseDurationNotANumber => Crowdin.getText(localeName, 'errorExerciseDurationNotANumber') ?? _fallbackTexts.errorExerciseDurationNotANumber;

	@override
  String get errorExerciseDurationEmpty => Crowdin.getText(localeName, 'errorExerciseDurationEmpty') ?? _fallbackTexts.errorExerciseDurationEmpty;

	@override
  String get errorExerciseSrcNotAString => Crowdin.getText(localeName, 'errorExerciseSrcNotAString') ?? _fallbackTexts.errorExerciseSrcNotAString;

	@override
  String get errorExerciseSrcEmpty => Crowdin.getText(localeName, 'errorExerciseSrcEmpty') ?? _fallbackTexts.errorExerciseSrcEmpty;

	@override
  String get errorShortDescriptionNotAString => Crowdin.getText(localeName, 'errorShortDescriptionNotAString') ?? _fallbackTexts.errorShortDescriptionNotAString;

	@override
  String get errorShortDescriptionEmpty => Crowdin.getText(localeName, 'errorShortDescriptionEmpty') ?? _fallbackTexts.errorShortDescriptionEmpty;

	@override
  String get errorDifficultyEmpty => Crowdin.getText(localeName, 'errorDifficultyEmpty') ?? _fallbackTexts.errorDifficultyEmpty;

	@override
  String get errorScaleBeforeQuestionNotAString => Crowdin.getText(localeName, 'errorScaleBeforeQuestionNotAString') ?? _fallbackTexts.errorScaleBeforeQuestionNotAString;

	@override
  String get errorScaleBeforeLowestTextNotAString => Crowdin.getText(localeName, 'errorScaleBeforeLowestTextNotAString') ?? _fallbackTexts.errorScaleBeforeLowestTextNotAString;

	@override
  String get errorScaleBeforeHighestTextNotAString => Crowdin.getText(localeName, 'errorScaleBeforeHighestTextNotAString') ?? _fallbackTexts.errorScaleBeforeHighestTextNotAString;

	@override
  String get errorScaleAfterQuestionNotAString => Crowdin.getText(localeName, 'errorScaleAfterQuestionNotAString') ?? _fallbackTexts.errorScaleAfterQuestionNotAString;

	@override
  String get errorScaleAfterLowestTextNotAString => Crowdin.getText(localeName, 'errorScaleAfterLowestTextNotAString') ?? _fallbackTexts.errorScaleAfterLowestTextNotAString;

	@override
  String get errorScaleAfterHighestTextNotAString => Crowdin.getText(localeName, 'errorScaleAfterHighestTextNotAString') ?? _fallbackTexts.errorScaleAfterHighestTextNotAString;

	@override
  String get errorTechniqueIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorTechniqueIdNotAPositiveNumber') ?? _fallbackTexts.errorTechniqueIdNotAPositiveNumber;

	@override
  String get errorTechniqueIdNotAnInteger => Crowdin.getText(localeName, 'errorTechniqueIdNotAnInteger') ?? _fallbackTexts.errorTechniqueIdNotAnInteger;

	@override
  String get errorTechniqueIdNotANumber => Crowdin.getText(localeName, 'errorTechniqueIdNotANumber') ?? _fallbackTexts.errorTechniqueIdNotANumber;

	@override
  String get errorTechniqueIdEmpty => Crowdin.getText(localeName, 'errorTechniqueIdEmpty') ?? _fallbackTexts.errorTechniqueIdEmpty;

	@override
  String get errorSubtitleNotAString => Crowdin.getText(localeName, 'errorSubtitleNotAString') ?? _fallbackTexts.errorSubtitleNotAString;

	@override
  String get errorSubtitleEmpty => Crowdin.getText(localeName, 'errorSubtitleEmpty') ?? _fallbackTexts.errorSubtitleEmpty;

	@override
  String get errorShortIntroductionNotAString => Crowdin.getText(localeName, 'errorShortIntroductionNotAString') ?? _fallbackTexts.errorShortIntroductionNotAString;

	@override
  String get errorShortIntroductionEmpty => Crowdin.getText(localeName, 'errorShortIntroductionEmpty') ?? _fallbackTexts.errorShortIntroductionEmpty;

	@override
  String get errorExplanationEmptyArray => Crowdin.getText(localeName, 'errorExplanationEmptyArray') ?? _fallbackTexts.errorExplanationEmptyArray;

	@override
  String get errorExplanationNotAnArray => Crowdin.getText(localeName, 'errorExplanationNotAnArray') ?? _fallbackTexts.errorExplanationNotAnArray;

	@override
  String get errorTechniquesEmptyArray => Crowdin.getText(localeName, 'errorTechniquesEmptyArray') ?? _fallbackTexts.errorTechniquesEmptyArray;

	@override
  String get errorTechniquesNotAnArray => Crowdin.getText(localeName, 'errorTechniquesNotAnArray') ?? _fallbackTexts.errorTechniquesNotAnArray;

	@override
  String get errorExternalTechniqueIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorExternalTechniqueIdNotAPositiveNumber') ?? _fallbackTexts.errorExternalTechniqueIdNotAPositiveNumber;

	@override
  String get errorExternalTechniqueIdNotAnInteger => Crowdin.getText(localeName, 'errorExternalTechniqueIdNotAnInteger') ?? _fallbackTexts.errorExternalTechniqueIdNotAnInteger;

	@override
  String get errorExternalTechniqueIdNotANumber => Crowdin.getText(localeName, 'errorExternalTechniqueIdNotANumber') ?? _fallbackTexts.errorExternalTechniqueIdNotANumber;

	@override
  String get errorExternalTechniqueIdEmpty => Crowdin.getText(localeName, 'errorExternalTechniqueIdEmpty') ?? _fallbackTexts.errorExternalTechniqueIdEmpty;

	@override
  String get errorExerciseUnlockStyleInvalidEnum => Crowdin.getText(localeName, 'errorExerciseUnlockStyleInvalidEnum') ?? _fallbackTexts.errorExerciseUnlockStyleInvalidEnum;

	@override
  String get errorExerciseUnlockStyleNotAString => Crowdin.getText(localeName, 'errorExerciseUnlockStyleNotAString') ?? _fallbackTexts.errorExerciseUnlockStyleNotAString;

	@override
  String get errorExerciseUnlockStyleEmpty => Crowdin.getText(localeName, 'errorExerciseUnlockStyleEmpty') ?? _fallbackTexts.errorExerciseUnlockStyleEmpty;

	@override
  String get errorExercisesNotAnArray => Crowdin.getText(localeName, 'errorExercisesNotAnArray') ?? _fallbackTexts.errorExercisesNotAnArray;

	@override
  String get errorScaleBeforeAnswerNumberTooBig => Crowdin.getText(localeName, 'errorScaleBeforeAnswerNumberTooBig') ?? _fallbackTexts.errorScaleBeforeAnswerNumberTooBig;

	@override
  String get errorScaleBeforeAnswerNumberTooSmall => Crowdin.getText(localeName, 'errorScaleBeforeAnswerNumberTooSmall') ?? _fallbackTexts.errorScaleBeforeAnswerNumberTooSmall;

	@override
  String get errorScaleBeforeAnswerNotAnInteger => Crowdin.getText(localeName, 'errorScaleBeforeAnswerNotAnInteger') ?? _fallbackTexts.errorScaleBeforeAnswerNotAnInteger;

	@override
  String get errorScaleBeforeAnswerNotANumber => Crowdin.getText(localeName, 'errorScaleBeforeAnswerNotANumber') ?? _fallbackTexts.errorScaleBeforeAnswerNotANumber;

	@override
  String get errorScaleAfterAnswerNumberTooBig => Crowdin.getText(localeName, 'errorScaleAfterAnswerNumberTooBig') ?? _fallbackTexts.errorScaleAfterAnswerNumberTooBig;

	@override
  String get errorScaleAfterAnswerNumberTooSmall => Crowdin.getText(localeName, 'errorScaleAfterAnswerNumberTooSmall') ?? _fallbackTexts.errorScaleAfterAnswerNumberTooSmall;

	@override
  String get errorScaleAfterAnswerNotAnInteger => Crowdin.getText(localeName, 'errorScaleAfterAnswerNotAnInteger') ?? _fallbackTexts.errorScaleAfterAnswerNotAnInteger;

	@override
  String get errorScaleAfterAnswerNotANumber => Crowdin.getText(localeName, 'errorScaleAfterAnswerNotANumber') ?? _fallbackTexts.errorScaleAfterAnswerNotANumber;

	@override
  String get errorScaleEmpty => Crowdin.getText(localeName, 'errorScaleEmpty') ?? _fallbackTexts.errorScaleEmpty;

	@override
  String get errorScaleInvalidEnum => Crowdin.getText(localeName, 'errorScaleInvalidEnum') ?? _fallbackTexts.errorScaleInvalidEnum;

	@override
  String get errorTimeNotADateString => Crowdin.getText(localeName, 'errorTimeNotADateString') ?? _fallbackTexts.errorTimeNotADateString;

	@override
  String get errorEmotionNotAnArray => Crowdin.getText(localeName, 'errorEmotionNotAnArray') ?? _fallbackTexts.errorEmotionNotAnArray;

	@override
  String get errorEmotionArrayContainsDuplicates => Crowdin.getText(localeName, 'errorEmotionArrayContainsDuplicates') ?? _fallbackTexts.errorEmotionArrayContainsDuplicates;

	@override
  String get errorEmotionArraySizeTooBig => Crowdin.getText(localeName, 'errorEmotionArraySizeTooBig') ?? _fallbackTexts.errorEmotionArraySizeTooBig;

	@override
  String get errorEmotionNotAString => Crowdin.getText(localeName, 'errorEmotionNotAString') ?? _fallbackTexts.errorEmotionNotAString;

	@override
  String get errorEmotionInvalidEnum => Crowdin.getText(localeName, 'errorEmotionInvalidEnum') ?? _fallbackTexts.errorEmotionInvalidEnum;

	@override
  String get errorPersonNotAnArray => Crowdin.getText(localeName, 'errorPersonNotAnArray') ?? _fallbackTexts.errorPersonNotAnArray;

	@override
  String get errorPersonArrayContainsDuplicates => Crowdin.getText(localeName, 'errorPersonArrayContainsDuplicates') ?? _fallbackTexts.errorPersonArrayContainsDuplicates;

	@override
  String get errorPersonArraySizeTooBig => Crowdin.getText(localeName, 'errorPersonArraySizeTooBig') ?? _fallbackTexts.errorPersonArraySizeTooBig;

	@override
  String get errorPersonNotAString => Crowdin.getText(localeName, 'errorPersonNotAString') ?? _fallbackTexts.errorPersonNotAString;

	@override
  String get errorPersonInvalidEnum => Crowdin.getText(localeName, 'errorPersonInvalidEnum') ?? _fallbackTexts.errorPersonInvalidEnum;

	@override
  String get errorLocationNotAnArray => Crowdin.getText(localeName, 'errorLocationNotAnArray') ?? _fallbackTexts.errorLocationNotAnArray;

	@override
  String get errorLocationArrayContainsDuplicates => Crowdin.getText(localeName, 'errorLocationArrayContainsDuplicates') ?? _fallbackTexts.errorLocationArrayContainsDuplicates;

	@override
  String get errorLocationArraySizeTooBig => Crowdin.getText(localeName, 'errorLocationArraySizeTooBig') ?? _fallbackTexts.errorLocationArraySizeTooBig;

	@override
  String get errorLocationNotAString => Crowdin.getText(localeName, 'errorLocationNotAString') ?? _fallbackTexts.errorLocationNotAString;

	@override
  String get errorFoodNotAnArray => Crowdin.getText(localeName, 'errorFoodNotAnArray') ?? _fallbackTexts.errorFoodNotAnArray;

	@override
  String get errorFoodArrayContainsDuplicates => Crowdin.getText(localeName, 'errorFoodArrayContainsDuplicates') ?? _fallbackTexts.errorFoodArrayContainsDuplicates;

	@override
  String get errorFoodArraySizeTooBig => Crowdin.getText(localeName, 'errorFoodArraySizeTooBig') ?? _fallbackTexts.errorFoodArraySizeTooBig;

	@override
  String get errorFoodNotAString => Crowdin.getText(localeName, 'errorFoodNotAString') ?? _fallbackTexts.errorFoodNotAString;

	@override
  String get errorFoodInvalidEnum => Crowdin.getText(localeName, 'errorFoodInvalidEnum') ?? _fallbackTexts.errorFoodInvalidEnum;

	@override
  String get errorNoteNotAString => Crowdin.getText(localeName, 'errorNoteNotAString') ?? _fallbackTexts.errorNoteNotAString;

	@override
  String get errorNoteStringTooShort => Crowdin.getText(localeName, 'errorNoteStringTooShort') ?? _fallbackTexts.errorNoteStringTooShort;

	@override
  String get errorNoteStringTooLong => Crowdin.getText(localeName, 'errorNoteStringTooLong') ?? _fallbackTexts.errorNoteStringTooLong;

	@override
  String get errorMoodIdEmpty => Crowdin.getText(localeName, 'errorMoodIdEmpty') ?? _fallbackTexts.errorMoodIdEmpty;

	@override
  String get errorMoodIdNotANumber => Crowdin.getText(localeName, 'errorMoodIdNotANumber') ?? _fallbackTexts.errorMoodIdNotANumber;

	@override
  String get errorMoodIdNotAnInteger => Crowdin.getText(localeName, 'errorMoodIdNotAnInteger') ?? _fallbackTexts.errorMoodIdNotAnInteger;

	@override
  String get errorMoodIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorMoodIdNotAPositiveNumber') ?? _fallbackTexts.errorMoodIdNotAPositiveNumber;

	@override
  String get errorExternalIdNotANumberString => Crowdin.getText(localeName, 'errorExternalIdNotANumberString') ?? _fallbackTexts.errorExternalIdNotANumberString;

	@override
  String get errorShortTitleNotAString => Crowdin.getText(localeName, 'errorShortTitleNotAString') ?? _fallbackTexts.errorShortTitleNotAString;

	@override
  String get errorShortTitleEmpty => Crowdin.getText(localeName, 'errorShortTitleEmpty') ?? _fallbackTexts.errorShortTitleEmpty;

	@override
  String get errorDescriptionNotAString => Crowdin.getText(localeName, 'errorDescriptionNotAString') ?? _fallbackTexts.errorDescriptionNotAString;

	@override
  String get errorDescriptionEmpty => Crowdin.getText(localeName, 'errorDescriptionEmpty') ?? _fallbackTexts.errorDescriptionEmpty;

	@override
  String get errorFunFactNotAString => Crowdin.getText(localeName, 'errorFunFactNotAString') ?? _fallbackTexts.errorFunFactNotAString;

	@override
  String get errorFunFactEmpty => Crowdin.getText(localeName, 'errorFunFactEmpty') ?? _fallbackTexts.errorFunFactEmpty;

	@override
  String get errorRequiredCompletionDaysNotANumber => Crowdin.getText(localeName, 'errorRequiredCompletionDaysNotANumber') ?? _fallbackTexts.errorRequiredCompletionDaysNotANumber;

	@override
  String get errorRequiredCompletionDaysNotAnInteger => Crowdin.getText(localeName, 'errorRequiredCompletionDaysNotAnInteger') ?? _fallbackTexts.errorRequiredCompletionDaysNotAnInteger;

	@override
  String get errorRequiredCompletionDaysNotAPositiveNumber => Crowdin.getText(localeName, 'errorRequiredCompletionDaysNotAPositiveNumber') ?? _fallbackTexts.errorRequiredCompletionDaysNotAPositiveNumber;

	@override
  String get errorLengthInDaysNotANumber => Crowdin.getText(localeName, 'errorLengthInDaysNotANumber') ?? _fallbackTexts.errorLengthInDaysNotANumber;

	@override
  String get errorLengthInDaysNotAnInteger => Crowdin.getText(localeName, 'errorLengthInDaysNotAnInteger') ?? _fallbackTexts.errorLengthInDaysNotAnInteger;

	@override
  String get errorLengthInDaysNotAPositiveNumber => Crowdin.getText(localeName, 'errorLengthInDaysNotAPositiveNumber') ?? _fallbackTexts.errorLengthInDaysNotAPositiveNumber;

	@override
  String get errorLengthInDaysNumberTooBig => Crowdin.getText(localeName, 'errorLengthInDaysNumberTooBig') ?? _fallbackTexts.errorLengthInDaysNumberTooBig;

	@override
  String get errorRelatedExternalGoalIdsNotAPositiveNumber => Crowdin.getText(localeName, 'errorRelatedExternalGoalIdsNotAPositiveNumber') ?? _fallbackTexts.errorRelatedExternalGoalIdsNotAPositiveNumber;

	@override
  String get errorRelatedExternalGoalIdsNotAnInteger => Crowdin.getText(localeName, 'errorRelatedExternalGoalIdsNotAnInteger') ?? _fallbackTexts.errorRelatedExternalGoalIdsNotAnInteger;

	@override
  String get errorRelatedExternalGoalIdsNotANumber => Crowdin.getText(localeName, 'errorRelatedExternalGoalIdsNotANumber') ?? _fallbackTexts.errorRelatedExternalGoalIdsNotANumber;

	@override
  String get errorRelatedExternalGoalIdsNotAnArray => Crowdin.getText(localeName, 'errorRelatedExternalGoalIdsNotAnArray') ?? _fallbackTexts.errorRelatedExternalGoalIdsNotAnArray;

	@override
  String get errorGoalIdEmpty => Crowdin.getText(localeName, 'errorGoalIdEmpty') ?? _fallbackTexts.errorGoalIdEmpty;

	@override
  String get errorGoalIdNotANumber => Crowdin.getText(localeName, 'errorGoalIdNotANumber') ?? _fallbackTexts.errorGoalIdNotANumber;

	@override
  String get errorGoalIdNotAnInteger => Crowdin.getText(localeName, 'errorGoalIdNotAnInteger') ?? _fallbackTexts.errorGoalIdNotAnInteger;

	@override
  String get errorGoalIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorGoalIdNotAPositiveNumber') ?? _fallbackTexts.errorGoalIdNotAPositiveNumber;

	@override
  String get errorCompletionDaysPer7DaysNotANumber => Crowdin.getText(localeName, 'errorCompletionDaysPer7DaysNotANumber') ?? _fallbackTexts.errorCompletionDaysPer7DaysNotANumber;

	@override
  String get errorCompletionDaysPer7DaysNotAnInteger => Crowdin.getText(localeName, 'errorCompletionDaysPer7DaysNotAnInteger') ?? _fallbackTexts.errorCompletionDaysPer7DaysNotAnInteger;

	@override
  String get errorCompletionDaysPer7DaysNotAPositiveNumber => Crowdin.getText(localeName, 'errorCompletionDaysPer7DaysNotAPositiveNumber') ?? _fallbackTexts.errorCompletionDaysPer7DaysNotAPositiveNumber;

	@override
  String get errorCompletionDaysPer7DaysNumberTooBig => Crowdin.getText(localeName, 'errorCompletionDaysPer7DaysNumberTooBig') ?? _fallbackTexts.errorCompletionDaysPer7DaysNumberTooBig;

	@override
  String get errorFilePathEmpty => Crowdin.getText(localeName, 'errorFilePathEmpty') ?? _fallbackTexts.errorFilePathEmpty;

	@override
  String get errorFilePathNotAString => Crowdin.getText(localeName, 'errorFilePathNotAString') ?? _fallbackTexts.errorFilePathNotAString;

	@override
  String get errorCategoryIdEmpty => Crowdin.getText(localeName, 'errorCategoryIdEmpty') ?? _fallbackTexts.errorCategoryIdEmpty;

	@override
  String get errorCategoryIdNotANumber => Crowdin.getText(localeName, 'errorCategoryIdNotANumber') ?? _fallbackTexts.errorCategoryIdNotANumber;

	@override
  String get errorCategoryIdNotAnInteger => Crowdin.getText(localeName, 'errorCategoryIdNotAnInteger') ?? _fallbackTexts.errorCategoryIdNotAnInteger;

	@override
  String get errorCategoryIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorCategoryIdNotAPositiveNumber') ?? _fallbackTexts.errorCategoryIdNotAPositiveNumber;

	@override
  String get errorTimesNotAnInteger => Crowdin.getText(localeName, 'errorTimesNotAnInteger') ?? _fallbackTexts.errorTimesNotAnInteger;

	@override
  String get errorTimesNumberTooSmall => Crowdin.getText(localeName, 'errorTimesNumberTooSmall') ?? _fallbackTexts.errorTimesNumberTooSmall;

	@override
  String get errorReviewIdEmpty => Crowdin.getText(localeName, 'errorReviewIdEmpty') ?? _fallbackTexts.errorReviewIdEmpty;

	@override
  String get errorReviewIdNotANumber => Crowdin.getText(localeName, 'errorReviewIdNotANumber') ?? _fallbackTexts.errorReviewIdNotANumber;

	@override
  String get errorReviewIdNotAnInteger => Crowdin.getText(localeName, 'errorReviewIdNotAnInteger') ?? _fallbackTexts.errorReviewIdNotAnInteger;

	@override
  String get errorReviewIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorReviewIdNotAPositiveNumber') ?? _fallbackTexts.errorReviewIdNotAPositiveNumber;

	@override
  String get errorProgressNotAnArray => Crowdin.getText(localeName, 'errorProgressNotAnArray') ?? _fallbackTexts.errorProgressNotAnArray;

	@override
  String get errorProgressEmptyArray => Crowdin.getText(localeName, 'errorProgressEmptyArray') ?? _fallbackTexts.errorProgressEmptyArray;

	@override
  String get errorDifficultyNotANumber => Crowdin.getText(localeName, 'errorDifficultyNotANumber') ?? _fallbackTexts.errorDifficultyNotANumber;

	@override
  String get errorDifficultyNotAnInteger => Crowdin.getText(localeName, 'errorDifficultyNotAnInteger') ?? _fallbackTexts.errorDifficultyNotAnInteger;

	@override
  String get errorDifficultyNotAPositiveNumber => Crowdin.getText(localeName, 'errorDifficultyNotAPositiveNumber') ?? _fallbackTexts.errorDifficultyNotAPositiveNumber;

	@override
  String get errorDifficultyNumberTooBig => Crowdin.getText(localeName, 'errorDifficultyNumberTooBig') ?? _fallbackTexts.errorDifficultyNumberTooBig;

	@override
  String get errorIsTryAgainNotABoolean => Crowdin.getText(localeName, 'errorIsTryAgainNotABoolean') ?? _fallbackTexts.errorIsTryAgainNotABoolean;

	@override
  String get errorSmartGoalIdEmpty => Crowdin.getText(localeName, 'errorSmartGoalIdEmpty') ?? _fallbackTexts.errorSmartGoalIdEmpty;

	@override
  String get errorSmartGoalIdNotANumber => Crowdin.getText(localeName, 'errorSmartGoalIdNotANumber') ?? _fallbackTexts.errorSmartGoalIdNotANumber;

	@override
  String get errorSmartGoalIdNotAnInteger => Crowdin.getText(localeName, 'errorSmartGoalIdNotAnInteger') ?? _fallbackTexts.errorSmartGoalIdNotAnInteger;

	@override
  String get errorSmartGoalIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorSmartGoalIdNotAPositiveNumber') ?? _fallbackTexts.errorSmartGoalIdNotAPositiveNumber;

	@override
  String get errorStartedAtEmpty => Crowdin.getText(localeName, 'errorStartedAtEmpty') ?? _fallbackTexts.errorStartedAtEmpty;

	@override
  String get errorStartedAtNotAString => Crowdin.getText(localeName, 'errorStartedAtNotAString') ?? _fallbackTexts.errorStartedAtNotAString;

	@override
  String get errorStartedAtNotADateString => Crowdin.getText(localeName, 'errorStartedAtNotADateString') ?? _fallbackTexts.errorStartedAtNotADateString;

	@override
  String get errorReasonInvalidEnum => Crowdin.getText(localeName, 'errorReasonInvalidEnum') ?? _fallbackTexts.errorReasonInvalidEnum;

	@override
  String get errorSessionIdEmpty => Crowdin.getText(localeName, 'errorSessionIdEmpty') ?? _fallbackTexts.errorSessionIdEmpty;

	@override
  String get errorProgressIdEmpty => Crowdin.getText(localeName, 'errorProgressIdEmpty') ?? _fallbackTexts.errorProgressIdEmpty;

	@override
  String get errorProgressIdNotANumber => Crowdin.getText(localeName, 'errorProgressIdNotANumber') ?? _fallbackTexts.errorProgressIdNotANumber;

	@override
  String get errorProgressIdNotAnInteger => Crowdin.getText(localeName, 'errorProgressIdNotAnInteger') ?? _fallbackTexts.errorProgressIdNotAnInteger;

	@override
  String get errorProgressIdNotAPositiveNumber => Crowdin.getText(localeName, 'errorProgressIdNotAPositiveNumber') ?? _fallbackTexts.errorProgressIdNotAPositiveNumber;

	@override
  String get errorCoreAccountIdFailedToSendMessage => Crowdin.getText(localeName, 'errorCoreAccountIdFailedToSendMessage') ?? _fallbackTexts.errorCoreAccountIdFailedToSendMessage;

	@override
  String get errorCoreRequestNeedToBeRefetched => Crowdin.getText(localeName, 'errorCoreRequestNeedToBeRefetched') ?? _fallbackTexts.errorCoreRequestNeedToBeRefetched;

	@override
  String get errorCoreMvpAccessDenied => Crowdin.getText(localeName, 'errorCoreMvpAccessDenied') ?? _fallbackTexts.errorCoreMvpAccessDenied;

	@override
  String get errorCoreAccountIdCanNotParse => Crowdin.getText(localeName, 'errorCoreAccountIdCanNotParse') ?? _fallbackTexts.errorCoreAccountIdCanNotParse;

	@override
  String get errorCoreAccountIdNotAuthenticated => Crowdin.getText(localeName, 'errorCoreAccountIdNotAuthenticated') ?? _fallbackTexts.errorCoreAccountIdNotAuthenticated;

	@override
  String get errorCoreEmailOrPasswordAreIncorrect => Crowdin.getText(localeName, 'errorCoreEmailOrPasswordAreIncorrect') ?? _fallbackTexts.errorCoreEmailOrPasswordAreIncorrect;

	@override
  String get errorCoreEmailNotApproved => Crowdin.getText(localeName, 'errorCoreEmailNotApproved') ?? _fallbackTexts.errorCoreEmailNotApproved;

	@override
  String get errorCoreRefreshTokenHasBeenExpired => Crowdin.getText(localeName, 'errorCoreRefreshTokenHasBeenExpired') ?? _fallbackTexts.errorCoreRefreshTokenHasBeenExpired;

	@override
  String get errorCorePasswordTokenNotFound => Crowdin.getText(localeName, 'errorCorePasswordTokenNotFound') ?? _fallbackTexts.errorCorePasswordTokenNotFound;

	@override
  String get errorCorePasswordTokenExpired => Crowdin.getText(localeName, 'errorCorePasswordTokenExpired') ?? _fallbackTexts.errorCorePasswordTokenExpired;

	@override
  String get errorAuthAccessTokenInvalid => Crowdin.getText(localeName, 'errorAuthAccessTokenInvalid') ?? _fallbackTexts.errorAuthAccessTokenInvalid;

	@override
  String get errorAuthRefreshTokenNotFound => Crowdin.getText(localeName, 'errorAuthRefreshTokenNotFound') ?? _fallbackTexts.errorAuthRefreshTokenNotFound;

	@override
  String get errorAccountEmailOrPasswordInvalid => Crowdin.getText(localeName, 'errorAccountEmailOrPasswordInvalid') ?? _fallbackTexts.errorAccountEmailOrPasswordInvalid;

	@override
  String get errorAccountIdAlreadyExists => Crowdin.getText(localeName, 'errorAccountIdAlreadyExists') ?? _fallbackTexts.errorAccountIdAlreadyExists;

	@override
  String get errorAccountIdNotFound => Crowdin.getText(localeName, 'errorAccountIdNotFound') ?? _fallbackTexts.errorAccountIdNotFound;

	@override
  String get errorAccountEmailNotFound => Crowdin.getText(localeName, 'errorAccountEmailNotFound') ?? _fallbackTexts.errorAccountEmailNotFound;

	@override
  String get errorAccountInvitationNotFound => Crowdin.getText(localeName, 'errorAccountInvitationNotFound') ?? _fallbackTexts.errorAccountInvitationNotFound;

	@override
  String get errorAccountEmailTokenNotFound => Crowdin.getText(localeName, 'errorAccountEmailTokenNotFound') ?? _fallbackTexts.errorAccountEmailTokenNotFound;

	@override
  String get errorAccountPasswordTokenNotFound => Crowdin.getText(localeName, 'errorAccountPasswordTokenNotFound') ?? _fallbackTexts.errorAccountPasswordTokenNotFound;

	@override
  String get errorAccountPasswordTokenExpired => Crowdin.getText(localeName, 'errorAccountPasswordTokenExpired') ?? _fallbackTexts.errorAccountPasswordTokenExpired;

	@override
  String get errorAccountEmailExpired => Crowdin.getText(localeName, 'errorAccountEmailExpired') ?? _fallbackTexts.errorAccountEmailExpired;

	@override
  String get errorAccountEmailPreviouslySubmitted => Crowdin.getText(localeName, 'errorAccountEmailPreviouslySubmitted') ?? _fallbackTexts.errorAccountEmailPreviouslySubmitted;

	@override
  String get errorAccountDiabetesTypeNotFound => Crowdin.getText(localeName, 'errorAccountDiabetesTypeNotFound') ?? _fallbackTexts.errorAccountDiabetesTypeNotFound;

	@override
  String get errorAccountSubscriptionCancelActive => Crowdin.getText(localeName, 'errorAccountSubscriptionCancelActive') ?? _fallbackTexts.errorAccountSubscriptionCancelActive;

	@override
  String get errorAccountPasswordTokenInvalid => Crowdin.getText(localeName, 'errorAccountPasswordTokenInvalid') ?? _fallbackTexts.errorAccountPasswordTokenInvalid;

	@override
  String get errorCoreFileInvalid => Crowdin.getText(localeName, 'errorCoreFileInvalid') ?? _fallbackTexts.errorCoreFileInvalid;

	@override
  String get errorAccountEmailLessThanADayFromLastChange => Crowdin.getText(localeName, 'errorAccountEmailLessThanADayFromLastChange') ?? _fallbackTexts.errorAccountEmailLessThanADayFromLastChange;

	@override
  String get errorPurchaseVerificationError => Crowdin.getText(localeName, 'errorPurchaseVerificationError') ?? _fallbackTexts.errorPurchaseVerificationError;

	@override
  String get errorSubscriptionIdAbsent => Crowdin.getText(localeName, 'errorSubscriptionIdAbsent') ?? _fallbackTexts.errorSubscriptionIdAbsent;

	@override
  String get errorSubscriptionIosProductIdNotFound => Crowdin.getText(localeName, 'errorSubscriptionIosProductIdNotFound') ?? _fallbackTexts.errorSubscriptionIosProductIdNotFound;

	@override
  String get errorSubscriptionAndroidProductIdNotFound => Crowdin.getText(localeName, 'errorSubscriptionAndroidProductIdNotFound') ?? _fallbackTexts.errorSubscriptionAndroidProductIdNotFound;

	@override
  String get errorSubscriptionAccountIdAbsent => Crowdin.getText(localeName, 'errorSubscriptionAccountIdAbsent') ?? _fallbackTexts.errorSubscriptionAccountIdAbsent;

	@override
  String get errorSubscriptionPurchaseTokenAbsent => Crowdin.getText(localeName, 'errorSubscriptionPurchaseTokenAbsent') ?? _fallbackTexts.errorSubscriptionPurchaseTokenAbsent;

	@override
  String get errorSubscriptionPackageNameInvalid => Crowdin.getText(localeName, 'errorSubscriptionPackageNameInvalid') ?? _fallbackTexts.errorSubscriptionPackageNameInvalid;

	@override
  String get errorSubscriptionAccountIdInvalid => Crowdin.getText(localeName, 'errorSubscriptionAccountIdInvalid') ?? _fallbackTexts.errorSubscriptionAccountIdInvalid;

	@override
  String get errorSubscriptionVendorInvalid => Crowdin.getText(localeName, 'errorSubscriptionVendorInvalid') ?? _fallbackTexts.errorSubscriptionVendorInvalid;

	@override
  String get errorSubscriptionPurchaseTokenInvalid => Crowdin.getText(localeName, 'errorSubscriptionPurchaseTokenInvalid') ?? _fallbackTexts.errorSubscriptionPurchaseTokenInvalid;

	@override
  String get errorSubscriptionEnvironmentInvalid => Crowdin.getText(localeName, 'errorSubscriptionEnvironmentInvalid') ?? _fallbackTexts.errorSubscriptionEnvironmentInvalid;

	@override
  String get errorSubscriptionBaseTransactionIdInvalid => Crowdin.getText(localeName, 'errorSubscriptionBaseTransactionIdInvalid') ?? _fallbackTexts.errorSubscriptionBaseTransactionIdInvalid;

	@override
  String get errorSubscriptionTransactionIdInvalid => Crowdin.getText(localeName, 'errorSubscriptionTransactionIdInvalid') ?? _fallbackTexts.errorSubscriptionTransactionIdInvalid;

	@override
  String get errorSubscriptionAndroidDataEmpty => Crowdin.getText(localeName, 'errorSubscriptionAndroidDataEmpty') ?? _fallbackTexts.errorSubscriptionAndroidDataEmpty;

	@override
  String get errorSubscriptionWithAccountNotFound => Crowdin.getText(localeName, 'errorSubscriptionWithAccountNotFound') ?? _fallbackTexts.errorSubscriptionWithAccountNotFound;

	@override
  String get errorGroupingAccountIdAppFeatureLocked => Crowdin.getText(localeName, 'errorGroupingAccountIdAppFeatureLocked') ?? _fallbackTexts.errorGroupingAccountIdAppFeatureLocked;

	@override
  String get errorGroupingDataOneOptionalFieldRequired => Crowdin.getText(localeName, 'errorGroupingDataOneOptionalFieldRequired') ?? _fallbackTexts.errorGroupingDataOneOptionalFieldRequired;

	@override
  String get errorGroupingGenderPreferenceInvalid => Crowdin.getText(localeName, 'errorGroupingGenderPreferenceInvalid') ?? _fallbackTexts.errorGroupingGenderPreferenceInvalid;

	@override
  String get errorGroupingBmiRangeCanNotCalculate => Crowdin.getText(localeName, 'errorGroupingBmiRangeCanNotCalculate') ?? _fallbackTexts.errorGroupingBmiRangeCanNotCalculate;

	@override
  String get errorGroupingAgeRangeCanNotCalculate => Crowdin.getText(localeName, 'errorGroupingAgeRangeCanNotCalculate') ?? _fallbackTexts.errorGroupingAgeRangeCanNotCalculate;

	@override
  String get errorGroupingAccountGroupingStateCanNotCancel => Crowdin.getText(localeName, 'errorGroupingAccountGroupingStateCanNotCancel') ?? _fallbackTexts.errorGroupingAccountGroupingStateCanNotCancel;

	@override
  String get errorGroupingGroupIdNotFound => Crowdin.getText(localeName, 'errorGroupingGroupIdNotFound') ?? _fallbackTexts.errorGroupingGroupIdNotFound;

	@override
  String get errorGroupingAccountIdAlreadyInGroup => Crowdin.getText(localeName, 'errorGroupingAccountIdAlreadyInGroup') ?? _fallbackTexts.errorGroupingAccountIdAlreadyInGroup;

	@override
  String get errorBuddyAccountAlreadyHaveABuddy => Crowdin.getText(localeName, 'errorBuddyAccountAlreadyHaveABuddy') ?? _fallbackTexts.errorBuddyAccountAlreadyHaveABuddy;

	@override
  String get errorBuddyEntityNotFound => Crowdin.getText(localeName, 'errorBuddyEntityNotFound') ?? _fallbackTexts.errorBuddyEntityNotFound;

	@override
  String get errorBuddyRefreshTokenNotFound => Crowdin.getText(localeName, 'errorBuddyRefreshTokenNotFound') ?? _fallbackTexts.errorBuddyRefreshTokenNotFound;

	@override
  String get errorBuddyRegistrationAlreadyExists => Crowdin.getText(localeName, 'errorBuddyRegistrationAlreadyExists') ?? _fallbackTexts.errorBuddyRegistrationAlreadyExists;

	@override
  String get errorBuddyRegistrationAlreadyConfirmed => Crowdin.getText(localeName, 'errorBuddyRegistrationAlreadyConfirmed') ?? _fallbackTexts.errorBuddyRegistrationAlreadyConfirmed;

	@override
  String get errorBuddyPasswordTokenInvalid => Crowdin.getText(localeName, 'errorBuddyPasswordTokenInvalid') ?? _fallbackTexts.errorBuddyPasswordTokenInvalid;

	@override
  String get errorBuddyRegistrationTokenExpired => Crowdin.getText(localeName, 'errorBuddyRegistrationTokenExpired') ?? _fallbackTexts.errorBuddyRegistrationTokenExpired;

	@override
  String get errorBuddyRegistrationTokenInvalid => Crowdin.getText(localeName, 'errorBuddyRegistrationTokenInvalid') ?? _fallbackTexts.errorBuddyRegistrationTokenInvalid;

	@override
  String get errorBuddyInvitationTokenExpired => Crowdin.getText(localeName, 'errorBuddyInvitationTokenExpired') ?? _fallbackTexts.errorBuddyInvitationTokenExpired;

	@override
  String get errorBuddyInvitationTokenInvalid => Crowdin.getText(localeName, 'errorBuddyInvitationTokenInvalid') ?? _fallbackTexts.errorBuddyInvitationTokenInvalid;

	@override
  String get errorBuddyInvitationEmailInvalid => Crowdin.getText(localeName, 'errorBuddyInvitationEmailInvalid') ?? _fallbackTexts.errorBuddyInvitationEmailInvalid;

	@override
  String get errorBuddyInvitationNotFound => Crowdin.getText(localeName, 'errorBuddyInvitationNotFound') ?? _fallbackTexts.errorBuddyInvitationNotFound;

	@override
  String get errorBuddyInvitationHasBeenRejected => Crowdin.getText(localeName, 'errorBuddyInvitationHasBeenRejected') ?? _fallbackTexts.errorBuddyInvitationHasBeenRejected;

	@override
  String get errorBuddyInvitationAlreadyApproved => Crowdin.getText(localeName, 'errorBuddyInvitationAlreadyApproved') ?? _fallbackTexts.errorBuddyInvitationAlreadyApproved;

	@override
  String get errorBuddyInvitationBuddyOccupied => Crowdin.getText(localeName, 'errorBuddyInvitationBuddyOccupied') ?? _fallbackTexts.errorBuddyInvitationBuddyOccupied;

	@override
  String get errorDiabetesTypeNotFound => Crowdin.getText(localeName, 'errorDiabetesTypeNotFound') ?? _fallbackTexts.errorDiabetesTypeNotFound;

	@override
  String get errorNutritionMealIdNotFound => Crowdin.getText(localeName, 'errorNutritionMealIdNotFound') ?? _fallbackTexts.errorNutritionMealIdNotFound;

	@override
  String get errorNutritionMealFoodItemIdNotFound => Crowdin.getText(localeName, 'errorNutritionMealFoodItemIdNotFound') ?? _fallbackTexts.errorNutritionMealFoodItemIdNotFound;

	@override
  String get errorNutritionMealRecipeIdNotFound => Crowdin.getText(localeName, 'errorNutritionMealRecipeIdNotFound') ?? _fallbackTexts.errorNutritionMealRecipeIdNotFound;

	@override
  String get errorNutritionMealDishIdNotFound => Crowdin.getText(localeName, 'errorNutritionMealDishIdNotFound') ?? _fallbackTexts.errorNutritionMealDishIdNotFound;

	@override
  String get errorNutritionFavoriteFoodItemIdNotFound => Crowdin.getText(localeName, 'errorNutritionFavoriteFoodItemIdNotFound') ?? _fallbackTexts.errorNutritionFavoriteFoodItemIdNotFound;

	@override
  String get errorNutritionFavoriteServingIdNotFound => Crowdin.getText(localeName, 'errorNutritionFavoriteServingIdNotFound') ?? _fallbackTexts.errorNutritionFavoriteServingIdNotFound;

	@override
  String get errorNutritionFavoriteAccountIdNotFound => Crowdin.getText(localeName, 'errorNutritionFavoriteAccountIdNotFound') ?? _fallbackTexts.errorNutritionFavoriteAccountIdNotFound;

	@override
  String get errorNutritionFavoriteAlreadyExists => Crowdin.getText(localeName, 'errorNutritionFavoriteAlreadyExists') ?? _fallbackTexts.errorNutritionFavoriteAlreadyExists;

	@override
  String get errorNutritionWeightLogNotFound => Crowdin.getText(localeName, 'errorNutritionWeightLogNotFound') ?? _fallbackTexts.errorNutritionWeightLogNotFound;

	@override
  String get errorNutritionRecipeIdNotFound => Crowdin.getText(localeName, 'errorNutritionRecipeIdNotFound') ?? _fallbackTexts.errorNutritionRecipeIdNotFound;

	@override
  String get errorNutritionAccountDishesNotFound => Crowdin.getText(localeName, 'errorNutritionAccountDishesNotFound') ?? _fallbackTexts.errorNutritionAccountDishesNotFound;

	@override
  String get errorNutritionDishNotFound => Crowdin.getText(localeName, 'errorNutritionDishNotFound') ?? _fallbackTexts.errorNutritionDishNotFound;

	@override
  String get errorNutritionDishFoodItemNotFound => Crowdin.getText(localeName, 'errorNutritionDishFoodItemNotFound') ?? _fallbackTexts.errorNutritionDishFoodItemNotFound;

	@override
  String get errorNutritionDishMealRecipeNotFound => Crowdin.getText(localeName, 'errorNutritionDishMealRecipeNotFound') ?? _fallbackTexts.errorNutritionDishMealRecipeNotFound;

	@override
  String get errorNutritionDishFoodItemsEmpty => Crowdin.getText(localeName, 'errorNutritionDishFoodItemsEmpty') ?? _fallbackTexts.errorNutritionDishFoodItemsEmpty;

	@override
  String get errorFoodPreferencesHateTagNotFound => Crowdin.getText(localeName, 'errorFoodPreferencesHateTagNotFound') ?? _fallbackTexts.errorFoodPreferencesHateTagNotFound;

	@override
  String get errorFoodPreferencesAllergenTagNotFound => Crowdin.getText(localeName, 'errorFoodPreferencesAllergenTagNotFound') ?? _fallbackTexts.errorFoodPreferencesAllergenTagNotFound;

	@override
  String get errorFoodPreferencesDislikeTagNotFound => Crowdin.getText(localeName, 'errorFoodPreferencesDislikeTagNotFound') ?? _fallbackTexts.errorFoodPreferencesDislikeTagNotFound;

	@override
  String get errorMentalHealthQuestionIdInvalid => Crowdin.getText(localeName, 'errorMentalHealthQuestionIdInvalid') ?? _fallbackTexts.errorMentalHealthQuestionIdInvalid;

	@override
  String get errorMentalHealthOptionIdInvalid => Crowdin.getText(localeName, 'errorMentalHealthOptionIdInvalid') ?? _fallbackTexts.errorMentalHealthOptionIdInvalid;

	@override
  String get errorMentalHealthTypeInvalid => Crowdin.getText(localeName, 'errorMentalHealthTypeInvalid') ?? _fallbackTexts.errorMentalHealthTypeInvalid;

	@override
  String get errorMedicalOnboardingQuestionTypeInvalid => Crowdin.getText(localeName, 'errorMedicalOnboardingQuestionTypeInvalid') ?? _fallbackTexts.errorMedicalOnboardingQuestionTypeInvalid;

	@override
  String get errorPhysicalActivitiesPhysicalProgramIdNotFound => Crowdin.getText(localeName, 'errorPhysicalActivitiesPhysicalProgramIdNotFound') ?? _fallbackTexts.errorPhysicalActivitiesPhysicalProgramIdNotFound;

	@override
  String get errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound => Crowdin.getText(localeName, 'errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound') ?? _fallbackTexts.errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound;

	@override
  String get errorPhysicalActivitiesPreferencesNotFound => Crowdin.getText(localeName, 'errorPhysicalActivitiesPreferencesNotFound') ?? _fallbackTexts.errorPhysicalActivitiesPreferencesNotFound;

	@override
  String get errorRiverModuleNotFound => Crowdin.getText(localeName, 'errorRiverModuleNotFound') ?? _fallbackTexts.errorRiverModuleNotFound;

	@override
  String get errorRiverModuleItemNotFound => Crowdin.getText(localeName, 'errorRiverModuleItemNotFound') ?? _fallbackTexts.errorRiverModuleItemNotFound;

	@override
  String get errorEducationLessonNotFound => Crowdin.getText(localeName, 'errorEducationLessonNotFound') ?? _fallbackTexts.errorEducationLessonNotFound;

	@override
  String get errorEducationQuizUpdateNotAllowed => Crowdin.getText(localeName, 'errorEducationQuizUpdateNotAllowed') ?? _fallbackTexts.errorEducationQuizUpdateNotAllowed;

	@override
  String get errorEducationQuizSubmitNotFound => Crowdin.getText(localeName, 'errorEducationQuizSubmitNotFound') ?? _fallbackTexts.errorEducationQuizSubmitNotFound;

	@override
  String get errorEducationQuizAlreadySubmitted => Crowdin.getText(localeName, 'errorEducationQuizAlreadySubmitted') ?? _fallbackTexts.errorEducationQuizAlreadySubmitted;

	@override
  String get errorEducationQuizOptionNotFound => Crowdin.getText(localeName, 'errorEducationQuizOptionNotFound') ?? _fallbackTexts.errorEducationQuizOptionNotFound;

	@override
  String get errorEducationQuizNotFound => Crowdin.getText(localeName, 'errorEducationQuizNotFound') ?? _fallbackTexts.errorEducationQuizNotFound;

	@override
  String get errorEducationReflectionNotFound => Crowdin.getText(localeName, 'errorEducationReflectionNotFound') ?? _fallbackTexts.errorEducationReflectionNotFound;

	@override
  String get errorEducationReflectionOptionNotFound => Crowdin.getText(localeName, 'errorEducationReflectionOptionNotFound') ?? _fallbackTexts.errorEducationReflectionOptionNotFound;

	@override
  String get errorEducationReflectionFeedbackNotFound => Crowdin.getText(localeName, 'errorEducationReflectionFeedbackNotFound') ?? _fallbackTexts.errorEducationReflectionFeedbackNotFound;

	@override
  String get errorEducationReflectionAlreadySubmitted => Crowdin.getText(localeName, 'errorEducationReflectionAlreadySubmitted') ?? _fallbackTexts.errorEducationReflectionAlreadySubmitted;

	@override
  String get errorEducationReflectionFeedbackAlreadySubmitted => Crowdin.getText(localeName, 'errorEducationReflectionFeedbackAlreadySubmitted') ?? _fallbackTexts.errorEducationReflectionFeedbackAlreadySubmitted;

	@override
  String get errorNutritionPlannedMealIdNotFound => Crowdin.getText(localeName, 'errorNutritionPlannedMealIdNotFound') ?? _fallbackTexts.errorNutritionPlannedMealIdNotFound;

	@override
  String get errorNutritionPlannedMealDateInvalid => Crowdin.getText(localeName, 'errorNutritionPlannedMealDateInvalid') ?? _fallbackTexts.errorNutritionPlannedMealDateInvalid;

	@override
  String get errorGroupSessionIdNotFound => Crowdin.getText(localeName, 'errorGroupSessionIdNotFound') ?? _fallbackTexts.errorGroupSessionIdNotFound;

	@override
  String get errorGroupSessionAccountIdNotGrouped => Crowdin.getText(localeName, 'errorGroupSessionAccountIdNotGrouped') ?? _fallbackTexts.errorGroupSessionAccountIdNotGrouped;

	@override
  String get errorGroupSessionAccountIdNotFound => Crowdin.getText(localeName, 'errorGroupSessionAccountIdNotFound') ?? _fallbackTexts.errorGroupSessionAccountIdNotFound;

	@override
  String get errorGroupSessionAccountIdAlreadySigned => Crowdin.getText(localeName, 'errorGroupSessionAccountIdAlreadySigned') ?? _fallbackTexts.errorGroupSessionAccountIdAlreadySigned;

	@override
  String get errorGroupSessionAccountIdWasNotSigned => Crowdin.getText(localeName, 'errorGroupSessionAccountIdWasNotSigned') ?? _fallbackTexts.errorGroupSessionAccountIdWasNotSigned;

	@override
  String get errorGroupSessionProgramImageNotFound => Crowdin.getText(localeName, 'errorGroupSessionProgramImageNotFound') ?? _fallbackTexts.errorGroupSessionProgramImageNotFound;

	@override
  String get errorGroupSessionProgramImageInvalidMimeType => Crowdin.getText(localeName, 'errorGroupSessionProgramImageInvalidMimeType') ?? _fallbackTexts.errorGroupSessionProgramImageInvalidMimeType;

	@override
  String get errorGroupSessionStatusMismatchUpdateFlow => Crowdin.getText(localeName, 'errorGroupSessionStatusMismatchUpdateFlow') ?? _fallbackTexts.errorGroupSessionStatusMismatchUpdateFlow;

	@override
  String get errorChatAccountIdNotAssignedToGroup => Crowdin.getText(localeName, 'errorChatAccountIdNotAssignedToGroup') ?? _fallbackTexts.errorChatAccountIdNotAssignedToGroup;

	@override
  String get errorChatMessageIdNotFound => Crowdin.getText(localeName, 'errorChatMessageIdNotFound') ?? _fallbackTexts.errorChatMessageIdNotFound;

	@override
  String get errorMindTechniqueIdNotFound => Crowdin.getText(localeName, 'errorMindTechniqueIdNotFound') ?? _fallbackTexts.errorMindTechniqueIdNotFound;

	@override
  String get errorMindExerciseIdNotFound => Crowdin.getText(localeName, 'errorMindExerciseIdNotFound') ?? _fallbackTexts.errorMindExerciseIdNotFound;

	@override
  String get errorMoodIdNotFound => Crowdin.getText(localeName, 'errorMoodIdNotFound') ?? _fallbackTexts.errorMoodIdNotFound;

	@override
  String get errorMoodCreatedAyIsOld => Crowdin.getText(localeName, 'errorMoodCreatedAyIsOld') ?? _fallbackTexts.errorMoodCreatedAyIsOld;

	@override
  String get errorSmartGoalStartDateActiveSessionExists => Crowdin.getText(localeName, 'errorSmartGoalStartDateActiveSessionExists') ?? _fallbackTexts.errorSmartGoalStartDateActiveSessionExists;

	@override
  String get errorSmartGoalIdNotFound => Crowdin.getText(localeName, 'errorSmartGoalIdNotFound') ?? _fallbackTexts.errorSmartGoalIdNotFound;

	@override
  String get errorSmartGoalSessionIdNotFound => Crowdin.getText(localeName, 'errorSmartGoalSessionIdNotFound') ?? _fallbackTexts.errorSmartGoalSessionIdNotFound;

	@override
  String get errorSmartGoalReviewIdNotFound => Crowdin.getText(localeName, 'errorSmartGoalReviewIdNotFound') ?? _fallbackTexts.errorSmartGoalReviewIdNotFound;

	@override
  String get errorSmartGoalProgressLogsInvalid => Crowdin.getText(localeName, 'errorSmartGoalProgressLogsInvalid') ?? _fallbackTexts.errorSmartGoalProgressLogsInvalid;

	@override
  String get errorSmartGoalCategoryIdsLocked => Crowdin.getText(localeName, 'errorSmartGoalCategoryIdsLocked') ?? _fallbackTexts.errorSmartGoalCategoryIdsLocked;

	@override
  String get errorSmartGoalCategoryIdLocked => Crowdin.getText(localeName, 'errorSmartGoalCategoryIdLocked') ?? _fallbackTexts.errorSmartGoalCategoryIdLocked;

	@override
  String get errorSmartGoalSessionIdActiveLimitExceeded => Crowdin.getText(localeName, 'errorSmartGoalSessionIdActiveLimitExceeded') ?? _fallbackTexts.errorSmartGoalSessionIdActiveLimitExceeded;

	@override
  String get errorSmartGoalCategoryIdNotFound => Crowdin.getText(localeName, 'errorSmartGoalCategoryIdNotFound') ?? _fallbackTexts.errorSmartGoalCategoryIdNotFound;

	@override
  String get errorSmartGoalIdConflictsWithActive => Crowdin.getText(localeName, 'errorSmartGoalIdConflictsWithActive') ?? _fallbackTexts.errorSmartGoalIdConflictsWithActive;

	@override
  String get errorSmartGoalIdDuplicatesFound => Crowdin.getText(localeName, 'errorSmartGoalIdDuplicatesFound') ?? _fallbackTexts.errorSmartGoalIdDuplicatesFound;

	@override
  String get errorCoreInternalServer => Crowdin.getText(localeName, 'errorCoreInternalServer') ?? _fallbackTexts.errorCoreInternalServer;

	@override
  String get errorRetry => Crowdin.getText(localeName, 'errorRetry') ?? _fallbackTexts.errorRetry;

	@override
  String get errorNoConnectionTitle => Crowdin.getText(localeName, 'errorNoConnectionTitle') ?? _fallbackTexts.errorNoConnectionTitle;

	@override
  String get errorNoConnectionText => Crowdin.getText(localeName, 'errorNoConnectionText') ?? _fallbackTexts.errorNoConnectionText;

	@override
  String get errorInvalidIngredientText => Crowdin.getText(localeName, 'errorInvalidIngredientText') ?? _fallbackTexts.errorInvalidIngredientText;

	@override
  String get errorOeps => Crowdin.getText(localeName, 'errorOeps') ?? _fallbackTexts.errorOeps;

	@override
  String get errorSomethingWentWrong => Crowdin.getText(localeName, 'errorSomethingWentWrong') ?? _fallbackTexts.errorSomethingWentWrong;

	@override
  String get errorSubscriptionServiceUnavailable => Crowdin.getText(localeName, 'errorSubscriptionServiceUnavailable') ?? _fallbackTexts.errorSubscriptionServiceUnavailable;

	@override
  String get errorPurchaseStreamError => Crowdin.getText(localeName, 'errorPurchaseStreamError') ?? _fallbackTexts.errorPurchaseStreamError;

	@override
  String get errorPurchaseErrorMessage => Crowdin.getText(localeName, 'errorPurchaseErrorMessage') ?? _fallbackTexts.errorPurchaseErrorMessage;

	@override
  String get errorSomethingIsIncorrect => Crowdin.getText(localeName, 'errorSomethingIsIncorrect') ?? _fallbackTexts.errorSomethingIsIncorrect;

	@override
  String get errorServingIdIsNotFound => Crowdin.getText(localeName, 'errorServingIdIsNotFound') ?? _fallbackTexts.errorServingIdIsNotFound;

	@override
  String get errorSocketException => Crowdin.getText(localeName, 'errorSocketException') ?? _fallbackTexts.errorSocketException;

	@override
  String get errorParsingException => Crowdin.getText(localeName, 'errorParsingException') ?? _fallbackTexts.errorParsingException;

	@override
  String get errorLoadTranslations => Crowdin.getText(localeName, 'errorLoadTranslations') ?? _fallbackTexts.errorLoadTranslations;

	@override
  String get errorTimeoutDio => Crowdin.getText(localeName, 'errorTimeoutDio') ?? _fallbackTexts.errorTimeoutDio;

	@override
  String get errorConnectionDio => Crowdin.getText(localeName, 'errorConnectionDio') ?? _fallbackTexts.errorConnectionDio;

	@override
  String get errorRequestCancelledDio => Crowdin.getText(localeName, 'errorRequestCancelledDio') ?? _fallbackTexts.errorRequestCancelledDio;

	@override
  String get errorBadRequestDio => Crowdin.getText(localeName, 'errorBadRequestDio') ?? _fallbackTexts.errorBadRequestDio;

	@override
  String get errorUnauthorizedDio => Crowdin.getText(localeName, 'errorUnauthorizedDio') ?? _fallbackTexts.errorUnauthorizedDio;

	@override
  String get errorForbiddenDio => Crowdin.getText(localeName, 'errorForbiddenDio') ?? _fallbackTexts.errorForbiddenDio;

	@override
  String get errorNotFoundDio => Crowdin.getText(localeName, 'errorNotFoundDio') ?? _fallbackTexts.errorNotFoundDio;

	@override
  String get errorConflictDio => Crowdin.getText(localeName, 'errorConflictDio') ?? _fallbackTexts.errorConflictDio;

	@override
  String get errorServerErrorDio => Crowdin.getText(localeName, 'errorServerErrorDio') ?? _fallbackTexts.errorServerErrorDio;

	@override
  String get errorUnprocessableEntityDio => Crowdin.getText(localeName, 'errorUnprocessableEntityDio') ?? _fallbackTexts.errorUnprocessableEntityDio;

	@override
  String get errorUnhandledResponseDio => Crowdin.getText(localeName, 'errorUnhandledResponseDio') ?? _fallbackTexts.errorUnhandledResponseDio;

	@override
  String get errorUnhandledErrorDio => Crowdin.getText(localeName, 'errorUnhandledErrorDio') ?? _fallbackTexts.errorUnhandledErrorDio;

	@override
  String get errorOtherDio => Crowdin.getText(localeName, 'errorOtherDio') ?? _fallbackTexts.errorOtherDio;

	@override
  String get onboardingIntroTitle => Crowdin.getText(localeName, 'onboardingIntroTitle') ?? _fallbackTexts.onboardingIntroTitle;

	@override
  String get onboardingIntroProgram1 => Crowdin.getText(localeName, 'onboardingIntroProgram1') ?? _fallbackTexts.onboardingIntroProgram1;

	@override
  String get onboardingIntroProgram2 => Crowdin.getText(localeName, 'onboardingIntroProgram2') ?? _fallbackTexts.onboardingIntroProgram2;

	@override
  String get onboardingIntroMissionTitle => Crowdin.getText(localeName, 'onboardingIntroMissionTitle') ?? _fallbackTexts.onboardingIntroMissionTitle;

	@override
  String get onboardingIntroMissionAndrew => Crowdin.getText(localeName, 'onboardingIntroMissionAndrew') ?? _fallbackTexts.onboardingIntroMissionAndrew;

	@override
  String get onboardingIntroMissionMaria => Crowdin.getText(localeName, 'onboardingIntroMissionMaria') ?? _fallbackTexts.onboardingIntroMissionMaria;

	@override
  String get onboardingIntroMissionShalu => Crowdin.getText(localeName, 'onboardingIntroMissionShalu') ?? _fallbackTexts.onboardingIntroMissionShalu;

	@override
  String get onboardingIntroMissionJoshua => Crowdin.getText(localeName, 'onboardingIntroMissionJoshua') ?? _fallbackTexts.onboardingIntroMissionJoshua;

	@override
  String get onboardingIntroMissionDenise => Crowdin.getText(localeName, 'onboardingIntroMissionDenise') ?? _fallbackTexts.onboardingIntroMissionDenise;

	@override
  String get onboardingPacingTitle => Crowdin.getText(localeName, 'onboardingPacingTitle') ?? _fallbackTexts.onboardingPacingTitle;

	@override
  String get onboardingPacingMessage => Crowdin.getText(localeName, 'onboardingPacingMessage') ?? _fallbackTexts.onboardingPacingMessage;

	@override
  String get onboardingIAmReady => Crowdin.getText(localeName, 'onboardingIAmReady') ?? _fallbackTexts.onboardingIAmReady;

	@override
  String get onboardingPhysicalIntroTitle => Crowdin.getText(localeName, 'onboardingPhysicalIntroTitle') ?? _fallbackTexts.onboardingPhysicalIntroTitle;

	@override
  String get onboardingPhysicalIntroBody => Crowdin.getText(localeName, 'onboardingPhysicalIntroBody') ?? _fallbackTexts.onboardingPhysicalIntroBody;

	@override
  String get onboardingAgeCheckFailedTitle => Crowdin.getText(localeName, 'onboardingAgeCheckFailedTitle') ?? _fallbackTexts.onboardingAgeCheckFailedTitle;

	@override
  String get onboardingAgeCheckFailedBody => Crowdin.getText(localeName, 'onboardingAgeCheckFailedBody') ?? _fallbackTexts.onboardingAgeCheckFailedBody;

	@override
  String get onboardingWhatYourSex => Crowdin.getText(localeName, 'onboardingWhatYourSex') ?? _fallbackTexts.onboardingWhatYourSex;

	@override
  String get onboardingSexQuestionBody => Crowdin.getText(localeName, 'onboardingSexQuestionBody') ?? _fallbackTexts.onboardingSexQuestionBody;

	@override
  String get onboardingSex => Crowdin.getText(localeName, 'onboardingSex') ?? _fallbackTexts.onboardingSex;

	@override
  String get onboardingGenderPageTitle => Crowdin.getText(localeName, 'onboardingGenderPageTitle') ?? _fallbackTexts.onboardingGenderPageTitle;

	@override
  String get onboardingHappinessTitle => Crowdin.getText(localeName, 'onboardingHappinessTitle') ?? _fallbackTexts.onboardingHappinessTitle;

	@override
  String get onboardingHappinessBody1 => Crowdin.getText(localeName, 'onboardingHappinessBody1') ?? _fallbackTexts.onboardingHappinessBody1;

	@override
  String get onboardingHappinessBody2 => Crowdin.getText(localeName, 'onboardingHappinessBody2') ?? _fallbackTexts.onboardingHappinessBody2;

	@override
  String get onboardingYourHeight => Crowdin.getText(localeName, 'onboardingYourHeight') ?? _fallbackTexts.onboardingYourHeight;

	@override
  String get onboardingMetric => Crowdin.getText(localeName, 'onboardingMetric') ?? _fallbackTexts.onboardingMetric;

	@override
  String get onboardingImperial => Crowdin.getText(localeName, 'onboardingImperial') ?? _fallbackTexts.onboardingImperial;

	@override
  String get onboardingNext => Crowdin.getText(localeName, 'onboardingNext') ?? _fallbackTexts.onboardingNext;

	@override
  String get onboardingChangeYourHeight => Crowdin.getText(localeName, 'onboardingChangeYourHeight') ?? _fallbackTexts.onboardingChangeYourHeight;

	@override
  String get onboardingHeightSmall => Crowdin.getText(localeName, 'onboardingHeightSmall') ?? _fallbackTexts.onboardingHeightSmall;

	@override
  String get onboardingHeightLarge => Crowdin.getText(localeName, 'onboardingHeightLarge') ?? _fallbackTexts.onboardingHeightLarge;

	@override
  String get onboardingCorrectHeight => Crowdin.getText(localeName, 'onboardingCorrectHeight') ?? _fallbackTexts.onboardingCorrectHeight;

	@override
  String get onboardingYourWeight => Crowdin.getText(localeName, 'onboardingYourWeight') ?? _fallbackTexts.onboardingYourWeight;

	@override
  String get onboardingBmiExclusionBodyTitle => Crowdin.getText(localeName, 'onboardingBmiExclusionBodyTitle') ?? _fallbackTexts.onboardingBmiExclusionBodyTitle;

	@override
  String get onboardingHighBmiDescription1 => Crowdin.getText(localeName, 'onboardingHighBmiDescription1') ?? _fallbackTexts.onboardingHighBmiDescription1;

	@override
  String get onboardingHighBmiDescription2 => Crowdin.getText(localeName, 'onboardingHighBmiDescription2') ?? _fallbackTexts.onboardingHighBmiDescription2;

	@override
  String get onboardingHighBmiDescription3 => Crowdin.getText(localeName, 'onboardingHighBmiDescription3') ?? _fallbackTexts.onboardingHighBmiDescription3;

	@override
  String get onboardingLowerBmiDescription1 => Crowdin.getText(localeName, 'onboardingLowerBmiDescription1') ?? _fallbackTexts.onboardingLowerBmiDescription1;

	@override
  String get onboardingLowerBmiDescription2 => Crowdin.getText(localeName, 'onboardingLowerBmiDescription2') ?? _fallbackTexts.onboardingLowerBmiDescription2;

	@override
  String get onboardingBmiExclusionBody1 => Crowdin.getText(localeName, 'onboardingBmiExclusionBody1') ?? _fallbackTexts.onboardingBmiExclusionBody1;

	@override
  String get onboardingBmiExclusionBody2 => Crowdin.getText(localeName, 'onboardingBmiExclusionBody2') ?? _fallbackTexts.onboardingBmiExclusionBody2;

	@override
  String get onboardingPhysicalCheckPassedTitle => Crowdin.getText(localeName, 'onboardingPhysicalCheckPassedTitle') ?? _fallbackTexts.onboardingPhysicalCheckPassedTitle;

	@override
  String get onboardingAge => Crowdin.getText(localeName, 'onboardingAge') ?? _fallbackTexts.onboardingAge;

	@override
  String get onboardingHeight => Crowdin.getText(localeName, 'onboardingHeight') ?? _fallbackTexts.onboardingHeight;

	@override
  String get onboardingWeight => Crowdin.getText(localeName, 'onboardingWeight') ?? _fallbackTexts.onboardingWeight;

	@override
  String get onboardingBmi => Crowdin.getText(localeName, 'onboardingBmi') ?? _fallbackTexts.onboardingBmi;

	@override
  String get onboardingYears => Crowdin.getText(localeName, 'onboardingYears') ?? _fallbackTexts.onboardingYears;

	@override
  String get onboardingBmiDescription1 => Crowdin.getText(localeName, 'onboardingBmiDescription1') ?? _fallbackTexts.onboardingBmiDescription1;

	@override
  String get onboardingBmiDescriptionAccent => Crowdin.getText(localeName, 'onboardingBmiDescriptionAccent') ?? _fallbackTexts.onboardingBmiDescriptionAccent;

	@override
  String get onboardingBmiDescription2 => Crowdin.getText(localeName, 'onboardingBmiDescription2') ?? _fallbackTexts.onboardingBmiDescription2;

	@override
  String get onboardingLetsMoveOn => Crowdin.getText(localeName, 'onboardingLetsMoveOn') ?? _fallbackTexts.onboardingLetsMoveOn;

	@override
  String get onboardingMedicalIntroTitle => Crowdin.getText(localeName, 'onboardingMedicalIntroTitle') ?? _fallbackTexts.onboardingMedicalIntroTitle;

	@override
  String get onboardingMedicalIntroBody => Crowdin.getText(localeName, 'onboardingMedicalIntroBody') ?? _fallbackTexts.onboardingMedicalIntroBody;

	@override
  String get onboardingAreYouPregnant => Crowdin.getText(localeName, 'onboardingAreYouPregnant') ?? _fallbackTexts.onboardingAreYouPregnant;

	@override
  String get onboardingFailedPregnancyTitle => Crowdin.getText(localeName, 'onboardingFailedPregnancyTitle') ?? _fallbackTexts.onboardingFailedPregnancyTitle;

	@override
  String get onboardingFailedPregnancyBody1 => Crowdin.getText(localeName, 'onboardingFailedPregnancyBody1') ?? _fallbackTexts.onboardingFailedPregnancyBody1;

	@override
  String get onboardingFailedPregnancyBody2 => Crowdin.getText(localeName, 'onboardingFailedPregnancyBody2') ?? _fallbackTexts.onboardingFailedPregnancyBody2;

	@override
  String get onboardingFailedPregnancyBody3 => Crowdin.getText(localeName, 'onboardingFailedPregnancyBody3') ?? _fallbackTexts.onboardingFailedPregnancyBody3;

	@override
  String get onboardingFailedPregnancyBody4 => Crowdin.getText(localeName, 'onboardingFailedPregnancyBody4') ?? _fallbackTexts.onboardingFailedPregnancyBody4;

	@override
  String get onboardingMedicinesTitle => Crowdin.getText(localeName, 'onboardingMedicinesTitle') ?? _fallbackTexts.onboardingMedicinesTitle;

	@override
  String get onboardingMedicinesPlaceholder => Crowdin.getText(localeName, 'onboardingMedicinesPlaceholder') ?? _fallbackTexts.onboardingMedicinesPlaceholder;

	@override
  String get onboardingWeightLossMedicationQuestion => Crowdin.getText(localeName, 'onboardingWeightLossMedicationQuestion') ?? _fallbackTexts.onboardingWeightLossMedicationQuestion;

	@override
  String get onboardingObesityQuestion => Crowdin.getText(localeName, 'onboardingObesityQuestion') ?? _fallbackTexts.onboardingObesityQuestion;

	@override
  String get onboardingThyroidDiseaseQuestion => Crowdin.getText(localeName, 'onboardingThyroidDiseaseQuestion') ?? _fallbackTexts.onboardingThyroidDiseaseQuestion;

	@override
  String get onboardingMetabolicDiseaseQuestion => Crowdin.getText(localeName, 'onboardingMetabolicDiseaseQuestion') ?? _fallbackTexts.onboardingMetabolicDiseaseQuestion;

	@override
  String get onboardingHypertensionQuestion => Crowdin.getText(localeName, 'onboardingHypertensionQuestion') ?? _fallbackTexts.onboardingHypertensionQuestion;

	@override
  String get onboardingCardiovascularDiseaseQuestion => Crowdin.getText(localeName, 'onboardingCardiovascularDiseaseQuestion') ?? _fallbackTexts.onboardingCardiovascularDiseaseQuestion;

	@override
  String get onboardingStomachReductionQuestion => Crowdin.getText(localeName, 'onboardingStomachReductionQuestion') ?? _fallbackTexts.onboardingStomachReductionQuestion;

	@override
  String get onboardingDiabetesQuestion => Crowdin.getText(localeName, 'onboardingDiabetesQuestion') ?? _fallbackTexts.onboardingDiabetesQuestion;

	@override
  String get onboardingRenalFailureQuestion => Crowdin.getText(localeName, 'onboardingRenalFailureQuestion') ?? _fallbackTexts.onboardingRenalFailureQuestion;

	@override
  String get onboardingAsthmaQuestion => Crowdin.getText(localeName, 'onboardingAsthmaQuestion') ?? _fallbackTexts.onboardingAsthmaQuestion;

	@override
  String get onboardingLiverDiseaseQuestion => Crowdin.getText(localeName, 'onboardingLiverDiseaseQuestion') ?? _fallbackTexts.onboardingLiverDiseaseQuestion;

	@override
  String get onboardingSleepApneaSyndromeQuestion => Crowdin.getText(localeName, 'onboardingSleepApneaSyndromeQuestion') ?? _fallbackTexts.onboardingSleepApneaSyndromeQuestion;

	@override
  String get onboardingLocomotorSystemDiseaseQuestion => Crowdin.getText(localeName, 'onboardingLocomotorSystemDiseaseQuestion') ?? _fallbackTexts.onboardingLocomotorSystemDiseaseQuestion;

	@override
  String get onboardingTreatmentByTheDoctorQuestion => Crowdin.getText(localeName, 'onboardingTreatmentByTheDoctorQuestion') ?? _fallbackTexts.onboardingTreatmentByTheDoctorQuestion;

	@override
  String get onboardingMedicalCheckPassedTitle => Crowdin.getText(localeName, 'onboardingMedicalCheckPassedTitle') ?? _fallbackTexts.onboardingMedicalCheckPassedTitle;

	@override
  String get onboardingMedicalCheckPassedBody => Crowdin.getText(localeName, 'onboardingMedicalCheckPassedBody') ?? _fallbackTexts.onboardingMedicalCheckPassedBody;

	@override
  String get onboardingMedicalCheckFailedTitle => Crowdin.getText(localeName, 'onboardingMedicalCheckFailedTitle') ?? _fallbackTexts.onboardingMedicalCheckFailedTitle;

	@override
  String get onboardingMedicalCheckFailedBody => Crowdin.getText(localeName, 'onboardingMedicalCheckFailedBody') ?? _fallbackTexts.onboardingMedicalCheckFailedBody;

	@override
  String get onboardingMedicalCheckFailedBody2 => Crowdin.getText(localeName, 'onboardingMedicalCheckFailedBody2') ?? _fallbackTexts.onboardingMedicalCheckFailedBody2;

	@override
  String get onboardingCardioVascularDisease => Crowdin.getText(localeName, 'onboardingCardioVascularDisease') ?? _fallbackTexts.onboardingCardioVascularDisease;

	@override
  String get onboardingStomachReductionDisease => Crowdin.getText(localeName, 'onboardingStomachReductionDisease') ?? _fallbackTexts.onboardingStomachReductionDisease;

	@override
  String get onboardingObesity => Crowdin.getText(localeName, 'onboardingObesity') ?? _fallbackTexts.onboardingObesity;

	@override
  String get onboardingThyroidDisease => Crowdin.getText(localeName, 'onboardingThyroidDisease') ?? _fallbackTexts.onboardingThyroidDisease;

	@override
  String get onboardingMetabolicDisease => Crowdin.getText(localeName, 'onboardingMetabolicDisease') ?? _fallbackTexts.onboardingMetabolicDisease;

	@override
  String get onboardingHypertension => Crowdin.getText(localeName, 'onboardingHypertension') ?? _fallbackTexts.onboardingHypertension;

	@override
  String get onboardingDiabetes => Crowdin.getText(localeName, 'onboardingDiabetes') ?? _fallbackTexts.onboardingDiabetes;

	@override
  String get onboardingDiabetesTypeI => Crowdin.getText(localeName, 'onboardingDiabetesTypeI') ?? _fallbackTexts.onboardingDiabetesTypeI;

	@override
  String get onboardingDiabetesTypeII => Crowdin.getText(localeName, 'onboardingDiabetesTypeII') ?? _fallbackTexts.onboardingDiabetesTypeII;

	@override
  String get onboardingRenalFailure => Crowdin.getText(localeName, 'onboardingRenalFailure') ?? _fallbackTexts.onboardingRenalFailure;

	@override
  String get onboardingAsthma => Crowdin.getText(localeName, 'onboardingAsthma') ?? _fallbackTexts.onboardingAsthma;

	@override
  String get onboardingLiverDisease => Crowdin.getText(localeName, 'onboardingLiverDisease') ?? _fallbackTexts.onboardingLiverDisease;

	@override
  String get onboardingSleepApneaSyndrome => Crowdin.getText(localeName, 'onboardingSleepApneaSyndrome') ?? _fallbackTexts.onboardingSleepApneaSyndrome;

	@override
  String get onboardingLocomotorSystemDisease => Crowdin.getText(localeName, 'onboardingLocomotorSystemDisease') ?? _fallbackTexts.onboardingLocomotorSystemDisease;

	@override
  String get onboardingYourMentalHealth => Crowdin.getText(localeName, 'onboardingYourMentalHealth') ?? _fallbackTexts.onboardingYourMentalHealth;

	@override
  String get onboardingMentalIntroBody1 => Crowdin.getText(localeName, 'onboardingMentalIntroBody1') ?? _fallbackTexts.onboardingMentalIntroBody1;

	@override
  String get onboardingMentalIntroBody2 => Crowdin.getText(localeName, 'onboardingMentalIntroBody2') ?? _fallbackTexts.onboardingMentalIntroBody2;

	@override
  String get onboardingMentalHealthIntroTextOne => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextOne') ?? _fallbackTexts.onboardingMentalHealthIntroTextOne;

	@override
  String get onboardingMentalHealthIntroTextTwo => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextTwo') ?? _fallbackTexts.onboardingMentalHealthIntroTextTwo;

	@override
  String get onboardingMentalHealthIntroTextTwoAccent => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextTwoAccent') ?? _fallbackTexts.onboardingMentalHealthIntroTextTwoAccent;

	@override
  String get onboardingMentalHealthIntroTextThree => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextThree') ?? _fallbackTexts.onboardingMentalHealthIntroTextThree;

	@override
  String get onboardingMentalHealthIntroTextThreeAccent => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextThreeAccent') ?? _fallbackTexts.onboardingMentalHealthIntroTextThreeAccent;

	@override
  String get onboardingMentalHealthIntroTextFour => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextFour') ?? _fallbackTexts.onboardingMentalHealthIntroTextFour;

	@override
  String get onboardingMentalHealthIntroTextFive => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextFive') ?? _fallbackTexts.onboardingMentalHealthIntroTextFive;

	@override
  String get onboardingMentalHealthIntroTextSix => Crowdin.getText(localeName, 'onboardingMentalHealthIntroTextSix') ?? _fallbackTexts.onboardingMentalHealthIntroTextSix;

	@override
	String onboardingMentalHealthMoreInfo(String appName) => Crowdin.getText(localeName, 'onboardingMentalHealthMoreInfo', {'appName':appName}) ?? _fallbackTexts.onboardingMentalHealthMoreInfo(appName);

	@override
  String get onboardingMentalHealthMoreInfoBold1 => Crowdin.getText(localeName, 'onboardingMentalHealthMoreInfoBold1') ?? _fallbackTexts.onboardingMentalHealthMoreInfoBold1;

	@override
  String get onboardingMentalHealthMoreInfoBold2 => Crowdin.getText(localeName, 'onboardingMentalHealthMoreInfoBold2') ?? _fallbackTexts.onboardingMentalHealthMoreInfoBold2;

	@override
  String get onboardingWho8Question => Crowdin.getText(localeName, 'onboardingWho8Question') ?? _fallbackTexts.onboardingWho8Question;

	@override
  String get onboardingLastTwoWeeks => Crowdin.getText(localeName, 'onboardingLastTwoWeeks') ?? _fallbackTexts.onboardingLastTwoWeeks;

	@override
  String get onboardingPastFourWeeks => Crowdin.getText(localeName, 'onboardingPastFourWeeks') ?? _fallbackTexts.onboardingPastFourWeeks;

	@override
  String get onboardingPhq15Question => Crowdin.getText(localeName, 'onboardingPhq15Question') ?? _fallbackTexts.onboardingPhq15Question;

	@override
  String get onboardingPhq8Question => Crowdin.getText(localeName, 'onboardingPhq8Question') ?? _fallbackTexts.onboardingPhq8Question;

	@override
  String get onboardingStartAgain => Crowdin.getText(localeName, 'onboardingStartAgain') ?? _fallbackTexts.onboardingStartAgain;

	@override
  String get onboardingWho5ResultTestMinimal => Crowdin.getText(localeName, 'onboardingWho5ResultTestMinimal') ?? _fallbackTexts.onboardingWho5ResultTestMinimal;

	@override
  String get onboardingWho5ResultTestHigh => Crowdin.getText(localeName, 'onboardingWho5ResultTestHigh') ?? _fallbackTexts.onboardingWho5ResultTestHigh;

	@override
  String get onboardingPhq15ResultMinimal => Crowdin.getText(localeName, 'onboardingPhq15ResultMinimal') ?? _fallbackTexts.onboardingPhq15ResultMinimal;

	@override
  String get onboardingPhq15ResultMild => Crowdin.getText(localeName, 'onboardingPhq15ResultMild') ?? _fallbackTexts.onboardingPhq15ResultMild;

	@override
  String get onboardingPhq15ResultMedium => Crowdin.getText(localeName, 'onboardingPhq15ResultMedium') ?? _fallbackTexts.onboardingPhq15ResultMedium;

	@override
  String get onboardingPhq15ResultHigh => Crowdin.getText(localeName, 'onboardingPhq15ResultHigh') ?? _fallbackTexts.onboardingPhq15ResultHigh;

	@override
  String get onboardingGad7ResultMinimal => Crowdin.getText(localeName, 'onboardingGad7ResultMinimal') ?? _fallbackTexts.onboardingGad7ResultMinimal;

	@override
  String get onboardingGad7ResultMild => Crowdin.getText(localeName, 'onboardingGad7ResultMild') ?? _fallbackTexts.onboardingGad7ResultMild;

	@override
  String get onboardingGad7ResultMedium => Crowdin.getText(localeName, 'onboardingGad7ResultMedium') ?? _fallbackTexts.onboardingGad7ResultMedium;

	@override
  String get onboardingGad7ResultHigh => Crowdin.getText(localeName, 'onboardingGad7ResultHigh') ?? _fallbackTexts.onboardingGad7ResultHigh;

	@override
  String get onboardingPhq8ResultMinimal => Crowdin.getText(localeName, 'onboardingPhq8ResultMinimal') ?? _fallbackTexts.onboardingPhq8ResultMinimal;

	@override
  String get onboardingPhq8ResultMild => Crowdin.getText(localeName, 'onboardingPhq8ResultMild') ?? _fallbackTexts.onboardingPhq8ResultMild;

	@override
  String get onboardingPhq8ResultMedium => Crowdin.getText(localeName, 'onboardingPhq8ResultMedium') ?? _fallbackTexts.onboardingPhq8ResultMedium;

	@override
  String get onboardingPhq8ResultHigh => Crowdin.getText(localeName, 'onboardingPhq8ResultHigh') ?? _fallbackTexts.onboardingPhq8ResultHigh;

	@override
  String get onboardingPhq8ResultHighest => Crowdin.getText(localeName, 'onboardingPhq8ResultHighest') ?? _fallbackTexts.onboardingPhq8ResultHighest;

	@override
  String get onboardingPhq8FinalResultHigh1 => Crowdin.getText(localeName, 'onboardingPhq8FinalResultHigh1') ?? _fallbackTexts.onboardingPhq8FinalResultHigh1;

	@override
  String get onboardingPhq8FinalResultHigh2 => Crowdin.getText(localeName, 'onboardingPhq8FinalResultHigh2') ?? _fallbackTexts.onboardingPhq8FinalResultHigh2;

	@override
  String get onboardingPhq8FinalResultHigh3 => Crowdin.getText(localeName, 'onboardingPhq8FinalResultHigh3') ?? _fallbackTexts.onboardingPhq8FinalResultHigh3;

	@override
  String get onboardingPhq8FinalResultHigh4 => Crowdin.getText(localeName, 'onboardingPhq8FinalResultHigh4') ?? _fallbackTexts.onboardingPhq8FinalResultHigh4;

	@override
  String get onboardingIfYouHaveSuicidalThoughts => Crowdin.getText(localeName, 'onboardingIfYouHaveSuicidalThoughts') ?? _fallbackTexts.onboardingIfYouHaveSuicidalThoughts;

	@override
  String get onboardingPersonalProgram => Crowdin.getText(localeName, 'onboardingPersonalProgram') ?? _fallbackTexts.onboardingPersonalProgram;

	@override
  String get onboardingSupportMessage => Crowdin.getText(localeName, 'onboardingSupportMessage') ?? _fallbackTexts.onboardingSupportMessage;

	@override
  String get onboardingFeelLimited1 => Crowdin.getText(localeName, 'onboardingFeelLimited1') ?? _fallbackTexts.onboardingFeelLimited1;

	@override
  String get onboardingFeelLimited2 => Crowdin.getText(localeName, 'onboardingFeelLimited2') ?? _fallbackTexts.onboardingFeelLimited2;

	@override
  String get onboardingFeelLimited3 => Crowdin.getText(localeName, 'onboardingFeelLimited3') ?? _fallbackTexts.onboardingFeelLimited3;

	@override
  String get onboardingFeelLimited4 => Crowdin.getText(localeName, 'onboardingFeelLimited4') ?? _fallbackTexts.onboardingFeelLimited4;

	@override
  String get onboardingNotATherapy => Crowdin.getText(localeName, 'onboardingNotATherapy') ?? _fallbackTexts.onboardingNotATherapy;

	@override
  String get onboardingLearnManyThings => Crowdin.getText(localeName, 'onboardingLearnManyThings') ?? _fallbackTexts.onboardingLearnManyThings;

	@override
  String get onboardingUnlockAllSections => Crowdin.getText(localeName, 'onboardingUnlockAllSections') ?? _fallbackTexts.onboardingUnlockAllSections;

	@override
  String get onboardingAwailableAreas => Crowdin.getText(localeName, 'onboardingAwailableAreas') ?? _fallbackTexts.onboardingAwailableAreas;

	@override
  String get onboardingUnlockBuddyMessage => Crowdin.getText(localeName, 'onboardingUnlockBuddyMessage') ?? _fallbackTexts.onboardingUnlockBuddyMessage;

	@override
  String get onboardingWeWillGuideYou => Crowdin.getText(localeName, 'onboardingWeWillGuideYou') ?? _fallbackTexts.onboardingWeWillGuideYou;

	@override
  String get onboardingPhq8Fail => Crowdin.getText(localeName, 'onboardingPhq8Fail') ?? _fallbackTexts.onboardingPhq8Fail;

	@override
  String get onboardingGeneralWellBeingSummary => Crowdin.getText(localeName, 'onboardingGeneralWellBeingSummary') ?? _fallbackTexts.onboardingGeneralWellBeingSummary;

	@override
  String get onboardingBodyAndMindBalanceSummary => Crowdin.getText(localeName, 'onboardingBodyAndMindBalanceSummary') ?? _fallbackTexts.onboardingBodyAndMindBalanceSummary;

	@override
  String get onboardingStateOfMindSummary => Crowdin.getText(localeName, 'onboardingStateOfMindSummary') ?? _fallbackTexts.onboardingStateOfMindSummary;

	@override
  String get onboardingCheckCompleted => Crowdin.getText(localeName, 'onboardingCheckCompleted') ?? _fallbackTexts.onboardingCheckCompleted;

	@override
  String get onboardingYouExceededTimeMessage => Crowdin.getText(localeName, 'onboardingYouExceededTimeMessage') ?? _fallbackTexts.onboardingYouExceededTimeMessage;

	@override
  String get onboardingNoWorriesYouCanDoItLater => Crowdin.getText(localeName, 'onboardingNoWorriesYouCanDoItLater') ?? _fallbackTexts.onboardingNoWorriesYouCanDoItLater;

	@override
  String get onboardingMentalResultSubText1 => Crowdin.getText(localeName, 'onboardingMentalResultSubText1') ?? _fallbackTexts.onboardingMentalResultSubText1;

	@override
  String get onboardingMentalResultSubText2 => Crowdin.getText(localeName, 'onboardingMentalResultSubText2') ?? _fallbackTexts.onboardingMentalResultSubText2;

	@override
  String get onboardingMentalResultSubText3 => Crowdin.getText(localeName, 'onboardingMentalResultSubText3') ?? _fallbackTexts.onboardingMentalResultSubText3;

	@override
  String get avatarAvatar => Crowdin.getText(localeName, 'avatarAvatar') ?? _fallbackTexts.avatarAvatar;

	@override
  String get avatarSelectProfilePicture => Crowdin.getText(localeName, 'avatarSelectProfilePicture') ?? _fallbackTexts.avatarSelectProfilePicture;

	@override
  String get avatarMoveToResize => Crowdin.getText(localeName, 'avatarMoveToResize') ?? _fallbackTexts.avatarMoveToResize;

	@override
  String get avatarChooseYourAvatar => Crowdin.getText(localeName, 'avatarChooseYourAvatar') ?? _fallbackTexts.avatarChooseYourAvatar;

	@override
  String get avatarAddPhoto => Crowdin.getText(localeName, 'avatarAddPhoto') ?? _fallbackTexts.avatarAddPhoto;

	@override
  String get avatarSizeErrorMessageTitle => Crowdin.getText(localeName, 'avatarSizeErrorMessageTitle') ?? _fallbackTexts.avatarSizeErrorMessageTitle;

	@override
  String get avatarSizeErrorMessageSubtitle => Crowdin.getText(localeName, 'avatarSizeErrorMessageSubtitle') ?? _fallbackTexts.avatarSizeErrorMessageSubtitle;

	@override
  String get avatarGoToAppSettings => Crowdin.getText(localeName, 'avatarGoToAppSettings') ?? _fallbackTexts.avatarGoToAppSettings;

	@override
  String get avatarGaleryPermissionsMessage => Crowdin.getText(localeName, 'avatarGaleryPermissionsMessage') ?? _fallbackTexts.avatarGaleryPermissionsMessage;

	@override
  String get avatarGaleryPermissionsMessageAndroid => Crowdin.getText(localeName, 'avatarGaleryPermissionsMessageAndroid') ?? _fallbackTexts.avatarGaleryPermissionsMessageAndroid;

	@override
  String get avatarCropper => Crowdin.getText(localeName, 'avatarCropper') ?? _fallbackTexts.avatarCropper;

	@override
  String get smartGoalsMyGoals => Crowdin.getText(localeName, 'smartGoalsMyGoals') ?? _fallbackTexts.smartGoalsMyGoals;

	@override
  String get smartGoalsNoGoalsSelected => Crowdin.getText(localeName, 'smartGoalsNoGoalsSelected') ?? _fallbackTexts.smartGoalsNoGoalsSelected;

	@override
  String get smartGoalsChooseGoalsForUpcomingDays => Crowdin.getText(localeName, 'smartGoalsChooseGoalsForUpcomingDays') ?? _fallbackTexts.smartGoalsChooseGoalsForUpcomingDays;

	@override
  String get smartGoalsUpcomingGoals => Crowdin.getText(localeName, 'smartGoalsUpcomingGoals') ?? _fallbackTexts.smartGoalsUpcomingGoals;

	@override
  String get smartGoalsUpcomingGoalsTitle => Crowdin.getText(localeName, 'smartGoalsUpcomingGoalsTitle') ?? _fallbackTexts.smartGoalsUpcomingGoalsTitle;

	@override
  String get smartGoalsUpcomingGoalsDescription => Crowdin.getText(localeName, 'smartGoalsUpcomingGoalsDescription') ?? _fallbackTexts.smartGoalsUpcomingGoalsDescription;

	@override
  String get smartGoalsCancelGoal => Crowdin.getText(localeName, 'smartGoalsCancelGoal') ?? _fallbackTexts.smartGoalsCancelGoal;

	@override
  String get smartGoalsCancelGoalTitle => Crowdin.getText(localeName, 'smartGoalsCancelGoalTitle') ?? _fallbackTexts.smartGoalsCancelGoalTitle;

	@override
  String get smartGoalsCancelGoalSubTitle => Crowdin.getText(localeName, 'smartGoalsCancelGoalSubTitle') ?? _fallbackTexts.smartGoalsCancelGoalSubTitle;

	@override
  String get smartGoalsSetGoal => Crowdin.getText(localeName, 'smartGoalsSetGoal') ?? _fallbackTexts.smartGoalsSetGoal;

	@override
  String get smartGoalsSelectGoalsCategoryTitle => Crowdin.getText(localeName, 'smartGoalsSelectGoalsCategoryTitle') ?? _fallbackTexts.smartGoalsSelectGoalsCategoryTitle;

	@override
  String get smartGoalsNewLabel => Crowdin.getText(localeName, 'smartGoalsNewLabel') ?? _fallbackTexts.smartGoalsNewLabel;

	@override
  String get smartGoalsSelectGoalsTitle => Crowdin.getText(localeName, 'smartGoalsSelectGoalsTitle') ?? _fallbackTexts.smartGoalsSelectGoalsTitle;

	@override
  String get smartGoalsSelectGoalsSubtitle => Crowdin.getText(localeName, 'smartGoalsSelectGoalsSubtitle') ?? _fallbackTexts.smartGoalsSelectGoalsSubtitle;

	@override
  String get smartGoalsSaveWeeklyGoalsSuccessMessage => Crowdin.getText(localeName, 'smartGoalsSaveWeeklyGoalsSuccessMessage') ?? _fallbackTexts.smartGoalsSaveWeeklyGoalsSuccessMessage;

	@override
  String get smartGoalsStatisticsTitle => Crowdin.getText(localeName, 'smartGoalsStatisticsTitle') ?? _fallbackTexts.smartGoalsStatisticsTitle;

	@override
  String get smartGoalsAccomplishedInTotal => Crowdin.getText(localeName, 'smartGoalsAccomplishedInTotal') ?? _fallbackTexts.smartGoalsAccomplishedInTotal;

	@override
  String get smartGoalsAccomplishedEmptyMessage => Crowdin.getText(localeName, 'smartGoalsAccomplishedEmptyMessage') ?? _fallbackTexts.smartGoalsAccomplishedEmptyMessage;

	@override
  String get smartGoalsAccomplished => Crowdin.getText(localeName, 'smartGoalsAccomplished') ?? _fallbackTexts.smartGoalsAccomplished;

	@override
	String smartGoalsGoalLogDays(int count) => Crowdin.getText(localeName, 'smartGoalsGoalLogDays', {'count':count}) ?? _fallbackTexts.smartGoalsGoalLogDays(count);

	@override
	String smartGoalsGoalLogged(int count) => Crowdin.getText(localeName, 'smartGoalsGoalLogged', {'count':count}) ?? _fallbackTexts.smartGoalsGoalLogged(count);

	@override
	String smartGoalsGoalTotalCompletions(int count) => Crowdin.getText(localeName, 'smartGoalsGoalTotalCompletions', {'count':count}) ?? _fallbackTexts.smartGoalsGoalTotalCompletions(count);

	@override
  String get smartGoalsGoalCompleted => Crowdin.getText(localeName, 'smartGoalsGoalCompleted') ?? _fallbackTexts.smartGoalsGoalCompleted;

	@override
  String get smartGoalsGoalNotCompleted => Crowdin.getText(localeName, 'smartGoalsGoalNotCompleted') ?? _fallbackTexts.smartGoalsGoalNotCompleted;

	@override
  String get smartGoalsHowHardWasTheGoal => Crowdin.getText(localeName, 'smartGoalsHowHardWasTheGoal') ?? _fallbackTexts.smartGoalsHowHardWasTheGoal;

	@override
  String get smartGoalsWantToTryInFuture => Crowdin.getText(localeName, 'smartGoalsWantToTryInFuture') ?? _fallbackTexts.smartGoalsWantToTryInFuture;

	@override
  String get smartGoalsGoalReview => Crowdin.getText(localeName, 'smartGoalsGoalReview') ?? _fallbackTexts.smartGoalsGoalReview;

	@override
	String smartGoalsWeeklyDaysLeft(int count) => Crowdin.getText(localeName, 'smartGoalsWeeklyDaysLeft', {'count':count}) ?? _fallbackTexts.smartGoalsWeeklyDaysLeft(count);

	@override
  String get smartGoalsWeeklyDayLeft => Crowdin.getText(localeName, 'smartGoalsWeeklyDayLeft') ?? _fallbackTexts.smartGoalsWeeklyDayLeft;

	@override
  String get smartGoalsWeeklyDaysReview => Crowdin.getText(localeName, 'smartGoalsWeeklyDaysReview') ?? _fallbackTexts.smartGoalsWeeklyDaysReview;

	@override
	String smartGoalsWeeklyTimes(int count) => Crowdin.getText(localeName, 'smartGoalsWeeklyTimes', {'count':count}) ?? _fallbackTexts.smartGoalsWeeklyTimes(count);

	@override
  String get smartGoalsReasonGoalNotLike => Crowdin.getText(localeName, 'smartGoalsReasonGoalNotLike') ?? _fallbackTexts.smartGoalsReasonGoalNotLike;

	@override
  String get smartGoalsReasonGoalChallenging => Crowdin.getText(localeName, 'smartGoalsReasonGoalChallenging') ?? _fallbackTexts.smartGoalsReasonGoalChallenging;

	@override
  String get smartGoalsReasonGoalMissing => Crowdin.getText(localeName, 'smartGoalsReasonGoalMissing') ?? _fallbackTexts.smartGoalsReasonGoalMissing;

	@override
  String get smartGoalsReasonGoalHabit => Crowdin.getText(localeName, 'smartGoalsReasonGoalHabit') ?? _fallbackTexts.smartGoalsReasonGoalHabit;

	@override
  String get smartGoalsReasonGoalSpecific => Crowdin.getText(localeName, 'smartGoalsReasonGoalSpecific') ?? _fallbackTexts.smartGoalsReasonGoalSpecific;

	@override
  String get nutritionProteinDegree => Crowdin.getText(localeName, 'nutritionProteinDegree') ?? _fallbackTexts.nutritionProteinDegree;

	@override
  String get nutritionFiber => Crowdin.getText(localeName, 'nutritionFiber') ?? _fallbackTexts.nutritionFiber;

	@override
  String get nutritionCalorieDensity => Crowdin.getText(localeName, 'nutritionCalorieDensity') ?? _fallbackTexts.nutritionCalorieDensity;

	@override
  String get buddyTitle => Crowdin.getText(localeName, 'buddyTitle') ?? _fallbackTexts.buddyTitle;

	@override
  String get buddyBuddy => Crowdin.getText(localeName, 'buddyBuddy') ?? _fallbackTexts.buddyBuddy;

	@override
  String get buddyUnlocked => Crowdin.getText(localeName, 'buddyUnlocked') ?? _fallbackTexts.buddyUnlocked;

	@override
  String get buddyUnlockedBody => Crowdin.getText(localeName, 'buddyUnlockedBody') ?? _fallbackTexts.buddyUnlockedBody;

	@override
  String get buddyGoToPreferences => Crowdin.getText(localeName, 'buddyGoToPreferences') ?? _fallbackTexts.buddyGoToPreferences;

	@override
  String get buddyIntroTitle => Crowdin.getText(localeName, 'buddyIntroTitle') ?? _fallbackTexts.buddyIntroTitle;

	@override
  String get buddyDescriptionTitle => Crowdin.getText(localeName, 'buddyDescriptionTitle') ?? _fallbackTexts.buddyDescriptionTitle;

	@override
  String get buddyIntroBody => Crowdin.getText(localeName, 'buddyIntroBody') ?? _fallbackTexts.buddyIntroBody;

	@override
  String get buddyIntroYesBtn => Crowdin.getText(localeName, 'buddyIntroYesBtn') ?? _fallbackTexts.buddyIntroYesBtn;

	@override
  String get buddyIntroNoBtn => Crowdin.getText(localeName, 'buddyIntroNoBtn') ?? _fallbackTexts.buddyIntroNoBtn;

	@override
  String get buddyDescriptionContent => Crowdin.getText(localeName, 'buddyDescriptionContent') ?? _fallbackTexts.buddyDescriptionContent;

	@override
  String get buddyPreferences => Crowdin.getText(localeName, 'buddyPreferences') ?? _fallbackTexts.buddyPreferences;

	@override
  String get buddyNoPreferencesState => Crowdin.getText(localeName, 'buddyNoPreferencesState') ?? _fallbackTexts.buddyNoPreferencesState;

	@override
  String get buddyCompleted => Crowdin.getText(localeName, 'buddyCompleted') ?? _fallbackTexts.buddyCompleted;

	@override
  String get buddyCompletedContent => Crowdin.getText(localeName, 'buddyCompletedContent') ?? _fallbackTexts.buddyCompletedContent;

	@override
  String get buddyLiveTogetherTitle => Crowdin.getText(localeName, 'buddyLiveTogetherTitle') ?? _fallbackTexts.buddyLiveTogetherTitle;

	@override
  String get buddyRelationTitle => Crowdin.getText(localeName, 'buddyRelationTitle') ?? _fallbackTexts.buddyRelationTitle;

	@override
  String get buddyEmailTitle => Crowdin.getText(localeName, 'buddyEmailTitle') ?? _fallbackTexts.buddyEmailTitle;

	@override
  String get buddyEmailLabel => Crowdin.getText(localeName, 'buddyEmailLabel') ?? _fallbackTexts.buddyEmailLabel;

	@override
  String get buddyEmailHint => Crowdin.getText(localeName, 'buddyEmailHint') ?? _fallbackTexts.buddyEmailHint;

	@override
  String get buddyPartner => Crowdin.getText(localeName, 'buddyPartner') ?? _fallbackTexts.buddyPartner;

	@override
  String get buddyChild => Crowdin.getText(localeName, 'buddyChild') ?? _fallbackTexts.buddyChild;

	@override
  String get buddyParent => Crowdin.getText(localeName, 'buddyParent') ?? _fallbackTexts.buddyParent;

	@override
  String get buddyFamily => Crowdin.getText(localeName, 'buddyFamily') ?? _fallbackTexts.buddyFamily;

	@override
  String get buddyFriend => Crowdin.getText(localeName, 'buddyFriend') ?? _fallbackTexts.buddyFriend;

	@override
  String get buddyPendingTitle => Crowdin.getText(localeName, 'buddyPendingTitle') ?? _fallbackTexts.buddyPendingTitle;

	@override
	String buddyPendingSubTitle(String date, String time) => Crowdin.getText(localeName, 'buddyPendingSubTitle', {'date':date, 'time':time}) ?? _fallbackTexts.buddyPendingSubTitle(date, time);

	@override
  String get buddyRejectTitle => Crowdin.getText(localeName, 'buddyRejectTitle') ?? _fallbackTexts.buddyRejectTitle;

	@override
  String get buddyRejectSubTitle => Crowdin.getText(localeName, 'buddyRejectSubTitle') ?? _fallbackTexts.buddyRejectSubTitle;

	@override
  String get buddyNotAvailableTitle => Crowdin.getText(localeName, 'buddyNotAvailableTitle') ?? _fallbackTexts.buddyNotAvailableTitle;

	@override
  String get buddyNotAvailableSubTitle => Crowdin.getText(localeName, 'buddyNotAvailableSubTitle') ?? _fallbackTexts.buddyNotAvailableSubTitle;

	@override
  String get buddyResendInvitation => Crowdin.getText(localeName, 'buddyResendInvitation') ?? _fallbackTexts.buddyResendInvitation;

	@override
  String get buddyInviteAnotherBuddy => Crowdin.getText(localeName, 'buddyInviteAnotherBuddy') ?? _fallbackTexts.buddyInviteAnotherBuddy;

	@override
  String get buddyFindAnotherBuddyContent => Crowdin.getText(localeName, 'buddyFindAnotherBuddyContent') ?? _fallbackTexts.buddyFindAnotherBuddyContent;

	@override
  String get buddyFindAnotherBuddy => Crowdin.getText(localeName, 'buddyFindAnotherBuddy') ?? _fallbackTexts.buddyFindAnotherBuddy;

	@override
  String get buddyNotNeedAnotherBuddy => Crowdin.getText(localeName, 'buddyNotNeedAnotherBuddy') ?? _fallbackTexts.buddyNotNeedAnotherBuddy;

	@override
  String get buddyEmail => Crowdin.getText(localeName, 'buddyEmail') ?? _fallbackTexts.buddyEmail;

	@override
  String get buddyUserName => Crowdin.getText(localeName, 'buddyUserName') ?? _fallbackTexts.buddyUserName;

	@override
  String get buddySince => Crowdin.getText(localeName, 'buddySince') ?? _fallbackTexts.buddySince;

	@override
  String get buddyRemoveInvite => Crowdin.getText(localeName, 'buddyRemoveInvite') ?? _fallbackTexts.buddyRemoveInvite;

	@override
  String get buddyRemoveBuddy => Crowdin.getText(localeName, 'buddyRemoveBuddy') ?? _fallbackTexts.buddyRemoveBuddy;

	@override
  String get buddyInviteBuddy => Crowdin.getText(localeName, 'buddyInviteBuddy') ?? _fallbackTexts.buddyInviteBuddy;

	@override
	String buddyFindAnotherBuddyLabel(String name) => Crowdin.getText(localeName, 'buddyFindAnotherBuddyLabel', {'name':name}) ?? _fallbackTexts.buddyFindAnotherBuddyLabel(name);

	@override
  String get buddyFindAnotherBuddyContentOne => Crowdin.getText(localeName, 'buddyFindAnotherBuddyContentOne') ?? _fallbackTexts.buddyFindAnotherBuddyContentOne;

	@override
  String get buddyFindAnotherBuddyContentTwo => Crowdin.getText(localeName, 'buddyFindAnotherBuddyContentTwo') ?? _fallbackTexts.buddyFindAnotherBuddyContentTwo;

	@override
  String get linksTermsAndConditionsUrl => Crowdin.getText(localeName, 'linksTermsAndConditionsUrl') ?? _fallbackTexts.linksTermsAndConditionsUrl;

	@override
  String get linksPrivacyPolicyUrl => Crowdin.getText(localeName, 'linksPrivacyPolicyUrl') ?? _fallbackTexts.linksPrivacyPolicyUrl;

	@override
  String get linksPsychologistConsulting => Crowdin.getText(localeName, 'linksPsychologistConsulting') ?? _fallbackTexts.linksPsychologistConsulting;

	@override
  String get linksInstructionsUrl => Crowdin.getText(localeName, 'linksInstructionsUrl') ?? _fallbackTexts.linksInstructionsUrl;

	@override
  String get riverOverviewTitle => Crowdin.getText(localeName, 'riverOverviewTitle') ?? _fallbackTexts.riverOverviewTitle;

	@override
  String get riverGuidancePracticeTitle => Crowdin.getText(localeName, 'riverGuidancePracticeTitle') ?? _fallbackTexts.riverGuidancePracticeTitle;

	@override
  String get riverGuidancePracticeDescription => Crowdin.getText(localeName, 'riverGuidancePracticeDescription') ?? _fallbackTexts.riverGuidancePracticeDescription;

	@override
  String get riverGuidanceProfileTitle => Crowdin.getText(localeName, 'riverGuidanceProfileTitle') ?? _fallbackTexts.riverGuidanceProfileTitle;

	@override
  String get riverGuidanceProfileDescription => Crowdin.getText(localeName, 'riverGuidanceProfileDescription') ?? _fallbackTexts.riverGuidanceProfileDescription;

	@override
  String get riverGuidanceCompletedTitle => Crowdin.getText(localeName, 'riverGuidanceCompletedTitle') ?? _fallbackTexts.riverGuidanceCompletedTitle;

	@override
  String get riverGuidanceCompletedDescription => Crowdin.getText(localeName, 'riverGuidanceCompletedDescription') ?? _fallbackTexts.riverGuidanceCompletedDescription;

	@override
	String riverModuleCompletedTitle(String module) => Crowdin.getText(localeName, 'riverModuleCompletedTitle', {'module':module}) ?? _fallbackTexts.riverModuleCompletedTitle(module);

	@override
	String riverModuleCompletedDescription(String nextModule) => Crowdin.getText(localeName, 'riverModuleCompletedDescription', {'nextModule':nextModule}) ?? _fallbackTexts.riverModuleCompletedDescription(nextModule);

	@override
  String get riverLastModuleCompletedDescription => Crowdin.getText(localeName, 'riverLastModuleCompletedDescription') ?? _fallbackTexts.riverLastModuleCompletedDescription;

	@override
  String get riverGuidanceStartRiverTitle => Crowdin.getText(localeName, 'riverGuidanceStartRiverTitle') ?? _fallbackTexts.riverGuidanceStartRiverTitle;

	@override
  String get riverGuidanceStartRiverDescription => Crowdin.getText(localeName, 'riverGuidanceStartRiverDescription') ?? _fallbackTexts.riverGuidanceStartRiverDescription;

	@override
  String get riverModuleGraduationCompletedItemsTitle => Crowdin.getText(localeName, 'riverModuleGraduationCompletedItemsTitle') ?? _fallbackTexts.riverModuleGraduationCompletedItemsTitle;

	@override
  String get riverModuleGraduationCompletedTimeTitle => Crowdin.getText(localeName, 'riverModuleGraduationCompletedTimeTitle') ?? _fallbackTexts.riverModuleGraduationCompletedTimeTitle;

	@override
  String get riverModuleGraduationCompletedItemsMessage => Crowdin.getText(localeName, 'riverModuleGraduationCompletedItemsMessage') ?? _fallbackTexts.riverModuleGraduationCompletedItemsMessage;

	@override
  String get riverModuleGraduationCompletedTimeMessage => Crowdin.getText(localeName, 'riverModuleGraduationCompletedTimeMessage') ?? _fallbackTexts.riverModuleGraduationCompletedTimeMessage;

	@override
  String get subscriptionTrialTitle => Crowdin.getText(localeName, 'subscriptionTrialTitle') ?? _fallbackTexts.subscriptionTrialTitle;

	@override
  String get subscriptionTrialLabel => Crowdin.getText(localeName, 'subscriptionTrialLabel') ?? _fallbackTexts.subscriptionTrialLabel;

	@override
  String get subscriptionTrialExpiredTitle => Crowdin.getText(localeName, 'subscriptionTrialExpiredTitle') ?? _fallbackTexts.subscriptionTrialExpiredTitle;

	@override
  String get subscriptionTrialExpiredLabel1 => Crowdin.getText(localeName, 'subscriptionTrialExpiredLabel1') ?? _fallbackTexts.subscriptionTrialExpiredLabel1;

	@override
  String get subscriptionTrialExpiredLabel2 => Crowdin.getText(localeName, 'subscriptionTrialExpiredLabel2') ?? _fallbackTexts.subscriptionTrialExpiredLabel2;

	@override
  String get subscriptionEndedTitle => Crowdin.getText(localeName, 'subscriptionEndedTitle') ?? _fallbackTexts.subscriptionEndedTitle;

	@override
  String get subscriptionEmptyToRestore => Crowdin.getText(localeName, 'subscriptionEmptyToRestore') ?? _fallbackTexts.subscriptionEmptyToRestore;

	@override
  String get subscriptionEndedLabel1 => Crowdin.getText(localeName, 'subscriptionEndedLabel1') ?? _fallbackTexts.subscriptionEndedLabel1;

	@override
  String get subscriptionEndedLabel2 => Crowdin.getText(localeName, 'subscriptionEndedLabel2') ?? _fallbackTexts.subscriptionEndedLabel2;

	@override
  String get subscriptionCancelledTitle => Crowdin.getText(localeName, 'subscriptionCancelledTitle') ?? _fallbackTexts.subscriptionCancelledTitle;

	@override
  String get subscriptionCancelledLabel1 => Crowdin.getText(localeName, 'subscriptionCancelledLabel1') ?? _fallbackTexts.subscriptionCancelledLabel1;

	@override
  String get subscriptionCancelledLabel2 => Crowdin.getText(localeName, 'subscriptionCancelledLabel2') ?? _fallbackTexts.subscriptionCancelledLabel2;

	@override
  String get subscriptionRenewedTitle => Crowdin.getText(localeName, 'subscriptionRenewedTitle') ?? _fallbackTexts.subscriptionRenewedTitle;

	@override
  String get subscriptionRenewedLabel => Crowdin.getText(localeName, 'subscriptionRenewedLabel') ?? _fallbackTexts.subscriptionRenewedLabel;

	@override
  String get subscriptionRestoreLabel => Crowdin.getText(localeName, 'subscriptionRestoreLabel') ?? _fallbackTexts.subscriptionRestoreLabel;

	@override
  String get subscriptionTermsLabel => Crowdin.getText(localeName, 'subscriptionTermsLabel') ?? _fallbackTexts.subscriptionTermsLabel;

	@override
  String get subscriptionPrivacyLabel => Crowdin.getText(localeName, 'subscriptionPrivacyLabel') ?? _fallbackTexts.subscriptionPrivacyLabel;

	@override
  String get subscriptionAnnual => Crowdin.getText(localeName, 'subscriptionAnnual') ?? _fallbackTexts.subscriptionAnnual;

	@override
  String get subscriptionMonthly => Crowdin.getText(localeName, 'subscriptionMonthly') ?? _fallbackTexts.subscriptionMonthly;

	@override
  String get subscriptionSubscribe => Crowdin.getText(localeName, 'subscriptionSubscribe') ?? _fallbackTexts.subscriptionSubscribe;

	@override
  String get subscriptionRedeem => Crowdin.getText(localeName, 'subscriptionRedeem') ?? _fallbackTexts.subscriptionRedeem;

	@override
	String subscriptionSubTitlePrice(String description) => Crowdin.getText(localeName, 'subscriptionSubTitlePrice', {'description':description}) ?? _fallbackTexts.subscriptionSubTitlePrice(description);

	@override
	String subscriptionTitlePrice(String title, String priceWithCurrency) => Crowdin.getText(localeName, 'subscriptionTitlePrice', {'title':title, 'priceWithCurrency':priceWithCurrency}) ?? _fallbackTexts.subscriptionTitlePrice(title, priceWithCurrency);

	@override
  String get subscriptionSubscription => Crowdin.getText(localeName, 'subscriptionSubscription') ?? _fallbackTexts.subscriptionSubscription;

	@override
  String get subscriptionManageSubscription => Crowdin.getText(localeName, 'subscriptionManageSubscription') ?? _fallbackTexts.subscriptionManageSubscription;

	@override
  String get subscriptionType => Crowdin.getText(localeName, 'subscriptionType') ?? _fallbackTexts.subscriptionType;

	@override
  String get subscriptionSubscriptionVia => Crowdin.getText(localeName, 'subscriptionSubscriptionVia') ?? _fallbackTexts.subscriptionSubscriptionVia;

	@override
  String get subscriptionMemberSince => Crowdin.getText(localeName, 'subscriptionMemberSince') ?? _fallbackTexts.subscriptionMemberSince;

	@override
  String get subscriptionAutomaticRenewalOn => Crowdin.getText(localeName, 'subscriptionAutomaticRenewalOn') ?? _fallbackTexts.subscriptionAutomaticRenewalOn;

	@override
  String get subscriptionServiceUnavailable => Crowdin.getText(localeName, 'subscriptionServiceUnavailable') ?? _fallbackTexts.subscriptionServiceUnavailable;

	@override
  String get subscriptionOtherPurchaseVendor => Crowdin.getText(localeName, 'subscriptionOtherPurchaseVendor') ?? _fallbackTexts.subscriptionOtherPurchaseVendor;

	@override
  String get subscriptionAppStore => Crowdin.getText(localeName, 'subscriptionAppStore') ?? _fallbackTexts.subscriptionAppStore;

	@override
  String get subscriptionGoogleMarket => Crowdin.getText(localeName, 'subscriptionGoogleMarket') ?? _fallbackTexts.subscriptionGoogleMarket;

	@override
  String get subscriptionCancelAccountSubscription => Crowdin.getText(localeName, 'subscriptionCancelAccountSubscription') ?? _fallbackTexts.subscriptionCancelAccountSubscription;

	@override
  String get subscriptionOtherPurchaseVendorCancelAccountSubscription => Crowdin.getText(localeName, 'subscriptionOtherPurchaseVendorCancelAccountSubscription') ?? _fallbackTexts.subscriptionOtherPurchaseVendorCancelAccountSubscription;

	@override
  String get subscriptionRestoreSubscriptionFromSettings => Crowdin.getText(localeName, 'subscriptionRestoreSubscriptionFromSettings') ?? _fallbackTexts.subscriptionRestoreSubscriptionFromSettings;

	@override
  String get subscriptionAskRestoreSubscription => Crowdin.getText(localeName, 'subscriptionAskRestoreSubscription') ?? _fallbackTexts.subscriptionAskRestoreSubscription;

	@override
  String get subscriptionDuplicateSubscriptionFromSettings => Crowdin.getText(localeName, 'subscriptionDuplicateSubscriptionFromSettings') ?? _fallbackTexts.subscriptionDuplicateSubscriptionFromSettings;

	@override
  String get subscriptionRecommendedAccess => Crowdin.getText(localeName, 'subscriptionRecommendedAccess') ?? _fallbackTexts.subscriptionRecommendedAccess;

	@override
  String get subscriptionLimitedAccess => Crowdin.getText(localeName, 'subscriptionLimitedAccess') ?? _fallbackTexts.subscriptionLimitedAccess;

	@override
  String get subscriptionLifeTimeAccess => Crowdin.getText(localeName, 'subscriptionLifeTimeAccess') ?? _fallbackTexts.subscriptionLifeTimeAccess;

	@override
  String get subscriptionFlexibleAccess => Crowdin.getText(localeName, 'subscriptionFlexibleAccess') ?? _fallbackTexts.subscriptionFlexibleAccess;

	@override
  String get subscriptionMonth => Crowdin.getText(localeName, 'subscriptionMonth') ?? _fallbackTexts.subscriptionMonth;

	@override
  String get subscriptionQuarterly => Crowdin.getText(localeName, 'subscriptionQuarterly') ?? _fallbackTexts.subscriptionQuarterly;

	@override
  String get subscriptionAnnually => Crowdin.getText(localeName, 'subscriptionAnnually') ?? _fallbackTexts.subscriptionAnnually;

	@override
  String get subscriptionWeekly => Crowdin.getText(localeName, 'subscriptionWeekly') ?? _fallbackTexts.subscriptionWeekly;

	@override
  String get subscriptionDaily => Crowdin.getText(localeName, 'subscriptionDaily') ?? _fallbackTexts.subscriptionDaily;

	@override
  String get subscriptionDescriptionLabel => Crowdin.getText(localeName, 'subscriptionDescriptionLabel') ?? _fallbackTexts.subscriptionDescriptionLabel;

	@override
  String get subscriptionGenericTitle => Crowdin.getText(localeName, 'subscriptionGenericTitle') ?? _fallbackTexts.subscriptionGenericTitle;

	@override
  String get emergencyAssistanceTitle => Crowdin.getText(localeName, 'emergencyAssistanceTitle') ?? _fallbackTexts.emergencyAssistanceTitle;

	@override
  String get emergencyAssistanceNumber => Crowdin.getText(localeName, 'emergencyAssistanceNumber') ?? _fallbackTexts.emergencyAssistanceNumber;

	@override
  String get emergencyAssistanceLabel => Crowdin.getText(localeName, 'emergencyAssistanceLabel') ?? _fallbackTexts.emergencyAssistanceLabel;

	@override
  String get emergencyUsLifelineTitle => Crowdin.getText(localeName, 'emergencyUsLifelineTitle') ?? _fallbackTexts.emergencyUsLifelineTitle;

	@override
  String get emergencyUsLifelineTitleNumber => Crowdin.getText(localeName, 'emergencyUsLifelineTitleNumber') ?? _fallbackTexts.emergencyUsLifelineTitleNumber;

	@override
  String get emergencyUsLifelineTitleLabel => Crowdin.getText(localeName, 'emergencyUsLifelineTitleLabel') ?? _fallbackTexts.emergencyUsLifelineTitleLabel;

	@override
  String get emergencyCrisisChatTitle => Crowdin.getText(localeName, 'emergencyCrisisChatTitle') ?? _fallbackTexts.emergencyCrisisChatTitle;

	@override
  String get emergencyCrisisChatUrl => Crowdin.getText(localeName, 'emergencyCrisisChatUrl') ?? _fallbackTexts.emergencyCrisisChatUrl;

	@override
  String get emergencyCrisisChatLabel => Crowdin.getText(localeName, 'emergencyCrisisChatLabel') ?? _fallbackTexts.emergencyCrisisChatLabel;

	@override
  String get emergencySelfHarmLineTitle => Crowdin.getText(localeName, 'emergencySelfHarmLineTitle') ?? _fallbackTexts.emergencySelfHarmLineTitle;

	@override
  String get emergencySelfHarmLineNumber => Crowdin.getText(localeName, 'emergencySelfHarmLineNumber') ?? _fallbackTexts.emergencySelfHarmLineNumber;

	@override
  String get emergencySelfHarmLineLabel => Crowdin.getText(localeName, 'emergencySelfHarmLineLabel') ?? _fallbackTexts.emergencySelfHarmLineLabel;

	@override
  String get emergencyLGBTQLineTitle => Crowdin.getText(localeName, 'emergencyLGBTQLineTitle') ?? _fallbackTexts.emergencyLGBTQLineTitle;

	@override
  String get emergencyLGBTQLineNumber => Crowdin.getText(localeName, 'emergencyLGBTQLineNumber') ?? _fallbackTexts.emergencyLGBTQLineNumber;

	@override
  String get emergencyLGBTQLineLabel => Crowdin.getText(localeName, 'emergencyLGBTQLineLabel') ?? _fallbackTexts.emergencyLGBTQLineLabel;

	@override
  String get emergencyNationalHotlineTitle => Crowdin.getText(localeName, 'emergencyNationalHotlineTitle') ?? _fallbackTexts.emergencyNationalHotlineTitle;

	@override
  String get emergencyNationalHotlineNumber => Crowdin.getText(localeName, 'emergencyNationalHotlineNumber') ?? _fallbackTexts.emergencyNationalHotlineNumber;

	@override
  String get emergencyNationalHotlineLabel => Crowdin.getText(localeName, 'emergencyNationalHotlineLabel') ?? _fallbackTexts.emergencyNationalHotlineLabel;

	@override
  String get emergencyVeteransLineTitle => Crowdin.getText(localeName, 'emergencyVeteransLineTitle') ?? _fallbackTexts.emergencyVeteransLineTitle;

	@override
  String get emergencyVeteransLineUrl => Crowdin.getText(localeName, 'emergencyVeteransLineUrl') ?? _fallbackTexts.emergencyVeteransLineUrl;

	@override
  String get emergencyVeteransLineLabel => Crowdin.getText(localeName, 'emergencyVeteransLineLabel') ?? _fallbackTexts.emergencyVeteransLineLabel;

	@override
	String introTitle(String projectName) => Crowdin.getText(localeName, 'introTitle', {'projectName':projectName}) ?? _fallbackTexts.introTitle(projectName);

	@override
  String get introBodyTextFirst => Crowdin.getText(localeName, 'introBodyTextFirst') ?? _fallbackTexts.introBodyTextFirst;

	@override
  String get introBodyTextSecond => Crowdin.getText(localeName, 'introBodyTextSecond') ?? _fallbackTexts.introBodyTextSecond;

	@override
	String loginTitle(String projectName) => Crowdin.getText(localeName, 'loginTitle', {'projectName':projectName}) ?? _fallbackTexts.loginTitle(projectName);

	@override
  String get forgotPasswordTitle => Crowdin.getText(localeName, 'forgotPasswordTitle') ?? _fallbackTexts.forgotPasswordTitle;

	@override
  String get forgotPasswordSubTitle => Crowdin.getText(localeName, 'forgotPasswordSubTitle') ?? _fallbackTexts.forgotPasswordSubTitle;

	@override
  String get forgotPasswordBody => Crowdin.getText(localeName, 'forgotPasswordBody') ?? _fallbackTexts.forgotPasswordBody;

	@override
  String get minutes => Crowdin.getText(localeName, 'minutes') ?? _fallbackTexts.minutes;

	@override
	String stepCounter(String currentStep, String totalSteps) => Crowdin.getText(localeName, 'stepCounter', {'currentStep':currentStep, 'totalSteps':totalSteps}) ?? _fallbackTexts.stepCounter(currentStep, totalSteps);

	@override
  String get yes => Crowdin.getText(localeName, 'yes') ?? _fallbackTexts.yes;

	@override
  String get no => Crowdin.getText(localeName, 'no') ?? _fallbackTexts.no;

	@override
  String get legalStatement => Crowdin.getText(localeName, 'legalStatement') ?? _fallbackTexts.legalStatement;

	@override
  String get legalStatementTextOne => Crowdin.getText(localeName, 'legalStatementTextOne') ?? _fallbackTexts.legalStatementTextOne;

	@override
  String get legalStatementTextTwo => Crowdin.getText(localeName, 'legalStatementTextTwo') ?? _fallbackTexts.legalStatementTextTwo;

	@override
  String get readLegalStatement => Crowdin.getText(localeName, 'readLegalStatement') ?? _fallbackTexts.readLegalStatement;

	@override
  String get legalStatementCheckboxTitle => Crowdin.getText(localeName, 'legalStatementCheckboxTitle') ?? _fallbackTexts.legalStatementCheckboxTitle;

	@override
  String get legalStatementCheckboxItemOne => Crowdin.getText(localeName, 'legalStatementCheckboxItemOne') ?? _fallbackTexts.legalStatementCheckboxItemOne;

	@override
  String get confirm => Crowdin.getText(localeName, 'confirm') ?? _fallbackTexts.confirm;

	@override
  String get openLinkErrorMessage => Crowdin.getText(localeName, 'openLinkErrorMessage') ?? _fallbackTexts.openLinkErrorMessage;

	@override
  String get signUpWelcomeTitle => Crowdin.getText(localeName, 'signUpWelcomeTitle') ?? _fallbackTexts.signUpWelcomeTitle;

	@override
  String get signUpWelcomeBody => Crowdin.getText(localeName, 'signUpWelcomeBody') ?? _fallbackTexts.signUpWelcomeBody;

	@override
  String get createAccount => Crowdin.getText(localeName, 'createAccount') ?? _fallbackTexts.createAccount;

	@override
  String get whatIsYourName => Crowdin.getText(localeName, 'whatIsYourName') ?? _fallbackTexts.whatIsYourName;

	@override
  String get niceToMeetYou => Crowdin.getText(localeName, 'niceToMeetYou') ?? _fallbackTexts.niceToMeetYou;

	@override
  String get enterPasswordSubTitle => Crowdin.getText(localeName, 'enterPasswordSubTitle') ?? _fallbackTexts.enterPasswordSubTitle;

	@override
  String get confirmPassword => Crowdin.getText(localeName, 'confirmPassword') ?? _fallbackTexts.confirmPassword;

	@override
  String get passwordStrengthToShort => Crowdin.getText(localeName, 'passwordStrengthToShort') ?? _fallbackTexts.passwordStrengthToShort;

	@override
  String get passwordStrengthToLong => Crowdin.getText(localeName, 'passwordStrengthToLong') ?? _fallbackTexts.passwordStrengthToLong;

	@override
  String get passwordStrengthNotSecure => Crowdin.getText(localeName, 'passwordStrengthNotSecure') ?? _fallbackTexts.passwordStrengthNotSecure;

	@override
  String get passwordStrengthMiddle => Crowdin.getText(localeName, 'passwordStrengthMiddle') ?? _fallbackTexts.passwordStrengthMiddle;

	@override
  String get passwordStrengthNice => Crowdin.getText(localeName, 'passwordStrengthNice') ?? _fallbackTexts.passwordStrengthNice;

	@override
  String get passwordValidationRule1 => Crowdin.getText(localeName, 'passwordValidationRule1') ?? _fallbackTexts.passwordValidationRule1;

	@override
  String get passwordValidationRule2 => Crowdin.getText(localeName, 'passwordValidationRule2') ?? _fallbackTexts.passwordValidationRule2;

	@override
  String get passwordValidationRule3 => Crowdin.getText(localeName, 'passwordValidationRule3') ?? _fallbackTexts.passwordValidationRule3;

	@override
  String get emailTitle => Crowdin.getText(localeName, 'emailTitle') ?? _fallbackTexts.emailTitle;

	@override
  String get emailBody => Crowdin.getText(localeName, 'emailBody') ?? _fallbackTexts.emailBody;

	@override
  String get termsAndConditions => Crowdin.getText(localeName, 'termsAndConditions') ?? _fallbackTexts.termsAndConditions;

	@override
  String get privacyPolicy => Crowdin.getText(localeName, 'privacyPolicy') ?? _fallbackTexts.privacyPolicy;

	@override
  String get termsAndConditionsTitle => Crowdin.getText(localeName, 'termsAndConditionsTitle') ?? _fallbackTexts.termsAndConditionsTitle;

	@override
  String get privacyPolicyTitle => Crowdin.getText(localeName, 'privacyPolicyTitle') ?? _fallbackTexts.privacyPolicyTitle;

	@override
  String get iAcceptThe => Crowdin.getText(localeName, 'iAcceptThe') ?? _fallbackTexts.iAcceptThe;

	@override
  String get pleaseAcceptTOC => Crowdin.getText(localeName, 'pleaseAcceptTOC') ?? _fallbackTexts.pleaseAcceptTOC;

	@override
  String get pleaseAcceptPrivacyPolicy => Crowdin.getText(localeName, 'pleaseAcceptPrivacyPolicy') ?? _fallbackTexts.pleaseAcceptPrivacyPolicy;

	@override
  String get register => Crowdin.getText(localeName, 'register') ?? _fallbackTexts.register;

	@override
  String get receiveEmailCheckboxLabel => Crowdin.getText(localeName, 'receiveEmailCheckboxLabel') ?? _fallbackTexts.receiveEmailCheckboxLabel;

	@override
  String get waitingForConfirmationTitle => Crowdin.getText(localeName, 'waitingForConfirmationTitle') ?? _fallbackTexts.waitingForConfirmationTitle;

	@override
  String get resendConfirmationMessage => Crowdin.getText(localeName, 'resendConfirmationMessage') ?? _fallbackTexts.resendConfirmationMessage;

	@override
  String get waitingForConfirmationSubtitle => Crowdin.getText(localeName, 'waitingForConfirmationSubtitle') ?? _fallbackTexts.waitingForConfirmationSubtitle;

	@override
  String get waitingForConfirmationBody => Crowdin.getText(localeName, 'waitingForConfirmationBody') ?? _fallbackTexts.waitingForConfirmationBody;

	@override
  String get waitingForConfirmationBody3 => Crowdin.getText(localeName, 'waitingForConfirmationBody3') ?? _fallbackTexts.waitingForConfirmationBody3;

	@override
  String get waitingForConfirmationBody4 => Crowdin.getText(localeName, 'waitingForConfirmationBody4') ?? _fallbackTexts.waitingForConfirmationBody4;

	@override
  String get resend => Crowdin.getText(localeName, 'resend') ?? _fallbackTexts.resend;

	@override
  String get incorrectEmail => Crowdin.getText(localeName, 'incorrectEmail') ?? _fallbackTexts.incorrectEmail;

	@override
  String get changeAddress => Crowdin.getText(localeName, 'changeAddress') ?? _fallbackTexts.changeAddress;

	@override
  String get changeEmail => Crowdin.getText(localeName, 'changeEmail') ?? _fallbackTexts.changeEmail;

	@override
  String get changeEmailAddressTitle => Crowdin.getText(localeName, 'changeEmailAddressTitle') ?? _fallbackTexts.changeEmailAddressTitle;

	@override
  String get emailConfirmedBottomSheetTitle => Crowdin.getText(localeName, 'emailConfirmedBottomSheetTitle') ?? _fallbackTexts.emailConfirmedBottomSheetTitle;

	@override
  String get emailConfirmedBottomSheetContent => Crowdin.getText(localeName, 'emailConfirmedBottomSheetContent') ?? _fallbackTexts.emailConfirmedBottomSheetContent;

	@override
  String get logMood => Crowdin.getText(localeName, 'logMood') ?? _fallbackTexts.logMood;

	@override
  String get yourNote => Crowdin.getText(localeName, 'yourNote') ?? _fallbackTexts.yourNote;

	@override
  String get educationTitle => Crowdin.getText(localeName, 'educationTitle') ?? _fallbackTexts.educationTitle;

	@override
  String get locked => Crowdin.getText(localeName, 'locked') ?? _fallbackTexts.locked;

	@override
  String get lesson => Crowdin.getText(localeName, 'lesson') ?? _fallbackTexts.lesson;

	@override
  String get lessonCompleted => Crowdin.getText(localeName, 'lessonCompleted') ?? _fallbackTexts.lessonCompleted;

	@override
  String get groupSessionsUnlocked => Crowdin.getText(localeName, 'groupSessionsUnlocked') ?? _fallbackTexts.groupSessionsUnlocked;

	@override
  String get waitingForGroupCompletedLesson => Crowdin.getText(localeName, 'waitingForGroupCompletedLesson') ?? _fallbackTexts.waitingForGroupCompletedLesson;

	@override
  String get notJoinedToGroupCompletedLesson => Crowdin.getText(localeName, 'notJoinedToGroupCompletedLesson') ?? _fallbackTexts.notJoinedToGroupCompletedLesson;

	@override
  String get groupSessionUnlockOnTrialPeriod => Crowdin.getText(localeName, 'groupSessionUnlockOnTrialPeriod') ?? _fallbackTexts.groupSessionUnlockOnTrialPeriod;

	@override
  String get unlockFeatureDescription => Crowdin.getText(localeName, 'unlockFeatureDescription') ?? _fallbackTexts.unlockFeatureDescription;

	@override
  String get lessonCompleteDescription => Crowdin.getText(localeName, 'lessonCompleteDescription') ?? _fallbackTexts.lessonCompleteDescription;

	@override
  String get assignmentCompleted => Crowdin.getText(localeName, 'assignmentCompleted') ?? _fallbackTexts.assignmentCompleted;

	@override
  String get assignmentCompleteDescription => Crowdin.getText(localeName, 'assignmentCompleteDescription') ?? _fallbackTexts.assignmentCompleteDescription;

	@override
  String get consultYourTherapistBody1 => Crowdin.getText(localeName, 'consultYourTherapistBody1') ?? _fallbackTexts.consultYourTherapistBody1;

	@override
  String get consultYourTherapistBody2 => Crowdin.getText(localeName, 'consultYourTherapistBody2') ?? _fallbackTexts.consultYourTherapistBody2;

	@override
  String get consultYourTherapistBody3 => Crowdin.getText(localeName, 'consultYourTherapistBody3') ?? _fallbackTexts.consultYourTherapistBody3;

	@override
  String get consultYourTherapistBody4 => Crowdin.getText(localeName, 'consultYourTherapistBody4') ?? _fallbackTexts.consultYourTherapistBody4;

	@override
  String get completeLesson => Crowdin.getText(localeName, 'completeLesson') ?? _fallbackTexts.completeLesson;

	@override
  String get didYouCheckWithSpecialist => Crowdin.getText(localeName, 'didYouCheckWithSpecialist') ?? _fallbackTexts.didYouCheckWithSpecialist;

	@override
  String get iConsultedTherapist => Crowdin.getText(localeName, 'iConsultedTherapist') ?? _fallbackTexts.iConsultedTherapist;

	@override
  String get treatedByTherapistLessonComplete => Crowdin.getText(localeName, 'treatedByTherapistLessonComplete') ?? _fallbackTexts.treatedByTherapistLessonComplete;

	@override
  String get trialSubscriptionLessonComplete => Crowdin.getText(localeName, 'trialSubscriptionLessonComplete') ?? _fallbackTexts.trialSubscriptionLessonComplete;

	@override
  String get groupSessionsJoinLaterLessonComplete => Crowdin.getText(localeName, 'groupSessionsJoinLaterLessonComplete') ?? _fallbackTexts.groupSessionsJoinLaterLessonComplete;

	@override
  String get needSubscrionScreenTitle => Crowdin.getText(localeName, 'needSubscrionScreenTitle') ?? _fallbackTexts.needSubscrionScreenTitle;

	@override
  String get needSubscrionScreenBody1 => Crowdin.getText(localeName, 'needSubscrionScreenBody1') ?? _fallbackTexts.needSubscrionScreenBody1;

	@override
  String get needSubscrionScreenBody2 => Crowdin.getText(localeName, 'needSubscrionScreenBody2') ?? _fallbackTexts.needSubscrionScreenBody2;

	@override
  String get needSubscrionScreenBody3 => Crowdin.getText(localeName, 'needSubscrionScreenBody3') ?? _fallbackTexts.needSubscrionScreenBody3;

	@override
  String get needSubscrionScreenBody4 => Crowdin.getText(localeName, 'needSubscrionScreenBody4') ?? _fallbackTexts.needSubscrionScreenBody4;

	@override
  String get consultYourTherapist => Crowdin.getText(localeName, 'consultYourTherapist') ?? _fallbackTexts.consultYourTherapist;

	@override
  String get groupSession => Crowdin.getText(localeName, 'groupSession') ?? _fallbackTexts.groupSession;

	@override
  String get getStarted => Crowdin.getText(localeName, 'getStarted') ?? _fallbackTexts.getStarted;

	@override
  String get haveAnAccount => Crowdin.getText(localeName, 'haveAnAccount') ?? _fallbackTexts.haveAnAccount;

	@override
  String get logIn => Crowdin.getText(localeName, 'logIn') ?? _fallbackTexts.logIn;

	@override
  String get bodyAndMind => Crowdin.getText(localeName, 'bodyAndMind') ?? _fallbackTexts.bodyAndMind;

	@override
  String get finish => Crowdin.getText(localeName, 'finish') ?? _fallbackTexts.finish;

	@override
  String get introPage => Crowdin.getText(localeName, 'introPage') ?? _fallbackTexts.introPage;

	@override
  String get moreInfo => Crowdin.getText(localeName, 'moreInfo') ?? _fallbackTexts.moreInfo;

	@override
  String get yourBirthday => Crowdin.getText(localeName, 'yourBirthday') ?? _fallbackTexts.yourBirthday;

	@override
  String get continueBtn => Crowdin.getText(localeName, 'continueBtn') ?? _fallbackTexts.continueBtn;

	@override
  String get downloadInstructions => Crowdin.getText(localeName, 'downloadInstructions') ?? _fallbackTexts.downloadInstructions;

	@override
  String get forgotPassword => Crowdin.getText(localeName, 'forgotPassword') ?? _fallbackTexts.forgotPassword;

	@override
  String get yourPassword => Crowdin.getText(localeName, 'yourPassword') ?? _fallbackTexts.yourPassword;

	@override
  String get login => Crowdin.getText(localeName, 'login') ?? _fallbackTexts.login;

	@override
  String get yourEmail => Crowdin.getText(localeName, 'yourEmail') ?? _fallbackTexts.yourEmail;

	@override
  String get yourName => Crowdin.getText(localeName, 'yourName') ?? _fallbackTexts.yourName;

	@override
  String get connectionLost => Crowdin.getText(localeName, 'connectionLost') ?? _fallbackTexts.connectionLost;

	@override
  String get pleaseEnterYourEmailAddress => Crowdin.getText(localeName, 'pleaseEnterYourEmailAddress') ?? _fallbackTexts.pleaseEnterYourEmailAddress;

	@override
  String get pleaseEnterYourName => Crowdin.getText(localeName, 'pleaseEnterYourName') ?? _fallbackTexts.pleaseEnterYourName;

	@override
  String get nameRegexValidationError => Crowdin.getText(localeName, 'nameRegexValidationError') ?? _fallbackTexts.nameRegexValidationError;

	@override
  String get pleaseEnterValidEmailAddress => Crowdin.getText(localeName, 'pleaseEnterValidEmailAddress') ?? _fallbackTexts.pleaseEnterValidEmailAddress;

	@override
  String get pleaseEnterYourPassword => Crowdin.getText(localeName, 'pleaseEnterYourPassword') ?? _fallbackTexts.pleaseEnterYourPassword;

	@override
  String get enterYourHeight => Crowdin.getText(localeName, 'enterYourHeight') ?? _fallbackTexts.enterYourHeight;

	@override
	String forgotEmailSuccessMessage(String email) => Crowdin.getText(localeName, 'forgotEmailSuccessMessage', {'email':email}) ?? _fallbackTexts.forgotEmailSuccessMessage(email);

	@override
  String get close => Crowdin.getText(localeName, 'close') ?? _fallbackTexts.close;

	@override
  String get youAndFoodItemThree => Crowdin.getText(localeName, 'youAndFoodItemThree') ?? _fallbackTexts.youAndFoodItemThree;

	@override
  String get start => Crowdin.getText(localeName, 'start') ?? _fallbackTexts.start;

	@override
  String get iDoNotEatOrDrink => Crowdin.getText(localeName, 'iDoNotEatOrDrink') ?? _fallbackTexts.iDoNotEatOrDrink;

	@override
  String get iAmAllergicTo => Crowdin.getText(localeName, 'iAmAllergicTo') ?? _fallbackTexts.iAmAllergicTo;

	@override
  String get iDoNotLike => Crowdin.getText(localeName, 'iDoNotLike') ?? _fallbackTexts.iDoNotLike;

	@override
  String get typeOne => Crowdin.getText(localeName, 'typeOne') ?? _fallbackTexts.typeOne;

	@override
  String get typeTwo => Crowdin.getText(localeName, 'typeTwo') ?? _fallbackTexts.typeTwo;

	@override
  String get breakfast => Crowdin.getText(localeName, 'breakfast') ?? _fallbackTexts.breakfast;

	@override
  String get lunch => Crowdin.getText(localeName, 'lunch') ?? _fallbackTexts.lunch;

	@override
  String get dinner => Crowdin.getText(localeName, 'dinner') ?? _fallbackTexts.dinner;

	@override
  String get lateDinner => Crowdin.getText(localeName, 'lateDinner') ?? _fallbackTexts.lateDinner;

	@override
  String get nutritionSummary => Crowdin.getText(localeName, 'nutritionSummary') ?? _fallbackTexts.nutritionSummary;

	@override
  String get calorieDensity => Crowdin.getText(localeName, 'calorieDensity') ?? _fallbackTexts.calorieDensity;

	@override
  String get proteinDegree => Crowdin.getText(localeName, 'proteinDegree') ?? _fallbackTexts.proteinDegree;

	@override
  String get whatIsCalorieDensity => Crowdin.getText(localeName, 'whatIsCalorieDensity') ?? _fallbackTexts.whatIsCalorieDensity;

	@override
  String get whatIsProtein => Crowdin.getText(localeName, 'whatIsProtein') ?? _fallbackTexts.whatIsProtein;

	@override
  String get calorieDensityExplanation => Crowdin.getText(localeName, 'calorieDensityExplanation') ?? _fallbackTexts.calorieDensityExplanation;

	@override
  String get forMoreInformationSeeLesson => Crowdin.getText(localeName, 'forMoreInformationSeeLesson') ?? _fallbackTexts.forMoreInformationSeeLesson;

	@override
  String get proteinDegreeExplanation => Crowdin.getText(localeName, 'proteinDegreeExplanation') ?? _fallbackTexts.proteinDegreeExplanation;

	@override
  String get fiberExplanation => Crowdin.getText(localeName, 'fiberExplanation') ?? _fallbackTexts.fiberExplanation;

	@override
  String get importanceOfProtein => Crowdin.getText(localeName, 'importanceOfProtein') ?? _fallbackTexts.importanceOfProtein;

	@override
  String get carbohydratesPart2 => Crowdin.getText(localeName, 'carbohydratesPart2') ?? _fallbackTexts.carbohydratesPart2;

	@override
	String fiberDailyGoal(String fiberAmount, String dailyGoal) => Crowdin.getText(localeName, 'fiberDailyGoal', {'fiberAmount':fiberAmount, 'dailyGoal':dailyGoal}) ?? _fallbackTexts.fiberDailyGoal(fiberAmount, dailyGoal);

	@override
	String fiberRatioToCarbo(String totalCarbohydrates, String ratio) => Crowdin.getText(localeName, 'fiberRatioToCarbo', {'totalCarbohydrates':totalCarbohydrates, 'ratio':ratio}) ?? _fallbackTexts.fiberRatioToCarbo(totalCarbohydrates, ratio);

	@override
  String get calories => Crowdin.getText(localeName, 'calories') ?? _fallbackTexts.calories;

	@override
  String get amount => Crowdin.getText(localeName, 'amount') ?? _fallbackTexts.amount;

	@override
  String get addAsFavourite => Crowdin.getText(localeName, 'addAsFavourite') ?? _fallbackTexts.addAsFavourite;

	@override
  String get removeFromFavorites => Crowdin.getText(localeName, 'removeFromFavorites') ?? _fallbackTexts.removeFromFavorites;

	@override
  String get addedToFavorites => Crowdin.getText(localeName, 'addedToFavorites') ?? _fallbackTexts.addedToFavorites;

	@override
  String get removedFromFavorites => Crowdin.getText(localeName, 'removedFromFavorites') ?? _fallbackTexts.removedFromFavorites;

	@override
  String get myFavorites => Crowdin.getText(localeName, 'myFavorites') ?? _fallbackTexts.myFavorites;

	@override
  String get my => Crowdin.getText(localeName, 'my') ?? _fallbackTexts.my;

	@override
  String get myDishes => Crowdin.getText(localeName, 'myDishes') ?? _fallbackTexts.myDishes;

	@override
  String get dishes => Crowdin.getText(localeName, 'dishes') ?? _fallbackTexts.dishes;

	@override
  String get scan => Crowdin.getText(localeName, 'scan') ?? _fallbackTexts.scan;

	@override
  String get showMy => Crowdin.getText(localeName, 'showMy') ?? _fallbackTexts.showMy;

	@override
  String get qrCodeSubtext_1 => Crowdin.getText(localeName, 'qrCodeSubtext_1') ?? _fallbackTexts.qrCodeSubtext_1;

	@override
  String get qrCodeSubtext_2 => Crowdin.getText(localeName, 'qrCodeSubtext_2') ?? _fallbackTexts.qrCodeSubtext_2;

	@override
  String get qrCodeSubtext_3 => Crowdin.getText(localeName, 'qrCodeSubtext_3') ?? _fallbackTexts.qrCodeSubtext_3;

	@override
  String get scanOtherProduct => Crowdin.getText(localeName, 'scanOtherProduct') ?? _fallbackTexts.scanOtherProduct;

	@override
  String get sorryNotFound => Crowdin.getText(localeName, 'sorryNotFound') ?? _fallbackTexts.sorryNotFound;

	@override
  String get scanYourProduct => Crowdin.getText(localeName, 'scanYourProduct') ?? _fallbackTexts.scanYourProduct;

	@override
  String get barCodeResultCalories => Crowdin.getText(localeName, 'barCodeResultCalories') ?? _fallbackTexts.barCodeResultCalories;

	@override
  String get barCodeResultPerServing => Crowdin.getText(localeName, 'barCodeResultPerServing') ?? _fallbackTexts.barCodeResultPerServing;

	@override
  String get openSettings => Crowdin.getText(localeName, 'openSettings') ?? _fallbackTexts.openSettings;

	@override
  String get allowCameraMessage => Crowdin.getText(localeName, 'allowCameraMessage') ?? _fallbackTexts.allowCameraMessage;

	@override
  String get item => Crowdin.getText(localeName, 'item') ?? _fallbackTexts.item;

	@override
  String get items => Crowdin.getText(localeName, 'items') ?? _fallbackTexts.items;

	@override
  String get selected => Crowdin.getText(localeName, 'selected') ?? _fallbackTexts.selected;

	@override
  String get deselectAll => Crowdin.getText(localeName, 'deselectAll') ?? _fallbackTexts.deselectAll;

	@override
  String get add => Crowdin.getText(localeName, 'add') ?? _fallbackTexts.add;

	@override
  String get addFoodItem => Crowdin.getText(localeName, 'addFoodItem') ?? _fallbackTexts.addFoodItem;

	@override
  String get saveToMyDishes => Crowdin.getText(localeName, 'saveToMyDishes') ?? _fallbackTexts.saveToMyDishes;

	@override
  String get addToDishes => Crowdin.getText(localeName, 'addToDishes') ?? _fallbackTexts.addToDishes;

	@override
  String get viewRecipe => Crowdin.getText(localeName, 'viewRecipe') ?? _fallbackTexts.viewRecipe;

	@override
  String get ingredientsBasedOn => Crowdin.getText(localeName, 'ingredientsBasedOn') ?? _fallbackTexts.ingredientsBasedOn;

	@override
	String portionMeal(String numberOfPortion) => Crowdin.getText(localeName, 'portionMeal', {'numberOfPortion':numberOfPortion}) ?? _fallbackTexts.portionMeal(numberOfPortion);

	@override
  String get total => Crowdin.getText(localeName, 'total') ?? _fallbackTexts.total;

	@override
  String get searchHint => Crowdin.getText(localeName, 'searchHint') ?? _fallbackTexts.searchHint;

	@override
  String get searchFilterAll => Crowdin.getText(localeName, 'searchFilterAll') ?? _fallbackTexts.searchFilterAll;

	@override
  String get searchFilterProducts => Crowdin.getText(localeName, 'searchFilterProducts') ?? _fallbackTexts.searchFilterProducts;

	@override
  String get searchFilterRecipes => Crowdin.getText(localeName, 'searchFilterRecipes') ?? _fallbackTexts.searchFilterRecipes;

	@override
  String get searchFilterMy => Crowdin.getText(localeName, 'searchFilterMy') ?? _fallbackTexts.searchFilterMy;

	@override
  String get inbetweens => Crowdin.getText(localeName, 'inbetweens') ?? _fallbackTexts.inbetweens;

	@override
  String get inbetweensShort => Crowdin.getText(localeName, 'inbetweensShort') ?? _fallbackTexts.inbetweensShort;

	@override
  String get drinks => Crowdin.getText(localeName, 'drinks') ?? _fallbackTexts.drinks;

	@override
  String get favorites => Crowdin.getText(localeName, 'favorites') ?? _fallbackTexts.favorites;

	@override
  String get allMy => Crowdin.getText(localeName, 'allMy') ?? _fallbackTexts.allMy;

	@override
  String get showNutritionValue => Crowdin.getText(localeName, 'showNutritionValue') ?? _fallbackTexts.showNutritionValue;

	@override
	String youHaveNo(String text) => Crowdin.getText(localeName, 'youHaveNo', {'text':text}) ?? _fallbackTexts.youHaveNo(text);

	@override
  String get favoritesExplain => Crowdin.getText(localeName, 'favoritesExplain') ?? _fallbackTexts.favoritesExplain;

	@override
  String get favoritesList => Crowdin.getText(localeName, 'favoritesList') ?? _fallbackTexts.favoritesList;

	@override
  String get dishesExplain => Crowdin.getText(localeName, 'dishesExplain') ?? _fallbackTexts.dishesExplain;

	@override
  String get dishesList => Crowdin.getText(localeName, 'dishesList') ?? _fallbackTexts.dishesList;

	@override
  String get groupPreferences => Crowdin.getText(localeName, 'groupPreferences') ?? _fallbackTexts.groupPreferences;

	@override
  String get groupRules => Crowdin.getText(localeName, 'groupRules') ?? _fallbackTexts.groupRules;

	@override
  String get wouldYouLikeToJoinSupportGroup => Crowdin.getText(localeName, 'wouldYouLikeToJoinSupportGroup') ?? _fallbackTexts.wouldYouLikeToJoinSupportGroup;

	@override
  String get genderPreferencesQuestion => Crowdin.getText(localeName, 'genderPreferencesQuestion') ?? _fallbackTexts.genderPreferencesQuestion;

	@override
  String get nicknamePreferencesQuestion => Crowdin.getText(localeName, 'nicknamePreferencesQuestion') ?? _fallbackTexts.nicknamePreferencesQuestion;

	@override
  String get nicknamePlaceholder => Crowdin.getText(localeName, 'nicknamePlaceholder') ?? _fallbackTexts.nicknamePlaceholder;

	@override
  String get weAreLookingForAMatch => Crowdin.getText(localeName, 'weAreLookingForAMatch') ?? _fallbackTexts.weAreLookingForAMatch;

	@override
  String get weAreLookingForAGroupSince => Crowdin.getText(localeName, 'weAreLookingForAGroupSince') ?? _fallbackTexts.weAreLookingForAGroupSince;

	@override
  String get genderPreference => Crowdin.getText(localeName, 'genderPreference') ?? _fallbackTexts.genderPreference;

	@override
  String get timezone => Crowdin.getText(localeName, 'timezone') ?? _fallbackTexts.timezone;

	@override
  String get yourNickname => Crowdin.getText(localeName, 'yourNickname') ?? _fallbackTexts.yourNickname;

	@override
  String get partOfGroup => Crowdin.getText(localeName, 'partOfGroup') ?? _fallbackTexts.partOfGroup;

	@override
  String get iNoLongerWantToJoin => Crowdin.getText(localeName, 'iNoLongerWantToJoin') ?? _fallbackTexts.iNoLongerWantToJoin;

	@override
  String get update => Crowdin.getText(localeName, 'update') ?? _fallbackTexts.update;

	@override
	String weHaveNotYetFound(String dateTime) => Crowdin.getText(localeName, 'weHaveNotYetFound', {'dateTime':dateTime}) ?? _fallbackTexts.weHaveNotYetFound(dateTime);

	@override
  String get goodNews => Crowdin.getText(localeName, 'goodNews') ?? _fallbackTexts.goodNews;

	@override
  String get youHaveBeenAddedToGroup => Crowdin.getText(localeName, 'youHaveBeenAddedToGroup') ?? _fallbackTexts.youHaveBeenAddedToGroup;

	@override
  String get readTheGroupRules => Crowdin.getText(localeName, 'readTheGroupRules') ?? _fallbackTexts.readTheGroupRules;

	@override
  String get leaveGroup => Crowdin.getText(localeName, 'leaveGroup') ?? _fallbackTexts.leaveGroup;

	@override
  String get notYet => Crowdin.getText(localeName, 'notYet') ?? _fallbackTexts.notYet;

	@override
  String get whatIsYourTimezone => Crowdin.getText(localeName, 'whatIsYourTimezone') ?? _fallbackTexts.whatIsYourTimezone;

	@override
  String get searchTimezone => Crowdin.getText(localeName, 'searchTimezone') ?? _fallbackTexts.searchTimezone;

	@override
  String get groupRulesOneTitle => Crowdin.getText(localeName, 'groupRulesOneTitle') ?? _fallbackTexts.groupRulesOneTitle;

	@override
  String get groupRulesAttention => Crowdin.getText(localeName, 'groupRulesAttention') ?? _fallbackTexts.groupRulesAttention;

	@override
  String get groupRulesOneParagraphOne => Crowdin.getText(localeName, 'groupRulesOneParagraphOne') ?? _fallbackTexts.groupRulesOneParagraphOne;

	@override
  String get groupRulesOneParagraphTwo => Crowdin.getText(localeName, 'groupRulesOneParagraphTwo') ?? _fallbackTexts.groupRulesOneParagraphTwo;

	@override
  String get continueToTheRules => Crowdin.getText(localeName, 'continueToTheRules') ?? _fallbackTexts.continueToTheRules;

	@override
  String get yesIAgree => Crowdin.getText(localeName, 'yesIAgree') ?? _fallbackTexts.yesIAgree;

	@override
  String get supportGroupPreferences => Crowdin.getText(localeName, 'supportGroupPreferences') ?? _fallbackTexts.supportGroupPreferences;

	@override
  String get groupRulesTwoParagraphOne => Crowdin.getText(localeName, 'groupRulesTwoParagraphOne') ?? _fallbackTexts.groupRulesTwoParagraphOne;

	@override
  String get groupRulesTwoParagraphTwo => Crowdin.getText(localeName, 'groupRulesTwoParagraphTwo') ?? _fallbackTexts.groupRulesTwoParagraphTwo;

	@override
  String get groupRulesTwoParagraphThree => Crowdin.getText(localeName, 'groupRulesTwoParagraphThree') ?? _fallbackTexts.groupRulesTwoParagraphThree;

	@override
  String get groupRulesThreeParagraphOne => Crowdin.getText(localeName, 'groupRulesThreeParagraphOne') ?? _fallbackTexts.groupRulesThreeParagraphOne;

	@override
  String get groupRulesThreeParagraphTwo => Crowdin.getText(localeName, 'groupRulesThreeParagraphTwo') ?? _fallbackTexts.groupRulesThreeParagraphTwo;

	@override
  String get groupRulesThreeParagraphThree => Crowdin.getText(localeName, 'groupRulesThreeParagraphThree') ?? _fallbackTexts.groupRulesThreeParagraphThree;

	@override
  String get groupRulesFourParagraphOnePartOne => Crowdin.getText(localeName, 'groupRulesFourParagraphOnePartOne') ?? _fallbackTexts.groupRulesFourParagraphOnePartOne;

	@override
  String get groupRulesFourParagraphOnePartTwo => Crowdin.getText(localeName, 'groupRulesFourParagraphOnePartTwo') ?? _fallbackTexts.groupRulesFourParagraphOnePartTwo;

	@override
  String get groupRulesFourParagraphOnePartThree => Crowdin.getText(localeName, 'groupRulesFourParagraphOnePartThree') ?? _fallbackTexts.groupRulesFourParagraphOnePartThree;

	@override
  String get groupRulesFourParagraphOneItalicOne => Crowdin.getText(localeName, 'groupRulesFourParagraphOneItalicOne') ?? _fallbackTexts.groupRulesFourParagraphOneItalicOne;

	@override
  String get groupRulesFourParagraphOneItalicTwo => Crowdin.getText(localeName, 'groupRulesFourParagraphOneItalicTwo') ?? _fallbackTexts.groupRulesFourParagraphOneItalicTwo;

	@override
  String get groupRulesFourParagraphOneItalicThree => Crowdin.getText(localeName, 'groupRulesFourParagraphOneItalicThree') ?? _fallbackTexts.groupRulesFourParagraphOneItalicThree;

	@override
  String get groupRulesFourParagraphTwo => Crowdin.getText(localeName, 'groupRulesFourParagraphTwo') ?? _fallbackTexts.groupRulesFourParagraphTwo;

	@override
  String get groupRulesFiveParagraphOne => Crowdin.getText(localeName, 'groupRulesFiveParagraphOne') ?? _fallbackTexts.groupRulesFiveParagraphOne;

	@override
  String get groupRulesFiveParagraphTwo => Crowdin.getText(localeName, 'groupRulesFiveParagraphTwo') ?? _fallbackTexts.groupRulesFiveParagraphTwo;

	@override
  String get groupRulesSixParagraphOne => Crowdin.getText(localeName, 'groupRulesSixParagraphOne') ?? _fallbackTexts.groupRulesSixParagraphOne;

	@override
  String get groupRulesSixParagraphTwo => Crowdin.getText(localeName, 'groupRulesSixParagraphTwo') ?? _fallbackTexts.groupRulesSixParagraphTwo;

	@override
  String get groupRulesSixParagraphThree => Crowdin.getText(localeName, 'groupRulesSixParagraphThree') ?? _fallbackTexts.groupRulesSixParagraphThree;

	@override
  String get groupRulesSixParagraphFour => Crowdin.getText(localeName, 'groupRulesSixParagraphFour') ?? _fallbackTexts.groupRulesSixParagraphFour;

	@override
  String get noPreference => Crowdin.getText(localeName, 'noPreference') ?? _fallbackTexts.noPreference;

	@override
  String get femaleOnly => Crowdin.getText(localeName, 'femaleOnly') ?? _fallbackTexts.femaleOnly;

	@override
  String get maleOnly => Crowdin.getText(localeName, 'maleOnly') ?? _fallbackTexts.maleOnly;

	@override
  String get mixed => Crowdin.getText(localeName, 'mixed') ?? _fallbackTexts.mixed;

	@override
  String get female => Crowdin.getText(localeName, 'female') ?? _fallbackTexts.female;

	@override
  String get male => Crowdin.getText(localeName, 'male') ?? _fallbackTexts.male;

	@override
  String get woman => Crowdin.getText(localeName, 'woman') ?? _fallbackTexts.woman;

	@override
  String get man => Crowdin.getText(localeName, 'man') ?? _fallbackTexts.man;

	@override
  String get other => Crowdin.getText(localeName, 'other') ?? _fallbackTexts.other;

	@override
  String get at => Crowdin.getText(localeName, 'at') ?? _fallbackTexts.at;

	@override
  String get joinAGroup => Crowdin.getText(localeName, 'joinAGroup') ?? _fallbackTexts.joinAGroup;

	@override
  String get unavailableGroupPrefsLabel => Crowdin.getText(localeName, 'unavailableGroupPrefsLabel') ?? _fallbackTexts.unavailableGroupPrefsLabel;

	@override
  String get findingMatchingGroup => Crowdin.getText(localeName, 'findingMatchingGroup') ?? _fallbackTexts.findingMatchingGroup;

	@override
  String get moreInformationInPreferences => Crowdin.getText(localeName, 'moreInformationInPreferences') ?? _fallbackTexts.moreInformationInPreferences;

	@override
  String get bookYourSeat => Crowdin.getText(localeName, 'bookYourSeat') ?? _fallbackTexts.bookYourSeat;

	@override
  String get comingUpThisWeek => Crowdin.getText(localeName, 'comingUpThisWeek') ?? _fallbackTexts.comingUpThisWeek;

	@override
  String get happeningNow => Crowdin.getText(localeName, 'happeningNow') ?? _fallbackTexts.happeningNow;

	@override
  String get joinSession => Crowdin.getText(localeName, 'joinSession') ?? _fallbackTexts.joinSession;

	@override
	String bookedFromTo(String day, String startTime, String endTime) => Crowdin.getText(localeName, 'bookedFromTo', {'day':day, 'startTime':startTime, 'endTime':endTime}) ?? _fallbackTexts.bookedFromTo(day, startTime, endTime);

	@override
	String dayFromTo(String day, String startTime, String endTime) => Crowdin.getText(localeName, 'dayFromTo', {'day':day, 'startTime':startTime, 'endTime':endTime}) ?? _fallbackTexts.dayFromTo(day, startTime, endTime);

	@override
  String get prepareForSession => Crowdin.getText(localeName, 'prepareForSession') ?? _fallbackTexts.prepareForSession;

	@override
	String prepareTakes(String times) => Crowdin.getText(localeName, 'prepareTakes', {'times':times}) ?? _fallbackTexts.prepareTakes(times);

	@override
  String get timeslotCancelled => Crowdin.getText(localeName, 'timeslotCancelled') ?? _fallbackTexts.timeslotCancelled;

	@override
  String get timeslotMissed => Crowdin.getText(localeName, 'timeslotMissed') ?? _fallbackTexts.timeslotMissed;

	@override
  String get chooseAnotherTimeslot => Crowdin.getText(localeName, 'chooseAnotherTimeslot') ?? _fallbackTexts.chooseAnotherTimeslot;

	@override
  String get noOtherTimeslotsAvailable => Crowdin.getText(localeName, 'noOtherTimeslotsAvailable') ?? _fallbackTexts.noOtherTimeslotsAvailable;

	@override
	String noMinMemberCount(int count) => Crowdin.getText(localeName, 'noMinMemberCount', {'count':count}) ?? _fallbackTexts.noMinMemberCount(count);

	@override
  String get noGroupThisWeek => Crowdin.getText(localeName, 'noGroupThisWeek') ?? _fallbackTexts.noGroupThisWeek;

	@override
  String get on => Crowdin.getText(localeName, 'on') ?? _fallbackTexts.on;

	@override
  String get off => Crowdin.getText(localeName, 'off') ?? _fallbackTexts.off;

	@override
  String get noMoodRecords => Crowdin.getText(localeName, 'noMoodRecords') ?? _fallbackTexts.noMoodRecords;

	@override
  String get yourSupportSystem => Crowdin.getText(localeName, 'yourSupportSystem') ?? _fallbackTexts.yourSupportSystem;

	@override
  String get supportGroupIntroDesc => Crowdin.getText(localeName, 'supportGroupIntroDesc') ?? _fallbackTexts.supportGroupIntroDesc;

	@override
  String get yesILikeToJoin => Crowdin.getText(localeName, 'yesILikeToJoin') ?? _fallbackTexts.yesILikeToJoin;

	@override
  String get joinLater => Crowdin.getText(localeName, 'joinLater') ?? _fallbackTexts.joinLater;

	@override
  String get theSupportGroup => Crowdin.getText(localeName, 'theSupportGroup') ?? _fallbackTexts.theSupportGroup;

	@override
  String get introduction => Crowdin.getText(localeName, 'introduction') ?? _fallbackTexts.introduction;

	@override
  String get reportIssue => Crowdin.getText(localeName, 'reportIssue') ?? _fallbackTexts.reportIssue;

	@override
  String get discussion => Crowdin.getText(localeName, 'discussion') ?? _fallbackTexts.discussion;

	@override
  String get left => Crowdin.getText(localeName, 'left') ?? _fallbackTexts.left;

	@override
  String get error => Crowdin.getText(localeName, 'error') ?? _fallbackTexts.error;

	@override
  String get sessionIsInProgress => Crowdin.getText(localeName, 'sessionIsInProgress') ?? _fallbackTexts.sessionIsInProgress;

	@override
  String get failedToJoinSession => Crowdin.getText(localeName, 'failedToJoinSession') ?? _fallbackTexts.failedToJoinSession;

	@override
  String get disconnectedFromSession => Crowdin.getText(localeName, 'disconnectedFromSession') ?? _fallbackTexts.disconnectedFromSession;

	@override
	String micState(String micState) => Crowdin.getText(localeName, 'micState', {'micState':micState}) ?? _fallbackTexts.micState(micState);

	@override
  String get toggleSpeakerError => Crowdin.getText(localeName, 'toggleSpeakerError') ?? _fallbackTexts.toggleSpeakerError;

	@override
  String get mute => Crowdin.getText(localeName, 'mute') ?? _fallbackTexts.mute;

	@override
  String get stopVideo => Crowdin.getText(localeName, 'stopVideo') ?? _fallbackTexts.stopVideo;

	@override
  String get settings => Crowdin.getText(localeName, 'settings') ?? _fallbackTexts.settings;

	@override
  String get sessionLeaveDialogText => Crowdin.getText(localeName, 'sessionLeaveDialogText') ?? _fallbackTexts.sessionLeaveDialogText;

	@override
  String get sessionEndDialogText => Crowdin.getText(localeName, 'sessionEndDialogText') ?? _fallbackTexts.sessionEndDialogText;

	@override
  String get leaveSession => Crowdin.getText(localeName, 'leaveSession') ?? _fallbackTexts.leaveSession;

	@override
  String get stayInTheSession => Crowdin.getText(localeName, 'stayInTheSession') ?? _fallbackTexts.stayInTheSession;

	@override
  String get signatureErrorMessage => Crowdin.getText(localeName, 'signatureErrorMessage') ?? _fallbackTexts.signatureErrorMessage;

	@override
  String get sessionAlreadyEnded => Crowdin.getText(localeName, 'sessionAlreadyEnded') ?? _fallbackTexts.sessionAlreadyEnded;

	@override
  String get duration => Crowdin.getText(localeName, 'duration') ?? _fallbackTexts.duration;

	@override
  String get badConnectionMessage => Crowdin.getText(localeName, 'badConnectionMessage') ?? _fallbackTexts.badConnectionMessage;

	@override
  String get exercise => Crowdin.getText(localeName, 'exercise') ?? _fallbackTexts.exercise;

	@override
  String get noMicrophoneAccessTitle => Crowdin.getText(localeName, 'noMicrophoneAccessTitle') ?? _fallbackTexts.noMicrophoneAccessTitle;

	@override
  String get noMicrophoneAccessDescription => Crowdin.getText(localeName, 'noMicrophoneAccessDescription') ?? _fallbackTexts.noMicrophoneAccessDescription;

	@override
  String get noCameraAccessTitle => Crowdin.getText(localeName, 'noCameraAccessTitle') ?? _fallbackTexts.noCameraAccessTitle;

	@override
  String get noCameraAccessDescription => Crowdin.getText(localeName, 'noCameraAccessDescription') ?? _fallbackTexts.noCameraAccessDescription;

	@override
  String get sessionGreeting => Crowdin.getText(localeName, 'sessionGreeting') ?? _fallbackTexts.sessionGreeting;

	@override
  String get goodToKnow => Crowdin.getText(localeName, 'goodToKnow') ?? _fallbackTexts.goodToKnow;

	@override
  String get warningOne => Crowdin.getText(localeName, 'warningOne') ?? _fallbackTexts.warningOne;

	@override
  String get warningTwo => Crowdin.getText(localeName, 'warningTwo') ?? _fallbackTexts.warningTwo;

	@override
  String get hi => Crowdin.getText(localeName, 'hi') ?? _fallbackTexts.hi;

	@override
  String get sessionWillStartIn => Crowdin.getText(localeName, 'sessionWillStartIn') ?? _fallbackTexts.sessionWillStartIn;

	@override
  String get sessionStartedMessage => Crowdin.getText(localeName, 'sessionStartedMessage') ?? _fallbackTexts.sessionStartedMessage;

	@override
  String get enterSession => Crowdin.getText(localeName, 'enterSession') ?? _fallbackTexts.enterSession;

	@override
  String get pickADateAndTime => Crowdin.getText(localeName, 'pickADateAndTime') ?? _fallbackTexts.pickADateAndTime;

	@override
	String fromTo(String startTime, String endTime) => Crowdin.getText(localeName, 'fromTo', {'startTime':startTime, 'endTime':endTime}) ?? _fallbackTexts.fromTo(startTime, endTime);

	@override
	String fromToLower(String startTime, String endTime) => Crowdin.getText(localeName, 'fromToLower', {'startTime':startTime, 'endTime':endTime}) ?? _fallbackTexts.fromToLower(startTime, endTime);

	@override
	String numberOfAvailableSeats(String number, String totalNumber) => Crowdin.getText(localeName, 'numberOfAvailableSeats', {'number':number, 'totalNumber':totalNumber}) ?? _fallbackTexts.numberOfAvailableSeats(number, totalNumber);

	@override
  String get passedSession => Crowdin.getText(localeName, 'passedSession') ?? _fallbackTexts.passedSession;

	@override
  String get cancelledSession => Crowdin.getText(localeName, 'cancelledSession') ?? _fallbackTexts.cancelledSession;

	@override
  String get minimumNotReached => Crowdin.getText(localeName, 'minimumNotReached') ?? _fallbackTexts.minimumNotReached;

	@override
  String get noMoreSeatAvailable => Crowdin.getText(localeName, 'noMoreSeatAvailable') ?? _fallbackTexts.noMoreSeatAvailable;

	@override
  String get bookedForYou => Crowdin.getText(localeName, 'bookedForYou') ?? _fallbackTexts.bookedForYou;

	@override
  String get cancelBooking => Crowdin.getText(localeName, 'cancelBooking') ?? _fallbackTexts.cancelBooking;

	@override
  String get sessionWarning_1 => Crowdin.getText(localeName, 'sessionWarning_1') ?? _fallbackTexts.sessionWarning_1;

	@override
  String get sessionWarning_2 => Crowdin.getText(localeName, 'sessionWarning_2') ?? _fallbackTexts.sessionWarning_2;

	@override
  String get emergencySubtitle => Crowdin.getText(localeName, 'emergencySubtitle') ?? _fallbackTexts.emergencySubtitle;

	@override
  String get subjectReport => Crowdin.getText(localeName, 'subjectReport') ?? _fallbackTexts.subjectReport;

	@override
  String get descriptionReport => Crowdin.getText(localeName, 'descriptionReport') ?? _fallbackTexts.descriptionReport;

	@override
  String get reportTitle => Crowdin.getText(localeName, 'reportTitle') ?? _fallbackTexts.reportTitle;

	@override
  String get reportSubTitle => Crowdin.getText(localeName, 'reportSubTitle') ?? _fallbackTexts.reportSubTitle;

	@override
  String get reportSuccessTitle => Crowdin.getText(localeName, 'reportSuccessTitle') ?? _fallbackTexts.reportSuccessTitle;

	@override
  String get errorReportMessage => Crowdin.getText(localeName, 'errorReportMessage') ?? _fallbackTexts.errorReportMessage;

	@override
  String get errorSubjectMessage => Crowdin.getText(localeName, 'errorSubjectMessage') ?? _fallbackTexts.errorSubjectMessage;

	@override
  String get requiredField => Crowdin.getText(localeName, 'requiredField') ?? _fallbackTexts.requiredField;

	@override
  String get send => Crowdin.getText(localeName, 'send') ?? _fallbackTexts.send;

	@override
  String get changeYourEmail => Crowdin.getText(localeName, 'changeYourEmail') ?? _fallbackTexts.changeYourEmail;

	@override
  String get changeYourEmailDescription => Crowdin.getText(localeName, 'changeYourEmailDescription') ?? _fallbackTexts.changeYourEmailDescription;

	@override
  String get submit => Crowdin.getText(localeName, 'submit') ?? _fallbackTexts.submit;

	@override
  String get emailChangeConfirmedTitle => Crowdin.getText(localeName, 'emailChangeConfirmedTitle') ?? _fallbackTexts.emailChangeConfirmedTitle;

	@override
  String get emailChangeConfirmedBody1 => Crowdin.getText(localeName, 'emailChangeConfirmedBody1') ?? _fallbackTexts.emailChangeConfirmedBody1;

	@override
  String get emailChangeConfirmedBody2 => Crowdin.getText(localeName, 'emailChangeConfirmedBody2') ?? _fallbackTexts.emailChangeConfirmedBody2;

	@override
	String yourPreferencesUpdated(String prefName) => Crowdin.getText(localeName, 'yourPreferencesUpdated', {'prefName':prefName}) ?? _fallbackTexts.yourPreferencesUpdated(prefName);

	@override
  String get createNew => Crowdin.getText(localeName, 'createNew') ?? _fallbackTexts.createNew;

	@override
  String get updateExist => Crowdin.getText(localeName, 'updateExist') ?? _fallbackTexts.updateExist;

	@override
  String get existMealText => Crowdin.getText(localeName, 'existMealText') ?? _fallbackTexts.existMealText;

	@override
	String chooseDateFor(String mealCategory) => Crowdin.getText(localeName, 'chooseDateFor', {'mealCategory':mealCategory}) ?? _fallbackTexts.chooseDateFor(mealCategory);

	@override
  String get youCanChangeTheDate => Crowdin.getText(localeName, 'youCanChangeTheDate') ?? _fallbackTexts.youCanChangeTheDate;

	@override
	String weekWithNumber(String number) => Crowdin.getText(localeName, 'weekWithNumber', {'number':number}) ?? _fallbackTexts.weekWithNumber(number);

	@override
	String capitalizeWeekWithNumber(String number) => Crowdin.getText(localeName, 'capitalizeWeekWithNumber', {'number':number}) ?? _fallbackTexts.capitalizeWeekWithNumber(number);

	@override
	String weekDates(String from, String to, String month) => Crowdin.getText(localeName, 'weekDates', {'from':from, 'to':to, 'month':month}) ?? _fallbackTexts.weekDates(from, to, month);

	@override
  String get saveChanges => Crowdin.getText(localeName, 'saveChanges') ?? _fallbackTexts.saveChanges;

	@override
  String get changesSaved => Crowdin.getText(localeName, 'changesSaved') ?? _fallbackTexts.changesSaved;

	@override
  String get thisMealPlannedFor => Crowdin.getText(localeName, 'thisMealPlannedFor') ?? _fallbackTexts.thisMealPlannedFor;

	@override
  String get saveDateError => Crowdin.getText(localeName, 'saveDateError') ?? _fallbackTexts.saveDateError;

	@override
  String get kcal => Crowdin.getText(localeName, 'kcal') ?? _fallbackTexts.kcal;

	@override
  String get yesReplace => Crowdin.getText(localeName, 'yesReplace') ?? _fallbackTexts.yesReplace;

	@override
	String youAlreadyPlanned(String mealCategory) => Crowdin.getText(localeName, 'youAlreadyPlanned', {'mealCategory':mealCategory}) ?? _fallbackTexts.youAlreadyPlanned(mealCategory);

	@override
	String andOtherDates(String number) => Crowdin.getText(localeName, 'andOtherDates', {'number':number}) ?? _fallbackTexts.andOtherDates(number);

	@override
	String alreadyPlannedCategory(String mealCategory) => Crowdin.getText(localeName, 'alreadyPlannedCategory', {'mealCategory':mealCategory}) ?? _fallbackTexts.alreadyPlannedCategory(mealCategory);

	@override
  String get replaceWith => Crowdin.getText(localeName, 'replaceWith') ?? _fallbackTexts.replaceWith;

	@override
  String get nothingOnTheMenu => Crowdin.getText(localeName, 'nothingOnTheMenu') ?? _fallbackTexts.nothingOnTheMenu;

	@override
  String get mindTraining => Crowdin.getText(localeName, 'mindTraining') ?? _fallbackTexts.mindTraining;

	@override
  String get learnMoreButton => Crowdin.getText(localeName, 'learnMoreButton') ?? _fallbackTexts.learnMoreButton;

	@override
  String get lock => Crowdin.getText(localeName, 'lock') ?? _fallbackTexts.lock;

	@override
	String unlocksOn(String date) => Crowdin.getText(localeName, 'unlocksOn', {'date':date}) ?? _fallbackTexts.unlocksOn(date);

	@override
  String get unlocksAfterCompletionExercise => Crowdin.getText(localeName, 'unlocksAfterCompletionExercise') ?? _fallbackTexts.unlocksAfterCompletionExercise;

	@override
  String get intro => Crowdin.getText(localeName, 'intro') ?? _fallbackTexts.intro;

	@override
  String get exercises => Crowdin.getText(localeName, 'exercises') ?? _fallbackTexts.exercises;

	@override
  String get startExercise => Crowdin.getText(localeName, 'startExercise') ?? _fallbackTexts.startExercise;

	@override
	String countMins(int count) => Crowdin.getText(localeName, 'countMins', {'count':count}) ?? _fallbackTexts.countMins(count);

	@override
  String get chooseAnExercise => Crowdin.getText(localeName, 'chooseAnExercise') ?? _fallbackTexts.chooseAnExercise;

	@override
  String get completedExerciseMessage1 => Crowdin.getText(localeName, 'completedExerciseMessage1') ?? _fallbackTexts.completedExerciseMessage1;

	@override
	String completedExerciseMessage2(String count) => Crowdin.getText(localeName, 'completedExerciseMessage2', {'count':count}) ?? _fallbackTexts.completedExerciseMessage2(count);

	@override
  String get completedIntroductionMessage2 => Crowdin.getText(localeName, 'completedIntroductionMessage2') ?? _fallbackTexts.completedIntroductionMessage2;

	@override
  String get chooseTechnique => Crowdin.getText(localeName, 'chooseTechnique') ?? _fallbackTexts.chooseTechnique;

	@override
  String get chooseExercise => Crowdin.getText(localeName, 'chooseExercise') ?? _fallbackTexts.chooseExercise;

	@override
  String get selectedExercise => Crowdin.getText(localeName, 'selectedExercise') ?? _fallbackTexts.selectedExercise;

	@override
  String get skipIntro => Crowdin.getText(localeName, 'skipIntro') ?? _fallbackTexts.skipIntro;

	@override
  String get selectMoodText => Crowdin.getText(localeName, 'selectMoodText') ?? _fallbackTexts.selectMoodText;

	@override
  String get selectMoodSubtext => Crowdin.getText(localeName, 'selectMoodSubtext') ?? _fallbackTexts.selectMoodSubtext;

	@override
  String get time => Crowdin.getText(localeName, 'time') ?? _fallbackTexts.time;

	@override
  String get specifyEmotion => Crowdin.getText(localeName, 'specifyEmotion') ?? _fallbackTexts.specifyEmotion;

	@override
  String get withWho => Crowdin.getText(localeName, 'withWho') ?? _fallbackTexts.withWho;

	@override
  String get where => Crowdin.getText(localeName, 'where') ?? _fallbackTexts.where;

	@override
  String get makeChoice => Crowdin.getText(localeName, 'makeChoice') ?? _fallbackTexts.makeChoice;

	@override
  String get personalNote => Crowdin.getText(localeName, 'personalNote') ?? _fallbackTexts.personalNote;

	@override
  String get moodOptionPageEmotionTitle => Crowdin.getText(localeName, 'moodOptionPageEmotionTitle') ?? _fallbackTexts.moodOptionPageEmotionTitle;

	@override
  String get descriptionEmotions => Crowdin.getText(localeName, 'descriptionEmotions') ?? _fallbackTexts.descriptionEmotions;

	@override
  String get deleteMood => Crowdin.getText(localeName, 'deleteMood') ?? _fallbackTexts.deleteMood;

	@override
  String get quiz => Crowdin.getText(localeName, 'quiz') ?? _fallbackTexts.quiz;

	@override
  String get letsGo => Crowdin.getText(localeName, 'letsGo') ?? _fallbackTexts.letsGo;

	@override
  String get correct => Crowdin.getText(localeName, 'correct') ?? _fallbackTexts.correct;

	@override
  String get incorrect => Crowdin.getText(localeName, 'incorrect') ?? _fallbackTexts.incorrect;

	@override
  String get assignmentAddedTitle => Crowdin.getText(localeName, 'assignmentAddedTitle') ?? _fallbackTexts.assignmentAddedTitle;

	@override
	String assignmentAddedText(String date) => Crowdin.getText(localeName, 'assignmentAddedText', {'date':date}) ?? _fallbackTexts.assignmentAddedText(date);

	@override
  String get startNow => Crowdin.getText(localeName, 'startNow') ?? _fallbackTexts.startNow;

	@override
  String get reflection => Crowdin.getText(localeName, 'reflection') ?? _fallbackTexts.reflection;

	@override
  String get reflections => Crowdin.getText(localeName, 'reflections') ?? _fallbackTexts.reflections;

	@override
  String get seeLesson => Crowdin.getText(localeName, 'seeLesson') ?? _fallbackTexts.seeLesson;

	@override
  String get allAssignmentsCompleted => Crowdin.getText(localeName, 'allAssignmentsCompleted') ?? _fallbackTexts.allAssignmentsCompleted;

	@override
  String get errorOpenTextMessage => Crowdin.getText(localeName, 'errorOpenTextMessage') ?? _fallbackTexts.errorOpenTextMessage;

	@override
  String get thisWeek => Crowdin.getText(localeName, 'thisWeek') ?? _fallbackTexts.thisWeek;

	@override
  String get doneToday => Crowdin.getText(localeName, 'doneToday') ?? _fallbackTexts.doneToday;

	@override
	String completeBefore(String date) => Crowdin.getText(localeName, 'completeBefore', {'date':date}) ?? _fallbackTexts.completeBefore(date);

	@override
	String completedOn(String date) => Crowdin.getText(localeName, 'completedOn', {'date':date}) ?? _fallbackTexts.completedOn(date);

	@override
  String get pastReflections => Crowdin.getText(localeName, 'pastReflections') ?? _fallbackTexts.pastReflections;

	@override
  String get iWantToLogMy => Crowdin.getText(localeName, 'iWantToLogMy') ?? _fallbackTexts.iWantToLogMy;

	@override
  String get logMealServingTitle => Crowdin.getText(localeName, 'logMealServingTitle') ?? _fallbackTexts.logMealServingTitle;

	@override
  String get descriptionTime => Crowdin.getText(localeName, 'descriptionTime') ?? _fallbackTexts.descriptionTime;

	@override
  String get descriptionWithWhom => Crowdin.getText(localeName, 'descriptionWithWhom') ?? _fallbackTexts.descriptionWithWhom;

	@override
  String get descriptionWhere => Crowdin.getText(localeName, 'descriptionWhere') ?? _fallbackTexts.descriptionWhere;

	@override
  String get descriptionFood => Crowdin.getText(localeName, 'descriptionFood') ?? _fallbackTexts.descriptionFood;

	@override
  String get logWeight => Crowdin.getText(localeName, 'logWeight') ?? _fallbackTexts.logWeight;

	@override
  String get foodLoggingUnlocked => Crowdin.getText(localeName, 'foodLoggingUnlocked') ?? _fallbackTexts.foodLoggingUnlocked;

	@override
  String get youCanStartLogging => Crowdin.getText(localeName, 'youCanStartLogging') ?? _fallbackTexts.youCanStartLogging;

	@override
  String get reportIssueAndEmergencyTitle => Crowdin.getText(localeName, 'reportIssueAndEmergencyTitle') ?? _fallbackTexts.reportIssueAndEmergencyTitle;

	@override
  String get groupChat => Crowdin.getText(localeName, 'groupChat') ?? _fallbackTexts.groupChat;

	@override
  String get groupChatTitle => Crowdin.getText(localeName, 'groupChatTitle') ?? _fallbackTexts.groupChatTitle;

	@override
	String groupChatLabel(int count) => Crowdin.getText(localeName, 'groupChatLabel', {'count':count}) ?? _fallbackTexts.groupChatLabel(count);

	@override
  String get copyGroupMessage => Crowdin.getText(localeName, 'copyGroupMessage') ?? _fallbackTexts.copyGroupMessage;

	@override
  String get removeGroupMessage => Crowdin.getText(localeName, 'removeGroupMessage') ?? _fallbackTexts.removeGroupMessage;

	@override
  String get reportGroupMessage => Crowdin.getText(localeName, 'reportGroupMessage') ?? _fallbackTexts.reportGroupMessage;

	@override
  String get snackMassageCopy => Crowdin.getText(localeName, 'snackMassageCopy') ?? _fallbackTexts.snackMassageCopy;

	@override
  String get messageRemoved => Crowdin.getText(localeName, 'messageRemoved') ?? _fallbackTexts.messageRemoved;

	@override
  String get membersEmpty => Crowdin.getText(localeName, 'membersEmpty') ?? _fallbackTexts.membersEmpty;

	@override
  String get messageLengthRestriction => Crowdin.getText(localeName, 'messageLengthRestriction') ?? _fallbackTexts.messageLengthRestriction;

	@override
  String get yourUser => Crowdin.getText(localeName, 'yourUser') ?? _fallbackTexts.yourUser;

	@override
  String get passwordValidationRule4 => Crowdin.getText(localeName, 'passwordValidationRule4') ?? _fallbackTexts.passwordValidationRule4;

	@override
  String get pleaseEnterRegistrationCode => Crowdin.getText(localeName, 'pleaseEnterRegistrationCode') ?? _fallbackTexts.pleaseEnterRegistrationCode;

	@override
  String get pleaseEnterValidRegistrationCode => Crowdin.getText(localeName, 'pleaseEnterValidRegistrationCode') ?? _fallbackTexts.pleaseEnterValidRegistrationCode;

	@override
  String get favorite => Crowdin.getText(localeName, 'favorite') ?? _fallbackTexts.favorite;

	@override
  String get recipe => Crowdin.getText(localeName, 'recipe') ?? _fallbackTexts.recipe;

	@override
  String get recipeDetails => Crowdin.getText(localeName, 'recipeDetails') ?? _fallbackTexts.recipeDetails;

	@override
  String get myDish => Crowdin.getText(localeName, 'myDish') ?? _fallbackTexts.myDish;

	@override
  String get editMyDish => Crowdin.getText(localeName, 'editMyDish') ?? _fallbackTexts.editMyDish;

	@override
  String get serving => Crowdin.getText(localeName, 'serving') ?? _fallbackTexts.serving;

	@override
  String get logList => Crowdin.getText(localeName, 'logList') ?? _fallbackTexts.logList;

	@override
  String get clearMealList => Crowdin.getText(localeName, 'clearMealList') ?? _fallbackTexts.clearMealList;

	@override
  String get logListEmptyMessage => Crowdin.getText(localeName, 'logListEmptyMessage') ?? _fallbackTexts.logListEmptyMessage;

	@override
  String get backToDashboard => Crowdin.getText(localeName, 'backToDashboard') ?? _fallbackTexts.backToDashboard;

	@override
  String get backToTodayLogging => Crowdin.getText(localeName, 'backToTodayLogging') ?? _fallbackTexts.backToTodayLogging;

	@override
  String get hello => Crowdin.getText(localeName, 'hello') ?? _fallbackTexts.hello;

	@override
  String get goodMorning => Crowdin.getText(localeName, 'goodMorning') ?? _fallbackTexts.goodMorning;

	@override
  String get goodAfternoon => Crowdin.getText(localeName, 'goodAfternoon') ?? _fallbackTexts.goodAfternoon;

	@override
  String get goodEvening => Crowdin.getText(localeName, 'goodEvening') ?? _fallbackTexts.goodEvening;

	@override
  String get logYourWeight => Crowdin.getText(localeName, 'logYourWeight') ?? _fallbackTexts.logYourWeight;

	@override
  String get mealLog => Crowdin.getText(localeName, 'mealLog') ?? _fallbackTexts.mealLog;

	@override
  String get planYourMeals => Crowdin.getText(localeName, 'planYourMeals') ?? _fallbackTexts.planYourMeals;

	@override
  String get planThisMeal => Crowdin.getText(localeName, 'planThisMeal') ?? _fallbackTexts.planThisMeal;

	@override
  String get diary => Crowdin.getText(localeName, 'diary') ?? _fallbackTexts.diary;

	@override
  String get mood => Crowdin.getText(localeName, 'mood') ?? _fallbackTexts.mood;

	@override
  String get today => Crowdin.getText(localeName, 'today') ?? _fallbackTexts.today;

	@override
  String get physicalActivities => Crowdin.getText(localeName, 'physicalActivities') ?? _fallbackTexts.physicalActivities;

	@override
  String get physicalActivitiesPreferences => Crowdin.getText(localeName, 'physicalActivitiesPreferences') ?? _fallbackTexts.physicalActivitiesPreferences;

	@override
  String get trainingFrequency => Crowdin.getText(localeName, 'trainingFrequency') ?? _fallbackTexts.trainingFrequency;

	@override
  String get trainingFocus => Crowdin.getText(localeName, 'trainingFocus') ?? _fallbackTexts.trainingFocus;

	@override
  String get didItWorkOutForYou => Crowdin.getText(localeName, 'didItWorkOutForYou') ?? _fallbackTexts.didItWorkOutForYou;

	@override
  String get foodPreferencesDesc => Crowdin.getText(localeName, 'foodPreferencesDesc') ?? _fallbackTexts.foodPreferencesDesc;

	@override
  String get foodPreferencesItemOne => Crowdin.getText(localeName, 'foodPreferencesItemOne') ?? _fallbackTexts.foodPreferencesItemOne;

	@override
  String get foodPreferencesItemTwo => Crowdin.getText(localeName, 'foodPreferencesItemTwo') ?? _fallbackTexts.foodPreferencesItemTwo;

	@override
  String get foodPreferencesItemThree => Crowdin.getText(localeName, 'foodPreferencesItemThree') ?? _fallbackTexts.foodPreferencesItemThree;

	@override
  String get foodPreferencesItemFour => Crowdin.getText(localeName, 'foodPreferencesItemFour') ?? _fallbackTexts.foodPreferencesItemFour;

	@override
  String get physicalActivitiesPreferencesDesc => Crowdin.getText(localeName, 'physicalActivitiesPreferencesDesc') ?? _fallbackTexts.physicalActivitiesPreferencesDesc;

	@override
  String get physicalActivitiesPreferencesItemOne => Crowdin.getText(localeName, 'physicalActivitiesPreferencesItemOne') ?? _fallbackTexts.physicalActivitiesPreferencesItemOne;

	@override
  String get physicalActivitiesPreferencesItemTwo => Crowdin.getText(localeName, 'physicalActivitiesPreferencesItemTwo') ?? _fallbackTexts.physicalActivitiesPreferencesItemTwo;

	@override
  String get physicalActivitiesPreferencesItemThree => Crowdin.getText(localeName, 'physicalActivitiesPreferencesItemThree') ?? _fallbackTexts.physicalActivitiesPreferencesItemThree;

	@override
  String get physicalActivitiesFrequencyTitle => Crowdin.getText(localeName, 'physicalActivitiesFrequencyTitle') ?? _fallbackTexts.physicalActivitiesFrequencyTitle;

	@override
  String get physicalActivitiesFrequencyItemOne => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemOne') ?? _fallbackTexts.physicalActivitiesFrequencyItemOne;

	@override
  String get physicalActivitiesFrequencyItemTwo => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemTwo') ?? _fallbackTexts.physicalActivitiesFrequencyItemTwo;

	@override
  String get physicalActivitiesFrequencyItemThree => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemThree') ?? _fallbackTexts.physicalActivitiesFrequencyItemThree;

	@override
  String get physicalActivitiesFrequencyItemFour => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemFour') ?? _fallbackTexts.physicalActivitiesFrequencyItemFour;

	@override
  String get physicalActivitiesFrequencyItemFive => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemFive') ?? _fallbackTexts.physicalActivitiesFrequencyItemFive;

	@override
  String get physicalActivitiesFrequencyItemSix => Crowdin.getText(localeName, 'physicalActivitiesFrequencyItemSix') ?? _fallbackTexts.physicalActivitiesFrequencyItemSix;

	@override
  String get physicalActivitiesFrequencyZero => Crowdin.getText(localeName, 'physicalActivitiesFrequencyZero') ?? _fallbackTexts.physicalActivitiesFrequencyZero;

	@override
  String get physicalActivitiesNoActivities => Crowdin.getText(localeName, 'physicalActivitiesNoActivities') ?? _fallbackTexts.physicalActivitiesNoActivities;

	@override
  String get whatWouldYouLikeToStartWorkingOn => Crowdin.getText(localeName, 'whatWouldYouLikeToStartWorkingOn') ?? _fallbackTexts.whatWouldYouLikeToStartWorkingOn;

	@override
  String get buildUpMuscle => Crowdin.getText(localeName, 'buildUpMuscle') ?? _fallbackTexts.buildUpMuscle;

	@override
  String get inceaseYourStamina => Crowdin.getText(localeName, 'inceaseYourStamina') ?? _fallbackTexts.inceaseYourStamina;

	@override
  String get youCanAlsoOptionally => Crowdin.getText(localeName, 'youCanAlsoOptionally') ?? _fallbackTexts.youCanAlsoOptionally;

	@override
  String get moreFlexibility => Crowdin.getText(localeName, 'moreFlexibility') ?? _fallbackTexts.moreFlexibility;

	@override
  String get physicalActivitiesCompletedTitle => Crowdin.getText(localeName, 'physicalActivitiesCompletedTitle') ?? _fallbackTexts.physicalActivitiesCompletedTitle;

	@override
  String get physicalActivitiesCompletedDesc => Crowdin.getText(localeName, 'physicalActivitiesCompletedDesc') ?? _fallbackTexts.physicalActivitiesCompletedDesc;

	@override
  String get physicalActivitiesUnlockedTitle => Crowdin.getText(localeName, 'physicalActivitiesUnlockedTitle') ?? _fallbackTexts.physicalActivitiesUnlockedTitle;

	@override
  String get physicalActivitiesUnlockedText => Crowdin.getText(localeName, 'physicalActivitiesUnlockedText') ?? _fallbackTexts.physicalActivitiesUnlockedText;

	@override
  String get physicalExercises => Crowdin.getText(localeName, 'physicalExercises') ?? _fallbackTexts.physicalExercises;

	@override
  String get perWeek => Crowdin.getText(localeName, 'perWeek') ?? _fallbackTexts.perWeek;

	@override
  String get supportGroup => Crowdin.getText(localeName, 'supportGroup') ?? _fallbackTexts.supportGroup;

	@override
  String get account => Crowdin.getText(localeName, 'account') ?? _fallbackTexts.account;

	@override
  String get education => Crowdin.getText(localeName, 'education') ?? _fallbackTexts.education;

	@override
  String get preferableInTheMorning => Crowdin.getText(localeName, 'preferableInTheMorning') ?? _fallbackTexts.preferableInTheMorning;

	@override
  String get noWeightLogged => Crowdin.getText(localeName, 'noWeightLogged') ?? _fallbackTexts.noWeightLogged;

	@override
  String get ok => Crowdin.getText(localeName, 'ok') ?? _fallbackTexts.ok;

	@override
  String get todaysWeight => Crowdin.getText(localeName, 'todaysWeight') ?? _fallbackTexts.todaysWeight;

	@override
  String get all => Crowdin.getText(localeName, 'all') ?? _fallbackTexts.all;

	@override
  String get general => Crowdin.getText(localeName, 'general') ?? _fallbackTexts.general;

	@override
  String get nutrition => Crowdin.getText(localeName, 'nutrition') ?? _fallbackTexts.nutrition;

	@override
  String get mind => Crowdin.getText(localeName, 'mind') ?? _fallbackTexts.mind;

	@override
  String get activity => Crowdin.getText(localeName, 'activity') ?? _fallbackTexts.activity;

	@override
  String get noMealsLogged => Crowdin.getText(localeName, 'noMealsLogged') ?? _fallbackTexts.noMealsLogged;

	@override
  String get noMealsPlanned => Crowdin.getText(localeName, 'noMealsPlanned') ?? _fallbackTexts.noMealsPlanned;

	@override
  String get noMealsLoggedYet => Crowdin.getText(localeName, 'noMealsLoggedYet') ?? _fallbackTexts.noMealsLoggedYet;

	@override
  String get noMealsPlannedYet => Crowdin.getText(localeName, 'noMealsPlannedYet') ?? _fallbackTexts.noMealsPlannedYet;

	@override
  String get summary => Crowdin.getText(localeName, 'summary') ?? _fallbackTexts.summary;

	@override
  String get instructions => Crowdin.getText(localeName, 'instructions') ?? _fallbackTexts.instructions;

	@override
  String get ingredients => Crowdin.getText(localeName, 'ingredients') ?? _fallbackTexts.ingredients;

	@override
  String get addToMyDishes => Crowdin.getText(localeName, 'addToMyDishes') ?? _fallbackTexts.addToMyDishes;

	@override
  String get addToMyDishedAs => Crowdin.getText(localeName, 'addToMyDishedAs') ?? _fallbackTexts.addToMyDishedAs;

	@override
  String get giveNameToThisDish => Crowdin.getText(localeName, 'giveNameToThisDish') ?? _fallbackTexts.giveNameToThisDish;

	@override
  String get save => Crowdin.getText(localeName, 'save') ?? _fallbackTexts.save;

	@override
  String get cookingTime => Crowdin.getText(localeName, 'cookingTime') ?? _fallbackTexts.cookingTime;

	@override
  String get preparation => Crowdin.getText(localeName, 'preparation') ?? _fallbackTexts.preparation;

	@override
  String get preparationTime => Crowdin.getText(localeName, 'preparationTime') ?? _fallbackTexts.preparationTime;

	@override
  String get show => Crowdin.getText(localeName, 'show') ?? _fallbackTexts.show;

	@override
  String get portions => Crowdin.getText(localeName, 'portions') ?? _fallbackTexts.portions;

	@override
  String get howToPrepare => Crowdin.getText(localeName, 'howToPrepare') ?? _fallbackTexts.howToPrepare;

	@override
  String get searchEmptyResultTitle => Crowdin.getText(localeName, 'searchEmptyResultTitle') ?? _fallbackTexts.searchEmptyResultTitle;

	@override
  String get searchEmptyResultText => Crowdin.getText(localeName, 'searchEmptyResultText') ?? _fallbackTexts.searchEmptyResultText;

	@override
  String get createMyDish => Crowdin.getText(localeName, 'createMyDish') ?? _fallbackTexts.createMyDish;

	@override
  String get logItem => Crowdin.getText(localeName, 'logItem') ?? _fallbackTexts.logItem;

	@override
  String get deleteDish => Crowdin.getText(localeName, 'deleteDish') ?? _fallbackTexts.deleteDish;

	@override
  String get deleteModalMessage => Crowdin.getText(localeName, 'deleteModalMessage') ?? _fallbackTexts.deleteModalMessage;

	@override
  String get deleteAccount => Crowdin.getText(localeName, 'deleteAccount') ?? _fallbackTexts.deleteAccount;

	@override
  String get signOut => Crowdin.getText(localeName, 'signOut') ?? _fallbackTexts.signOut;

	@override
  String get yesDelete => Crowdin.getText(localeName, 'yesDelete') ?? _fallbackTexts.yesDelete;

	@override
  String get deleteMealModalMessage => Crowdin.getText(localeName, 'deleteMealModalMessage') ?? _fallbackTexts.deleteMealModalMessage;

	@override
	String deleteMultiDateMealModalMessage(String mealCategory) => Crowdin.getText(localeName, 'deleteMultiDateMealModalMessage', {'mealCategory':mealCategory}) ?? _fallbackTexts.deleteMultiDateMealModalMessage(mealCategory);

	@override
  String get deleteMultiDateMealModalExplain => Crowdin.getText(localeName, 'deleteMultiDateMealModalExplain') ?? _fallbackTexts.deleteMultiDateMealModalExplain;

	@override
  String get deleteMultiDateMealModalExplain2 => Crowdin.getText(localeName, 'deleteMultiDateMealModalExplain2') ?? _fallbackTexts.deleteMultiDateMealModalExplain2;

	@override
  String get openDatepicker => Crowdin.getText(localeName, 'openDatepicker') ?? _fallbackTexts.openDatepicker;

	@override
  String get remove => Crowdin.getText(localeName, 'remove') ?? _fallbackTexts.remove;

	@override
  String get recommendations => Crowdin.getText(localeName, 'recommendations') ?? _fallbackTexts.recommendations;

	@override
  String get noCancel => Crowdin.getText(localeName, 'noCancel') ?? _fallbackTexts.noCancel;

	@override
  String get recentSearch => Crowdin.getText(localeName, 'recentSearch') ?? _fallbackTexts.recentSearch;

	@override
  String get dishWasSaved => Crowdin.getText(localeName, 'dishWasSaved') ?? _fallbackTexts.dishWasSaved;

	@override
  String get foodItemWasAddedToDish => Crowdin.getText(localeName, 'foodItemWasAddedToDish') ?? _fallbackTexts.foodItemWasAddedToDish;

	@override
  String get foodItemWasDeletedFromDish => Crowdin.getText(localeName, 'foodItemWasDeletedFromDish') ?? _fallbackTexts.foodItemWasDeletedFromDish;

	@override
  String get invalidDishNameMessage => Crowdin.getText(localeName, 'invalidDishNameMessage') ?? _fallbackTexts.invalidDishNameMessage;

	@override
  String get invalidDishServingsAmountMessage => Crowdin.getText(localeName, 'invalidDishServingsAmountMessage') ?? _fallbackTexts.invalidDishServingsAmountMessage;

	@override
  String get invalidDishSelectedMealCategory => Crowdin.getText(localeName, 'invalidDishSelectedMealCategory') ?? _fallbackTexts.invalidDishSelectedMealCategory;

	@override
  String get invalidDishPortionsAmountMessage => Crowdin.getText(localeName, 'invalidDishPortionsAmountMessage') ?? _fallbackTexts.invalidDishPortionsAmountMessage;

	@override
  String get availableIn => Crowdin.getText(localeName, 'availableIn') ?? _fallbackTexts.availableIn;

	@override
  String get psychology => Crowdin.getText(localeName, 'psychology') ?? _fallbackTexts.psychology;

	@override
  String get medical => Crowdin.getText(localeName, 'medical') ?? _fallbackTexts.medical;

	@override
  String get community => Crowdin.getText(localeName, 'community') ?? _fallbackTexts.community;

	@override
  String get invalidCreateDishFromMealMessage => Crowdin.getText(localeName, 'invalidCreateDishFromMealMessage') ?? _fallbackTexts.invalidCreateDishFromMealMessage;

	@override
  String get readText => Crowdin.getText(localeName, 'readText') ?? _fallbackTexts.readText;

	@override
  String get backToToday => Crowdin.getText(localeName, 'backToToday') ?? _fallbackTexts.backToToday;

	@override
  String get backToEducation => Crowdin.getText(localeName, 'backToEducation') ?? _fallbackTexts.backToEducation;

	@override
  String get backToThePool => Crowdin.getText(localeName, 'backToThePool') ?? _fallbackTexts.backToThePool;

	@override
  String get completed => Crowdin.getText(localeName, 'completed') ?? _fallbackTexts.completed;

	@override
  String get complete => Crowdin.getText(localeName, 'complete') ?? _fallbackTexts.complete;

	@override
  String get todo => Crowdin.getText(localeName, 'todo') ?? _fallbackTexts.todo;

	@override
  String get done => Crowdin.getText(localeName, 'done') ?? _fallbackTexts.done;

	@override
  String get physicalActivity => Crowdin.getText(localeName, 'physicalActivity') ?? _fallbackTexts.physicalActivity;

	@override
  String get selectYourProgram => Crowdin.getText(localeName, 'selectYourProgram') ?? _fallbackTexts.selectYourProgram;

	@override
  String get selectExerciseType => Crowdin.getText(localeName, 'selectExerciseType') ?? _fallbackTexts.selectExerciseType;

	@override
  String get yourOwnActivity => Crowdin.getText(localeName, 'yourOwnActivity') ?? _fallbackTexts.yourOwnActivity;

	@override
	String countExercises(int count) => Crowdin.getText(localeName, 'countExercises', {'count':count}) ?? _fallbackTexts.countExercises(count);

	@override
  String get strength => Crowdin.getText(localeName, 'strength') ?? _fallbackTexts.strength;

	@override
  String get endurance => Crowdin.getText(localeName, 'endurance') ?? _fallbackTexts.endurance;

	@override
  String get mobility => Crowdin.getText(localeName, 'mobility') ?? _fallbackTexts.mobility;

	@override
  String get yourLocation => Crowdin.getText(localeName, 'yourLocation') ?? _fallbackTexts.yourLocation;

	@override
  String get home => Crowdin.getText(localeName, 'home') ?? _fallbackTexts.home;

	@override
  String get office => Crowdin.getText(localeName, 'office') ?? _fallbackTexts.office;

	@override
  String get outdoor => Crowdin.getText(localeName, 'outdoor') ?? _fallbackTexts.outdoor;

	@override
  String get desiredDifficulty => Crowdin.getText(localeName, 'desiredDifficulty') ?? _fallbackTexts.desiredDifficulty;

	@override
  String get easy => Crowdin.getText(localeName, 'easy') ?? _fallbackTexts.easy;

	@override
  String get medium => Crowdin.getText(localeName, 'medium') ?? _fallbackTexts.medium;

	@override
  String get hard => Crowdin.getText(localeName, 'hard') ?? _fallbackTexts.hard;

	@override
  String get logActivity => Crowdin.getText(localeName, 'logActivity') ?? _fallbackTexts.logActivity;

	@override
  String get whatPhysicalActivityDidYouDo => Crowdin.getText(localeName, 'whatPhysicalActivityDidYouDo') ?? _fallbackTexts.whatPhysicalActivityDidYouDo;

	@override
  String get errorActivityMessage => Crowdin.getText(localeName, 'errorActivityMessage') ?? _fallbackTexts.errorActivityMessage;

	@override
  String get strengthPrograms => Crowdin.getText(localeName, 'strengthPrograms') ?? _fallbackTexts.strengthPrograms;

	@override
  String get yourProfile => Crowdin.getText(localeName, 'yourProfile') ?? _fallbackTexts.yourProfile;

	@override
  String get reportAbuse => Crowdin.getText(localeName, 'reportAbuse') ?? _fallbackTexts.reportAbuse;

	@override
  String get inCaseOfEmergency => Crowdin.getText(localeName, 'inCaseOfEmergency') ?? _fallbackTexts.inCaseOfEmergency;

	@override
  String get personalDetails => Crowdin.getText(localeName, 'personalDetails') ?? _fallbackTexts.personalDetails;

	@override
  String get testResults => Crowdin.getText(localeName, 'testResults') ?? _fallbackTexts.testResults;

	@override
  String get preferences => Crowdin.getText(localeName, 'preferences') ?? _fallbackTexts.preferences;

	@override
  String get name => Crowdin.getText(localeName, 'name') ?? _fallbackTexts.name;

	@override
  String get email => Crowdin.getText(localeName, 'email') ?? _fallbackTexts.email;

	@override
  String get emailAddress => Crowdin.getText(localeName, 'emailAddress') ?? _fallbackTexts.emailAddress;

	@override
  String get changePassword => Crowdin.getText(localeName, 'changePassword') ?? _fallbackTexts.changePassword;

	@override
  String get useFaceOrTouchId => Crowdin.getText(localeName, 'useFaceOrTouchId') ?? _fallbackTexts.useFaceOrTouchId;

	@override
  String get requireLoginEachTime => Crowdin.getText(localeName, 'requireLoginEachTime') ?? _fallbackTexts.requireLoginEachTime;

	@override
  String get food => Crowdin.getText(localeName, 'food') ?? _fallbackTexts.food;

	@override
  String get group => Crowdin.getText(localeName, 'group') ?? _fallbackTexts.group;

	@override
  String get groupSessions => Crowdin.getText(localeName, 'groupSessions') ?? _fallbackTexts.groupSessions;

	@override
  String get foodPreferences => Crowdin.getText(localeName, 'foodPreferences') ?? _fallbackTexts.foodPreferences;

	@override
  String get dontEat => Crowdin.getText(localeName, 'dontEat') ?? _fallbackTexts.dontEat;

	@override
  String get dontLike => Crowdin.getText(localeName, 'dontLike') ?? _fallbackTexts.dontLike;

	@override
  String get howHard => Crowdin.getText(localeName, 'howHard') ?? _fallbackTexts.howHard;

	@override
  String get veryEasy => Crowdin.getText(localeName, 'veryEasy') ?? _fallbackTexts.veryEasy;

	@override
  String get veryHard => Crowdin.getText(localeName, 'veryHard') ?? _fallbackTexts.veryHard;

	@override
  String get rotateDevice => Crowdin.getText(localeName, 'rotateDevice') ?? _fallbackTexts.rotateDevice;

	@override
  String get skipExplanation => Crowdin.getText(localeName, 'skipExplanation') ?? _fallbackTexts.skipExplanation;

	@override
  String get repeat => Crowdin.getText(localeName, 'repeat') ?? _fallbackTexts.repeat;

	@override
	String exerciseCompleteMessage(String currentIndex, String length) => Crowdin.getText(localeName, 'exerciseCompleteMessage', {'currentIndex':currentIndex, 'length':length}) ?? _fallbackTexts.exerciseCompleteMessage(currentIndex, length);

	@override
  String get activitiesForThisWeek => Crowdin.getText(localeName, 'activitiesForThisWeek') ?? _fallbackTexts.activitiesForThisWeek;

	@override
  String get didYouLikeThisProgram => Crowdin.getText(localeName, 'didYouLikeThisProgram') ?? _fallbackTexts.didYouLikeThisProgram;

	@override
  String get backToTodayNotLogged => Crowdin.getText(localeName, 'backToTodayNotLogged') ?? _fallbackTexts.backToTodayNotLogged;

	@override
  String get notReally => Crowdin.getText(localeName, 'notReally') ?? _fallbackTexts.notReally;

	@override
  String get yesYes => Crowdin.getText(localeName, 'yesYes') ?? _fallbackTexts.yesYes;

	@override
  String get recommended => Crowdin.getText(localeName, 'recommended') ?? _fallbackTexts.recommended;

	@override
  String get alternatives => Crowdin.getText(localeName, 'alternatives') ?? _fallbackTexts.alternatives;

	@override
	String equipment(String equipment) => Crowdin.getText(localeName, 'equipment', {'equipment':equipment}) ?? _fallbackTexts.equipment(equipment);

	@override
	String targetMuscles(String targetMuscles) => Crowdin.getText(localeName, 'targetMuscles', {'targetMuscles':targetMuscles}) ?? _fallbackTexts.targetMuscles(targetMuscles);

	@override
  String get breakBetweenExercises => Crowdin.getText(localeName, 'breakBetweenExercises') ?? _fallbackTexts.breakBetweenExercises;

	@override
  String get inProgress => Crowdin.getText(localeName, 'inProgress') ?? _fallbackTexts.inProgress;

	@override
	String logAs(String mealCategory) => Crowdin.getText(localeName, 'logAs', {'mealCategory':mealCategory}) ?? _fallbackTexts.logAs(mealCategory);

	@override
  String get skip => Crowdin.getText(localeName, 'skip') ?? _fallbackTexts.skip;

	@override
  String get plannedMeals => Crowdin.getText(localeName, 'plannedMeals') ?? _fallbackTexts.plannedMeals;

	@override
  String get loggedMeals => Crowdin.getText(localeName, 'loggedMeals') ?? _fallbackTexts.loggedMeals;

	@override
  String get hey => Crowdin.getText(localeName, 'hey') ?? _fallbackTexts.hey;

	@override
  String get cancelled => Crowdin.getText(localeName, 'cancelled') ?? _fallbackTexts.cancelled;

	@override
  String get cancel => Crowdin.getText(localeName, 'cancel') ?? _fallbackTexts.cancel;

	@override
  String get missed => Crowdin.getText(localeName, 'missed') ?? _fallbackTexts.missed;

	@override
  String get saved => Crowdin.getText(localeName, 'saved') ?? _fallbackTexts.saved;

	@override
  String get notEnrolledInGroup => Crowdin.getText(localeName, 'notEnrolledInGroup') ?? _fallbackTexts.notEnrolledInGroup;

	@override
  String get supportGroupPaidSubscriptionNotGrouped => Crowdin.getText(localeName, 'supportGroupPaidSubscriptionNotGrouped') ?? _fallbackTexts.supportGroupPaidSubscriptionNotGrouped;

	@override
  String get supportGroupTrialSubscriptionNotGrouped => Crowdin.getText(localeName, 'supportGroupTrialSubscriptionNotGrouped') ?? _fallbackTexts.supportGroupTrialSubscriptionNotGrouped;

	@override
  String get updateRequired => Crowdin.getText(localeName, 'updateRequired') ?? _fallbackTexts.updateRequired;

	@override
  String get updateRequiredBodyText1 => Crowdin.getText(localeName, 'updateRequiredBodyText1') ?? _fallbackTexts.updateRequiredBodyText1;

	@override
  String get updateRequiredBodyText2 => Crowdin.getText(localeName, 'updateRequiredBodyText2') ?? _fallbackTexts.updateRequiredBodyText2;

	@override
  String get updatePoliciesDocuments => Crowdin.getText(localeName, 'updatePoliciesDocuments') ?? _fallbackTexts.updatePoliciesDocuments;

	@override
  String get updatePoliciesDocumentsBodyText1 => Crowdin.getText(localeName, 'updatePoliciesDocumentsBodyText1') ?? _fallbackTexts.updatePoliciesDocumentsBodyText1;

	@override
  String get updatePoliciesDocumentsBodyText2 => Crowdin.getText(localeName, 'updatePoliciesDocumentsBodyText2') ?? _fallbackTexts.updatePoliciesDocumentsBodyText2;

	@override
  String get nextWeekTopic => Crowdin.getText(localeName, 'nextWeekTopic') ?? _fallbackTexts.nextWeekTopic;

	@override
  String get registrationCodePlaceholder => Crowdin.getText(localeName, 'registrationCodePlaceholder') ?? _fallbackTexts.registrationCodePlaceholder;

	@override
  String get registrationCodeTitle => Crowdin.getText(localeName, 'registrationCodeTitle') ?? _fallbackTexts.registrationCodeTitle;

	@override
  String get registrationCodeLabel => Crowdin.getText(localeName, 'registrationCodeLabel') ?? _fallbackTexts.registrationCodeLabel;

	@override
  String get checkAccessCode => Crowdin.getText(localeName, 'checkAccessCode') ?? _fallbackTexts.checkAccessCode;

	@override
  String get noAccessCodeYet => Crowdin.getText(localeName, 'noAccessCodeYet') ?? _fallbackTexts.noAccessCodeYet;

	@override
  String get physicalActivitiesPreferencesLabel => Crowdin.getText(localeName, 'physicalActivitiesPreferencesLabel') ?? _fallbackTexts.physicalActivitiesPreferencesLabel;

	@override
  String get requestCode => Crowdin.getText(localeName, 'requestCode') ?? _fallbackTexts.requestCode;

	@override
  String get calorie => Crowdin.getText(localeName, 'calorie') ?? _fallbackTexts.calorie;

	@override
  String get dencity => Crowdin.getText(localeName, 'dencity') ?? _fallbackTexts.dencity;

	@override
  String get protein => Crowdin.getText(localeName, 'protein') ?? _fallbackTexts.protein;

	@override
  String get degree => Crowdin.getText(localeName, 'degree') ?? _fallbackTexts.degree;

	@override
  String get fiber => Crowdin.getText(localeName, 'fiber') ?? _fallbackTexts.fiber;

	@override
  String get dailyCalorieBudget => Crowdin.getText(localeName, 'dailyCalorieBudget') ?? _fallbackTexts.dailyCalorieBudget;

	@override
  String get dailyCalorieBudgetDescription => Crowdin.getText(localeName, 'dailyCalorieBudgetDescription') ?? _fallbackTexts.dailyCalorieBudgetDescription;

	@override
  String get dailyCalorieBudgetLink => Crowdin.getText(localeName, 'dailyCalorieBudgetLink') ?? _fallbackTexts.dailyCalorieBudgetLink;

	@override
  String get calorieDensityHighQualityDescription => Crowdin.getText(localeName, 'calorieDensityHighQualityDescription') ?? _fallbackTexts.calorieDensityHighQualityDescription;

	@override
  String get calorieDensityHighQualityLabel => Crowdin.getText(localeName, 'calorieDensityHighQualityLabel') ?? _fallbackTexts.calorieDensityHighQualityLabel;

	@override
  String get calorieDensityMidQualityDescription => Crowdin.getText(localeName, 'calorieDensityMidQualityDescription') ?? _fallbackTexts.calorieDensityMidQualityDescription;

	@override
  String get calorieDensityMidQualityLabel => Crowdin.getText(localeName, 'calorieDensityMidQualityLabel') ?? _fallbackTexts.calorieDensityMidQualityLabel;

	@override
  String get calorieDensityLowQualityDescription => Crowdin.getText(localeName, 'calorieDensityLowQualityDescription') ?? _fallbackTexts.calorieDensityLowQualityDescription;

	@override
  String get calorieDensityLowQualityLabel => Crowdin.getText(localeName, 'calorieDensityLowQualityLabel') ?? _fallbackTexts.calorieDensityLowQualityLabel;

	@override
  String get proteinDegreeLowQualityDescription => Crowdin.getText(localeName, 'proteinDegreeLowQualityDescription') ?? _fallbackTexts.proteinDegreeLowQualityDescription;

	@override
  String get proteinDegreeLowQualityLabel => Crowdin.getText(localeName, 'proteinDegreeLowQualityLabel') ?? _fallbackTexts.proteinDegreeLowQualityLabel;

	@override
  String get proteinDegreeLowMidQualityDescription => Crowdin.getText(localeName, 'proteinDegreeLowMidQualityDescription') ?? _fallbackTexts.proteinDegreeLowMidQualityDescription;

	@override
  String get proteinDegreeLowMidQualityLabel => Crowdin.getText(localeName, 'proteinDegreeLowMidQualityLabel') ?? _fallbackTexts.proteinDegreeLowMidQualityLabel;

	@override
  String get proteinDegreeMidQualityDescription => Crowdin.getText(localeName, 'proteinDegreeMidQualityDescription') ?? _fallbackTexts.proteinDegreeMidQualityDescription;

	@override
  String get proteinDegreeMidQualityLabel => Crowdin.getText(localeName, 'proteinDegreeMidQualityLabel') ?? _fallbackTexts.proteinDegreeMidQualityLabel;

	@override
  String get proteinDegreeHighQualityDescription => Crowdin.getText(localeName, 'proteinDegreeHighQualityDescription') ?? _fallbackTexts.proteinDegreeHighQualityDescription;

	@override
  String get proteinDegreeHighQualityLabel => Crowdin.getText(localeName, 'proteinDegreeHighQualityLabel') ?? _fallbackTexts.proteinDegreeHighQualityLabel;

	@override
  String get fiberHighQualityLabel => Crowdin.getText(localeName, 'fiberHighQualityLabel') ?? _fallbackTexts.fiberHighQualityLabel;

	@override
  String get fiberMidQualityLabel => Crowdin.getText(localeName, 'fiberMidQualityLabel') ?? _fallbackTexts.fiberMidQualityLabel;

	@override
  String get fiberLowQualityLabel => Crowdin.getText(localeName, 'fiberLowQualityLabel') ?? _fallbackTexts.fiberLowQualityLabel;

	@override
  String get notSignificant => Crowdin.getText(localeName, 'notSignificant') ?? _fallbackTexts.notSignificant;

	@override
  String get insignificant => Crowdin.getText(localeName, 'insignificant') ?? _fallbackTexts.insignificant;

	@override
  String get practice => Crowdin.getText(localeName, 'practice') ?? _fallbackTexts.practice;

	@override
  String get pool => Crowdin.getText(localeName, 'pool') ?? _fallbackTexts.pool;

	@override
  String get mindDashboardTitle => Crowdin.getText(localeName, 'mindDashboardTitle') ?? _fallbackTexts.mindDashboardTitle;

	@override
  String get mindDashboardBtn => Crowdin.getText(localeName, 'mindDashboardBtn') ?? _fallbackTexts.mindDashboardBtn;

	@override
  String get maintenanceLabel => Crowdin.getText(localeName, 'maintenanceLabel') ?? _fallbackTexts.maintenanceLabel;

	@override
  String get maintenancePageTitle => Crowdin.getText(localeName, 'maintenancePageTitle') ?? _fallbackTexts.maintenancePageTitle;

	@override
  String get maintenancePageDescription => Crowdin.getText(localeName, 'maintenancePageDescription') ?? _fallbackTexts.maintenancePageDescription;

	@override
  String get noAlternativesAvailable => Crowdin.getText(localeName, 'noAlternativesAvailable') ?? _fallbackTexts.noAlternativesAvailable;

	@override
  String get chooseAlternative => Crowdin.getText(localeName, 'chooseAlternative') ?? _fallbackTexts.chooseAlternative;

}

class _CrowdinLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _CrowdinLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.delegate.load(locale)
          .then((fallback) => CrowdinLocalization(locale.toString(), fallback));

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.contains(locale);

  @override
  bool shouldReload(_CrowdinLocalizationsDelegate old) => false;
}
