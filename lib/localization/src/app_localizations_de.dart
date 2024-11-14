import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

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
  String get errorValidationIosMinVersionNotANumber => 'iOS-Mindestversion muss eine Zahl sein.';

  @override
  String get errorValidationIosMinVersionNotAnInteger => 'Die iOS-Mindestversion muss eine ganze Zahl sein.';

  @override
  String get errorValidationIosMinVersionNotAPositiveNumber => 'Die iOS-Mindestversion muss eine positive Zahl sein.';

  @override
  String get errorValidationAndroidMinVersionNotANumber => 'Die Android-Mindestversion muss eine Zahl sein.';

  @override
  String get errorValidationAndroidMinVersionNotAnInteger => 'Die Android-Mindestversion muss eine ganze Zahl sein.';

  @override
  String get errorValidationAndroidMinVersionNotAPositiveNumber => 'Die Android-Mindestversion muss eine positive Zahl sein.';

  @override
  String get errorValidationTermsAndConditionsVersionNotANumber => 'Die Version der Allgemeinen Geschäftsbedingungen muss eine Zahl sein.';

  @override
  String get errorValidationTermsAndConditionsVersionNotAnInteger => 'Die Version der Geschäftsbedingungen muss eine ganze Zahl sein.';

  @override
  String get errorValidationTermsAndConditionsVersionNotAPositiveNumber => 'Die Version der Allgemeinen Geschäftsbedingungen muss eine positive Zahl sein.';

  @override
  String get errorValidationPrivacyPolicyVersionNotANumber => 'Die Version der Datenschutzrichtlinie muss eine Zahl sein.';

  @override
  String get errorValidationPrivacyPolicyVersionNotAnInteger => 'Die Version der Datenschutzrichtlinie muss eine ganze Zahl sein.';

  @override
  String get errorValidationPrivacyPolicyVersionNotAPositiveNumber => 'Die Version der Datenschutzrichtlinie muss eine positive Zahl sein.';

  @override
  String get errorValidationRefreshTokenNotAJwt => 'Das Refresh-Token muss ein gültiges JWT sein.';

  @override
  String get errorValidationVersionEmpty => 'Version kann nicht leer sein.';

  @override
  String get errorValidationVersionNotAString => 'Version muss ein String sein.';

  @override
  String get errorValidationNotificationTypeInvalidEnum => 'Der Benachrichtigungstyp ist ungültig.';

  @override
  String get errorValidationPurchaseTokenEmpty => 'Das Kauf-Token kann nicht leer sein.';

  @override
  String get errorValidationPurchaseTokenNotAString => 'Der Einkaufstoken muss ein String sein.';

  @override
  String get errorValidationSubscriptionIdEmpty => 'Die Abonnement-ID kann nicht leer sein.';

  @override
  String get errorValidationSubscriptionIdNotAString => 'Die Abonnement-ID muss ein String sein.';

  @override
  String get errorValidationPackageNameEmpty => 'Der Paketname darf nicht leer sein.';

  @override
  String get errorValidationPackageNameNotAString => 'Etwas ist schief gelaufen! Bitte kontaktiere den Support und füge \"Paketname muss ein String sein\" hinzu.';

  @override
  String get errorValidationEventTimeMillisNotANumberString => 'Das Event muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationSubscriptionNotificationEmptyObject => 'Die Abo-Benachrichtigung kann kein leeres Objekt sein.';

  @override
  String get errorValidationFilenameStringTooShort => 'Dateiname ist zu kurz.';

  @override
  String get errorValidationFilenameNotAString => 'Place must be a string.';

  @override
  String get errorValidationFilenameEmpty => 'Der Dateiname darf nicht leer sein.';

  @override
  String get errorValidationMimetypeInvalidEnum => 'Der MIME-Typ ist ungültig.';

  @override
  String get errorValidationMimetypeNotAString => 'Der MIME-Typ muss ein String sein.';

  @override
  String get errorValidationMimetypeEmpty => 'Der MIME-Typ kann nicht leer sein.';

  @override
  String get errorValidationFieldnameInvalidEnum => 'Der Feldname ist ungültig.';

  @override
  String get errorValidationFieldnameEmpty => 'Der Feldname darf nicht leer sein.';

  @override
  String get errorValidationFieldnameNotAString => 'Der Feldname muss ein String sein.';

  @override
  String get errorValidationPasswordPasswordTooWeak => 'Wir konnten deine E-Mail-Adresse nicht aktualisieren. Bitte überprüfe deine Anmeldedaten und versuche es erneut';

  @override
  String get errorValidationPasswordEmpty => 'Passwort kann nicht leer sein.';

  @override
  String get errorValidationPasswordNotAString => 'Passwort muss ein String sein.';

  @override
  String get errorValidationEmailStringTooLong => 'E-Mail ist zu lang.';

  @override
  String get errorValidationEmailStringTooShort => 'E-Mail ist zu kurz.';

  @override
  String get errorValidationEmailInvalidEmail => 'E-Mail ist ungültig.';

  @override
  String get errorValidationEmailNotAString => 'E-Mail muss ein String sein.';

  @override
  String get errorValidationNameStringTooLong => 'Name ist zu lang.';

  @override
  String get errorValidationNameStringTooShort => 'Name ist zu kurz.';

  @override
  String get errorValidationNameEmpty => 'Der Name darf nicht leer sein.';

  @override
  String get errorValidationNameNotAString => 'Der Name muss eine String sein.';

  @override
  String get errorValidationInvitationTokenEmpty => 'Das Kauf-Token kann nicht leer sein.';

  @override
  String get errorValidationInvitationTokenNotAString => 'Das Einladungs-Token muss ein String sein.';

  @override
  String get errorValidationInvitationTokenNotAJwt => 'Das Einladungs-Token muss ein gültiges JWT sein.';

  @override
  String get errorValidationNumberOfUnitsEmpty => 'Die Anzahl der Einheiten kann nicht leer sein.';

  @override
  String get errorValidationNumberOfUnitsNotANumber => 'Die Anzahl der Einheiten muss eine Zahl sein.';

  @override
  String get errorValidationNumberOfUnitsNotAPositiveNumber => 'Die Anzahl der Einheiten muss eine positive Zahl sein.';

  @override
  String get errorValidationNumberOfUnitsNumberTooBig => 'Die Anzahl der Einheiten ist zu groß.';

  @override
  String get errorValidationNumberOfUnitsNumberTooSmall => 'Die Anzahl der Einheiten ist zu gering.';

  @override
  String get errorValidationFoodItemIdEmpty => 'Die ID eines Lebensmittels kann nicht leer sein.';

  @override
  String get errorValidationFoodItemIdNotANumberString => 'Die ID eines Lebensmittels muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationServingIdEmpty => 'Die Serving ID kann nicht leer sein.';

  @override
  String get errorValidationServingIdNotANumberString => 'Die Serving ID muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationMealCategoriesEmpty => 'Mahlzeitenkategorien können nicht leer sein.';

  @override
  String get errorValidationMealCategoriesNotAnArray => 'Die Mahlzeitenkategorien müssen ein Array sein.';

  @override
  String get errorValidationMealCategoriesEmptyArray => 'Mahlzeitenkategorien können kein leeres Array sein.';

  @override
  String get errorValidationMealCategoriesInvalidEnum => 'Die Mahlzeitenkategorien enthalten einen ungültigen Wert.';

  @override
  String get errorValidationNicknameEmpty => 'Der Spitzname kann nicht leer sein.';

  @override
  String get errorValidationNicknameNotAString => 'Spitzname muss ein String sein.';

  @override
  String get errorValidationNicknameStringTooLong => 'Spritzname ist zu lang.';

  @override
  String get errorValidationNicknameStringTooShort => 'Spritzname ist zu kurz.';

  @override
  String get errorValidationGenderPreferenceEmpty => 'Die Geschlechtspräferenz kann nicht leer sein.';

  @override
  String get errorValidationGenderPreferenceInvalidEnum => 'Die Geschlechtspräferenz ist ungültig.';

  @override
  String get errorValidationTimezoneEmpty => 'Die Zeitzone kann nicht leer sein.';

  @override
  String get errorValidationTimezoneNotAString => 'Die Zeitzone muss ein String sein.';

  @override
  String get errorValidationRulesAcceptedNotABoolean => 'Akzeptierte Regeln müssen boolesch sein.';

  @override
  String get errorValidationMealIdEmpty => 'Die Mahlzeiten-ID kann nicht leer sein.';

  @override
  String get errorValidationMealIdNotANumber => 'Die Mahlzeiten-ID muss eine Zahl sein.';

  @override
  String get errorValidationMealIdNotAnInteger => 'Die Mahlzeiten-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationMealIdNotAPositiveNumber => 'Die Mahlzeiten-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationMealRecipeIdEmpty => 'Die Rezept-ID der Mahlzeit kann nicht leer sein.';

  @override
  String get errorValidationMealRecipeIdNotANumber => 'Die Rezept-ID der Mahlzeit muss eine Zahl sein.';

  @override
  String get errorValidationMealRecipeIdNotAnInteger => 'Die Rezept-ID der Mahlzeit muss eine ganze Zahl sein.';

  @override
  String get errorValidationMealRecipeIdNotAPositiveNumber => 'Die Rezept-ID der Mahlzeit muss eine positive Zahl sein.';

  @override
  String get errorValidationTypeInvalidEnum => 'Der Typ ist ungültig.';

  @override
  String get errorValidationMealCategoryInvalidEnum => 'Die Mahlzeitenkategorie ist ungültig.';

  @override
  String get errorValidationStartDateNotAString => 'Das Startdatum muss ein String sein.';

  @override
  String get errorValidationStartDateNotADateString => 'Das Startdatum muss ein gültiger Datumsstring sein.';

  @override
  String get errorValidationEndDateNotAString => 'Das Enddatum muss ein String sein.';

  @override
  String get errorValidationEndDateNotADateString => 'Das Enddatum muss ein gültiger Datumsstring sein.';

  @override
  String get errorValidationPregnantEmpty => 'Das Feld Schwangere kann nicht leer sein.';

  @override
  String get errorValidationPregnantNotABoolean => 'Das Feld Pregnant muss ein Boolean sein.';

  @override
  String get errorValidationMedicinesNotAnArray => 'Medikamente müssen ein Array sein.';

  @override
  String get errorValidationMedicinesEmptyArray => 'Medikamente können kein leeres Array sein.';

  @override
  String get errorValidationUseSemaglutideMedicationNotAString => 'Die Verwendung des Medikaments Semaglutid muss ein String sein.';

  @override
  String get errorValidationHowLongTakeSemaglutideMedicationNotAString => 'Die Dauer der Einnahme von Semaglutid-Medikamenten muss ein String sein.';

  @override
  String get errorValidationHowLongSemaglutideTreatmentLastNotAString => 'Die Dauer der Semaglutid-Behandlung muss ein String sein.';

  @override
  String get errorValidationIsUseSemaglutideMedicationNotABoolean => 'Die Verwendung des Medikaments Semaglutid muss ein Boolescher Wert sein.';

  @override
  String get errorValidationObesityNotABoolean => 'Das Feld Adipositas muss ein Boolescher Wert sein.';

  @override
  String get errorValidationObesityEmpty => 'Das Feld Adipositas kann nicht leer sein.';

  @override
  String get errorValidationThyroidDiseaseEmpty => 'Das Feld Schilddrüsenerkrankung darf nicht leer sein.';

  @override
  String get errorValidationThyroidDiseaseNotABoolean => 'Das Feld Schilddrüsenerkrankung muss ein Boolescher Wert sein.';

  @override
  String get errorValidationMetabolicDiseaseEmpty => 'Das Feld für die Stoffwechselkrankheit darf nicht leer sein.';

  @override
  String get errorValidationMetabolicDiseaseNotABoolean => 'Das Feld Stoffwechselkrankheit muss ein Boolescher Wert sein.';

  @override
  String get errorValidationHypertensionEmpty => 'Das Feld Bluthochdruck kann nicht leer sein.';

  @override
  String get errorValidationHypertensionNotABoolean => 'Das Feld Bluthochdruck muss ein boolescher Wert sein.';

  @override
  String get errorValidationCardiovascularDiseaseEmpty => 'Das Feld für die kardiovaskuläre Krankheit darf nicht leer sein.';

  @override
  String get errorValidationCardiovascularDiseaseNotABoolean => 'Das Feld für die kardiovaskuläre Erkrankung muss ein Boolescher Wert sein.';

  @override
  String get errorValidationStomachReductionEmpty => 'Das Feld für die Magenverkleinerung kann nicht leer sein.';

  @override
  String get errorValidationStomachReductionNotABoolean => 'Das Feld für die Magenverkleinerung muss ein boolescher Wert sein.';

  @override
  String get errorValidationDiabetesEmpty => 'Das Feld Diabetes kann nicht leer sein.';

  @override
  String get errorValidationDiabetesNotAString => 'Das Feld Diabetes muss ein String sein.';

  @override
  String get errorValidationRenalFailureEmpty => 'Das Feld Nierenversagen kann nicht leer sein.';

  @override
  String get errorValidationRenalFailureNotABoolean => 'Das Feld Nierenversagen muss ein Boolescher Wert sein.';

  @override
  String get errorValidationAsthmaEmpty => 'Das Feld Asthma kann nicht leer sein.';

  @override
  String get errorValidationAsthmaNotABoolean => 'Das Feld Asthma muss boolesch sein.';

  @override
  String get errorValidationLiverDiseaseEmpty => 'Das Feld Lebererkrankung kann nicht leer sein.';

  @override
  String get errorValidationLiverDiseaseNotABoolean => 'Das Feld Lebererkrankung muss ein Boolescher Wert sein.';

  @override
  String get errorValidationSleepApneaSyndromeEmpty => 'Das Feld Schlafapnoe-Syndrom kann nicht leer sein.';

  @override
  String get errorValidationSleepApneaSyndromeNotABoolean => 'Das Feld Schlafapnoe-Syndrom muss ein Boolescher Wert sein.';

  @override
  String get errorValidationLocomotorSystemDiseaseEmpty => 'Das Feld Krankheit des Bewegungsapparates darf nicht leer sein.';

  @override
  String get errorValidationLocomotorSystemDiseaseNotABoolean => 'Das Feld für die Erkrankung des Bewegungsapparats muss ein Boolescher Wert sein.';

  @override
  String get errorValidationTreatedByPsychiatristEmpty => 'Das Feld Behandelt von einem Psychiater darf nicht leer sein.';

  @override
  String get errorValidationTreatedByPsychiatristNotABoolean => 'Das Feld Behandelt vom Psychiater muss ein Boolescher Wert sein.';

  @override
  String get errorValidationItemStateNotFromDefinedList => 'Der Elementstatus muss aus der definierten Liste stammen.';

  @override
  String get errorValidationItemStateNotAString => 'Der Elementstatus muss ein String sein.';

  @override
  String get errorValidationHatesEmpty => 'Das Feld Hates darf nicht leer sein.';

  @override
  String get errorValidationHatesNotAnArray => 'Das Feld Hates muss ein Array sein.';

  @override
  String get errorValidationHatesNotANumber => 'Das Feld Hates muss eine Zahl sein.';

  @override
  String get errorValidationHatesNotAnInteger => 'Das Feld Hates muss eine ganze Zahl sein.';

  @override
  String get errorValidationHatesNotAPositiveNumber => 'Das Feld Hates muss eine positive Zahl sein.';

  @override
  String get errorValidationAllergicEmpty => 'Das Feld Allergiker kann nicht leer sein.';

  @override
  String get errorValidationAllergicNotAnArray => 'Das Feld Allergisch muss ein Array sein.';

  @override
  String get errorValidationAllergicNotANumber => 'Das Feld Allergiker muss eine Zahl sein.';

  @override
  String get errorValidationAllergicNotAnInteger => 'Das Feld Allergisch muss eine ganze Zahl sein.';

  @override
  String get errorValidationAllergicNotAPositiveNumber => 'Das Feld Allergiker muss eine positive Zahl sein.';

  @override
  String get errorValidationDislikeEmpty => 'Das Dislike-Feld kann nicht leer sein.';

  @override
  String get errorValidationDislikeNotAnArray => 'Das Dislike-Feld muss ein Array sein.';

  @override
  String get errorValidationDislikeNotANumber => 'Das Dislike-Feld muss eine Zahl sein.';

  @override
  String get errorValidationDislikeNotAnInteger => 'Das Dislike-Feld muss eine ganze Zahl sein.';

  @override
  String get errorValidationDislikeNotAPositiveNumber => 'Das Dislike-Feld muss eine positive Zahl sein.';

  @override
  String get errorValidationQuestionIdEmpty => 'Die Frage-ID darf nicht leer sein.';

  @override
  String get errorValidationQuestionIdNotANumber => 'Die Frage-ID muss eine Zahl sein.';

  @override
  String get errorValidationQuestionIdNotAnInteger => 'Die Frage-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationQuestionIdNotAPositiveNumber => 'Die Frage-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationOptionIdEmpty => 'Die Options-ID kann nicht leer sein.';

  @override
  String get errorValidationOptionIdNotANumber => 'Die Options-ID muss eine Zahl sein.';

  @override
  String get errorValidationOptionIdNotAnInteger => 'Die Options-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationOptionIdNotAPositiveNumber => 'Die Options-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationAnswersEmpty => 'Das Feld Antworten kann nicht leer sein.';

  @override
  String get errorValidationAnswersNotAnArray => 'Das Feld Antworten muss ein Array sein.';

  @override
  String get errorValidationAnswersEmptyArray => 'Das Feld Antworten kann kein leeres Array sein.';

  @override
  String get errorValidationIsConsentApprovedEmpty => 'Das Feld ConsentApproved darf nicht leer sein.';

  @override
  String get errorValidationIsConsentApprovedNotABoolean => 'Das Feld ConsentApproved muss ein Boolescher Wert sein.';

  @override
  String get errorValidationIsLegalApprovedEmpty => 'Das Feld LegalApproved darf nicht leer sein.';

  @override
  String get errorValidationIsLegalApprovedNotABoolean => 'Das Feld Legal approved muss ein boolescher Wert sein.';

  @override
  String get errorValidationHeightEmpty => 'Das Feld Größe kann nicht leer sein.';

  @override
  String get errorValidationHeightNotANumber => 'Das Feld Größe muss eine Zahl sein.';

  @override
  String get errorValidationHeightNumberTooBig => 'Das Größefeld ist zu groß.';

  @override
  String get errorValidationHeightNumberTooSmall => 'Das Größenfeld ist zu klein.';

  @override
  String get errorValidationBirthDateEmpty => 'Das Geburtsdatum kann nicht leer sein.';

  @override
  String get errorValidationBirthDateNotADateString => 'Das Geburtsdatum muss eine gültige Datumszeichenfolge sein.';

  @override
  String get errorValidationWeightEmpty => 'Das Feld Gewicht kann nicht leer sein.';

  @override
  String get errorValidationWeightNotANumber => 'Das Gewichtsfeld muss eine Zahl sein.';

  @override
  String get errorValidationWeightNotAPositiveNumber => 'Das Gewichtsfeld muss eine positive Zahl sein.';

  @override
  String get errorValidationBmiEmpty => 'Das BMI-Feld kann nicht leer sein.';

  @override
  String get errorValidationBmiNotANumber => 'Das BMI-Feld muss eine Zahl sein.';

  @override
  String get errorValidationBmiNotAPositiveNumber => 'Das BMI-Feld muss eine positive Zahl sein.';

  @override
  String get errorValidationGenderEmpty => 'Das Feld Geschlecht kann nicht leer sein.';

  @override
  String get errorValidationGenderNotAString => 'Das Feld Geschlecht muss ein String sein.';

  @override
  String get errorValidationGenderInvalidEnum => 'Das Feld Geschlecht ist ungültig.';

  @override
  String get errorValidationSexEmpty => 'Das Feld Geschlecht kann nicht leer sein.';

  @override
  String get errorValidationSexNotAString => 'Das Feld Geschlecht muss ein String sein.';

  @override
  String get errorValidationSexInvalidEnum => 'Das Feld Geschlecht ist ungültig.';

  @override
  String get errorValidationHappinessEmpty => 'Das Feld Happiness kann nicht leer sein.';

  @override
  String get errorValidationHappinessInvalidEnum => 'Das Feld Happiness ist ungültig.';

  @override
  String get errorValidationMentalHealthTestEmptyObject => 'Das Testfeld für psychische Gesundheit kann kein leeres Objekt sein.';

  @override
  String get errorValidationMedicalOnboardingEmptyObject => 'Das Feld Medizinisches Onboarding kann kein leeres Objekt sein.';

  @override
  String get errorValidationCustomerIoIdEmpty => 'Die Kunden-IO-ID kann nicht leer sein.';

  @override
  String get errorValidationCustomerIoIdNotAString => 'Die Kunden-IO-ID muss ein String sein.';

  @override
  String get errorValidationNameLettersAndNumbersRequired => 'Der Name muss Buchstaben und Zahlen enthalten.';

  @override
  String get errorValidationBucketStringTooShort => 'Der Bucket String ist zu kurz.';

  @override
  String get errorValidationBucketLettersAndNumbersRequired => 'Bucket muss Buchstaben und Zahlen enthalten.';

  @override
  String get errorValidationBucketEmpty => 'Das Feld Bucket kann nicht leer sein.';

  @override
  String get errorValidationBucketNotAString => 'Das Bucket-Feld muss ein String sein.';

  @override
  String get errorValidationDistributionUrlNotUrlAddress => 'Die Verteilungs-URL muss eine gültige URL-Adresse sein.';

  @override
  String get errorValidationDistributionUrlEmpty => 'Die Verteilungs-URL kann nicht leer sein.';

  @override
  String get errorValidationDistributionUrlNotAString => 'Die Verteilungs-URL muss ein String sein.';

  @override
  String get errorValidationTypeNotAString => 'Das Typfeld muss ein String sein.';

  @override
  String get errorValidationAccountIdEmpty => 'Die Account-ID kann nicht leer sein.';

  @override
  String get errorValidationAccountIdNotANumber => 'Die Account-ID muss eine Zahl sein.';

  @override
  String get errorValidationAccountIdNotAnInteger => 'Die Account-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationAccountIdNotAPositiveNumber => 'Die Account-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationProductIdEmpty => 'Die Produkt-ID darf nicht leer sein.';

  @override
  String get errorValidationProductIdNotANumber => 'Die Produkt-ID muss eine Zahl sein.';

  @override
  String get errorValidationProductIdNotAnInteger => 'Die Produkt-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationProductIdNotAPositiveNumber => 'Die Produkt-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationStateInvalidEnum => 'Das Statusfeld ist ungültig.';

  @override
  String get errorValidationExpiresAtEmpty => 'Das Verfallsdatum darf nicht leer sein.';

  @override
  String get errorValidationExpiresAtNotADate => 'Das Verfallsdatum muss ein gültiges Datum sein.';

  @override
  String get errorValidationCreatedAtEmpty => 'Das Erstellungsdatum darf nicht leer sein.';

  @override
  String get errorValidationCreatedAtNotADate => 'Das Erstellungsdatum muss ein gültiges Datum sein.';

  @override
  String get errorValidationReceiptEmpty => 'Das Quittungsfeld kann nicht leer sein.';

  @override
  String get errorValidationReceiptNotAString => 'Das Quittungsfeld muss ein String sein.';

  @override
  String get errorValidationTransactionIdEmpty => 'Die Transaktions-ID darf nicht leer sein.';

  @override
  String get errorValidationTransactionIdNotANumberString => 'Die Transaktions-ID muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationBaseTransactionIdEmpty => 'Die ID der Basistransaktion kann nicht leer sein.';

  @override
  String get errorValidationBaseTransactionIdNotANumberString => 'Die ID der Basistransaktion muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationLinkedPurchaseTokenEmpty => 'Das verknüpfte Kauf-Token kann nicht leer sein.';

  @override
  String get errorValidationLinkedPurchaseTokenNotAString => 'Linked Purchase Token muss ein String sein.';

  @override
  String get errorValidationDataEmptyObject => 'Die Daten können kein leeres Objekt sein.';

  @override
  String get errorValidationSignedPayloadNotAJwt => 'Signierte Nutzdaten müssen ein gültiges JWT sein.';

  @override
  String get errorValidationSignedPayloadEmpty => 'Signed Payload kann nicht leer sein.';

  @override
  String get errorValidationMessageIdEmpty => 'Die Nachrichten-ID darf nicht leer sein.';

  @override
  String get errorValidationMessageIdNotANumberString => 'Die Nachrichten-ID muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationDataEmpty => 'Daten können nicht leer sein.';

  @override
  String get errorValidationDataNotBase64Encoded => 'Die Daten müssen base64 kodiert sein.';

  @override
  String get errorValidationDataNotAString => 'Daten müssen eine Zeichenkette sein.';

  @override
  String get errorValidationMessageEmptyObject => 'Die Nachricht kann kein leeres Objekt sein.';

  @override
  String get errorValidationSubscriptionEmpty => 'Das Abonnement kann nicht leer sein.';

  @override
  String get errorValidationSubscriptionNotAString => 'Das Abonnement muss ein String sein.';

  @override
  String get errorValidationProductIdNotAString => 'Die Produkt-ID muss ein String sein.';

  @override
  String get errorValidationOfferIdEmpty => 'Die Angebots-ID kann nicht leer sein.';

  @override
  String get errorValidationOfferIdNotAString => 'Die Angebots-ID muss ein String sein.';

  @override
  String get errorValidationAccountTokenEmpty => 'Das Konto-Token kann nicht leer sein.';

  @override
  String get errorValidationAccountTokenNotAString => 'Das Kontotoken muss ein String sein.';

  @override
  String get errorValidationAccountTokenNotUuidV4 => 'Das Konto-Token muss eine gültige UUID v4 sein.';

  @override
  String get errorValidationVendorInvalidEnum => 'Der Verkäufer ist ungültig.';

  @override
  String get errorValidationLiveTogetherEmpty => 'Das Feld \"Zusammenleben\" kann nicht leer sein.';

  @override
  String get errorValidationLiveTogetherNotABoolean => 'Das Feld \"Zusammenleben\" muss ein boolescher Wert sein.';

  @override
  String get errorValidationRelationEmpty => 'Das Beziehungsfeld kann nicht leer sein.';

  @override
  String get errorValidationRelationNotAString => 'Das Beziehungsfeld muss ein String sein.';

  @override
  String get errorValidationRelationInvalidEnum => 'Das Beziehungsfeld ist ungültig.';

  @override
  String get errorValidationEmailEmpty => 'E-Mail kann nicht leer sein.';

  @override
  String get errorValidationRegistrationTokenEmpty => 'Das Registrierungs-Token kann nicht leer sein.';

  @override
  String get errorValidationRegistrationTokenNotAString => 'Das Registrierungstoken muss ein String sein.';

  @override
  String get errorValidationRegistrationTokenNotAJwt => 'Das Registrierungstoken muss ein gültiges JWT sein.';

  @override
  String get errorValidationPasswordTokenEmpty => 'Das Passwort-Token kann nicht leer sein.';

  @override
  String get errorValidationPasswordTokenNotAString => 'Das Passwort-Token muss ein String sein.';

  @override
  String get errorValidationPasswordTokenNotAJwt => 'Das Passwort-Token muss ein gültiges JWT sein.';

  @override
  String get errorValidationBuddyIdEmpty => 'Die Buddy ID kann nicht leer sein.';

  @override
  String get errorValidationBuddyIdNotANumber => 'Die Buddy-ID muss eine Zahl sein.';

  @override
  String get errorValidationBuddyIdNotAnInteger => 'Die Buddy-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationBuddyIdNotAPositiveNumber => 'Buddy ID muss eine positive Zahl sein.';

  @override
  String get errorValidationIdEmpty => 'ID kann nicht leer sein.';

  @override
  String get errorValidationIdNotANumber => 'ID muss eine Zahl sein.';

  @override
  String get errorValidationIdNotAnInteger => 'Die ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationIdNotAPositiveNumber => 'Die ID muss eine positive Zahl sein.';

  @override
  String get errorValidationDishIdEmpty => 'Gericht ID kann nicht leer sein.';

  @override
  String get errorValidationDishIdNotANumber => 'Gericht ID muss eine Nummer sein.';

  @override
  String get errorValidationDishIdNotAnInteger => 'Gericht ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationDishIdNotAPositiveNumber => 'Gericht ID muss eine positive Zahl sein.';

  @override
  String get errorValidationMealCategoriesNotAString => 'Mahlzeiten Kategorien müssen ein String sein.';

  @override
  String get errorValidationNumberOfServingsEmpty => 'Die Anzahl der Portionen kann nicht leer sein.';

  @override
  String get errorValidationNumberOfServingsNotANumber => 'Die Anzahl der Portionen muss eine Zahl sein.';

  @override
  String get errorValidationNumberOfServingsNotAPositiveNumber => 'Die Anzahl der Portionen muss eine positive Zahl sein.';

  @override
  String get errorValidationExternalFoodItemIdEmpty => 'Die ID eines externen Lebensmittels kann nicht leer sein.';

  @override
  String get errorValidationExternalFoodItemIdNotANumberString => 'Die ID eines externen Lebensmittels muss eine gültige Zahlenstring sein.';

  @override
  String get errorValidationFoodItemsEmpty => 'Lebensmittel können nicht leer sein.';

  @override
  String get errorValidationFoodItemsNotAnArray => 'Die Lebensmittel müssen ein Array sein.';

  @override
  String get errorValidationFoodItemsEmptyArray => 'Lebensmittel können kein leeres Array sein.';

  @override
  String get errorValidationInternalFoodItemIdEmpty => 'Die interne Food Item ID kann nicht leer sein.';

  @override
  String get errorValidationInternalFoodItemIdNotANumber => 'Die interne Food Item ID muss eine Nummer sein.';

  @override
  String get errorValidationInternalFoodItemIdNotAnInteger => 'Die interne Food Item ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationInternalFoodItemIdNotAPositiveNumber => 'Die interne Food Item ID muss eine positive Zahl sein.';

  @override
  String get errorValidationMealRecipeIdNumberTooBig => 'Die Rezept-ID-Nummer ist zu groß.';

  @override
  String get errorValidationMealRecipeIdNumberTooSmall => 'Die Rezept-ID-Nummer ist zu klein.';

  @override
  String get errorValidationRecipeIdNotANumber => 'Die Rezeptur-ID muss eine Zahl sein.';

  @override
  String get errorValidationRecipeIdNotAnInteger => 'Die Rezeptur-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationRecipeIdNotAPositiveNumber => 'Die Rezeptur-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationRecipeIdNumberTooBig => 'Die Rezept-ID-Nummer ist zu groß.';

  @override
  String get errorValidationRecipeIdNumberTooSmall => 'Die Rezept-ID-Nummer ist zu klein.';

  @override
  String get errorValidationRegionInvalidEnum => 'Region ist ungültig.';

  @override
  String get errorValidationBarcodeEmpty => 'Barcode kann nicht leer sein.';

  @override
  String get errorValidationBarcodeNotAString => 'Barcode muss ein String sein.';

  @override
  String get errorValidationBarcodeStringTooLong => 'Barcode-String ist zu lang.';

  @override
  String get errorValidationBarcodeStringTooShort => 'Barcode-String ist zu kurz.';

  @override
  String get errorValidationExternalFoodItemIdNotAString => 'Externe Lebensmittel ID muss ein String sein.';

  @override
  String get errorValidationServingIdNotAString => 'Die Portion ID muss ein String sein.';

  @override
  String get errorValidationFoodItemsArraySizeTooSmall => 'Lebensmittelarray Größe ist zu klein.';

  @override
  String get errorValidationInternalRecipeIdEmpty => 'Die interne Rezept-ID kann nicht leer sein.';

  @override
  String get errorValidationInternalRecipeIdNotANumber => 'Die interne Rezept-ID muss eine Nummer sein.';

  @override
  String get errorValidationInternalRecipeIdNotAnInteger => 'Die interne Rezept-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationInternalRecipeIdNotAPositiveNumber => 'Die interne Rezept-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationLoggingDateEmpty => 'Das Logging-Datum darf nicht leer sein.';

  @override
  String get errorValidationLoggingDateNotADateString => 'Das Logging-Datum muss ein gültiger Datumsstring sein.';

  @override
  String get errorValidationMealCategoryEmpty => 'Die Mahlzeitenkategorie kann nicht leer sein.';

  @override
  String get errorValidationInternalFoodItemIdNotANumberString => 'Die interne Food Item ID muss eine gültige Zahlenfolge sein.';

  @override
  String get errorValidationDateEmpty => 'Das Datum kann nicht leer sein.';

  @override
  String get errorValidationDateNotADateString => 'Datum muss eine gültige Datumszeichenfolge sein.';

  @override
  String get errorValidationQueryEmpty => 'Suche kann nicht leer sein.';

  @override
  String get errorValidationQueryNotAString => 'Suche muss ein String sein.';

  @override
  String get errorValidationQueryStringTooShort => 'Suche-String ist zu kurz.';

  @override
  String get errorValidationModesEmpty => 'Modi können nicht leer sein.';

  @override
  String get errorValidationModesNotFromDefinedList => 'Die Modi müssen aus der definierten Liste stammen.';

  @override
  String get errorValidationPageNotANumber => 'Die Seite muss eine Nummer sein.';

  @override
  String get errorValidationPageNotAnInteger => 'Die Seite muss eine ganze Zahl sein.';

  @override
  String get errorValidationPageNotAPositiveNumber => 'Die Seite muss eine positive Zahl sein.';

  @override
  String get errorValidationPageSizeNotANumber => 'Die Seitengröße muss eine Zahl sein.';

  @override
  String get errorValidationPageSizeNotAnInteger => 'Die Seitengröße muss eine ganze Zahl sein.';

  @override
  String get errorValidationPageSizeNotAPositiveNumber => 'Die Seitengröße muss eine positive Zahl sein.';

  @override
  String get errorValidationPageSizeNumberTooBig => 'Die Seitengrößennummer ist zu groß.';

  @override
  String get errorValidationPlanningDatesDateTooSmall => 'Das Datum der Planungsdaten ist zu klein.';

  @override
  String get errorValidationPlanningDatesDateTooBig => 'Das Datum der Planungsdaten ist zu groß.';

  @override
  String get errorValidationPlanningDatesEmpty => 'Die Planungsdaten dürfen nicht leer sein.';

  @override
  String get errorValidationPlanningDatesEmptyArray => 'Die Planungsdaten können kein leeres Array sein.';

  @override
  String get errorValidationPlanningDatesNotADateString => 'Die Planungsdaten müssen eine gültige Datumszeichenfolge sein.';

  @override
  String get errorValidationStartDateDateEmptyPeriod => 'Das Startdatum darf nicht leer oder ungültig sein.';

  @override
  String get errorValidationPlannedMealIdEmpty => 'Die ID der geplanten Mahlzeit kann nicht leer sein.';

  @override
  String get errorValidationPlannedMealIdNotANumber => 'Die ID der geplanten Mahlzeit muss eine Nummer sein.';

  @override
  String get errorValidationPlannedMealIdNotAnInteger => 'Die ID der geplanten Mahlzeit muss eine ganze Zahl sein.';

  @override
  String get errorValidationPlannedMealIdNotAPositiveNumber => 'Die ID der geplanten Mahlzeit muss eine positive Zahl sein.';

  @override
  String get errorValidationLoggingDateDateTooBig => 'Das Protokollierungsdatum ist zu groß.';

  @override
  String get errorValidationLoggingDateDateTooSmall => 'Das Datum der Protokollierung ist zu klein.';

  @override
  String get errorValidationLimitNumberTooSmall => 'Die Grenzwertnummer ist zu klein.';

  @override
  String get errorValidationLimitNotAnInteger => 'Das Limit muss eine ganze Zahl sein.';

  @override
  String get errorValidationLimitNotAPositiveNumber => 'Das Limit muss eine positive Zahl sein.';

  @override
  String get errorValidationLimitNotANumber => 'Das Limit muss eine Zahl sein.';

  @override
  String get errorValidationUrlNotAString => 'Die URL muss ein String sein.';

  @override
  String get errorValidationUrlNotUrlAddress => 'Die URL muss eine gültige URL-Adresse sein.';

  @override
  String get errorValidationDataArraySizeTooSmall => 'Die Größe des Datenarrays ist zu klein.';

  @override
  String get errorValidationDataNotAnArray => 'Die Daten müssen ein Array sein.';

  @override
  String get errorValidationDateNotAString => 'Das Datum muss ein String sein.';

  @override
  String get errorValidationDateDateTooSmall => 'Das Datum ist zu klein.';

  @override
  String get errorValidationDateDateTooBig => 'Das Datum ist zu groß.';

  @override
  String get errorValidationWeightNumberTooBig => 'Die Gewichtsnummer ist zu groß.';

  @override
  String get errorValidationStartDateDateTooBig => 'Das Startdatum ist zu groß.';

  @override
  String get errorValidationEndDateDateTooBig => 'Das Enddatum ist zu groß.';

  @override
  String get errorValidationStateNotAString => 'Der Status muss ein String sein.';

  @override
  String get errorValidationGenderPreferenceIdEmpty => 'Die ID der Geschlechtspräferenz kann nicht leer sein.';

  @override
  String get errorValidationGenderPreferenceIdNotANumber => 'Die ID der Geschlechtspräferenz muss eine Zahl sein.';

  @override
  String get errorValidationGenderPreferenceIdNotAnInteger => 'Die ID der Geschlechtspräferenz muss eine ganze Zahl sein.';

  @override
  String get errorValidationGenderPreferenceIdNotAPositiveNumber => 'Die ID der Geschlechtspräferenz muss eine positive Zahl sein.';

  @override
  String get errorValidationTypeIdEmpty => 'Die Typ-ID darf nicht leer sein.';

  @override
  String get errorValidationTypeIdNotANumber => 'Die Typ-ID muss eine Zahl sein.';

  @override
  String get errorValidationTypeIdNotAnInteger => 'Die Typ-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationTypeIdNotAPositiveNumber => 'Die Typ-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationBmiRangeNotAString => 'Der BMI-Bereich muss ein String sein.';

  @override
  String get errorValidationBmiRangeInvalidEnum => 'Der BMI-Bereich ist ungültig.';

  @override
  String get errorValidationAgeRangeNotAString => 'Der Altersbereich muss ein String sein.';

  @override
  String get errorValidationAgeRangeInvalidEnum => 'Der Altersbereich ist ungültig.';

  @override
  String get errorValidationTimezoneStringTooShort => 'Die Zeitzonenzeichenfolge ist zu kurz.';

  @override
  String get errorValidationGroupIdEmpty => 'Die Gruppen-ID kann nicht leer sein.';

  @override
  String get errorValidationGroupIdNotANumber => 'Gruppen-ID muss eine Zahl sein.';

  @override
  String get errorValidationGroupIdNotAnInteger => 'Gruppen-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationGroupIdNotAPositiveNumber => 'Gruppen-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationGroupSessionIdEmpty => 'Onlinetreffen ID kann nicht leer sein.';

  @override
  String get errorValidationGroupSessionIdNotANumber => 'Onlinetreffen ID muss eine Zahl sein.';

  @override
  String get errorValidationGroupSessionIdNotAnInteger => 'Onlinetreffen ID muss eine Zahl sein.';

  @override
  String get errorValidationGroupSessionIdNotAPositiveNumber => 'Onlinetreffen ID muss eine positive Zahl sein.';

  @override
  String get errorValidationEventInvalidEnum => 'Event ist ungültig.';

  @override
  String get errorValidationEventNotAString => 'Event muss ein String sein.';

  @override
  String get errorValidationEventEmpty => 'Event kann nicht leer sein.';

  @override
  String get errorValidationStartDateNotAnIsoDateString => 'Startdatum muss ein gültiger ISO-Datumsstring sein.';

  @override
  String get errorValidationEndDateNotAnIsoDateString => 'Enddatum muss ein gültiger ISO-Datumsstring sein.';

  @override
  String get errorValidationStatusEmpty => 'Status kann nicht leer sein.';

  @override
  String get errorValidationStatusNotAString => 'Status muss ein String sein.';

  @override
  String get errorValidationStatusInvalidEnum => 'Status ist ungültig.';

  @override
  String get errorValidationTopicStringTooLong => 'Themenstring ist zu lang.';

  @override
  String get errorValidationTopicStringTooShort => 'Themenstring ist zu kurz.';

  @override
  String get errorValidationTopicNotAString => 'Thema muss ein String sein.';

  @override
  String get errorValidationPasswordStringTooLong => 'Passwortstring ist zu lang.';

  @override
  String get errorValidationPasswordStringTooShort => 'Passwortstring ist zu kurz.';

  @override
  String get errorValidationGroupSessionProgramIdNotAPositiveNumber => 'Onlinetreffen Programm ID muss eine positive Zahl sein.';

  @override
  String get errorValidationGroupSessionProgramIdNotAnInteger => 'Onlinetreffen Programm ID muss eine Zahl sein.';

  @override
  String get errorValidationGroupSessionProgramIdNotANumber => 'Onlinetreffen Programm ID muss eine Zahl sein.';

  @override
  String get errorValidationPreparationNotAString => 'Vorbereitung muss ein String sein.';

  @override
  String get errorValidationPreparationEmpty => 'Vorbereitung kann nicht leer sein.';

  @override
  String get errorValidationTitleNotAString => 'Titel muss ein String sein.';

  @override
  String get errorValidationTitleEmpty => 'Titel kann nicht leer sein.';

  @override
  String get errorValidationEventsNotAnArray => 'Events müssen ein Array sein.';

  @override
  String get errorValidationImageNotAString => 'Bild muss ein String sein.';

  @override
  String get errorValidationImageEmpty => 'Bild kann nicht leer sein.';

  @override
  String get errorValidationStartNotAString => 'Start muss ein String sein.';

  @override
  String get errorValidationStartEmpty => 'Start kann nicht leer sein.';

  @override
  String get errorValidationPromptNotAString => 'Prompt muss ein String sein.';

  @override
  String get errorValidationVideoNotAString => 'Video muss ein String sein.';

  @override
  String get errorValidationDurationNotAnInteger => 'Dauer muss eine ganze Zahl sein.';

  @override
  String get errorValidationDurationNotAPositiveNumber => 'Dauer muss eine positive Zahl sein.';

  @override
  String get errorValidationDurationNotANumber => 'Dauer muss eine Zahl sein.';

  @override
  String get errorValidationSessionIdNotAnInteger => 'Onlinetreffen ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationSessionIdNotAPositiveNumber => 'Onlinetreffen ID muss eine positive Zahl sein.';

  @override
  String get errorValidationSessionIdNotANumber => 'Onlinetreffen ID muss eine Zahl sein.';

  @override
  String get errorValidationTypeEmpty => 'Typ kann nicht leer sein.';

  @override
  String get errorValidationImagePathStringTooShort => 'Image Path String ist zu kurz.';

  @override
  String get errorValidationImagePathNotAString => 'Image path muss ein String sein.';

  @override
  String get errorValidationImagePathEmpty => 'Image path kann nicht leer sein.';

  @override
  String get errorValidationDifficultyNotAString => 'Schwierigkeitsgrad muss ein String sein.';

  @override
  String get errorValidationDifficultyInvalidEnum => 'Schwierigkeitsgrad ist ungültig.';

  @override
  String get errorValidationPlaceNotAString => 'Ort muss ein String sein.';

  @override
  String get errorValidationPlaceInvalidEnum => 'Ort ist ungültig.';

  @override
  String get errorValidationPhysicalProgramIdEmpty => 'Bewegungsprogramm-ID kann nicht leer sein.';

  @override
  String get errorValidationPhysicalProgramIdNotANumber => 'Bewegungsprogramm-ID muss eine Zahl sein.';

  @override
  String get errorValidationPhysicalProgramIdNotAnInteger => 'Die physische Programm-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationPhysicalProgramIdNotAPositiveNumber => 'Die physische Programm-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationScoreEmpty => 'Die Punktzahl kann nicht leer sein.';

  @override
  String get errorValidationScoreNotANumber => 'Die Punktzahl muss eine Zahl sein.';

  @override
  String get errorValidationScoreNumberTooBig => 'Die Punktzahl ist zu groß.';

  @override
  String get errorValidationScoreNumberTooSmall => 'Die Punktzahl ist zu klein.';

  @override
  String get errorValidationLikeEmpty => 'Like kann nicht leer sein.';

  @override
  String get errorValidationLikeNotABoolean => 'Like muss ein boolescher Wert sein.';

  @override
  String get errorValidationTrainingFrequencyEmpty => 'Die Trainingsfrequenz kann nicht leer sein.';

  @override
  String get errorValidationTrainingFrequencyNotAString => 'Die Trainingshäufigkeit muss ein String sein.';

  @override
  String get errorValidationTrainingFrequencyInvalidEnum => 'Die Trainingsfrequenz ist ungültig.';

  @override
  String get errorValidationTrainingTargetsEmpty => 'Trainingsziele können nicht leer sein.';

  @override
  String get errorValidationTrainingTargetsNotAString => 'Trainingsziele müssen ein String sein.';

  @override
  String get errorValidationTrainingTargetsInvalidEnum => 'Die Trainingsziele sind ungültig.';

  @override
  String get errorValidationFlexibleEmpty => 'Flexibel kann nicht leer sein.';

  @override
  String get errorValidationFlexibleNotABoolean => 'Flexibel muss ein boolescher Wert sein.';

  @override
  String get errorValidationImageStringTooShort => 'Die Bildzeichenfolge ist zu kurz.';

  @override
  String get errorValidationVideoStringTooShort => 'Der Videostring ist zu kurz.';

  @override
  String get errorValidationVideoEmpty => 'Das Video kann nicht leer sein.';

  @override
  String get errorValidationDurationNotAString => 'Die Dauer muss ein String sein.';

  @override
  String get errorValidationDurationEmpty => 'Die Dauer kann nicht leer sein.';

  @override
  String get errorValidationSkipToNotAString => 'Skip to muss ein String sein.';

  @override
  String get errorValidationSkipToEmpty => 'Skip to kann nicht leer sein.';

  @override
  String get errorValidationExerciseIdEmpty => 'Die Übungs-ID kann nicht leer sein.';

  @override
  String get errorValidationExerciseIdNotANumber => 'Die Übungs-ID muss eine Zahl sein.';

  @override
  String get errorValidationExerciseIdNotAnInteger => 'Die Übungs-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationExerciseIdNotAPositiveNumber => 'Die Übungs-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationCategoryInvalidEnum => 'Die Kategorie ist ungültig.';

  @override
  String get errorValidationLocationInvalidEnum => 'Der Standort ist ungültig.';

  @override
  String get errorValidationEquipmentStringTooShort => 'Der Ausrüstungsstring ist zu kurz.';

  @override
  String get errorValidationEquipmentNotAString => 'Die Ausrüstung muss ein String sein.';

  @override
  String get errorValidationEquipmentEmpty => 'Die Ausrüstung kann nicht leer sein.';

  @override
  String get errorValidationTargetMusclesStringTooShort => 'Der String der Zielmuskeln ist zu kurz.';

  @override
  String get errorValidationTargetMusclesNotAString => 'Zielmuskeln müssen ein String sein.';

  @override
  String get errorValidationTargetMusclesEmpty => 'Zielmuskeln können nicht leer sein.';

  @override
  String get errorValidationDurationStringTooShort => 'Duration String ist zu kurz.';

  @override
  String get errorValidationVideoNotUrlAddress => 'Das Video muss eine gültige URL-Adresse sein.';

  @override
  String get errorValidationProgramIdEmpty => 'Die Programm-ID kann nicht leer sein.';

  @override
  String get errorValidationProgramIdNotANumber => 'Die Programm-ID muss eine Zahl sein.';

  @override
  String get errorValidationProgramIdNotAnInteger => 'Die Programm-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationProgramIdNotAPositiveNumber => 'Die Programm-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationImageNotUrlAddress => 'Das Bild muss eine gültige URL-Adresse sein.';

  @override
  String get errorValidationOrderNotAPositiveNumber => 'Die Bestellung muss eine positive Zahl sein.';

  @override
  String get errorValidationOrderNotAnInteger => 'Die Bestellung muss eine ganze Zahl sein.';

  @override
  String get errorValidationModuleIdNotAPositiveNumber => 'Die Modul-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationModuleIdNotAnInteger => 'Die Modul-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationModuleIdNotANumber => 'Die Modul-ID muss eine Zahl sein.';

  @override
  String get errorValidationModuleIdEmpty => 'Die Modul-ID darf nicht leer sein.';

  @override
  String get errorValidationExternalIdNotAPositiveNumber => 'Die externe ID muss eine positive Zahl sein.';

  @override
  String get errorValidationExternalIdNotAnInteger => 'Die externe ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationExternalIdNotANumber => 'Externe ID muss eine Zahl sein.';

  @override
  String get errorValidationExternalIdEmpty => 'Externe ID kann nicht leer sein.';

  @override
  String get errorValidationStreamTypeInvalidEnum => 'Streamtype ist ungültig.';

  @override
  String get errorValidationStreamTypeEmpty => 'Streamtype kann nicht leer sein.';

  @override
  String get errorValidationIconTypeInvalidEnum => 'Icon-Type ist ungültig.';

  @override
  String get errorValidationIconTypeEmpty => 'Icon-Type kann nicht leer sein.';

  @override
  String get errorValidationIsRootItemNotABoolean => 'Is Root Item muss ein Boolean sein.';

  @override
  String get errorValidationIsRootItemEmpty => 'Is Root Item kann nicht leer sein.';

  @override
  String get errorValidationLessonExternalIdNotAPositiveNumber => 'Externe Abschnitt ID muss eine positive Zahl sein.';

  @override
  String get errorValidationLessonExternalIdNotAnInteger => 'Externe Abschnitt ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationLessonExternalIdNotANumber => 'Externe Abschnitt ID muss eine Zahl sein.';

  @override
  String get errorValidationLessonExternalIdEmpty => 'Externe Abschnitt ID kann nicht leer sein.';

  @override
  String get errorValidationUnlocksItemExternalIdsNotANumber => 'Externen Abschnitt IDs zum entsperren müssen Zahlen sein.';

  @override
  String get errorValidationUnlocksItemExternalIdsNotAnArray => 'Externe item IDs zum entsperren müssen ein Array sein.';

  @override
  String get errorValidationUnlocksItemExternalIdsEmpty => 'Externe item IDs zum entsperren kann nicht leer sein.';

  @override
  String get errorValidationUnlocksFeatureNotAString => 'Schaltet Feature frei muss ein String sein.';

  @override
  String get errorValidationUnlocksFeatureNotAnArray => 'Schaltet Feature frei muss ein Array sein.';

  @override
  String get errorValidationUnlocksFeatureEmpty => 'Schaltet Feature frei kann nicht leer sein.';

  @override
  String get errorValidationUnlocksReflectionExternalIdNotANumber => 'Reflexion externe ID freigeschaltet muss eine Zahl sein.';

  @override
  String get errorValidationUnlocksReflectionExternalIdEmpty => 'Externe ID der entsperrten Reflexion darf nicht leer sein.';

  @override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdNotANumber => 'Externe Smart Goal Kategorie ID muss eine Zahl sein.';

  @override
  String get errorValidationUnlocksSmartGoalCategoryExternalIdEmpty => 'Externe Smart Goal-Kategorie ID darf nicht leer sein.';

  @override
  String get errorValidationCrossModuleNotABoolean => 'CrossModule muss ein boolescher Wert sein.';

  @override
  String get errorValidationCrossModuleEmpty => 'CrossModule kann nicht leer sein.';

  @override
  String get errorValidationFeaturePlacementInvalidEnum => 'Feature Platzierung ist ungültig.';

  @override
  String get errorValidationFeaturePlacementEmpty => 'Feature-Platzierung kann nicht leer sein.';

  @override
  String get errorValidationModuleItemsNotAnArray => 'Modulelemente müssen ein Array sein.';

  @override
  String get errorValidationModuleItemsEmpty => 'Modulelemente können nicht leer sein.';

  @override
  String get errorValidationRiverModuleIdEmpty => 'River Modul ID kann nicht leer sein.';

  @override
  String get errorValidationRiverModuleIdNotANumber => 'River module ID muss eine Zahl sein.';

  @override
  String get errorValidationRiverModuleIdNotAnInteger => 'River Modul ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationRiverModuleIdNotAPositiveNumber => 'River module ID muss eine positive Zahl sein.';

  @override
  String get errorValidationRiverModuleItemIdEmpty => 'River Modul Element ID kann nicht leer sein.';

  @override
  String get errorValidationRiverModuleItemIdNotANumber => 'River Modul Element ID muss eine Zahl sein.';

  @override
  String get errorValidationRiverModuleItemIdNotAnInteger => 'River Modul Element ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationRiverModuleItemIdNotAPositiveNumber => 'River Modul Element ID muss eine positive Zahl sein.';

  @override
  String get errorValidationLanguageNotAString => 'Sprache muss ein String sein.';

  @override
  String get errorValidationCountryNotAString => 'Land muss ein String sein.';

  @override
  String get errorValidationTimezoneOffsetNotANumber => 'Zeitzonenversatz muss eine Zahl sein.';

  @override
  String get errorValidationTimezoneNameNotAString => 'Name der Zeitzone muss ein String sein.';

  @override
  String get errorValidationMeasurementSystemNotAString => 'Messsystem muss ein String sein.';

  @override
  String get errorValidationRefreshTokenNotAString => 'Refresh-Token muss ein String sein.';

  @override
  String get errorValidationDiabetesNotAPositiveNumber => 'Diabetes muss eine positive Zahl sein.';

  @override
  String get errorValidationDiabetesNotANumber => 'Diabetes muss eine Zahl sein.';

  @override
  String get errorValidationTextStringTooLong => 'Textstring ist zu lang.';

  @override
  String get errorValidationTextStringTooShort => 'Textstring ist zu kurz.';

  @override
  String get errorValidationTextEmpty => 'Text kann nicht leer sein.';

  @override
  String get errorValidationTextNotAString => 'Text muss ein String sein.';

  @override
  String get errorValidationReplyMessageIdNotANumberString => 'Antwortnachricht ID muss ein Zahlenstring sein.';

  @override
  String get errorValidationMessageIdNotANumber => 'Nachrichten-ID muss eine Zahl sein.';

  @override
  String get errorValidationMessageIdNotAnInteger => 'Die Nachrichten-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationMessageIdNotAPositiveNumber => 'Die Nachrichten-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationTimeEmpty => 'Die Zeit kann nicht leer sein.';

  @override
  String get errorValidationTimeNotAString => 'Die Zeit muss ein String sein.';

  @override
  String get errorValidationTimeStringTooLong => 'Der Zeitstring ist zu lang.';

  @override
  String get errorValidationTimeStringTooShort => 'Der Zeitstring ist zu kurz.';

  @override
  String get errorValidationSubjectEmpty => 'Der Betreff kann nicht leer sein.';

  @override
  String get errorValidationSubjectNotAString => 'Der Betreff muss ein String sein.';

  @override
  String get errorValidationSubjectStringTooLong => 'Die Betreffzeile ist zu lang.';

  @override
  String get errorValidationSubjectStringTooShort => 'Die Betreffzeile ist zu kurz.';

  @override
  String get errorValidationMessageEmpty => 'Nachricht kann nicht leer sein.';

  @override
  String get errorValidationMessageNotAString => 'Die Nachricht muss ein String sein.';

  @override
  String get errorValidationMessageStringTooLong => 'Der Nachrichtenstring ist zu lang.';

  @override
  String get errorValidationMessageStringTooShort => 'Der Nachrichtenstring ist zu kurz.';

  @override
  String get errorValidationAppVersionEmpty => 'Die App-Version kann nicht leer sein.';

  @override
  String get errorValidationAppVersionNotAString => 'Die App-Version muss ein String sein.';

  @override
  String get errorValidationAppVersionStringTooLong => 'Der String der App-Version ist zu lang.';

  @override
  String get errorValidationAppVersionStringTooShort => 'Der String der App-Version ist zu kurz.';

  @override
  String get errorValidationEmailTokenEmpty => 'Das E-Mail-Token kann nicht leer sein.';

  @override
  String get errorValidationEmailTokenNotAString => 'Das E-Mail-Token muss ein String sein.';

  @override
  String get errorValidationEmailTokenNotAJwt => 'Das E-Mail-Token muss ein JWT sein.';

  @override
  String get errorValidationExtraAccountsCountNumberTooSmall => 'Die Anzahl der zusätzlichen Konten ist zu klein.';

  @override
  String get errorValidationExtraAccountsCountNotAnInteger => 'Die Anzahl der zusätzlichen Konten muss eine ganze Zahl sein.';

  @override
  String get errorValidationExtraAccountsCountNotANumber => 'Die Anzahl der zusätzlichen Konten muss eine Zahl sein.';

  @override
  String get errorValidationUidNotAString => 'UID muss ein String sein.';

  @override
  String get errorValidationPlatformInvalidEnum => 'Die Plattform ist ungültig.';

  @override
  String get errorValidationPlatformNotAString => 'Die Plattform muss ein String sein.';

  @override
  String get errorValidationDeviceIdNotAString => 'Die Geräte-ID muss ein String sein.';

  @override
  String get errorValidationDeviceIdEmpty => 'Die Geräte-ID kann nicht leer sein.';

  @override
  String get errorValidationDeviceIdStringTooLong => 'Der String der Geräte-ID ist zu lang.';

  @override
  String get errorValidationAdvertisingIdNotAString => 'Die Werbe-ID muss ein String sein.';

  @override
  String get errorValidationAdvertisingIdEmpty => 'Die Werbe-ID kann nicht leer sein.';

  @override
  String get errorValidationAdvertisingIdStringTooLong => 'Der String der Werbe-ID ist zu lang.';

  @override
  String get errorValidationLimitNumberTooBig => 'Die Grenzwertnummer ist zu groß.';

  @override
  String get errorValidationFromMessageIdNotANumberString => 'From Message ID muss ein Zahlenstring sein.';

  @override
  String get errorValidationChatMessageIdNotAString => 'Die Chatnachrichten-ID muss ein String sein.';

  @override
  String get errorValidationChatMessageIdNotANumberString => 'Die Chatnachrichten-ID muss ein Zahlenstring sein.';

  @override
  String get errorValidationReflectionIdEmpty => 'Die Reflection ID kann nicht leer sein.';

  @override
  String get errorValidationReflectionIdNotANumber => 'Die Reflection ID muss eine Zahl sein.';

  @override
  String get errorValidationReflectionIdNotAnInteger => 'Die Reflection ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationReflectionIdNotAPositiveNumber => 'Die Reflection ID muss eine positive Zahl sein.';

  @override
  String get errorValidationReflectionQuestionIdEmpty => 'Die ID der Reflexionsfrage kann nicht leer sein.';

  @override
  String get errorValidationReflectionQuestionIdNotANumber => 'Die ID der Reflexionsfrage muss eine Zahl sein.';

  @override
  String get errorValidationReflectionQuestionIdNotAnInteger => 'Die Reflection Question ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationReflectionQuestionIdNotAPositiveNumber => 'Die ID der Reflexionsfrage muss eine positive Zahl sein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNumberTooBig => 'Die Anzahl der Reflection Question Option IDs ist zu groß.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNumberTooSmall => 'Die Anzahl der Reflexionsfrage-Options-IDs ist zu klein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAPositiveNumber => 'Reflection Question Option IDs müssen eine positive Zahl sein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAnInteger => 'Reflection Question Option IDs müssen eine ganze Zahl sein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotANumber => 'Reflection Question Option IDs müssen eine Zahl sein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsEmptyArray => 'Reflexion Frage Option IDs können kein leeres Array sein.';

  @override
  String get errorValidationReflectionQuestionOptionIdsNotAnArray => 'Reflexion Frage Option IDs muss ein Array sein.';

  @override
  String get errorValidationValueNumberTooBig => 'Value Nummer ist zu groß.';

  @override
  String get errorValidationValueNumberTooSmall => 'Value Nummer ist zu klein.';

  @override
  String get errorValidationValueNotAPositiveNumber => 'Value muss eine positive Zahl sein.';

  @override
  String get errorValidationValueNotAnInteger => 'Value muss eine ganze Zahl sein.';

  @override
  String get errorValidationValueNotANumber => 'Value muss eine Zahl sein.';

  @override
  String get errorValidationLessonIdEmpty => 'Abschnitts-ID kann nicht leer sein.';

  @override
  String get errorValidationLessonIdNotANumber => 'Abschnitts-ID muss eine Nummer sein.';

  @override
  String get errorValidationLessonIdNotAnInteger => 'Abschnitts-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationLessonIdNotAPositiveNumber => 'Abschnitts-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationLabelNotAString => 'Label muss ein String sein.';

  @override
  String get errorValidationIsCorrectNotABoolean => 'Is correct muss ein boolescher Wert sein.';

  @override
  String get errorValidationMinValueNotAPositiveNumber => 'Mindestwert muss eine positive Zahl sein.';

  @override
  String get errorValidationMinValueNotAnInteger => 'Mindestwert muss eine ganze Zahl sein.';

  @override
  String get errorValidationMinValueNotANumber => 'Mindestwert muss eine positive Zahl sein.';

  @override
  String get errorValidationMaxValueNotAPositiveNumber => 'Maximalwert muss eine positive Zahl sein.';

  @override
  String get errorValidationMaxValueNotAnInteger => 'Maximalwert muss eine ganze Zahl sein.';

  @override
  String get errorValidationMaxValueNotANumber => 'Maximalwert muss eine Zahl sein.';

  @override
  String get errorValidationLowestTextNotAString => 'Niedrigster Text muss ein String sein.';

  @override
  String get errorValidationHighestTextNotAString => 'Höchster Text muss ein String sein.';

  @override
  String get errorValidationScaleNotAnArray => 'Scale muss ein Array sein.';

  @override
  String get errorValidationQuestionNotAString => 'Frage muss ein String sein.';

  @override
  String get errorValidationAnswerTypeInvalidEnum => 'Antworttyp ist ungültig.';

  @override
  String get errorValidationAnswerTypeNotAString => 'Antworttyp muss ein String sein.';

  @override
  String get errorValidationIntroductionNotAString => 'Einleitung muss ein String sein.';

  @override
  String get errorValidationFeedbackNotAnArray => 'Feedback muss ein Array sein.';

  @override
  String get errorValidationExtraInstructionNotAString => 'Zusätzliche Anweisung muss ein String sein.';

  @override
  String get errorValidationInstructionNotAString => 'Anleitung muss ein String sein.';

  @override
  String get errorValidationCategoryNotAString => 'Kategorie muss ein String sein.';

  @override
  String get errorValidationExternalLessonIdNotAPositiveNumber => 'Externe Abschnitt-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationExternalLessonIdNotAnInteger => 'Externe Abschnitts ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationExternalLessonIdNotANumber => 'Externe Abschnitts ID muss eine Nummer sein.';

  @override
  String get errorValidationQuestionsNotAnArray => 'Fragen müssen ein Array sein.';

  @override
  String get errorValidationOrderNotANumber => 'Anordnung muss eine Nummer sein.';

  @override
  String get errorValidationOrderEmpty => 'Anordnung kann nicht leer sein.';

  @override
  String get errorValidationContentTypeInvalidEnum => 'Content type ist ungültig.';

  @override
  String get errorValidationContentTypeNotAString => 'Content type muss ein String sein.';

  @override
  String get errorValidationContentTypeEmpty => 'Content type kann nicht leer sein.';

  @override
  String get errorValidationCardImageUrlNotAString => 'Card image URL muss ein String sein.';

  @override
  String get errorValidationImageUrlNotAString => 'Image URL muss ein String sein.';

  @override
  String get errorValidationAudioUrlNotAString => 'Audio URL muss ein String sein.';

  @override
  String get errorValidationHtmlUrlNotAString => 'HTML URL muss ein String sein.';

  @override
  String get errorValidationSubtitlesImagesNotAString => 'Untertitel Bilder müssen ein String sein.';

  @override
  String get errorValidationConclusionNotAString => 'Conclusion muss ein String sein.';

  @override
  String get errorValidationUnlockTitleNotAString => 'Unlock title muss ein String sein.';

  @override
  String get errorValidationUnlockDescriptionNotAString => 'Unlock description muss ein String sein.';

  @override
  String get errorValidationAudioEmpty => 'Audio kann nicht leer sein.';

  @override
  String get errorValidationAudioNotAString => 'Audio muss ein String sein.';

  @override
  String get errorValidationSubtitlesImagesEmpty => 'Untertitel Bilder kann nicht leer sein.';

  @override
  String get errorValidationCorrectNotAString => 'Richtig muss ein String sein.';

  @override
  String get errorValidationIncorrectNotAString => 'Falsch muss ein String sein.';

  @override
  String get errorValidationVisualEmpty => 'Das Bildmaterial kann nicht leer sein.';

  @override
  String get errorValidationVisualNotAString => 'Visuell muss ein String sein.';

  @override
  String get errorValidationCompletionTimeNotAString => 'Die Bearbeitungszeit muss ein String sein.';

  @override
  String get errorValidationCompletionTimeEmpty => 'Die Bearbeitungszeit kann nicht leer sein.';

  @override
  String get errorValidationLessonsArraySizeTooSmall => 'Die Arraygröße des Abschnitts ist zu klein.';

  @override
  String get errorValidationLessonsNotAnArray => 'Die Abschnitte müssen ein Array sein.';

  @override
  String get errorValidationLessonQuizIdEmpty => 'Der Abschnitts-Quiz-ID kann nicht leer sein.';

  @override
  String get errorValidationLessonQuizIdNotANumber => 'Der Abschnitts-Quiz-ID muss eine Zahl sein.';

  @override
  String get errorValidationLessonQuizIdNotAnInteger => 'Abschnitts-Quiz-ID muss eine ganze Zahl sein.';

  @override
  String get errorValidationLessonQuizIdNotAPositiveNumber => 'Abschnitts-Quiz-ID muss eine positive Zahl sein.';

  @override
  String get errorValidationLessonQuizQuestionOptionIdsNumberTooBig => 'Anzahl der IDs für die Abschnittsquizfrage ist zu groß.';

  @override
  String get errorLessonQuizQuestionOptionIdsNumberTooSmall => 'Anzahl der IDs für die Abschnittsquizfragen ist zu klein.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAPositiveNumber => 'Anzahl der IDs für die Abschnittsquizfragen müssen positive Zahlen sein.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAnInteger => 'Anzahl der IDs für die Abschnittsquizfragen müssen ganze Zahlen sein.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotANumber => 'Abschnittsquizfragen-Option-IDs müssen Zahlen sein.';

  @override
  String get errorLessonQuizQuestionOptionIdsNotAnArray => 'Abschnittsquizfragen-Option-IDs müssen ein Array sein.';

  @override
  String get errorLessonQuizQuestionIdEmpty => 'Die Anschnitts-Quizfrage-ID kann nicht leer sein.';

  @override
  String get errorLessonQuizQuestionIdNotANumber => 'Die Anschnitts-Quizfrage-ID muss eine Zahl sein.';

  @override
  String get errorLessonQuizQuestionIdNotAnInteger => 'Die Anschnitts-Quizfrage-ID muss eine ganze Zahl sein.';

  @override
  String get errorLessonQuizQuestionIdNotAPositiveNumber => 'Die Anschnitts-Quizfragen-ID muss eine positive Zahl sein.';

  @override
  String get errorExplanationTypeInvalidEnum => 'Der Erläuterungstyp ist ungültig.';

  @override
  String get errorExplanationTypeNotAString => 'Der Erklärungstyp muss ein String sein.';

  @override
  String get errorExplanationTypeEmpty => 'Der Erläuterungstyp kann nicht leer sein.';

  @override
  String get errorExplanationSrcNotAString => 'Die Erklärungsquelle muss ein String sein.';

  @override
  String get errorExplanationSrcEmpty => 'Die Erklärungsquelle kann nicht leer sein.';

  @override
  String get errorExplanationDurationNotAPositiveNumber => 'Die Erklärungsdauer muss eine positive Zahl sein.';

  @override
  String get errorExplanationDurationNotANumber => 'Die Erklärungsdauer muss eine Zahl sein.';

  @override
  String get errorExplanationDurationEmpty => 'Die Erklärungsdauer kann nicht leer sein.';

  @override
  String get errorExplanationOrientationInvalidEnum => 'Die Erklärungsausrichtung ist ungültig.';

  @override
  String get errorExplanationOrientationNotAString => 'Die Erklärungsausrichtung muss ein String sein.';

  @override
  String get errorExerciseTypeInvalidEnum => 'Der Übungstyp ist ungültig.';

  @override
  String get errorExerciseTypeNotAString => 'Der Übungstyp muss ein String sein.';

  @override
  String get errorExerciseTypeEmpty => 'Der Übungstyp kann nicht leer sein.';

  @override
  String get errorExerciseOrientationInvalidEnum => 'Die Ausrichtung der Übung ist ungültig.';

  @override
  String get errorExerciseOrientationNotAString => 'Die Ausrichtung der Übung muss ein String sein.';

  @override
  String get errorExerciseOrientationEmpty => 'Die Übungsausrichtung kann nicht leer sein.';

  @override
  String get errorExerciseDurationNotAPositiveNumber => 'Die Übungsdauer muss eine positive Zahl sein.';

  @override
  String get errorExerciseDurationNotANumber => 'Die Übungsdauer muss eine Zahl sein.';

  @override
  String get errorExerciseDurationEmpty => 'Die Übungsdauer kann nicht leer sein.';

  @override
  String get errorExerciseSrcNotAString => 'Die Quelle der Übung muss ein String sein.';

  @override
  String get errorExerciseSrcEmpty => 'Die Übungsquelle kann nicht leer sein.';

  @override
  String get errorShortDescriptionNotAString => 'Die Kurzbeschreibung muss ein String sein.';

  @override
  String get errorShortDescriptionEmpty => 'Die Kurzbeschreibung kann nicht leer sein.';

  @override
  String get errorDifficultyEmpty => 'Der Schwierigkeitsgrad kann nicht leer sein.';

  @override
  String get errorScaleBeforeQuestionNotAString => 'Die Skala vor der Frage muss ein String sein.';

  @override
  String get errorScaleBeforeLowestTextNotAString => 'Scale before lowest text muss ein String sein.';

  @override
  String get errorScaleBeforeHighestTextNotAString => 'Scale before highest text muss ein String sein.';

  @override
  String get errorScaleAfterQuestionNotAString => 'Die Skala nach der Frage muss ein String sein.';

  @override
  String get errorScaleAfterLowestTextNotAString => 'Scale after lowest text muss ein String sein.';

  @override
  String get errorScaleAfterHighestTextNotAString => 'Scale after highest text muss ein String sein.';

  @override
  String get errorTechniqueIdNotAPositiveNumber => 'Technique ID muss eine positive Zahl sein.';

  @override
  String get errorTechniqueIdNotAnInteger => 'Technique ID muss eine ganze Zahl sein.';

  @override
  String get errorTechniqueIdNotANumber => 'Technique ID muss eine Nummer sein.';

  @override
  String get errorTechniqueIdEmpty => 'Technique ID kann nicht leer sein.';

  @override
  String get errorSubtitleNotAString => 'Untertitel muss ein String sein.';

  @override
  String get errorSubtitleEmpty => 'Untertitel kann nicht leer sein.';

  @override
  String get errorShortIntroductionNotAString => 'Kurze Einleitung muss ein String sein.';

  @override
  String get errorShortIntroductionEmpty => 'Kurze Einleitung kann nicht leer sein.';

  @override
  String get errorExplanationEmptyArray => 'Explanation kann kein leeres Array sein.';

  @override
  String get errorExplanationNotAnArray => 'Explanation muss ein Array sein.';

  @override
  String get errorTechniquesEmptyArray => 'Techniques können kein leeres Array sein.';

  @override
  String get errorTechniquesNotAnArray => 'Techniques müssen ein Array sein.';

  @override
  String get errorExternalTechniqueIdNotAPositiveNumber => 'Externe Techniques-ID muss eine positive Zahl sein.';

  @override
  String get errorExternalTechniqueIdNotAnInteger => 'Externe Techniques-ID muss eine ganze Zahl sein.';

  @override
  String get errorExternalTechniqueIdNotANumber => 'Externe Techniques-ID muss eine Zahl sein.';

  @override
  String get errorExternalTechniqueIdEmpty => 'Externe Techniques-ID kann nicht leer sein.';

  @override
  String get errorExerciseUnlockStyleInvalidEnum => 'Übung unlock style ist ungültig.';

  @override
  String get errorExerciseUnlockStyleNotAString => 'Übung unlock style muss ein String sein.';

  @override
  String get errorExerciseUnlockStyleEmpty => 'Übung unlock style kann nicht leer sein.';

  @override
  String get errorExercisesNotAnArray => 'Übungen müssen ein Array sein.';

  @override
  String get errorScaleBeforeAnswerNumberTooBig => 'Scale vor Antwortnummer ist zu groß.';

  @override
  String get errorScaleBeforeAnswerNumberTooSmall => 'Scale vor der Antwortnummer ist zu klein.';

  @override
  String get errorScaleBeforeAnswerNotAnInteger => 'Scale vor der Antwort muss eine ganze Zahl sein.';

  @override
  String get errorScaleBeforeAnswerNotANumber => 'Scale vor der Antwort muss eine Zahl sein.';

  @override
  String get errorScaleAfterAnswerNumberTooBig => 'Scale nach der Antwortnummer ist zu groß.';

  @override
  String get errorScaleAfterAnswerNumberTooSmall => 'Scale nach der Antwortnummer ist zu klein.';

  @override
  String get errorScaleAfterAnswerNotAnInteger => 'Scale nach der Antwort muss eine ganze Zahl sein.';

  @override
  String get errorScaleAfterAnswerNotANumber => 'Scale nach der Antwort muss eine Zahl sein.';

  @override
  String get errorScaleEmpty => 'Scale kann nicht leer sein.';

  @override
  String get errorScaleInvalidEnum => 'Scale ist ungültig.';

  @override
  String get errorTimeNotADateString => 'Zeit muss ein Datumsstring sein.';

  @override
  String get errorEmotionNotAnArray => 'Emotion muss ein Array sein.';

  @override
  String get errorEmotionArrayContainsDuplicates => 'Emotion Array enthält Duplikate.';

  @override
  String get errorEmotionArraySizeTooBig => 'Die Größe des Emotionsarrays ist zu groß.';

  @override
  String get errorEmotionNotAString => 'Emotion muss ein String sein.';

  @override
  String get errorEmotionInvalidEnum => 'Emotion ist ungültig.';

  @override
  String get errorPersonNotAnArray => 'Person muss ein Array sein.';

  @override
  String get errorPersonArrayContainsDuplicates => 'Personen-Array enthält Duplikate.';

  @override
  String get errorPersonArraySizeTooBig => 'Größe des Personenarrays ist zu groß.';

  @override
  String get errorPersonNotAString => 'Person muss ein String sein.';

  @override
  String get errorPersonInvalidEnum => 'Person ist ungültig.';

  @override
  String get errorLocationNotAnArray => 'Ort muss ein Array sein.';

  @override
  String get errorLocationArrayContainsDuplicates => 'Location Array enthält Duplikate.';

  @override
  String get errorLocationArraySizeTooBig => 'Location-Array-Größe ist zu groß.';

  @override
  String get errorLocationNotAString => 'Location muss ein String sein.';

  @override
  String get errorFoodNotAnArray => 'Essen muss ein Array sein.';

  @override
  String get errorFoodArrayContainsDuplicates => 'Food Array enthält Duplikate.';

  @override
  String get errorFoodArraySizeTooBig => 'Food-Array-Größe ist zu groß.';

  @override
  String get errorFoodNotAString => 'Food muss ein String sein.';

  @override
  String get errorFoodInvalidEnum => 'Das Lebensmittel ist ungültig.';

  @override
  String get errorNoteNotAString => 'Hinweis muss ein String sein.';

  @override
  String get errorNoteStringTooShort => 'Die Notenzeichenfolge ist zu kurz.';

  @override
  String get errorNoteStringTooLong => 'Die Notenzeichenfolge ist zu lang.';

  @override
  String get errorMoodIdEmpty => 'Mood ID kann nicht leer sein.';

  @override
  String get errorMoodIdNotANumber => 'Mood ID muss eine Zahl sein.';

  @override
  String get errorMoodIdNotAnInteger => 'Mood ID muss eine ganze Zahl sein.';

  @override
  String get errorMoodIdNotAPositiveNumber => 'Mood ID muss eine positive Zahl sein.';

  @override
  String get errorExternalIdNotANumberString => 'Die externe ID muss ein Zahlenstring sein.';

  @override
  String get errorShortTitleNotAString => 'Der Kurztitel muss ein String sein.';

  @override
  String get errorShortTitleEmpty => 'Der Kurztitel kann nicht leer sein.';

  @override
  String get errorDescriptionNotAString => 'Die Beschreibung muss ein String sein.';

  @override
  String get errorDescriptionEmpty => 'Die Beschreibung kann nicht leer sein.';

  @override
  String get errorFunFactNotAString => 'Fun Fact muss ein String sein.';

  @override
  String get errorFunFactEmpty => 'Fun Fact kann nicht leer sein.';

  @override
  String get errorRequiredCompletionDaysNotANumber => 'Erforderliche Fertigstellungstage müssen eine Zahl sein.';

  @override
  String get errorRequiredCompletionDaysNotAnInteger => 'Erforderliche Fertigstellungstage müssen eine ganze Zahl sein.';

  @override
  String get errorRequiredCompletionDaysNotAPositiveNumber => 'Erforderliche Fertigstellungstage müssen eine positive Zahl sein.';

  @override
  String get errorLengthInDaysNotANumber => 'Die Länge in Tagen muss eine Zahl sein.';

  @override
  String get errorLengthInDaysNotAnInteger => 'Die Länge in Tagen muss eine ganze Zahl sein.';

  @override
  String get errorLengthInDaysNotAPositiveNumber => 'Die Länge in Tagen muss eine positive Zahl sein.';

  @override
  String get errorLengthInDaysNumberTooBig => 'Länge in Tagen Zahl ist zu groß.';

  @override
  String get errorRelatedExternalGoalIdsNotAPositiveNumber => 'Bezogene externe Ziel-IDs müssen positive Zahlen sein.';

  @override
  String get errorRelatedExternalGoalIdsNotAnInteger => 'Bezogene externe Ziel-IDs müssen ganze Zahlen sein.';

  @override
  String get errorRelatedExternalGoalIdsNotANumber => 'Bezogene externe Ziel-IDs müssen Zahlen sein.';

  @override
  String get errorRelatedExternalGoalIdsNotAnArray => 'Bezogene externe Ziel-IDs müssen ein Array sein.';

  @override
  String get errorGoalIdEmpty => 'Goal ID kann nicht leer sein.';

  @override
  String get errorGoalIdNotANumber => 'Goal ID muss eine Zahl sein.';

  @override
  String get errorGoalIdNotAnInteger => 'Goal ID muss eine ganze Zahl sein.';

  @override
  String get errorGoalIdNotAPositiveNumber => 'Die Goal ID muss eine positive Zahl sein.';

  @override
  String get errorCompletionDaysPer7DaysNotANumber => 'Fertigstellungstage pro 7 Tage muss eine Zahl sein.';

  @override
  String get errorCompletionDaysPer7DaysNotAnInteger => 'Fertigstellungstage pro 7 Tage muss eine ganze Zahl sein.';

  @override
  String get errorCompletionDaysPer7DaysNotAPositiveNumber => 'Fertigstellungstage pro 7 Tage muss eine positive Zahl sein.';

  @override
  String get errorCompletionDaysPer7DaysNumberTooBig => 'Die Anzahl der Fertigstellungstage pro 7 Tage ist zu groß.';

  @override
  String get errorFilePathEmpty => 'Der Dateipfad kann nicht leer sein.';

  @override
  String get errorFilePathNotAString => 'Der Dateipfad muss ein String sein.';

  @override
  String get errorCategoryIdEmpty => 'Die Kategorie-ID kann nicht leer sein.';

  @override
  String get errorCategoryIdNotANumber => 'Die Kategorie-ID muss eine Zahl sein.';

  @override
  String get errorCategoryIdNotAnInteger => 'Die Kategorie-ID muss eine ganze Zahl sein.';

  @override
  String get errorCategoryIdNotAPositiveNumber => 'Die Kategorie-ID muss eine positive Zahl sein.';

  @override
  String get errorTimesNotAnInteger => 'Zeiten müssen eine ganze Zahl sein.';

  @override
  String get errorTimesNumberTooSmall => 'Die Zeitnummer ist zu klein.';

  @override
  String get errorReviewIdEmpty => 'Die Review ID kann nicht leer sein.';

  @override
  String get errorReviewIdNotANumber => 'Die Review ID muss eine Nummer sein.';

  @override
  String get errorReviewIdNotAnInteger => 'Die Review ID muss eine ganze Zahl sein.';

  @override
  String get errorReviewIdNotAPositiveNumber => 'Die Review ID muss eine positive Zahl sein.';

  @override
  String get errorProgressNotAnArray => 'Der Fortschritt muss ein Array sein.';

  @override
  String get errorProgressEmptyArray => 'Der Fortschritt kann kein leeres Array sein.';

  @override
  String get errorDifficultyNotANumber => 'Der Schwierigkeitsgrad muss eine Zahl sein.';

  @override
  String get errorDifficultyNotAnInteger => 'Der Schwierigkeitsgrad muss eine ganze Zahl sein.';

  @override
  String get errorDifficultyNotAPositiveNumber => 'Der Schwierigkeitsgrad muss eine positive Zahl sein.';

  @override
  String get errorDifficultyNumberTooBig => 'Der Schwierigkeitsgrad ist zu hoch.';

  @override
  String get errorIsTryAgainNotABoolean => 'IsTryAgain muss ein boolescher Wert sein.';

  @override
  String get errorSmartGoalIdEmpty => 'Die Smart Goal ID kann nicht leer sein.';

  @override
  String get errorSmartGoalIdNotANumber => 'Die Smart Goal ID muss eine Zahl sein.';

  @override
  String get errorSmartGoalIdNotAnInteger => 'Die Smart Goal ID muss eine ganze Zahl sein.';

  @override
  String get errorSmartGoalIdNotAPositiveNumber => 'Die Smart Goal ID muss eine positive Zahl sein.';

  @override
  String get errorStartedAtEmpty => 'Anfangen am kann nicht leer sein.';

  @override
  String get errorStartedAtNotAString => 'Angefangen am muss ein String sein';

  @override
  String get errorStartedAtNotADateString => 'Angefangen an muss ein Datum sein';

  @override
  String get errorReasonInvalidEnum => 'Der Grund ist ungültig.';

  @override
  String get errorSessionIdEmpty => 'Die Sitzungs-ID kann nicht leer sein.';

  @override
  String get errorProgressIdEmpty => 'Die Fortschritts-ID darf nicht leer sein.';

  @override
  String get errorProgressIdNotANumber => 'Die Fortschritts-ID muss eine Zahl sein.';

  @override
  String get errorProgressIdNotAnInteger => 'Die Fortschritts-ID muss eine ganze Zahl sein.';

  @override
  String get errorProgressIdNotAPositiveNumber => 'Die Fortschritts-ID muss eine positive Zahl sein.';

  @override
  String get errorCoreAccountIdFailedToSendMessage => 'Die Hauptkonto-ID konnte die Nachricht nicht senden.';

  @override
  String get errorCoreRequestNeedToBeRefetched => 'Die Anfrage muss zurückgerufen werden.';

  @override
  String get errorCoreMvpAccessDenied => 'MVP-Zugriff verweigert.';

  @override
  String get errorCoreAccountIdCanNotParse => 'Account-ID kann nicht geparst werden.';

  @override
  String get errorCoreAccountIdNotAuthenticated => 'Die Konto-ID wurde nicht authentifiziert.';

  @override
  String get errorCoreEmailOrPasswordAreIncorrect => 'Die E-Mail-Adresse oder Passwort sind falsch.';

  @override
  String get errorCoreEmailNotApproved => 'E-Mail nicht genehmigt.';

  @override
  String get errorCoreRefreshTokenHasBeenExpired => 'Das Refresh-Token ist abgelaufen.';

  @override
  String get errorCorePasswordTokenNotFound => 'Passwort-Token nicht gefunden.';

  @override
  String get errorCorePasswordTokenExpired => 'Das Passwort-Token ist abgelaufen.';

  @override
  String get errorAuthAccessTokenInvalid => 'Das Auth-Zugriffstoken ist ungültig.';

  @override
  String get errorAuthRefreshTokenNotFound => 'Auth-Refresh-Token nicht gefunden.';

  @override
  String get errorAccountEmailOrPasswordInvalid => 'Wir konnten deine E-Mail-Adresse nicht aktualisieren. Bitte überprüfe deine Anmeldedaten und versuche es erneut';

  @override
  String get errorAccountIdAlreadyExists => 'Diese E-Mail-Adresse ist falsch oder bereits vergeben.';

  @override
  String get errorAccountIdNotFound => 'Account-ID nicht gefunden.';

  @override
  String get errorAccountEmailNotFound => 'E-Mail oder Passwort sind falsch.';

  @override
  String get errorAccountInvitationNotFound => 'Account Einladung nicht gefunden.';

  @override
  String get errorAccountEmailTokenNotFound => 'Account-E-Mail-Token nicht gefunden.';

  @override
  String get errorAccountPasswordTokenNotFound => 'Kontopasswort-Token nicht gefunden.';

  @override
  String get errorAccountPasswordTokenExpired => 'Das Passwort-Token für das Konto ist abgelaufen.';

  @override
  String get errorAccountEmailExpired => 'Die Kontomail ist abgelaufen.';

  @override
  String get errorAccountEmailPreviouslySubmitted => 'Zuvor übermittelte Kontomail.';

  @override
  String get errorAccountDiabetesTypeNotFound => 'Der Diabetes-Typ des Kontos wurde nicht gefunden.';

  @override
  String get errorAccountSubscriptionCancelActive => 'Kontoabonnement stornieren aktiv.';

  @override
  String get errorAccountPasswordTokenInvalid => 'Das Kontopasswort-Token ist ungültig.';

  @override
  String get errorCoreFileInvalid => 'Die Kerndatei ist ungültig.';

  @override
  String get errorAccountEmailLessThanADayFromLastChange => 'Die Änderung der Kontonummer muss länger als einen Tag zurückliegen.';

  @override
  String get errorPurchaseVerificationError => 'Bei der Verifizierung des Abonnements ist etwas schief gelaufen, bitte versuche es erneut';

  @override
  String get errorSubscriptionIdAbsent => 'Die Abonnement-ID ist nicht vorhanden.';

  @override
  String get errorSubscriptionIosProductIdNotFound => 'Abo iOS Produkt ID nicht gefunden.';

  @override
  String get errorSubscriptionAndroidProductIdNotFound => 'Abonnement Android Produkt ID nicht gefunden.';

  @override
  String get errorSubscriptionAccountIdAbsent => 'Die ID des Abonnementkontos fehlt.';

  @override
  String get errorSubscriptionPurchaseTokenAbsent => 'Das Abonnement-Kauf-Token ist nicht vorhanden.';

  @override
  String get errorSubscriptionPackageNameInvalid => 'Der Name des Abonnementpakets ist ungültig.';

  @override
  String get errorSubscriptionAccountIdInvalid => 'Es sieht so aus, als ob deine Apple-ID bereits ein Abonnement für ein anderes LeanOnMe-Konto hat. Bitte melde dich mit dieser E-Mail-Adresse an, um dein Abonnement zu nutzen. Wenn du Hilfe benötigst, wende dich an support@lean-on.me.';

  @override
  String get errorSubscriptionVendorInvalid => 'Der Anbieter des Abonnements ist ungültig.';

  @override
  String get errorSubscriptionPurchaseTokenInvalid => 'Das Abonnement-Kauf-Token ist ungültig.';

  @override
  String get errorSubscriptionEnvironmentInvalid => 'Die Abonnementumgebung ist ungültig.';

  @override
  String get errorSubscriptionBaseTransactionIdInvalid => 'Die Transaktions-ID der Abonnementbasis ist ungültig.';

  @override
  String get errorSubscriptionTransactionIdInvalid => 'Die ID der Abonnementtransaktion ist ungültig.';

  @override
  String get errorSubscriptionAndroidDataEmpty => 'Die Android-Daten des Abonnements sind leer.';

  @override
  String get errorSubscriptionWithAccountNotFound => 'Abonnement mit Konto nicht gefunden.';

  @override
  String get errorGroupingAccountIdAppFeatureLocked => 'Das App-Feature \"Grouping Account ID\" ist gesperrt.';

  @override
  String get errorGroupingDataOneOptionalFieldRequired => 'Für die Gruppierungsdaten ist ein optionales Feld erforderlich.';

  @override
  String get errorGroupingGenderPreferenceInvalid => 'Die Gruppierungspräferenz für das Geschlecht ist ungültig.';

  @override
  String get errorGroupingBmiRangeCanNotCalculate => 'Der BMI-Bereich der Gruppierung kann nicht berechnet werden.';

  @override
  String get errorGroupingAgeRangeCanNotCalculate => 'Der Altersbereich der Gruppierung kann nicht berechnet werden.';

  @override
  String get errorGroupingAccountGroupingStateCanNotCancel => 'Der Status der Kontogruppierung kann nicht aufgehoben werden.';

  @override
  String get errorGroupingGroupIdNotFound => 'Die ID der Gruppierungsgruppe wurde nicht gefunden.';

  @override
  String get errorGroupingAccountIdAlreadyInGroup => 'Die Konto-ID ist bereits in der Gruppe.';

  @override
  String get errorBuddyAccountAlreadyHaveABuddy => 'Der Account hat bereits einen Buddy.';

  @override
  String get errorBuddyEntityNotFound => 'Buddy Entity nicht gefunden.';

  @override
  String get errorBuddyRefreshTokenNotFound => 'Buddy-Refresh-Token nicht gefunden.';

  @override
  String get errorBuddyRegistrationAlreadyExists => 'Die Buddy-Registrierung existiert bereits.';

  @override
  String get errorBuddyRegistrationAlreadyConfirmed => 'Die Buddy-Registrierung wurde bereits bestätigt.';

  @override
  String get errorBuddyPasswordTokenInvalid => 'Das Buddy-Passwort-Token ist ungültig.';

  @override
  String get errorBuddyRegistrationTokenExpired => 'Das Buddy-Registrierungstoken ist abgelaufen.';

  @override
  String get errorBuddyRegistrationTokenInvalid => 'Das Buddy-Registrierungstoken ist ungültig.';

  @override
  String get errorBuddyInvitationTokenExpired => 'Das Buddy-Einladungs-Token ist abgelaufen.';

  @override
  String get errorBuddyInvitationTokenInvalid => 'Das Buddy-Einladungs-Token ist ungültig.';

  @override
  String get errorBuddyInvitationEmailInvalid => 'Die Buddy-Einladungs-E-Mail ist ungültig.';

  @override
  String get errorBuddyInvitationNotFound => 'Buddy-Einladung nicht gefunden.';

  @override
  String get errorBuddyInvitationHasBeenRejected => 'Die Buddy-Einladung wurde abgelehnt.';

  @override
  String get errorBuddyInvitationAlreadyApproved => 'Die Buddy-Einladung wurde bereits genehmigt.';

  @override
  String get errorBuddyInvitationBuddyOccupied => 'Diese Person ist leider nicht für das Buddy-Programm verfügbar. Fällt dir jemand anderes ein, der dir helfen könnte? Wende dich an den Support, wenn du Hilfe brauchst';

  @override
  String get errorDiabetesTypeNotFound => 'Diabetes-Typ nicht gefunden.';

  @override
  String get errorNutritionMealIdNotFound => 'Nutrition meal ID nicht gefunden.';

  @override
  String get errorNutritionMealFoodItemIdNotFound => 'Nutrition Meal Food Item ID nicht gefunden.';

  @override
  String get errorNutritionMealRecipeIdNotFound => 'Nährwertrezept-ID nicht gefunden.';

  @override
  String get errorNutritionMealDishIdNotFound => 'Die ID des Nährwertgerichts wurde nicht gefunden.';

  @override
  String get errorNutritionFavoriteFoodItemIdNotFound => 'Nutrition Favorite Food Item ID nicht gefunden.';

  @override
  String get errorNutritionFavoriteServingIdNotFound => 'Nutrition Favorite Serving ID nicht gefunden.';

  @override
  String get errorNutritionFavoriteAccountIdNotFound => 'Nutrition Favorite Account ID nicht gefunden.';

  @override
  String get errorNutritionFavoriteAlreadyExists => 'Der Ernährungsfavorit existiert bereits.';

  @override
  String get errorNutritionWeightLogNotFound => 'Ernährungsgewichtsprotokoll nicht gefunden.';

  @override
  String get errorNutritionRecipeIdNotFound => 'Nährwertrezept-ID nicht gefunden.';

  @override
  String get errorNutritionAccountDishesNotFound => 'Gerichte des Ernährungskontos wurden nicht gefunden.';

  @override
  String get errorNutritionDishNotFound => 'Nährwertgericht nicht gefunden.';

  @override
  String get errorNutritionDishFoodItemNotFound => 'Nährwertgericht Lebensmittel nicht gefunden.';

  @override
  String get errorNutritionDishMealRecipeNotFound => 'Nährwertgericht-Rezept nicht gefunden.';

  @override
  String get errorNutritionDishFoodItemsEmpty => 'Die Lebensmittel in der Nährwertschale sind leer.';

  @override
  String get errorFoodPreferencesHateTagNotFound => 'Food Preferences Hate Tag nicht gefunden.';

  @override
  String get errorFoodPreferencesAllergenTagNotFound => 'Das Allergen-Tag für Lebensmittelpräferenzen wurde nicht gefunden.';

  @override
  String get errorFoodPreferencesDislikeTagNotFound => 'Dislike-Tag für Lebensmittelpräferenzen wurde nicht gefunden.';

  @override
  String get errorMentalHealthQuestionIdInvalid => 'Die ID der Frage zur psychischen Gesundheit ist ungültig.';

  @override
  String get errorMentalHealthOptionIdInvalid => 'Die Options-ID für psychische Gesundheit ist ungültig.';

  @override
  String get errorMentalHealthTypeInvalid => 'Psychische Gesundheit Typ ist ungültig.';

  @override
  String get errorMedicalOnboardingQuestionTypeInvalid => 'Fragetyp des medizinischen Onboardings ist ungültig.';

  @override
  String get errorPhysicalActivitiesPhysicalProgramIdNotFound => 'Bewegungsprogramm ID wurde nicht gefunden.';

  @override
  String get errorPhysicalActivitiesPhysicalProgramExerciseIdNotFound => 'Bewegungsprogramm ID wurde nicht gefunden.';

  @override
  String get errorPhysicalActivitiesPreferencesNotFound => 'Voreinstellungen für körperliche Aktivitäten nicht gefunden.';

  @override
  String get errorRiverModuleNotFound => 'River module not found.';

  @override
  String get errorRiverModuleItemNotFound => 'River Element nicht gefunden.';

  @override
  String get errorEducationLessonNotFound => 'Artikel nicht gefunden.';

  @override
  String get errorEducationQuizUpdateNotAllowed => 'Aktualisierung vom Quiz nicht erlaubt.';

  @override
  String get errorEducationQuizSubmitNotFound => 'Aktualisierung vom Quiz nicht erlaubt.';

  @override
  String get errorEducationQuizAlreadySubmitted => 'Das Quiz wurde bereits abgegeben.';

  @override
  String get errorEducationQuizOptionNotFound => 'Wissenssquiz-Option nicht gefunden.';

  @override
  String get errorEducationQuizNotFound => 'Das Wissensquiz wurde nicht gefunden.';

  @override
  String get errorEducationReflectionNotFound => 'Wissensreflexion nicht gefunden.';

  @override
  String get errorEducationReflectionOptionNotFound => 'Wissensreflexion Option nicht gefunden.';

  @override
  String get errorEducationReflectionFeedbackNotFound => 'Wissensreflexions-Feedback nicht gefunden.';

  @override
  String get errorEducationReflectionAlreadySubmitted => 'Wissensreflexion schon abgegeben.';

  @override
  String get errorEducationReflectionFeedbackAlreadySubmitted => 'Wissensreflexion-Feedback wurde bereits eingereicht.';

  @override
  String get errorNutritionPlannedMealIdNotFound => 'Die ID der geplanten Mahlzeit wurde nicht gefunden.';

  @override
  String get errorNutritionPlannedMealDateInvalid => 'Das Datum der geplanten Mahlzeit ist ungültig.';

  @override
  String get errorGroupSessionIdNotFound => 'Die ID der Gruppensitzung wurde nicht gefunden.';

  @override
  String get errorGroupSessionAccountIdNotGrouped => 'Die Konto-ID ist in der Sitzung nicht gruppiert.';

  @override
  String get errorGroupSessionAccountIdNotFound => 'Die ID des Gruppensitzungskontos wurde nicht gefunden.';

  @override
  String get errorGroupSessionAccountIdAlreadySigned => 'Die Konto-ID ist bereits in der Sitzung signiert.';

  @override
  String get errorGroupSessionAccountIdWasNotSigned => 'Die Konto-ID wurde in der Sitzung nicht signiert.';

  @override
  String get errorGroupSessionProgramImageNotFound => 'Das Bild des Gruppensitzungsprogramms wurde nicht gefunden.';

  @override
  String get errorGroupSessionProgramImageInvalidMimeType => 'Das Bild des Gruppensitzungsprogramms hat einen ungültigen MIME-Typ.';

  @override
  String get errorGroupSessionStatusMismatchUpdateFlow => 'Unstimmigkeit des Gruppensitzungsstatus im Update Flow.';

  @override
  String get errorChatAccountIdNotAssignedToGroup => 'Die Chat-Konto-ID ist der Gruppe nicht zugewiesen.';

  @override
  String get errorChatMessageIdNotFound => 'Chatnachrichten-ID nicht gefunden.';

  @override
  String get errorMindTechniqueIdNotFound => 'Geisttechnik-ID nicht gefunden.';

  @override
  String get errorMindExerciseIdNotFound => 'Mind Exercise ID nicht gefunden.';

  @override
  String get errorMoodIdNotFound => 'Mood ID nicht gefunden.';

  @override
  String get errorMoodCreatedAyIsOld => 'Der Tag der Stimmungserstellung ist zu alt.';

  @override
  String get errorSmartGoalStartDateActiveSessionExists => 'Das Smart Goal Startdatum hat eine aktive Sitzung.';

  @override
  String get errorSmartGoalIdNotFound => 'Die Smart Goal ID wurde nicht gefunden.';

  @override
  String get errorSmartGoalSessionIdNotFound => 'Smart Goal Session ID nicht gefunden.';

  @override
  String get errorSmartGoalReviewIdNotFound => 'Die Smart Goal Review ID wurde nicht gefunden.';

  @override
  String get errorSmartGoalProgressLogsInvalid => 'Smart Goal Fortschrittsprotokolle sind ungültig.';

  @override
  String get errorSmartGoalCategoryIdsLocked => 'Smart Goal Category IDs sind gesperrt.';

  @override
  String get errorSmartGoalCategoryIdLocked => 'Die Smart Goal Kategorie ID ist gesperrt.';

  @override
  String get errorSmartGoalSessionIdActiveLimitExceeded => 'Smart Goal Session ID Aktivitätslimit überschritten.';

  @override
  String get errorSmartGoalCategoryIdNotFound => 'Smart Goal Kategorie ID nicht gefunden.';

  @override
  String get errorSmartGoalIdConflictsWithActive => 'Die Smart Goal ID steht im Konflikt mit einem aktiven Ziel.';

  @override
  String get errorSmartGoalIdDuplicatesFound => 'Doppelte Smart Goal IDs gefunden.';

  @override
  String get errorCoreInternalServer => 'Interner Serverfehler.';

  @override
  String get errorRetry => 'Wiederholen';

  @override
  String get errorNoConnectionTitle => 'Keine Verbindung';

  @override
  String get errorNoConnectionText => 'Deine Internetverbindung wurde unterbrochen. \nStelle die Verbindung wieder her und versuche es erneut';

  @override
  String get errorInvalidIngredientText => 'Sorry, ungültige Zutatenangaben';

  @override
  String get errorOeps => 'Ups!';

  @override
  String get errorSomethingWentWrong => 'Etwas ist schief gelaufen \nBitte versuche es später noch einmal';

  @override
  String get errorSubscriptionServiceUnavailable => 'Beim Dienst ist etwas schief gelaufen, bitte versuche es erneut';

  @override
  String get errorPurchaseStreamError => 'Beim Stream-Abonnement ist etwas schief gelaufen, bitte versuche es noch einmal';

  @override
  String get errorPurchaseErrorMessage => 'Produkt wurde nicht gekauft, bitte versuche es erneut';

  @override
  String get errorSomethingIsIncorrect => 'Etwas ist falsch oder fehlt';

  @override
  String get errorServingIdIsNotFound => 'Sorry, ungültige Zutatenangaben';

  @override
  String get errorSocketException => 'Mit dem Socket ist etwas schief gelaufen';

  @override
  String get errorParsingException => 'Etwas ist falsch oder fehlt in den Daten';

  @override
  String get errorLoadTranslations => 'Fehler beim Laden von Übersetzungen';

  @override
  String get errorTimeoutDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorConnectionDio => 'Deine Internetverbindung wurde unterbrochen. \nStelle die Verbindung wieder her und versuche es erneut';

  @override
  String get errorRequestCancelledDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorBadRequestDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorUnauthorizedDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorForbiddenDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorNotFoundDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorConflictDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorServerErrorDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorUnprocessableEntityDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorUnhandledResponseDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorUnhandledErrorDio => 'Etwas ist schief gelaufen.';

  @override
  String get errorOtherDio => 'Etwas ist schief gelaufen';

  @override
  String get onboardingIntroTitle => 'LeanOnMe gibt dir die Werkzeuge an die Hand, um nachhaltig abzunehmen.';

  @override
  String get onboardingIntroProgram1 => 'Es basiert auf einem psychologisch fundierten Programm, das Menschen erfolgreich dabei geholfen hat, langfristig abzunehmen und sich besser zu fühlen.';

  @override
  String get onboardingIntroProgram2 => 'Ernährung, Bewegung, medizinisches Wissen und Unterstützung durch die Community werden mit Psychologie kombiniert, um dir zu helfen, deine Ziele zu erreichen.';

  @override
  String get onboardingIntroMissionTitle => 'Unser Expertenteam bringt den Erfolg des klinischen Programms zu dir!';

  @override
  String get onboardingIntroMissionAndrew => 'Andrew hat einen Doktor in Bio-Chemie und ist der Experte für unser Ernährungsprogramm. Mit individuellen Rezepten, persönlichen Zielen und KEINEN FOKUS AUF KALORIEN ZÄHLEN ist unser Ernährungsprogramm einzigartig.';

  @override
  String get onboardingIntroMissionMaria => 'Maria hat einen Master in digitaler Psychologie und ist das Bindeglied zwischen dem erfolgreichen klinischen Programm und unserer digitalisierten Version.';

  @override
  String get onboardingIntroMissionShalu => 'Shalu ist Fachärztin für Psychiatrie. Mit ihrem Schwerpunkt auf Sucht und Suchtverhalten ist sie bestens qualifiziert, dich auf deinem Weg zu einem glücklicheren und gesünderen Leben zu begleiten und zu unterstützen.';

  @override
  String get onboardingIntroMissionJoshua => 'Josh hat einen Abschluss in Sportwissenschaften und jahrelange Erfahrung als Gesundheitstrainer mit Schwerpunkt Gewichtsabnahme. Er kann Menschen helfen, sich besser zu bewegen und sich besser zu fühlen.';

  @override
  String get onboardingIntroMissionDenise => 'Denise ist eine erfahrene klinische Psychologin, die auch in kognitiver Verhaltenstherapie, Meditation und achtsamkeitsbasierter Therapie ausgebildet ist. Ihre Leidenschaft ist es, Menschen den Mut zur Veränderung zu geben und sie Schritt für Schritt durch diesen Prozess zu begleiten.';

  @override
  String get onboardingPacingTitle => 'In der Ruhe liegt die Kraft.';

  @override
  String get onboardingPacingMessage => 'Unser Programm ist in Module aufgeteilt, die „Pools“ genannt werden. Du solltest mindestens 1 Woche in jedem Pool verbringen, um Wissen aufzunehmen und neue Gewohnheiten einzuüben.';

  @override
  String get onboardingIAmReady => 'Ich bin bereit';

  @override
  String get onboardingPhysicalIntroTitle => 'Erstmal die Grundlagen';

  @override
  String get onboardingPhysicalIntroBody => 'Joshua möchte die Antworten auf einige grundlegende Fragen wissen, damit wir dein Programm individuell gestalten können.';

  @override
  String get onboardingAgeCheckFailedTitle => 'Es tut uns leid. Leider ist deine Registrierung im Moment nicht möglich.';

  @override
  String get onboardingAgeCheckFailedBody => 'Unser Programm ist nicht für Personen unter 18 Jahren geeignet';

  @override
  String get onboardingWhatYourSex => 'Was ist dein biologisches Geschlecht?';

  @override
  String get onboardingSexQuestionBody => 'Bitte gib an, welches biologische Geschlecht für die Berechnung bestimmter Messwerte verwendet werden soll, um das Programm richtig auf dich zuzuschneiden.';

  @override
  String get onboardingSex => 'Biologisches Geschlecht';

  @override
  String get onboardingGenderPageTitle => 'Was ist dein soziales Geschlecht?';

  @override
  String get onboardingHappinessTitle => 'Wie empfindest du deinen derzeitigen Lebensstil?';

  @override
  String get onboardingHappinessBody1 => 'Nimm dir einen Moment Zeit, um über deinen aktuellen Lebensstil nachzudenken.';

  @override
  String get onboardingHappinessBody2 => 'Bitte gib auf der folgenden Skala an, wie du dich im Allgemeinen fühlst, wenn du an deinen derzeitigen Lebensstil denkst.';

  @override
  String get onboardingYourHeight => 'Größe';

  @override
  String get onboardingMetric => 'Metrisch';

  @override
  String get onboardingImperial => 'Imperial';

  @override
  String get onboardingChangeYourHeight => 'Ändere deine Größe';

  @override
  String get onboardingHeightSmall => 'Bist du sicher, dass dies die richtige Größe ist? Sie scheint ziemlich klein zu sein. Bitte korrigiere deine Eingabe';

  @override
  String get onboardingHeightLarge => 'Bist du sicher, dass dies die richtige Größe ist? Sie scheint ziemlich groß zu sein. Bitte korrigiere deine Eingabe';

  @override
  String get onboardingCorrectHeight => 'Bitte korrigiere deine Antwort';

  @override
  String get onboardingYourWeight => 'Gewicht';

  @override
  String get onboardingBmiExclusionBodyTitle => 'Dein Body Mass Index (BMI) ist:';

  @override
  String get onboardingHighBmiDescription1 => 'LeanOnMe bietet derzeit maßgeschneiderte Programme für Menschen mit einem BMI zwischen 25 und 40. Wir arbeiten an weiteren Anpassungen, um Menschen zu unterstützen, die außerhalb dieses BMI-Bereichs liegen, sind aber noch nicht ganz so weit.';

  @override
  String get onboardingHighBmiDescription2 => 'Einige Teile unseres aktuellen Programms sind vielleicht nicht zu 100% auf deine Bedürfnisse zugeschnitten.';

  @override
  String get onboardingHighBmiDescription3 => 'Hör auf deinen Körper und wenn du Bedenken hast, dass etwas nicht zu dir passt, wende dich an support@lean-on.me.';

  @override
  String get onboardingLowerBmiDescription1 => 'Deinem BMI zufolge liegst du in einem gesunden Bereich, das ist toll! Aber das Programm von LeanOnMe wurde entwickelt, um Menschen zu unterstützen, die mit verschiedenen Graden von Übergewicht und Fettleibigkeit leben.';

  @override
  String get onboardingLowerBmiDescription2 => 'Keiner unserer Inhalte ist schlecht für dich, aber manche sind vielleicht nicht so relevant. Viel Spaß!';

  @override
  String get onboardingBmiExclusionBody1 => 'Dein BMI zeigt an, dass du möglicherweise untergewichtig bist. LeanOnMe ist derzeit ein Programm zur Gewichtsreduzierung. In Bezug auf deinen aktuellen BMI könnte eine weitere Gewichtsabnahme deine Gesundheit beeinträchtigen.';

  @override
  String get onboardingBmiExclusionBody2 => 'Bitte konsultiere deinen Hausarzt, um sicherzustellen, dass deine Gesundheit nicht beeinträchtigt wird.';

  @override
  String get onboardingPhysicalCheckPassedTitle => 'Grundlagen abgeschlossen!';

  @override
  String get onboardingAge => 'Alter';

  @override
  String get onboardingHeight => 'Größe';

  @override
  String get onboardingWeight => 'Gewicht';

  @override
  String get onboardingBmi => 'BMI';

  @override
  String get onboardingYears => 'Jahre';

  @override
  String get onboardingBmiDescription1 => 'Der Body-Mass-Index (BMI) misst, anhand deiner Größe und deines Gewichts, ob dein Gewicht für deinen Körper in einem gesunden Bereich liegt.';

  @override
  String get onboardingBmiDescriptionAccent => 'Body Mass Index (BMI)';

  @override
  String get onboardingBmiDescription2 => 'Der BMI hat jedoch seine Grenzen - zum Beispiel kann er nicht zwischen Fett-, Muskel- und Knochengewicht unterscheiden. Wir verwenden ihn zusammen mit anderen Messwerten, um dein Programm anzupassen. Aber keine Sorge: Er wird nicht der einzige Faktor sein, der berücksichtigt wird.';

  @override
  String get onboardingLetsMoveOn => 'Weiter geht\'s';

  @override
  String get onboardingMedicalIntroTitle => 'Medizinischer Check';

  @override
  String get onboardingMedicalIntroBody => 'Um sicherzustellen, dass dieses Programm für deine aktuelle Situation geeignet ist, und um es speziell auf dich zuzuschneiden, beantworte bitte die folgenden Fragen zu deinem Gesundheitszustand.';

  @override
  String get onboardingAreYouPregnant => 'Bist du schwanger?';

  @override
  String get onboardingFailedPregnancyTitle => 'Es tut uns leid. Leider ist deine Registrierung im Moment nicht möglich.';

  @override
  String get onboardingFailedPregnancyBody1 => 'Du erwartest ein Baby.';

  @override
  String get onboardingFailedPregnancyBody2 => 'Dieses Programm ist nicht für Schwangere geeignet.';

  @override
  String get onboardingFailedPregnancyBody3 => 'Wir würden uns freuen, dich nach deiner Schwangerschaft wieder bei uns begrüßen zu dürfen.';

  @override
  String get onboardingFailedPregnancyBody4 => 'Wir wünschen dir und deinem Baby alles Gute!';

  @override
  String get onboardingMedicinesTitle => 'Welche Medikamente nimmst du regelmäßig?';

  @override
  String get onboardingMedicinesPlaceholder => 'Schreibe hier ein Medikament auf';

  @override
  String get onboardingWeightLossMedicationQuestion => 'Nimmst du Medikamente ein, die dir bei der Gewichtsabnahme helfen?';

  @override
  String get onboardingObesityQuestion => 'Wurde bei dir eine sekundäre Form der Adipositas diagnostiziert (z. B. Cushing-Syndrom, Prader-Willi-Syndrom oder Hypogonadismus)?';

  @override
  String get onboardingThyroidDiseaseQuestion => 'Wurde bei dir eine Schilddrüsenerkrankung diagnostiziert (z.B. Hashimoto-Krankheit oder Hypothyreose)?';

  @override
  String get onboardingMetabolicDiseaseQuestion => 'Wurde bei dir eine Form von Stoffwechselstörung diagnostiziert?';

  @override
  String get onboardingHypertensionQuestion => 'Wurde bei dir Bluthochdruck diagnostiziert?';

  @override
  String get onboardingCardiovascularDiseaseQuestion => 'Wurde bei dir eine Herz-Kreislauf-Erkrankung diagnostiziert oder hattest du in den letzten 12 Monaten eine Herzoperation?';

  @override
  String get onboardingStomachReductionQuestion => 'Hattest du in den letzten 3 Jahren eine Magenverkleinerung oder eine bariatrische Operation oder befindest du dich in einer Vorbereitungsphase für eine solche Operation?';

  @override
  String get onboardingDiabetesQuestion => 'Wurde bei dir Diabetes diagnostiziert?';

  @override
  String get onboardingRenalFailureQuestion => 'Wurde bei dir Nierenversagen diagnostiziert?';

  @override
  String get onboardingAsthmaQuestion => 'Wurde bei dir Asthma oder COPD diagnostiziert?';

  @override
  String get onboardingLiverDiseaseQuestion => 'Wurde bei dir eine Hepatitis oder Lebererkrankung diagnostiziert?';

  @override
  String get onboardingSleepApneaSyndromeQuestion => 'Wurde bei dir das Schlafapnoe-Syndrom diagnostiziert?';

  @override
  String get onboardingLocomotorSystemDiseaseQuestion => 'Wurde bei dir eine Erkrankung des Bewegungsapparats diagnostiziert (z. B. Arthritis, Osteoporose, Rücken-/Nackenschmerzen oder eine entzündliche Erkrankung)?';

  @override
  String get onboardingTreatmentByTheDoctorQuestion => 'Wirst du derzeit von einem Psychologen/einer Psychologin behandelt?';

  @override
  String get onboardingMedicalCheckPassedTitle => 'Medizinischer Check abgeschlossen!';

  @override
  String get onboardingMedicalCheckPassedBody => 'Du hast bereits 2 von 3 Abschnitten abgeschlossen. Super, du bist fast fertig!';

  @override
  String get onboardingMedicalCheckFailedTitle => 'Bitte frage deine/n Ärztin/Arzt!';

  @override
  String get onboardingMedicalCheckFailedBody => 'Bitte frage deine/n Ärztin/Arzt, oder Psychologin/Psychologen, bevor du diese App benutzt, ob sie für deinen Gesundheitszustand und/oder deiner Behandlung geeignet ist bei:';

  @override
  String get onboardingMedicalCheckFailedBody2 => 'Bitte beachte, dass wir zusätzlich Selbsthilfegruppen anbieten. Wenn du im weiteren Verlauf des Programms an einer dieser Gruppen teilnehmen möchtest, brauchst du zunächst die Erlaubnis deiner Psychologin/ deines Psychologen.';

  @override
  String get onboardingCardioVascularDisease => 'Herz-Kreislauf-Erkrankungen';

  @override
  String get onboardingStomachReductionDisease => 'Magenverkleinerung';

  @override
  String get onboardingObesity => 'Sekundäre Form der Adipositas';

  @override
  String get onboardingThyroidDisease => 'Schilddrüsenerkrankung';

  @override
  String get onboardingMetabolicDisease => 'Stoffwechselstörung';

  @override
  String get onboardingHypertension => 'Bluthochdruck';

  @override
  String get onboardingDiabetes => 'Diabetes';

  @override
  String get onboardingDiabetesTypeI => 'Diabetes Typ 1';

  @override
  String get onboardingDiabetesTypeII => 'Diabetes Typ 2';

  @override
  String get onboardingRenalFailure => 'Nierenversagen';

  @override
  String get onboardingAsthma => 'Asthma';

  @override
  String get onboardingLiverDisease => 'Lebererkrankung';

  @override
  String get onboardingSleepApneaSyndrome => 'Schlafapnoe-Syndrom';

  @override
  String get onboardingLocomotorSystemDisease => 'Erkrankung des Bewegungsapparates';

  @override
  String get onboardingMentalHealth => 'Psychische Gesundheit';

  @override
  String get onboardingMentalIntroBody1 => 'In diesem Bereich werden dir Fragen zu deinem aktuellen Wohlbefinden, deinen körperlichen Symptomen und deiner Stimmung gestellt.';

  @override
  String get onboardingMentalIntroBody2 => 'Basierend auf diesen Ergebnissen wird das Programm an deine Bedürfnisse angepasst.';

  @override
  String get onboardingYourMentalHealth => 'Deine psychische Gesundheit';

  @override
  String get onboardingMentalHealthIntroTextOne => 'Eine stabile psychische Gesundheit ist eine gute Basis, um deinen Lebensstil erfolgreich zu verbessern.';

  @override
  String get onboardingMentalHealthIntroTextTwo => 'Dieser Teil dauert etwa 15 Minuten.';

  @override
  String get onboardingMentalHealthIntroTextTwoAccent => '15 Minuten';

  @override
  String get onboardingMentalHealthIntroTextThree => 'Du kannst zwischendurch eine Pause machen, solange du diesen Abschnitt innerhalb einer Stunde abschließt.';

  @override
  String get onboardingMentalHealthIntroTextThreeAccent => 'innerhalb einer Stunde';

  @override
  String get onboardingMentalHealthIntroTextFour => 'Wenn du mehr als eine Stunde brauchst, musst du diesen Teil noch einmal von vorne beginnen.';

  @override
  String get onboardingMentalHealthIntroTextFive => 'Du erhältst deine Ergebnisse sofort nach den Fragen.';

  @override
  String get onboardingMentalHealthIntroTextSix => 'Bitte beachte, dass diese Testergebnisse keine Diagnose darstellen. Eine Diagnose kann nur von eine/m Ärztin/Arzt oder eine/m Psychologin/Psychologen gestellt werden.';

  @override
  String onboardingMentalHealthMoreInfo(String appName) {
    return 'In diesem Abschnitt werden dir Fragen aus wissenschaftlich validierten Fragebögen gestellt, die von unserem klinischen Psychologen sorgfältig ausgewählt wurden. \n\nWenn du mehr Informationen über die verwendeten Fragebögen erhalten möchtest, wende dich bitte an $appName.';
  }

  @override
  String get onboardingMentalHealthMoreInfoBold1 => 'wissenschaftlich validierte Fragebögen';

  @override
  String get onboardingMentalHealthMoreInfoBold2 => 'unsere klinische Psychologin';

  @override
  String get onboardingWho8Question => 'Bitte markiere bei jeder Aussage die Antwort, die deiner Meinung nach am besten beschreibt, wie du dich in den letzten zwei Wochen gefühlt hast.';

  @override
  String get onboardingLastTwoWeeks => 'letzte zwei Wochen';

  @override
  String get onboardingPastFourWeeks => 'letzten vier Wochen';

  @override
  String get onboardingPhq15Question => 'Wie stark fühltest du dich im Verlauf der letzten 4 Wochen durch die folgenden Beschwerden beeinträchtigt?';

  @override
  String get onboardingPhq8Question => 'Wie oft fühltest du dich im Verlauf der letzten 2 Wochen durch die folgenden Beschwerden beeinträchtigt?';

  @override
  String get onboardingStartAgain => 'Neu beginnen';

  @override
  String get onboardingWho5ResultTestMinimal => 'In Bezug auf dein allgemeines Wohlbefinden hast du angegeben, dass du dich in den letzten zwei Wochen die meiste Zeit unwohl und energielos gefühlt hast. Wenn deine Stimmung über einen längeren Zeitraum eingschränkt ist und dein allgemeines Wohlbefinden beeinträchtigt ist, empfehlen wir dir eine/n Psychologin/ Psychologen oder deine/n Hausärztin/Hausarzt aufzusuchen, um diese Symptome abzukären. \nPsychologinnen/Psychologen findest du hier:';

  @override
  String get onboardingWho5ResultTestHigh => 'Deine Antworten weisen auf ein hohes allgemeines Wohlbefinden hin. Du hast angegeben, dass du dich in den letzten zwei Wochen im Allgemeinen ausgeglichen, fröhlich und entspannt gefühlt hast.';

  @override
  String get onboardingPhq15ResultMinimal => 'Du hast angegeben, dass du in den letzten vier Wochen keine oder nur wenige körperliche Beschwerden hattest. Das ist großartig.';

  @override
  String get onboardingPhq15ResultMild => 'Du hast angegeben, dass du in den letzten vier Wochen ein paar körperliche Beschwerden hattest. Das ist kein Grund zur Sorge. Leichte körperliche Symptome können auch ein Anzeichen für Stress sein. Es könnte hilfreich sein, den Stress zu reduzieren. Um zu klären, ob diese Beschwerden mit Stress zu tun haben, wende dich bitte an deine/n Hausärztin/Hausarzt.';

  @override
  String get onboardingPhq15ResultMedium => 'Du hast angegeben, dass dich in den letzten vier Wochen eine Reihe von körperlichen Beschwerden belastet haben. Wir empfehlen dir, deine/n Hausärztin/Hausarzt aufzusuchen, um zu überprüfen, ob diese Symptome nur vorübergehend sind. Die Symptome können eine Reaktion deines Körpers auf Stress oder emotionale Probleme sein.';

  @override
  String get onboardingPhq15ResultHigh => 'Du hast angegeben, dass dich in den letzten vier Wochen viele körperliche Beschwerden belastet haben. Diese Symptome können eine medizinische Ursache haben oder auf eine Somatisierungsstörung hinweisen. \n\nDieses Programm ist kein Ersatz für eine medizinische Diagnose oder psychologische Behandlung. Um die Symptome genauer zu überprüfen und ggf. zu behandeln, empfehlen wir, dir deine/n Hausärztin/Hausarzt oder eine/n Psychologin/Psychologen aufzusuchen. Adressen findest du hier:';

  @override
  String get onboardingGad7ResultMinimal => 'Du hast angegeben, dass du in den letzten zwei Wochen die meiste Zeit entspannt warst. Dein Alltag wird nicht durch übermäßige Ängste beeinträchtigt. Toll, mach weiter so.';

  @override
  String get onboardingGad7ResultMild => 'Du hast angegeben, dass du in den letzten zwei Wochen ab und zu Schwierigkeiten hattest, dich zu entspannen. Vielleicht hast du dich auch nervös, ängstlich oder gereizt gefühlt. Mach dir deswegen keine Sorgen. Dies können vorübergehende Symptome sein. Gönne dir öfter mal eine Pause, um dich zu entspannen. \nSollten sich die Symptome jedoch verschlechtern, empfehlen wir ein Gespräch mit einer Psychologin oder einem Psychologen.';

  @override
  String get onboardingGad7ResultMedium => 'Du hast angegeben, dass du dich in den letzten zwei Wochen mehr als die Hälfte der Tage nervös oder ängstlich gefühlt hast. Möglicherweise hast du dir viele Sorgen gemacht und hattest das Gefühl, diese nicht kontrollieren zu können. Das kann für dich im Alltag eine Belastung sein. \n\nWenn die Symptome anhalten oder sich verschlimmern, empfehlen wir ein Gespräch mit einer Psychologin oder einem Psychologen.';

  @override
  String get onboardingGad7ResultHigh => 'Du hast angegeben, dass du dich in den letzten zwei Wochen fast jeden Tag nervös oder ängstlich gefühlt hast. Vielleicht konntest du auch nicht aufhören, dir Sorgen zu machen oder sie kontrollieren. Das kann als sehr belastend empfunden werden. Diese Symptome könnten auf eine Angststörung hinweisen. \n\nUm die Symptome zu überprüfen und ggf. zu behandeln, empfehlen wir dir, eine/n Psychologin/Psychologen aufzusuchen. Adressen findest du hier:';

  @override
  String get onboardingPhq8ResultMinimal => 'Du hast angegeben, dass deine Stimmung in den letzten zwei Wochen an den meisten Tagen positiv war. Toll, mach weiter so und halte Ausschau nach all den positiven Dingen, die dir auf deiner Reise begegnen werden.';

  @override
  String get onboardingPhq8ResultMild => 'Du hast angegeben, dass du dich in den letzten zwei Wochen ab und zu niedergeschlagen gefühlt hast. Vielleicht hattest du auch das Gefühl, hoffnungslos zu sein oder keine Energie zu haben. Im Laufe des LeanOnMe-Programms lernst du den Zusammenhang zwischen Gedanken und Gefühlen kennen und erfährst, was du tun kannst, um deine psychische Gesundheit zu verbessern. \n\nWenn sich die Symptome verschlimmern, empfehlen wir ein Gespräch mit einer Psychologin oder einem Psychologen.';

  @override
  String get onboardingPhq8ResultMedium => 'Du hast angegeben, dass du in den letzten zwei Wochen mehr als die Hälfte der Tage deprimiert warst. Vielleicht hattest du auch Gefühle der Hoffnungslosigkeit oder hast dich niedergeschlagen gefühlt. Im Laufe des LeanOnMe-Programms lernst du den Zusammenhang zwischen Gedanken und Gefühlen kennen und erfährst, was du tun kannst, um deine psychische Gesundheit zu verbessern. \n\nWenn die Symptome anhalten oder sich verschlimmern, empfehlen wir dir ein Gespräch mit einer Psychologin oder einem Psychologen.';

  @override
  String get onboardingPhq8ResultHigh => 'Du hast angegeben, dass deine Stimmung in den letzten zwei Wochen oft stark beeinträchtigt war. Du hast angegeben, dass du dich deprimiert gefühlt hast und in den letzten Wochen oft unter Lustlosigkeit oder Niedergeschlagenheit gelitten hast. Die Symptome deuten auf eine akute psychische Belastung mit emotionaler Beeinträchtigung hin. Dies können Anzeichen für eine vorübergehende depressive Episode sein. \n\nDieses Programm ist kein Ersatz für eine medizinische Diagnose oder psychologische Behandlung. Um die Symptome genauer zu überprüfen und ggf. zu behandeln, empfehlen wir dir, deine/n Hausärztin/Hausarzt oder eine/n Psychologin/Psychologen aufzusuchen. Adressen findest du hier:';

  @override
  String get onboardingPhq8ResultHighest => 'Du hast angegeben, dass deine Stimmung in den letzten zwei Wochen jeden Tag erheblich beeinträchtigt war. Du hast angegeben, dass du dich deprimiert gefühlt hast und in den letzten Wochen oft unter Lustlosigkeit oder Niedergeschlagenheit gelitten hast. Diese Symptome deuten auf ein hohes Maß an psychischer Belastung mit emotionaler Beeinträchtigung hin und könnten ein Hinweis auf eine Depression sein. \n\nDieses Programm ist kein Ersatz für eine medizinische Diagnose oder psychologische Behandlung. Um die Symptome genauer zu überprüfen und ggf. zu behandeln, empfehlen wir dir, deine/n Hausärztin/Hausarzt oder eine/n Psychologin/Psychologen aufzusuchen. Adressen findest du hier:';

  @override
  String get onboardingPhq8FinalResultHigh1 => 'Die Ergebnisse des Fragebogens deuten darauf hin, dass du derzeit unter einer erheblichen psychischen Belastung leidest.';

  @override
  String get onboardingPhq8FinalResultHigh2 => 'Leider ist das Programm nicht für Menschen geeignet, die derzeit unter einer hohen psychischen Belastung leiden, da die Teilnahme an diesem Programm zusätzlichen Stress bedeuten kann.';

  @override
  String get onboardingPhq8FinalResultHigh3 => 'Um diese Symptome abzuklären oder zu behandeln, empfehlen wir, dich an eine/n Psychologin/Psychologe zu wenden. Adressen findest du hier:';

  @override
  String get onboardingPhq8FinalResultHigh4 => 'Wir laden dich ein, den Test zu wiederholen, wenn sich diese Symptome reduziert haben, damit du dich voll und ganz auf deinen Weg der Gewichtsreduktion konzentrieren kannst.';

  @override
  String get onboardingIfYouHaveSuicidalThoughts => 'Wenn du dich in einer akuten Krise befindest oder Selbstmordgedanken hast, wende dich bitte sofort an deine/n Ärztin/Arzt oder an eine der folgenden gebührenfreien 24-Stunden-Notrufnummern:';

  @override
  String get onboardingPersonalProgram => 'Anhand deiner Angaben, erstellen wir ein Programm, das genau auf dich zugeschnitten ist.';

  @override
  String get onboardingSupportMessage => 'Wir möchten dich auf deiner Reise bestmöglich unterstützen und das Programm genau auf dich persönlich zuschneiden.';

  @override
  String get onboardingFeelLimited1 => 'Es hat sich herausgestellt, dass du dich derzeit durch Ängste und körperliche Symptome eingeschränkt fühlst. Wir empfehlen dir, mit deine/m Hausärztin/Hausarzt oder Psychologin/Psychologen zu sprechen.';

  @override
  String get onboardingFeelLimited2 => 'Es hat sich herausgestellt, dass du dich derzeit durch körperliche Symptome eingeschränkt fühlst. Wir empfehlen dir, mit deine/m Hausärztin/Hausarzt oder Psychologin/Psychologen zu sprechen.';

  @override
  String get onboardingFeelLimited3 => 'Es hat sich herausgestellt, dass du dich derzeit durch Angstsymptome eingeschränkt fühlst. Wir empfehlen dir, mit deine/m Hausärztin/Hausarzt oder Psychologin/Psychologen zu sprechen.';

  @override
  String get onboardingFeelLimited4 => 'Es hat sich herausgestellt, dass du dich im Moment in mehreren Bereichen belastet fühlst.';

  @override
  String get onboardingNotATherapy => 'Bitte beachte, dass LeanOnMe keine Therapie ist.';

  @override
  String get onboardingLearnManyThings => 'Du wirst aber viele Dinge lernen, die dich bei deinem mentalen und körperlichen Wohlbefinden unterstützen.';

  @override
  String get onboardingUnlockAllSections => 'Du erhältst Zugang zu allen Bereichen des Programms.';

  @override
  String get onboardingAwailableAreas => 'Die folgenden Bereiche werden dir im Laufe des Programms freigeschaltet:';

  @override
  String get onboardingUnlockBuddyMessage => 'Finde einen Buddy und werde Teil einer Gruppe';

  @override
  String get onboardingWeWillGuideYou => 'Wir werden dich Schritt für Schritt auf deiner Abnehmreise begleiten.\n\nViel Spaß beim Entdecken!';

  @override
  String get onboardingPhq8Fail => 'Es tut uns leid. Leider ist deine Registrierung im Moment nicht möglich.';

  @override
  String get onboardingGeneralWellBeingSummary => 'Zusammenfassung: Allgemeines Wohlbefinden';

  @override
  String get onboardingBodyAndMindBalanceSummary => 'Zusammenfassung: Körperliche Beschwerden';

  @override
  String get onboardingStateOfMindSummary => 'Zusammenfassung: Gefühlslage';

  @override
  String get onboardingCheckCompleted => 'Check abgeschlossen!';

  @override
  String get onboardingYouExceededTimeMessage => 'Tut uns leid, aber du hast das Zeitlimit von einer Stunde überschritten';

  @override
  String get onboardingNoWorriesYouCanDoItLater => 'Aber keine Sorge, du kannst nochmal anfangen';

  @override
  String get onboardingMentalResultSubText1 => 'Du hast den ersten Teil geschafft. Du machst das super. Mach weiter so!';

  @override
  String get onboardingMentalResultSubText2 => 'Du gehst diese Fragen im Nullkommanix durch. Gut gemacht! Du hast die Hälfte der Fragen geschafft!';

  @override
  String get onboardingMentalResultSubText3 => 'Gleich geschafft! Nur noch ein paar letzte Fragen!';

  @override
  String get avatarAvatar => 'Avatar';

  @override
  String get avatarSelectProfilePicture => 'Wähle dein Profilbild aus';

  @override
  String get avatarMoveToResize => 'zum Ändern der Größe bewegen';

  @override
  String get avatarChooseYourAvatar => 'Wähle deinen Avatar';

  @override
  String get avatarAddPhoto => 'Foto hinzufügen';

  @override
  String get avatarSizeErrorMessageTitle => 'Ups! Es sieht so aus, als ob das Bild, das du hochzuladen versuchst, die Größenbeschränkung von 10 MB überschritten hat.';

  @override
  String get avatarSizeErrorMessageSubtitle => 'Bitte wähle eine kleinere Datei und versuche es erneut.';

  @override
  String get avatarGoToAppSettings => 'Gehe zu den App-Einstellungen';

  @override
  String get avatarGaleryPermissionsMessage => 'Bitte erlaube den Zugriff auf deine Galerie';

  @override
  String get avatarGaleryPermissionsMessageAndroid => 'Bitte erlaube den Zugriff auf deine Mediengalerie und Kamera';

  @override
  String get avatarCropper => 'Zuschneiden';

  @override
  String get smartGoalsMyGoals => 'Meine Ziele';

  @override
  String get smartGoalsNoGoalsSelected => 'Noch keine Ziele ausgewählt';

  @override
  String get smartGoalsChooseGoalsForUpcomingDays => 'Wähle Ziele für die kommenden 7 Tage';

  @override
  String get smartGoalsUpcomingGoals => 'Kommende Ziele';

  @override
  String get smartGoalsUpcomingGoalsTitle => 'Setze Ziele';

  @override
  String get smartGoalsUpcomingGoalsDescription => 'Du kannst bis zu 2 Ziele für die kommenden 7 Tage auswählen.';

  @override
  String get smartGoalsCancelGoal => 'Ziel abbrechen';

  @override
  String get smartGoalsCancelGoalTitle => 'Dein Ziel abbrechen?';

  @override
  String get smartGoalsCancelGoalSubTitle => 'Bitte nenne uns den Grund, warum du dieses Ziel abbrechen möchtest.';

  @override
  String get smartGoalsSetGoal => 'Ziel setzen';

  @override
  String get smartGoalsSelectGoalsCategoryTitle => 'Wähle eine Kategorie';

  @override
  String get smartGoalsNewLabel => 'Neu';

  @override
  String get smartGoalsSelectGoalsTitle => 'Wähle ein Ziel';

  @override
  String get smartGoalsSelectGoalsSubtitle => 'Du hast 7 Tage Zeit, um dein Ziel zu erreichen. Gezählt werden die einzelnen Tage, an denen du Einträge machst.';

  @override
  String get smartGoalsSaveWeeklyGoalsSuccessMessage => 'Ziele wurden zu deiner wöchentlichen Liste hinzugefügt';

  @override
  String get smartGoalsStatisticsTitle => 'Deine bevorzugten Zielkategorien';

  @override
  String get smartGoalsAccomplishedInTotal => 'Ziele, die insgesamt erreicht wurden.';

  @override
  String get smartGoalsAccomplishedEmptyMessage => 'Sobald du anfängst, Ziele zu erreichen, werden deine Lieblingszielkategorien hier angezeigt.';

  @override
  String get smartGoalsAccomplished => 'erreichte Ziele';

  @override
  String smartGoalsGoalLogDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ziel: $count geloggte Tage in einer Woche',
      one: 'Ziel: $count  geloggte Tage in einer Woche',
      zero: 'Ziel: $count geloggte Tage in einer Woche',
    );
    return '$_temp0';
  }

  @override
  String smartGoalsGoalLogged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Geloggte Tage: $count',
      one: 'Geloggte Tage: $count',
      zero: 'Geloggte Tage: $count',
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
  String get smartGoalsGoalCompleted => 'Abgeschlossen: Ja';

  @override
  String get smartGoalsGoalNotCompleted => 'Abgeschlossen: Nein';

  @override
  String get smartGoalsHowHardWasTheGoal => 'Wie schwierig war dieses Ziel für dich?';

  @override
  String get smartGoalsWantToTryInFuture => 'Willst du es in Zukunft noch einmal machen?';

  @override
  String get smartGoalsGoalReview => 'Überblick';

  @override
  String smartGoalsWeeklyDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage mehr bis zum Abschluss',
      one: '1 Tag mehr bis zum Abschluss',
      zero: 'Keine Tage mehr bis zum Abschluss',
    );
    return '$_temp0';
  }

  @override
  String get smartGoalsWeeklyDayLeft => '1 Tag bis zum Abschluss';

  @override
  String get smartGoalsWeeklyDaysReview => 'Beendet';

  @override
  String smartGoalsWeeklyTimes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Mal',
      one: '1 Mal',
      zero: 'Keine Male',
    );
    return '$_temp0';
  }

  @override
  String get smartGoalsReasonGoalNotLike => 'Ich mag es nicht.';

  @override
  String get smartGoalsReasonGoalChallenging => 'Das Ziel ist zu herausfordernd.';

  @override
  String get smartGoalsReasonGoalMissing => 'Mir fehlt noch etwas, um es zu vervollständigen.';

  @override
  String get smartGoalsReasonGoalHabit => 'Das Ziel ist bereits eine Gewohnheit.';

  @override
  String get smartGoalsReasonGoalSpecific => 'Kein spezifischer Grund.';

  @override
  String get nutritionProteinDegree => 'Proteingehalt';

  @override
  String get nutritionFiber => 'Ballaststoffe';

  @override
  String get nutritionCalorieDensity => 'Kaloriendichte';

  @override
  String get buddyTitle => 'Buddy';

  @override
  String get buddyBuddy => 'Buddy';

  @override
  String get buddyUnlocked => 'Buddy freigeschaltet';

  @override
  String get buddyUnlockedBody => 'Du kannst anfangen einen Buddy im Profilbereich zu finden.';

  @override
  String get buddyGoToPreferences => 'Zu den Buddypräferenzen gehen';

  @override
  String get buddyIntroTitle => 'Finde deinen Buddy';

  @override
  String get buddyDescriptionTitle => 'Wie finde ich einen Buddy?';

  @override
  String get buddyIntroBody => 'Mit einem Buddy an deiner Seite ist es nicht nur wahrscheinlicher, dass du deine Ziele erreichst, sondern auch, dass du jemanden hast, der deinen Weg mit dir teilt und es dadurch leichter wird. \n\nUm auf Kurs zu bleiben, ist ein Buddy sehr zu empfehlen. Das gilt vor allem, wenn du dich auch einer Gruppe anschließen willst. Mache dein soziales Netzwerk so stark wie möglich';

  @override
  String get buddyIntroYesBtn => 'Ja, ich möchte einen Buddy';

  @override
  String get buddyIntroNoBtn => 'Vielleicht mache ich das später';

  @override
  String get buddyDescriptionContent => 'Es ist toll, dass du deine Reise teilen willst! \nAber wie findest du eigentlich einen Buddy? \n\nProbiere es aus, indem du mit Menschen in deinem näheren sozialen Umfeld über die Buddy-Mitgliedschaft sprichst. \n\nHier sind ein paar Dinge, die du erwähnen kannst, wenn du mit einem Freund sprichst, der interessiert ist: \n- die Rolle, die ein Buddy auf deiner Reise spielt\n- was du von einem Buddy brauchst und wie du die Grenzen eurer potenziellen Buddy-Beziehung besprichst\n- als Buddy würden sie Zugang zum Buddy-Netzwerk erhalten, um zu erfahren, wie sie dich am besten unterstützen können\n\nDer vorangegangene Abschnitt \"Einen Buddy finden\" kann dir auch einen Einblick geben, wie du dabei vorgehen kannst. \n\nWenn du einen Freund oder eine Freundin gefunden hast, der/die bereit ist, sich dir anzuschließen, gehe auf dein Profil und fülle die Buddy-Einstellungen aus. Sobald du das ausgefüllt hast, erhält dein Freund eine Einladung, dem Buddy-Netzwerk beizutreten. \n\n';

  @override
  String get buddyPreferences => 'Buddy-Präferenzen';

  @override
  String get buddyNoPreferencesState => 'Willst du einen Buddy hinzufügen?';

  @override
  String get buddyCompleted => 'Buddy-Präferenzen\nabgeschlossen';

  @override
  String get buddyCompletedContent => 'Dein Buddy wird in Kürze eine Einladung erhalten. Du wirst benachrichtigt, sobald dein Buddy geantwortet hat.';

  @override
  String get buddyLiveTogetherTitle => 'Wohnst du mit deinem Buddy zusammen?';

  @override
  String get buddyRelationTitle => 'Welches Verhältnis hast du zu deinem Buddy?';

  @override
  String get buddyEmailTitle => 'Wie lautet die E-Mail Adresse deines Buddys?';

  @override
  String get buddyEmailLabel => 'Über diese E-Mail-Adresse wird dein Buddy eingeladen, an deiner Reise teilzunehmen.';

  @override
  String get buddyEmailHint => 'Buddy-E-Mail-Adresse';

  @override
  String get buddyPartner => 'Partner/in';

  @override
  String get buddyChild => 'Kind';

  @override
  String get buddyParent => 'Elternteil';

  @override
  String get buddyFamily => 'Familie';

  @override
  String get buddyFriend => 'Freund/in';

  @override
  String get buddyPendingTitle => 'Wir haben eine Einladung an deinen Buddy geschickt';

  @override
  String buddyPendingSubTitle(String date, String time) {
    return 'Diese Einladung wurde am\n$date um $time gesendet.\n\nDu wirst benachrichtigt, sobald dein Buddy geantwortet hat.';
  }

  @override
  String get buddyRejectTitle => 'Dein Buddy hat die Einladung nicht angenommen';

  @override
  String get buddyRejectSubTitle => 'Leider kann dein Freund dich nicht auf deiner Reise begleiten. Es kann viele verschiedene Gründe geben, warum sie/er nicht mitkommen kann, aber lass dich davon nicht entmutigen! Versuche, einen anderen Buddy zu finden.\n\nBitte sprich mit Freunden und Bekannten darüber, ob sie bereit sind, dein Buddy zu sein, bevor du die nächste Einladung verschickst. \n\nHast du Probleme, einen Buddy zu finden? Der Artikel \"Einen Buddy finden\" kann dir einen Einblick geben, wie du dieses Thema mit anderen angehen kannst.\n\nDu kannst ganz einfach eine andere Person einladen, an deiner Reise teilzunehmen.';

  @override
  String get buddyNotAvailableTitle => 'Dein Buddy ist nicht mehr in der Lage, dich zu unterstützen';

  @override
  String get buddyNotAvailableSubTitle => 'Leider kann dein aktueller Buddy nicht da sein, um dich so zu unterstützen, wie es ein Buddy tut. \n\nKein Grund zur Sorge, es gibt einen anderen Buddy da draußen. Sprich mit deinen engen Freunden und frag herum, ob sich einer von ihnen dir anschließen möchte.\n\nDie Unterrichtseinheit \"Einen Buddy finden\" kann dir auch dabei helfen, einen neuen Buddy zu finden. \n\nDu kannst ganz einfach eine andere Person einladen, an deiner Reise teilzunehmen.';

  @override
  String get buddyResendInvitation => 'Einladung erneut senden';

  @override
  String get buddyInviteAnotherBuddy => 'Einen anderen Buddy einladen';

  @override
  String get buddyFindAnotherBuddyContent => 'Bitte beachte: Wenn du einen neuen Buddy willst, wird dein aktueller Buddy benachrichtigt, dass du diese Anfrage gestellt hast.';

  @override
  String get buddyFindAnotherBuddy => 'Ja, ich will einen anderen Buddy';

  @override
  String get buddyNotNeedAnotherBuddy => 'Nein, ich möchte diesen Buddy behalten';

  @override
  String get buddyEmail => 'Buddy E-Mail';

  @override
  String get buddyUserName => 'Buddy-Benutzername';

  @override
  String get buddySince => 'Buddy seit';

  @override
  String get buddyRemoveInvite => 'Einladung entfernen';

  @override
  String get buddyRemoveBuddy => 'Buddy entfernen';

  @override
  String get buddyInviteBuddy => 'Buddy einladen';

  @override
  String buddyFindAnotherBuddyLabel(String name) {
    return 'Bist du sicher, dass du $name als deinen aktuellen Buddy entfernen möchtest?';
  }

  @override
  String get buddyFindAnotherBuddyContentOne => 'Wir glauben an unser Buddy-Programm und empfehlen dir, deinen Buddy zu behalten oder jemanden einzuladen, der dich besser ermutigen kann.';

  @override
  String get buddyFindAnotherBuddyContentTwo => 'Bitte beachte: Wenn du einen neuen Buddy willst, wird dein aktueller Buddy benachrichtigt, dass du diese Anfrage gestellt hast.';

  @override
  String get linksTermsAndConditionsUrl => 'https://lean-on.me/de-DE/terms-and-conditions';

  @override
  String get linksPrivacyPolicyUrl => 'https://lean-on.me/DE-de/privacy-policy';

  @override
  String get linksPsychologistConsulting => 'https://www.bptk.de/patient-innen/#psychotherapeutensuche';

  @override
  String get linksInstructionsUrl => 'https://loopcare-pdf-instructions.s3.eu-central-1.amazonaws.com/Dokument2-2.pdf';

  @override
  String get riverOverviewTitle => 'Meine Reise';

  @override
  String get riverGuidancePracticeTitle => 'Übung macht den Meister.';

  @override
  String get riverGuidancePracticeDescription => 'Der Kalender wird dein täglicher Anker sein, um das Gelernte zu üben.';

  @override
  String get riverGuidanceProfileTitle => 'Dein Profil und deine Accounteinstellungen.';

  @override
  String get riverGuidanceProfileDescription => 'Im Profil kannst du deine Kontoeinstellungen anpassen, persönliche Präferenzen ändern und auf vergangene Aufgaben und Funktionen zugreifen.';

  @override
  String get riverGuidanceCompletedTitle => 'Gratuliere, \"Der Anfang\" ist abgeschlossen.';

  @override
  String get riverGuidanceCompletedDescription => 'Du kannst jetzt mit dem ersten Pool fortfahren: Was ist deine Motivation?';

  @override
  String riverModuleCompletedTitle(String module) {
    return 'Glückwunsch, du hast das Modul abgeschlossen: \"$module\"';
  }

  @override
  String riverModuleCompletedDescription(String nextModule) {
    return 'Keine Eile, du kannst in diesem Modul bleiben und die Übungen so oft wiederholen, wie du willst. Wenn du bereit bist, kannst du zum nächsten Modul übergehen: „$nextModule“.';
  }

  @override
  String get riverLastModuleCompletedDescription => 'Nimm dir Zeit, die vorherigen Module noch einmal durchzugehen und die Übungen zu vertiefen, wann immer du sie brauchst.\nDu hast bis zu diesem Punkt eine tolle Leistung erbracht! Bleib dran, bald gibt es noch mehr spannende Inhalte!';

  @override
  String get riverGuidanceStartRiverTitle => 'Prima!';

  @override
  String get riverGuidanceStartRiverDescription => 'Tippe jetzt auf die anderen Icons, um Funktionen freizuschalten und zu entdecken.';

  @override
  String get riverModuleGraduationCompletedItemsTitle => 'Super! Du hast alle Abschnitte in diesem Modul abgeschlossen.';

  @override
  String get riverModuleGraduationCompletedTimeTitle => 'Dein Modul ist vollständig eingefärbt, d.h. du hast die Reflexion vor über 7 Tagen zum ersten Mal gelesen.';

  @override
  String get riverModuleGraduationCompletedItemsMessage => 'Du bist dem Abschluss dieses Abschnitts einen Schritt näher gekommen. Aber bevor du zum nächsten Modul übergehen kannst, solltest du noch einmal üben und darüber nachdenken, was du in diesem Pool gelernt hast.\n\nSobald der 7-Tage-Timer diesen Pool mit Farbe gefüllt hat, kannst du zum nächsten Pool übergehen.';

  @override
  String get riverModuleGraduationCompletedTimeMessage => 'Keine Eile: Jedes Modul braucht seine Zeit. Denke weiter nach! Wenn du alle notwendigen Schritte abgeschlossen hast, fragen wir dich, ob du bereit bist, weiterzumachen. Brauchst du Hilfe? Wende dich per E-Mail an support@lean-on.me und einer unserer Experten hilft dir gerne weiter.';

  @override
  String get subscriptionTrialTitle => 'Die ersten 2 Wochen kostenlos!';

  @override
  String get subscriptionTrialLabel => 'Nach der Probezeit bist du registriert und \nkannst danach monatlich kündigen.';

  @override
  String get subscriptionTrialExpiredTitle => 'Deine Probezeit ist abgelaufen';

  @override
  String get subscriptionTrialExpiredLabel1 => 'Wir hoffen, dass dir unser Programm gefallen hat.';

  @override
  String get subscriptionTrialExpiredLabel2 => 'Wenn du weitermachen möchtest,\naktualisiere dein Abonnement hier:';

  @override
  String get subscriptionEndedTitle => 'Dein Abonnement \nist beendet';

  @override
  String get subscriptionEmptyToRestore => 'Leider hat der Store kein Abonnement übermittelt, das wir wiederherstellen können. Wenn du der Meinung bist, dass es sich hierbei um einen Fehler handelt, sende bitte einen Nachweis des Abonnements an support@lean-on.me.';

  @override
  String get subscriptionEndedLabel1 => 'Wir hoffen, dass dir unser Programm gefallen hat.';

  @override
  String get subscriptionEndedLabel2 => 'Wenn du weitermachen möchtest,\naktualisiere dein Abonnement hier:';

  @override
  String get subscriptionCancelledTitle => 'Dein Abonnement \nwurde gekündigt';

  @override
  String get subscriptionCancelledLabel1 => 'Wir hoffen, unser Programm hat dir gefallen.';

  @override
  String get subscriptionCancelledLabel2 => 'Wenn du weitermachen möchtest,\naktualisiere dein Abonnement hier:';

  @override
  String get subscriptionRenewedTitle => 'Dein Abonnement \nkonnte nicht verlängert werden';

  @override
  String get subscriptionRenewedLabel => 'Wir möchten dich darüber informieren, dass dein\nAbonnement nicht automatisch\nverlängert werden konnte. \n\nDu bekommst ein paar Tage Zeit, um dies zu überprüfen.\nWährend dieser Zeit kannst du die App weiterhin nutzen.';

  @override
  String get subscriptionRestoreLabel => 'Kauf wiederherstellen';

  @override
  String get subscriptionTermsLabel => 'Allgemeine Geschäftsbedingungen';

  @override
  String get subscriptionPrivacyLabel => 'Datenschutzinformation';

  @override
  String get subscriptionAnnual => 'Jährlich';

  @override
  String get subscriptionMonthly => 'Monatlich';

  @override
  String get subscriptionSubscribe => 'Abonnieren';

  @override
  String get subscriptionRedeem => 'Einlösen';

  @override
  String subscriptionSubTitlePrice(String description) {
    return '$description';
  }

  @override
  String subscriptionTitlePrice(String title, String priceWithCurrency) {
    return '$title $priceWithCurrency';
  }

  @override
  String get subscriptionSubscription => 'Abonnement';

  @override
  String get subscriptionManageSubscription => 'Abonnement verwalten';

  @override
  String get subscriptionType => 'Abonnement-Typ';

  @override
  String get subscriptionSubscriptionVia => 'Abonnement über';

  @override
  String get subscriptionMemberSince => 'Mitglied seit';

  @override
  String get subscriptionAutomaticRenewalOn => 'Automatische Erneuerung am';

  @override
  String get subscriptionServiceUnavailable => 'Der Dienst ist nicht verfügbar,\nbitte versuche es später.';

  @override
  String get subscriptionOtherPurchaseVendor => 'Sorry, dein Abonnement scheint bei einem anderen Anbieter gekauft worden zu sein.';

  @override
  String get subscriptionAppStore => 'App Store';

  @override
  String get subscriptionGoogleMarket => 'Play Market';

  @override
  String get subscriptionCancelAccountSubscription => 'Bevor du dein Konto bei LeanOnMe löschst, nimm dir bitte einen Moment Zeit, um dein Abonnement zu kündigen. So verhinderst du zukünftige Gebühren. Wenn du dazu bereit bist, tippe auf \"Abonnement verwalten\", um zu den Einstellungen deines Geräts zu gelangen';

  @override
  String get subscriptionOtherPurchaseVendorCancelAccountSubscription => 'Dein Abonnement scheint bei einem anderen Anbieter gekauft worden zu sein.';

  @override
  String get subscriptionRestoreSubscriptionFromSettings => 'Bitte nimm dir einen Moment Zeit, um dein Abonnement über die Abonnementeinstellungen neu zu abonnieren. Wenn du bereit bist fortzufahren, tippe auf \"Abonnement verwalten\", um zu deinen Geräteeinstellungen zu gelangen';

  @override
  String get subscriptionAskRestoreSubscription => 'Sorry, dein Abonnement scheint gekauft zu sein, ist aber nicht verifiziert. Bitte tippe auf Kauf wiederherstellen, um es zu verifizieren.';

  @override
  String get subscriptionDuplicateSubscriptionFromSettings => 'Dieses Abonnement scheint bereits gekauft worden zu sein. Bitte nimm dir einen Moment Zeit, um dein Abonnement in den Abonnementeinstellungen neu zu abonnieren. Wenn du bereit bist, fortzufahren, tippe auf \"Abonnement verwalten\", um zu den Einstellungen deines Geräts zu gelangen';

  @override
  String get subscriptionRecommendedAccess => 'empfohlen';

  @override
  String get subscriptionLimitedAccess => 'Befristetes Angebot';

  @override
  String get subscriptionLifeTimeAccess => 'Lifetime Zugang';

  @override
  String get subscriptionFlexibleAccess => 'flexibler Zugang';

  @override
  String get subscriptionMonth => 'monatlich';

  @override
  String get subscriptionQuarterly => 'vierteljährlich';

  @override
  String get subscriptionAnnually => 'jährlich';

  @override
  String get subscriptionWeekly => 'wöchentlich';

  @override
  String get subscriptionDaily => 'Tage';

  @override
  String get subscriptionDescriptionLabel => 'Jederzeit im Abo-Center kündigen';

  @override
  String get subscriptionGenericTitle => 'Deine Reise beginnt jetzt.';

  @override
  String get emergencyAssistanceTitle => 'Medizinische Notfallhilfe';

  @override
  String get emergencyAssistanceNumber => '112';

  @override
  String get emergencyAssistanceLabel => '112';

  @override
  String get emergencyUsLifelineTitle => 'Telefonseelsorge';

  @override
  String get emergencyUsLifelineTitleNumber => '08001110111';

  @override
  String get emergencyUsLifelineTitleLabel => '08001110111';

  @override
  String get emergencyCrisisChatTitle => '';

  @override
  String get emergencyCrisisChatUrl => '';

  @override
  String get emergencyCrisisChatLabel => '';

  @override
  String get emergencySelfHarmLineTitle => 'Polizei';

  @override
  String get emergencySelfHarmLineNumber => '110';

  @override
  String get emergencySelfHarmLineLabel => '110';

  @override
  String get emergencyLGBTQLineTitle => '';

  @override
  String get emergencyLGBTQLineNumber => '';

  @override
  String get emergencyLGBTQLineLabel => '';

  @override
  String get emergencyNationalHotlineTitle => 'Ärztlicher Bereitschaftsdienst';

  @override
  String get emergencyNationalHotlineNumber => '116 117';

  @override
  String get emergencyNationalHotlineLabel => '116 117';

  @override
  String get emergencyVeteransLineTitle => '';

  @override
  String get emergencyVeteransLineUrl => '';

  @override
  String get emergencyVeteransLineLabel => '';

  @override
  String introTitle(String projectName) {
    return 'Willkommen bei $projectName!';
  }

  @override
  String get introBodyTextFirst => 'Dieses Programm wurde speziell für Menschen mit Übergewicht und Adipositas entwickelt, die nachhaltig abnehmen und ihren Lebensstil ändern wollen.';

  @override
  String get introBodyTextSecond => 'Wenn diese Beschreibung auf dich zutrifft, lass uns deine Reise beginnen.';

  @override
  String loginTitle(String projectName) {
    return 'Willkommen zurück bei $projectName';
  }

  @override
  String get forgotPasswordTitle => 'Passwort vergessen';

  @override
  String get forgotPasswordSubTitle => 'Deine E-Mail-Adresse';

  @override
  String get forgotPasswordBody => 'Gib deine E-Mail-Adresse ein. Du erhältst eine Anleitung zum Zurücksetzen deines Passworts';

  @override
  String get minutes => 'Minuten';

  @override
  String stepCounter(String currentStep, String totalSteps) {
    return 'Schritt $currentStep von $totalSteps';
  }

  @override
  String get yes => 'ja';

  @override
  String get no => 'nein';

  @override
  String get legalStatement => 'Rechtliche Erklärung';

  @override
  String get legalStatementTextOne => 'Für deine eigene Gesundheit und Sicherheit ist es wichtig, dass du alle Fragen wahrheitsgemäß beantwortet hast';

  @override
  String get legalStatementTextTwo => 'Um fortzufahren, bitte lies und akzeptiere unsere rechtliche Erklärung';

  @override
  String get readLegalStatement => 'Rechtliche Erklärung lesen';

  @override
  String get legalStatementCheckboxTitle => 'Ich bestätige hiermit, dass:';

  @override
  String get legalStatementCheckboxItemOne => 'meine Antworten nach bestem Wissen und Gewissen wahrheitsgemäß sind und ich auch in Zukunft Fragen wahrheitsgemäß beantworten werde.';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get openLinkErrorMessage => 'Link kann nicht geöffnet werden';

  @override
  String get signUpWelcomeTitle => 'Glückwunsch, du kannst jetzt das LeanOnMe Programm beginnen';

  @override
  String get signUpWelcomeBody => 'Schön, dass du dabei bist. Erstelle deinen Account, um deine Reise zu beginnen';

  @override
  String get createAccount => 'Account erstellen';

  @override
  String get whatIsYourName => 'Welchen Namen möchtest du verwenden';

  @override
  String get niceToMeetYou => 'Schön dich kennenzulernen';

  @override
  String get enterPasswordSubTitle => 'Welches Passwort möchtest du verwenden';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get passwordStrengthToShort => 'Dein Passwort ist zu kurz';

  @override
  String get passwordStrengthToLong => 'Dein Passwort ist zu lang';

  @override
  String get passwordStrengthNotSecure => 'Noch nicht sicher genug...';

  @override
  String get passwordStrengthMiddle => 'Sieht besser aus, füge ein bisschen mehr hinzu';

  @override
  String get passwordStrengthNice => 'Das sieht gut und sicher aus!';

  @override
  String get passwordValidationRule1 => 'mindestens acht Zeichen';

  @override
  String get passwordValidationRule2 => 'mindestens eine Zahl';

  @override
  String get passwordValidationRule3 => 'mindestens ein Sonderzeichen';

  @override
  String get emailTitle => 'Bitte gib deine E-Mail-Adresse jetzt an';

  @override
  String get emailBody => 'Du erhältst eine E-Mail zur Bestätigung deiner Adresse';

  @override
  String get termsAndConditions => 'Allgemeine Geschäftsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzinformation';

  @override
  String get termsAndConditionsTitle => 'Allgemeine Geschäftsbedingungen';

  @override
  String get privacyPolicyTitle => 'Datenschutzinformation';

  @override
  String get iAcceptThe => 'Ich akzeptiere die';

  @override
  String get pleaseAcceptTOC => 'Bitte akzeptiere die allgemeinen Geschäftsbedingungen';

  @override
  String get pleaseAcceptPrivacyPolicy => 'Bitte akzeptiere die Datenschutzinformation';

  @override
  String get register => 'Registrieren';

  @override
  String get receiveEmailCheckboxLabel => 'Ich bin damit einverstanden, gelegentlich E-Mails über Updates zu erhalten';

  @override
  String get waitingForConfirmationTitle => 'Du hast Post';

  @override
  String get resendConfirmationMessage => 'Wir haben gerade eine weitere E-Mail an dich geschickt';

  @override
  String get waitingForConfirmationSubtitle => 'Bitte bestätige deine E-Mail-Adresse';

  @override
  String get waitingForConfirmationBody => 'Keine Eile, du kannst deine E-Mail-Adresse auch später bestätigen. Die E-Mail wurde geschickt an:';

  @override
  String get waitingForConfirmationBody3 => 'Wenn du keine Nachricht erhalten hast, überprüfe deinen Spam-Ordner';

  @override
  String get waitingForConfirmationBody4 => 'Keine Nachricht in deinem Posteingang? Bitte klicke auf den untenstehenden Link';

  @override
  String get resend => 'Bestätigungsmail erneut senden';

  @override
  String get incorrectEmail => 'Falsche E-Mail?';

  @override
  String get changeAddress => 'E-Mail-Adresse ändern';

  @override
  String get changeEmail => 'E-Mail ändern';

  @override
  String get changeEmailAddressTitle => 'Bitte schreibe die neue E-Mail-Adresse auf';

  @override
  String get emailConfirmedBottomSheetTitle => 'E-Mail Adresse wird bestätigt';

  @override
  String get emailConfirmedBottomSheetContent => 'Danke, dass du deine E-Mail-Adresse bestätigt hast. Du kannst die App jetzt benutzen';

  @override
  String get logMood => 'Bestätigen';

  @override
  String get yourNote => 'Dein Eintrag';

  @override
  String get educationTitle => 'Ein Schritt nach dem anderen zu machen wird eine große Wirkung haben';

  @override
  String get locked => 'Gesperrt';

  @override
  String get lesson => 'Abschnitt';

  @override
  String get lessonCompleted => 'Fertig!';

  @override
  String get groupSessionsUnlocked => 'Gruppe freigeschaltet';

  @override
  String get waitingForGroupCompletedLesson => 'Wir werden dich benachrichtigen, sobald wir eine Gruppe für dich gefunden haben, die deinen Wünschen entspricht';

  @override
  String get notJoinedToGroupCompletedLesson => 'Wenn du in Zukunft an Online Gruppentreffen teilnehmen möchtest, kannst du dies in deinen Einstellungen angeben';

  @override
  String get groupSessionUnlockOnTrialPeriod => 'Gruppensitzungen sind nur verfügbar, wenn du ein bezahltes Abonnement hast. Nachdem du bezahlt hast, kannst du dich über das Dashboard oder dein Profil anmelden.';

  @override
  String get unlockFeatureDescription => 'Deine Präferenzen wurden zu deinem Profil hinzugefügt. Du kannst sie später aktualisieren.';

  @override
  String get lessonCompleteDescription => 'Gut gemacht! Du kannst gleich mit der nächsten Einheit anfangen';

  @override
  String get assignmentCompleted => 'Reflexion abgeschlossen!';

  @override
  String get assignmentCompleteDescription => 'Gut gemacht! Deine Antworten werden gespeichert, damit du sie später noch einmal ansehen kannst.';

  @override
  String get consultYourTherapistBody1 => 'Du hast angegeben, dass du derzeit von einem Psychologen/einer Psychologin behandelt wirst. ';

  @override
  String get consultYourTherapistBody2 => 'Besprich bitte mit deinem Therapeuten/deiner Therapeutin, ob die Teilnahme an einer Selbsthilfegruppe ein guter Schritt für dich in deinem aktuellen Behandlungsplan wäre.';

  @override
  String get consultYourTherapistBody3 => 'Wenn du das mit deinem Therapeuten/ deiner Therapeutin besprochen hast, kannst du den Prozess fortsetzen und einer Gruppe beitreten.';

  @override
  String get consultYourTherapistBody4 => 'Dazu gehst du in dein Profil und findest unter Einstellungen den Punkt Meine Gruppe.';

  @override
  String get completeLesson => 'Vervollständige den Abschnitt';

  @override
  String get didYouCheckWithSpecialist => 'Hast du mit deinem Therapeuten/ deine Therapeutin gesprochen?';

  @override
  String get iConsultedTherapist => 'Ich habe meinen Therapeuten/meine Therapeutin konsultiert';

  @override
  String get treatedByTherapistLessonComplete => 'Wenn du es mit deinem Therapeuten/ deine Therapeutin besprochen hast, gehst du im Benutzerprofil zu den Einstellungen der Gruppe, um fortzufahren.';

  @override
  String get trialSubscriptionLessonComplete => 'Die Gruppe ist nur verfügbar, wenn du ein bezahltes Abonnement hast. Nachdem du ein Abonnement erworben hast, kannst du einer Gruppe beitreten. Dies kannst du dann in deine Einstellungen ändern.';

  @override
  String get groupSessionsJoinLaterLessonComplete => 'Wenn du in Zukunft einer Gruppe beitreten möchtest, gehe zu den Einstellungen für Meine Gruppe in deinem Nutzerprofil. Bitte beachte, dass die Gruppe nur verfügbar ist, wenn du ein bezahltes Abonnement hast.';

  @override
  String get needSubscrionScreenTitle => 'Gruppe verfügbar mit bezahltem Abonnement';

  @override
  String get needSubscrionScreenBody1 => 'Du befindest dich gerade in der kostenlosen 14-tägigen Testphase des LeanOnMe-Programms.';

  @override
  String get needSubscrionScreenBody2 => 'Sobald die kostenlose Testphase endet, kannst du einer Gruppe beitreten. ';

  @override
  String get needSubscrionScreenBody3 => 'Das Gruppen-Widget auf deinem Dashboard zeigt dir an, wenn diese Funktion verfügbar ist.';

  @override
  String get needSubscrionScreenBody4 => 'Du kannst einer Gruppe dann über das Dashboard oder über dein Profil beitreten.';

  @override
  String get consultYourTherapist => 'Konsultiere deinen Therapeuten/deine Therapeutin';

  @override
  String get groupSession => 'Onlinetreffen';

  @override
  String get getStarted => 'Leg los';

  @override
  String get haveAnAccount => 'Hast du ein Account?';

  @override
  String get logIn => 'Zur Anmeldung';

  @override
  String get bodyAndMind => 'Körperliche Beschwerden';

  @override
  String get finish => 'Erledigen';

  @override
  String get introPage => 'Intro Seite';

  @override
  String get moreInfo => 'Weitere Info';

  @override
  String get yourBirthday => 'Dein Geburtstag';

  @override
  String get continueBtn => 'Weiter';

  @override
  String get downloadInstructions => 'Anleitung herunterladen';

  @override
  String get forgotPassword => 'Passwort vergessen';

  @override
  String get yourPassword => 'Dein Passwort';

  @override
  String get login => 'Anmelden';

  @override
  String get yourEmail => 'Deine E-Mail';

  @override
  String get yourName => 'Dein Name';

  @override
  String get connectionLost => 'Internetverbindung unterbrochen, bitte überprüfe deine Internetverbindung oder versuche es später';

  @override
  String get pleaseEnterYourEmailAddress => 'Bitte gib deine E-Mail-Adresse ein';

  @override
  String get pleaseEnterYourName => 'Bitte gib deinen Namen ein';

  @override
  String get nameRegexValidationError => 'Nur . + - \' Sonderzeichen sind erlaubt';

  @override
  String get pleaseEnterValidEmailAddress => 'Bitte gib eine gültige E-Mail-Adresse ein';

  @override
  String get pleaseEnterYourPassword => 'Bitte gib dein Passwort ein';

  @override
  String get enterYourHeight => 'Bitte gib deine Größe ein';

  @override
  String forgotEmailSuccessMessage(String email) {
    return 'Wenn es ein Konto gibt, das mit der $email verbunden ist, wird eine E-Mail mit weiteren Anweisungen an diese Adresse geschickt.';
  }

  @override
  String get close => 'Schließen';

  @override
  String get next => 'Weiter';

  @override
  String get youAndFoodItemThree => 'Allergien';

  @override
  String get start => 'Start';

  @override
  String get iDoNotEatOrDrink => 'Was ich nicht esse oder trinke:';

  @override
  String get iAmAllergicTo => 'Ich bin allergisch gegen:';

  @override
  String get iDoNotLike => 'Was ich nicht mag:';

  @override
  String get typeOne => 'Ja, Typ 1';

  @override
  String get typeTwo => 'Ja, Typ 2';

  @override
  String get breakfast => 'Frühstück';

  @override
  String get lunch => 'Mittagessen';

  @override
  String get dinner => 'Abendessen';

  @override
  String get lateDinner => 'Spät abends';

  @override
  String get nutritionSummary => 'Nährwert-Zusammenfassung';

  @override
  String get calorieDensity => 'Kaloriendichte';

  @override
  String get proteinDegree => 'Proteingehalt';

  @override
  String get whatIsCalorieDensity => 'Was ist die Kaloriendichte';

  @override
  String get whatIsProtein => 'Was ist Proteingehalt';

  @override
  String get calorieDensityExplanation => 'Die Kaloriendichte ist ein Maß dafür, wie viele Kalorien in einem bestimmten Gewicht eines Lebensmittels enthalten sind, meist ausgedrückt als Kalorien pro Gramm. Sie ist ein guter Indikator dafür, wie sättigend ein Lebensmittel ist.';

  @override
  String get forMoreInformationSeeLesson => 'Für weitere Informationen siehe Abschnitt';

  @override
  String get proteinDegreeExplanation => 'Eiweiß ist der sättigendste Makronährstoff. Der Verzehr von 300 Kalorien Eiweiß sättigt mehr als der Verzehr von 300 Kalorien Kohlenhydraten oder Fett.';

  @override
  String get fiberExplanation => 'Ballaststoffe sind der beste Nährstoff, um einen gesunden Darm und ein gesundes Mikrobiom zu erhalten. Außerdem sind sie ein hervorragender Indikator für die Gesamtqualität der Kohlenhydrate in deiner Ernährung.';

  @override
  String get importanceOfProtein => 'Die Wichtigkeit von Protein';

  @override
  String get carbohydratesPart2 => 'Kohlenhydrate Teil 2';

  @override
  String fiberDailyGoal(String fiberAmount, String dailyGoal) {
    return '${fiberAmount}g deines Tagesziels von ${dailyGoal}g Ballaststoffe';
  }

  @override
  String fiberRatioToCarbo(String totalCarbohydrates, String ratio) {
    return 'Das Verhältnis zu ${totalCarbohydrates}g Gesamtkohlenhydrate ist 1:$ratio';
  }

  @override
  String get calories => 'Kalorien';

  @override
  String get amount => 'Menge';

  @override
  String get addAsFavourite => 'Als Favorit hinzufügen';

  @override
  String get removeFromFavorites => 'Aus den Favoriten entfernen';

  @override
  String get addedToFavorites => 'Zu den Favoriten hinzugefügt';

  @override
  String get removedFromFavorites => 'Aus den Favoriten entfernt';

  @override
  String get myFavorites => 'Meine Favoriten';

  @override
  String get my => 'Meine';

  @override
  String get myDishes => 'Meine Gerichte';

  @override
  String get dishes => 'Gerichte';

  @override
  String get scan => 'Scannen';

  @override
  String get showMy => 'Zeig meine';

  @override
  String get qrCodeSubtext_1 => 'Halte den Barcode direkt vor die Kamera und achte darauf, dass er sich innerhalb des angegebenen Bereichs befindet.';

  @override
  String get qrCodeSubtext_2 => 'Wenn der Barcode erkannt wird, hörst du einen Piepton. ';

  @override
  String get qrCodeSubtext_3 => 'Wenn das Kamerabild unscharf ist, dann bewege das Produkt ein wenig, damit die Kamera es wieder scharf stellen kann.';

  @override
  String get scanOtherProduct => 'Anderes Produkt scannen';

  @override
  String get sorryNotFound => 'Es tut uns leid, aber wir können diesen Barcode nicht in unserem System finden';

  @override
  String get scanYourProduct => 'Scanne deinen Barcode';

  @override
  String get barCodeResultCalories => 'Kalorien: ';

  @override
  String get barCodeResultPerServing => 'Pro Portion : ';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get allowCameraMessage => 'Um den Barcode-Scanner zu verwenden, erlaube bitte die Kameranutzung in den Einstellungen';

  @override
  String get item => 'item';

  @override
  String get items => 'items';

  @override
  String get selected => 'ausgewählt';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get addFoodItem => 'Lebensmittel hinzufügen';

  @override
  String get saveToMyDishes => 'In „Meine Gerichte” speichern';

  @override
  String get addToDishes => 'In „Meine Gerichte” speichern';

  @override
  String get viewRecipe => 'Rezept ansehen';

  @override
  String get ingredientsBasedOn => 'Zutaten basierend auf';

  @override
  String portionMeal(String numberOfPortion) {
    return '$numberOfPortion Portion';
  }

  @override
  String get total => 'Summe';

  @override
  String get searchHint => 'Suche nach Lebensmitteln';

  @override
  String get searchFilterAll => 'Alle';

  @override
  String get searchFilterProducts => 'Produkte';

  @override
  String get searchFilterRecipes => 'Rezepte';

  @override
  String get searchFilterMy => 'Mein Essen';

  @override
  String get inbetweens => 'Zwischenmahlzeiten & Snacks';

  @override
  String get inbetweensShort => 'Zwischenmahlzeiten';

  @override
  String get drinks => 'Getränke';

  @override
  String get favorites => 'Favoriten';

  @override
  String get allMy => 'Alle meine';

  @override
  String get showNutritionValue => 'Nährwerttabelle anzeigen';

  @override
  String youHaveNo(String text) {
    return 'Du hast noch keine $text';
  }

  @override
  String get favoritesExplain => 'Mit den Favoriten kannst du deine am häufigsten verwendeten Lebensmittel\nschnell auflisten';

  @override
  String get favoritesList => '1. Suche ein Lebensmittel aus. \n2. Sieh dir die Details an. \n3. Tippe auf den Stern auf der rechten Seite, um es als Favorit zu markieren.';

  @override
  String get dishesExplain => 'Meine Gerichte hilft dir, deine meist gegessenen Gerichte schnell zu protokollieren';

  @override
  String get dishesList => '1. Protokolliere die gewünschten Lebensmittel \n2. Erstelle ein Mein Gericht direkt aus deinen Einträgen';

  @override
  String get groupPreferences => 'Gruppen-Präferenzen';

  @override
  String get groupRules => 'Gruppenregeln';

  @override
  String get wouldYouLikeToJoinSupportGroup => 'Würdest du gerne einer Gruppe beitreten?';

  @override
  String get genderPreferencesQuestion => 'Hast du eine geschlechtsspezifische Präferenz für deine Selbsthilfegruppe?';

  @override
  String get nicknamePreferencesQuestion => 'Welchen Namen möchtest du innerhalb deiner Gruppe verwenden?';

  @override
  String get nicknamePlaceholder => 'Dein Name';

  @override
  String get weAreLookingForAMatch => 'Wir suchen nach einer Gruppe';

  @override
  String get weAreLookingForAGroupSince => 'Wir suchen nach einer Gruppe, die deinen Präferenzen entspricht, seit';

  @override
  String get genderPreference => 'Geschlechtspräferenz';

  @override
  String get timezone => 'Zeitzone';

  @override
  String get yourNickname => 'Dein (Spitz-) Name';

  @override
  String get partOfGroup => 'Gruppenmitglied';

  @override
  String get iNoLongerWantToJoin => 'Ich möchte einer Gruppe nicht mehr beitreten';

  @override
  String get update => 'Aktualisieren';

  @override
  String weHaveNotYetFound(String dateTime) {
    return 'Wir konnten seit $dateTime\n\nkeine Gruppe finden, die deinen Präferenzen entspricht. Um den Prozess zu beschleunigen, könntest du deine Präferenz für das Geschlecht der Gruppe auf \"keine Präferenz\" einstellen';
  }

  @override
  String get goodNews => 'Gute Neuigkeiten!';

  @override
  String get youHaveBeenAddedToGroup => 'Du wurdest zu einer Gruppe hinzugefügt, die deinen Präferenzen entspricht. Melde dich für eine Gruppensitzung an und nutze den Chat, um die anderen Gruppenmitglieder kennenzulernen';

  @override
  String get readTheGroupRules => 'Lies die Gruppenregeln';

  @override
  String get leaveGroup => 'Gruppe verlassen';

  @override
  String get notYet => 'Noch nicht';

  @override
  String get whatIsYourTimezone => 'Was ist deine Zeitzone?';

  @override
  String get searchTimezone => 'Zeitzone suchen';

  @override
  String get groupRulesOneTitle => 'Sich sicher fühlen in einer vertrauensvollen Umgebung';

  @override
  String get groupRulesAttention => 'Bitte lies die 14 Gruppenregeln sorgfältig durch';

  @override
  String get groupRulesOneParagraphOne => 'Es ist sehr wichtig, dass du bei allen Gruppentreffen die Gruppenregeln einhältst. Diese Gruppenregeln tragen dazu bei, dass ein sicheres und vertrauensvolles Umfeld für jedes einzelne Mitglied geschaffen wird.';

  @override
  String get groupRulesOneParagraphTwo => 'Deine Gruppe sollte ein Ort sein, an dem du dich wohl fühlst und dich öffnen kannst. Sie gibt dir die Möglichkeit, Dinge, die dich beschäftigen, in einer vertrauensvollen Umgebung zu besprechen, abseits vom Chaos des Alltags.';

  @override
  String get continueToTheRules => 'Weiter zu den Regeln';

  @override
  String get yesIAgree => 'Ja, ich stimme zu';

  @override
  String get supportGroupPreferences => 'Gruppen-Präferenzen';

  @override
  String get groupRulesTwoParagraphOne => 'Alles, was in der Gruppe besprochen wird, bleibt auch in der Gruppe. Jedes Mitglied bemüht sich, eine freundliche Atmosphäre zu schaffen, in der sich alle wohlfühlen können.';

  @override
  String get groupRulesTwoParagraphTwo => 'Wir behandeln uns gegenseitig mit Respekt und sind freundlich zueinander.';

  @override
  String get groupRulesTwoParagraphThree => 'Wir lassen einander ausreden und kritisieren uns nicht gegenseitig.';

  @override
  String get groupRulesThreeParagraphOne => 'Gemeinsam sorgen wir dafür, dass alle Mitglieder die gleiche Chance zum Reden bekommen.';

  @override
  String get groupRulesThreeParagraphTwo => 'Wir hören aktiv zu - manchmal ist es mehr wert, einander zuzuhören, als ständig Kommentare und Ratschläge zu geben.';

  @override
  String get groupRulesThreeParagraphThree => 'Jedes Thema, jedes Problem, wird ernst genommen.';

  @override
  String get groupRulesFourParagraphOnePartOne => 'Wir senden';

  @override
  String get groupRulesFourParagraphOnePartTwo => 'Wir verwenden sie, um unsere eigenen Gefühle, Meinungen, Annahmen und Wahrnehmungen auszudrücken. Deshalb vermeiden wir Formulierungen wie';

  @override
  String get groupRulesFourParagraphOnePartThree => 'Stattdessen könnte ein Satz beginnen mit';

  @override
  String get groupRulesFourParagraphOneItalicOne => '\"Ich-Botschaften\".';

  @override
  String get groupRulesFourParagraphOneItalicTwo => '\"du musst/du bist\".';

  @override
  String get groupRulesFourParagraphOneItalicThree => '\"Ich habe positive Erfahrungen gemacht mit.../Ich fand es hilfreich, als...\".';

  @override
  String get groupRulesFourParagraphTwo => 'Es ist hilfreich, sich regelmäßig seiner selbst bewusst zu werden - deines Körpers, deiner Gedanken, deiner Gefühle.';

  @override
  String get groupRulesFiveParagraphOne => 'Wir reden miteinander, nicht übereinander. Abwesende Gruppenmitglieder werden nicht zum Thema der Unterhaltung.';

  @override
  String get groupRulesFiveParagraphTwo => 'Individuelle Verantwortung: Jedes Mitglied einer Gruppe ist für das verantwortlich, was es tut und/oder sagt. Wertschätzung und Respekt für sich selbst und andere ist wichtig. Das bedeutet, ich respektiere meine eigenen Grenzen, die ich mir selbst setze, sowie die meiner Gruppenmitglieder.';

  @override
  String get groupRulesSixParagraphOne => 'Die Kamera sollte während der Sitzungen eingeschaltet bleiben, damit ihr euch alle gegenseitig sehen könnt und kein Mitglied vergessen wird.';

  @override
  String get groupRulesSixParagraphTwo => 'Nimm dir etwas Zeit und entspanne dich vor einer Sitzung.';

  @override
  String get groupRulesSixParagraphThree => 'Sei geduldig mit anderen, aber vor allem mit dir selbst - sei nett zu dir selbst.';

  @override
  String get groupRulesSixParagraphFour => 'Zu guter Letzt: Viel Spaß!';

  @override
  String get noPreference => 'keine Präferenz';

  @override
  String get femaleOnly => 'nur weiblich';

  @override
  String get maleOnly => 'nur männlich';

  @override
  String get mixed => 'gemischt';

  @override
  String get female => 'Weiblich';

  @override
  String get male => 'Männlich';

  @override
  String get woman => 'Weiblich';

  @override
  String get man => 'Männlich';

  @override
  String get other => 'Divers';

  @override
  String get at => 'unter';

  @override
  String get joinAGroup => 'Einer Gruppe beitreten';

  @override
  String get unavailableGroupPrefsLabel => 'Sobald du die Unterrichtseinheit \"Sich mit Menschen umgeben, die es verstehen\" abgeschlossen hast, kannst du einer Selbsthilfegruppe beitreten';

  @override
  String get findingMatchingGroup => 'Wir suchen nach einer passenden Gruppe';

  @override
  String get moreInformationInPreferences => 'Mehr Informationen in den Präferenzen';

  @override
  String get bookYourSeat => 'Buche deinen Sitzplatz';

  @override
  String get comingUpThisWeek => 'Diese Woche';

  @override
  String get happeningNow => 'Happening Now';

  @override
  String get joinSession => 'Onlinetreffen beitreten';

  @override
  String bookedFromTo(String day, String startTime, String endTime) {
    return 'Gebucht $day von $startTime bis $endTime';
  }

  @override
  String dayFromTo(String day, String startTime, String endTime) {
    return '$day\nvon $startTime bis $endTime';
  }

  @override
  String get prepareForSession => 'Für Sitzung vorbereiten';

  @override
  String prepareTakes(String times) {
    return 'Bereite dich auf dieses Treffen vor ($times min)';
  }

  @override
  String get timeslotCancelled => 'Sorry, dieses Zeitfenster wurde abgesagt';

  @override
  String get timeslotMissed => 'Sorry, du hast dieses Zeitfenster verpasst';

  @override
  String get chooseAnotherTimeslot => 'Wähle einen anderen Zeitraum aus';

  @override
  String get noOtherTimeslotsAvailable => 'Für diese Woche sind keine weiteren Zeitfenster verfügbar. Das Thema der nächsten Woche folgt in Kürze';

  @override
  String noMinMemberCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Weniger als $count Nutzer haben sich für diese Sitzung angemeldet, daher wird sie möglicherweise abgesagt.',
      one: 'Nur 1 Benutzer hat sich für diese Sitzung angemeldet, daher kann sie abgesagt werden.',
      zero: 'Es haben sich keine Nutzer für diese Sitzung angemeldet, daher kann sie abgesagt werden.',
    );
    return '$_temp0';
  }

  @override
  String get noGroupThisWeek => 'Kein Onlinetreffen diese Woche.';

  @override
  String get on => 'an';

  @override
  String get off => 'aus';

  @override
  String get noMoodRecords => 'Du hast keine Einträge für den ausgewählten Tag';

  @override
  String get yourSupportSystem => 'Dein Unterstützungssystem';

  @override
  String get supportGroupIntroDesc => 'Eine Gruppe erhöht die Wahrscheinlichkeit, dass du auf dem richtigen Weg bleibst und eine nachhaltige Gewichtsabnahme erreichst. \nUmgib dich mit Menschen, die es verstehen. Du kannst dich jederzeit mit anderen Mitgliedern austauschen. In den wöchentlichen Treffen kannst du diskutieren, neue Dinge lernen und deine Erfahrungen teilen. ';

  @override
  String get yesILikeToJoin => 'Ja, ich würde gerne einer Gruppe beitreten';

  @override
  String get joinLater => 'Ich möchte später beitreten';

  @override
  String get theSupportGroup => 'Meine Gruppe';

  @override
  String get introduction => 'Einleitung';

  @override
  String get reportIssue => 'Problem melden';

  @override
  String get discussion => 'Diskussion';

  @override
  String get left => 'links';

  @override
  String get error => 'Fehler';

  @override
  String get sessionIsInProgress => 'Treffen im Gange';

  @override
  String get failedToJoinSession => 'Fehlgeschlagener Versuch, ein Treffen beizutreten';

  @override
  String get disconnectedFromSession => 'Deine Verbindung zum Treffen wurde getrennt';

  @override
  String micState(String micState) {
    return 'Dein Mikrofon wurde $micState';
  }

  @override
  String get toggleSpeakerError => 'Das Gerät unterstützt die Lautsprecherumschaltung nicht';

  @override
  String get mute => 'Stummschalten';

  @override
  String get stopVideo => 'Video ausschalten';

  @override
  String get settings => 'Einstellungen';

  @override
  String get sessionLeaveDialogText => 'Wenn du auflegst, kannst du dieses Onlinetreffen möglicherweise nicht mehr beitreten';

  @override
  String get sessionEndDialogText => 'Dein Treffen ist beendet, danke für deine Teilnahme';

  @override
  String get leaveSession => 'Verlasse das Treffen trotzdem';

  @override
  String get stayInTheSession => 'In dem Treffen bleiben';

  @override
  String get signatureErrorMessage => 'Bei deinem Onlinetreffen ist etwas schiefgelaufen, versuch zurückzugehen und später zurückzukommen';

  @override
  String get sessionAlreadyEnded => 'Dein Onlinetreffen ist bereits beendet, du kannst nicht beitreten';

  @override
  String get duration => 'Dauer';

  @override
  String get badConnectionMessage => 'Deine Verbindung ist schlecht';

  @override
  String get exercise => 'Übung';

  @override
  String get noMicrophoneAccessTitle => 'Kein Mikrofon Zugriff';

  @override
  String get noMicrophoneAccessDescription => 'Bitte aktiviere das in den Systemeinstellungen, um die Erlaubnis zu erteilen';

  @override
  String get noCameraAccessTitle => 'Kann nicht auf die Kamera zugreifen';

  @override
  String get noCameraAccessDescription => 'Bitte aktiviere das Kontrollkästchen in den Systemeinstellungen, um die Erlaubnis zu erteilen';

  @override
  String get sessionGreeting => 'Schön, dass du an das Onlinetreffen teilnimmst';

  @override
  String get goodToKnow => 'Gut zu wissen';

  @override
  String get warningOne => 'Deine Kamera ist eingeschaltet und dein Mikrofon ist nicht stummgeschaltet, wenn du die Sitzung betrittst';

  @override
  String get warningTwo => 'Es wird von dir erwartet, dass du dich hältst an';

  @override
  String get hi => 'Hallo';

  @override
  String get sessionWillStartIn => 'Das Treffen wird beginnen in';

  @override
  String get sessionStartedMessage => 'Das Treffen hat bereits begonnen';

  @override
  String get enterSession => 'Onlinetreffen beitreten';

  @override
  String get pickADateAndTime => 'Wähle ein Datum und eine Uhrzeit';

  @override
  String fromTo(String startTime, String endTime) {
    return 'Von $startTime bis $endTime';
  }

  @override
  String fromToLower(String startTime, String endTime) {
    return 'von $startTime bis $endTime';
  }

  @override
  String numberOfAvailableSeats(String number, String totalNumber) {
    return '$number der $totalNumber verfügbaren Plätze';
  }

  @override
  String get passedSession => 'Vergangenes Treffen';

  @override
  String get cancelledSession => 'Abgesagtes Treffen';

  @override
  String get minimumNotReached => 'Minimum nicht erreicht';

  @override
  String get noMoreSeatAvailable => 'Keine Plätze mehr verfügbar';

  @override
  String get bookedForYou => 'Gebucht für dich';

  @override
  String get cancelBooking => 'Buchung stornieren';

  @override
  String get sessionWarning_1 => 'Wenn weniger als vier Plätze gebucht sind, wird das Treffen abgesagt';

  @override
  String get sessionWarning_2 => 'Wenn du es nicht zeitlich schaffst, bitte schreib dich aus dieses Treffen aus';

  @override
  String get emergencySubtitle => 'Dieses Programm ist keine Psychotherapie und kann auch keine Psychotherapie ersetzen. \n\nSollest du eine akute psychische Krise haben oder das Gefühl haben, psychologische Unterstützung zu brauchen oder Gedanken haben, dir das Leben nehmen zu wollen, dann suche bitte umgehend ärztliche oder psychologische Hilfe auf. \n\nIm Notfall kannst du dich auch an folgende Nummern wenden, die du 24h/Tag gebührenfrei erreichen kannst:';

  @override
  String get subjectReport => 'Betreff';

  @override
  String get descriptionReport => 'Beschreibung';

  @override
  String get reportTitle => 'Problem melden';

  @override
  String get reportSubTitle => 'Bitte beschreibe die Angelegenheit.';

  @override
  String get reportSuccessTitle => 'Wir haben deinen Bericht erhalten und werden ihn entsprechend bearbeiten';

  @override
  String get errorReportMessage => 'Die Textnachricht muss mindestens ein Symbol und weniger als 500 Symbole enthalten';

  @override
  String get errorSubjectMessage => 'Die Textnachricht muss mindestens ein Symbol und weniger als 30 Symbole enthalten';

  @override
  String get requiredField => 'Feld ist erforderlich';

  @override
  String get send => 'Senden';

  @override
  String get changeYourEmail => 'Ändere deine E-Mail-Adresse';

  @override
  String get changeYourEmailDescription => 'Gib deine neue E-Mail-Adresse ein und bestätige sie mit deinem Passwort.';

  @override
  String get submit => 'Abschicken';

  @override
  String get emailChangeConfirmedTitle => 'Änderung der E-Mail-Adresse bestätigt';

  @override
  String get emailChangeConfirmedBody1 => 'Deine E-Mail-Adresse wurde erfolgreich aktualisiert.';

  @override
  String get emailChangeConfirmedBody2 => 'Wir haben dir eine E-Mail an deine neue Adresse geschickt. Bitte klicke auf den Link, um sie zu bestätigen.';

  @override
  String yourPreferencesUpdated(String prefName) {
    return 'Deine Präferenzen wurden aktualisiert';
  }

  @override
  String get createNew => 'Neu erstellen';

  @override
  String get updateExist => 'Vorhandenes aktualisieren';

  @override
  String get existMealText => 'Du willst eine neue Mahlzeit erstellen oder eine bestehende bearbeiten?';

  @override
  String chooseDateFor(String mealCategory) {
    return 'Datum wählen für $mealCategory';
  }

  @override
  String get youCanChangeTheDate => 'Du kannst das Datum ändern und/oder es auf mehrere Tage legen. Vergiss nicht, alle Änderungen zu speichern';

  @override
  String weekWithNumber(String number) {
    return 'WOCHE $number';
  }

  @override
  String capitalizeWeekWithNumber(String number) {
    return 'Woche $number';
  }

  @override
  String weekDates(String from, String to, String month) {
    return '$from bis $to $month';
  }

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get changesSaved => 'Die Änderungen wurden gespeichert';

  @override
  String get thisMealPlannedFor => 'Diese Mahlzeit ist geplant für';

  @override
  String get saveDateError => 'Du musst zuerst ein anderes Datum auswählen, bevor du die Auswahl dieses Datums aufheben kannst';

  @override
  String get kcal => 'kcal';

  @override
  String get yesReplace => 'Ja ersetzen';

  @override
  String youAlreadyPlanned(String mealCategory) {
    return 'Du hast bereits eine $mealCategory für diesen Tag geplant:';
  }

  @override
  String andOtherDates(String number) {
    return 'und $number andere Termine';
  }

  @override
  String alreadyPlannedCategory(String mealCategory) {
    return '$mealCategory BEREITS GEPLANT';
  }

  @override
  String get replaceWith => 'Ersetzen durch?';

  @override
  String get nothingOnTheMenu => 'Noch nichts auf der Speisekarte';

  @override
  String get mindTraining => 'Achtsamkeit';

  @override
  String get learnMoreButton => 'Weiter lesen';

  @override
  String get lock => 'Sperren';

  @override
  String unlocksOn(String date) {
    return 'Freigeschaltet am \n$date';
  }

  @override
  String get unlocksAfterCompletionExercise => 'Wird nach Abschluss der vorherigen Übung freigeschaltet';

  @override
  String get intro => 'Intro';

  @override
  String get exercises => 'Übungen';

  @override
  String get startExercise => 'Übung starten';

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
  String get chooseAnExercise => 'Wähle eine Übung';

  @override
  String get completedExerciseMessage1 => 'Super! Du hast';

  @override
  String completedExerciseMessage2(String count) {
    return '$count Übung';
  }

  @override
  String get completedIntroductionMessage2 => 'die Einleitung zu';

  @override
  String get chooseTechnique => 'Wähle eine Technik';

  @override
  String get chooseExercise => 'Übung wählen';

  @override
  String get selectedExercise => 'Ausgewählte Übung';

  @override
  String get skipIntro => 'Intro überspringen';

  @override
  String get selectMoodText => 'Wie fühlst du dich?';

  @override
  String get selectMoodSubtext => 'Du kannst wählen, welche Informationen du ausfüllen möchtest.';

  @override
  String get time => 'Zeit';

  @override
  String get specifyEmotion => 'Emotion(en) angeben';

  @override
  String get withWho => 'Mit wem';

  @override
  String get where => 'Wo';

  @override
  String get makeChoice => 'Wähle';

  @override
  String get personalNote => 'Persönliche Notiz';

  @override
  String get moodOptionPageEmotionTitle => 'Emotionen';

  @override
  String get descriptionEmotions => 'Wähle bis zu drei Emotionen';

  @override
  String get deleteMood => 'Stimmung löschen';

  @override
  String get quiz => 'Quiz';

  @override
  String get letsGo => 'Los geht\'s';

  @override
  String get correct => 'Richtig!';

  @override
  String get incorrect => 'Falsch';

  @override
  String get assignmentAddedTitle => 'Reflexion wurde zu deinem Kalender hinzugefügt';

  @override
  String assignmentAddedText(String date) {
    return 'Bitte versuche, sie vor $date abzuschließen';
  }

  @override
  String get startNow => 'Jetzt starten';

  @override
  String get reflection => 'Reflexion';

  @override
  String get reflections => 'Meine Reflexionen';

  @override
  String get seeLesson => 'Siehe Abschnitt';

  @override
  String get allAssignmentsCompleted => 'Alle Reflexionsübungen wurden abgeschlossen';

  @override
  String get errorOpenTextMessage => 'Die Textnachricht muss mindestens ein Symbol und weniger als 20.000 Symbole enthalten';

  @override
  String get thisWeek => 'diese Woche';

  @override
  String get doneToday => 'Heute erledigt';

  @override
  String completeBefore(String date) {
    return 'Abschließen vor $date';
  }

  @override
  String completedOn(String date) {
    return 'Abgeschlossen am $date';
  }

  @override
  String get pastReflections => 'Vergangene Reflexionen';

  @override
  String get iWantToLogMy => 'Ich möchte meine';

  @override
  String get logMealServingTitle => 'Portionsgröße auswählen';

  @override
  String get descriptionTime => 'Wähle eine Zeit';

  @override
  String get descriptionWithWhom => 'Wähle aus, mit wem du warst';

  @override
  String get descriptionWhere => 'Wähle aus, wo du warst';

  @override
  String get descriptionFood => 'Wähle aus, welches Essen du gegessen hast?';

  @override
  String get logWeight => 'Bestätigen';

  @override
  String get foodLoggingUnlocked => 'Mein Essen freigeschaltet';

  @override
  String get youCanStartLogging => 'Du kannst jetzt mit dem Protokollieren deiner Mahlzeiten beginnen';

  @override
  String get reportIssueAndEmergencyTitle => 'Problem und Notfall melden';

  @override
  String get groupChat => 'Gruppenchat';

  @override
  String get groupChatTitle => 'Gruppenmitglieder';

  @override
  String groupChatLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Es gibt $count Mitglieder in deiner Gruppe',
      one: 'Es gibt 1 Mitglied in deiner Gruppe',
      zero: 'Es gibt keine Mitglieder in deiner Gruppe',
    );
    return '$_temp0';
  }

  @override
  String get copyGroupMessage => 'Kopieren';

  @override
  String get removeGroupMessage => 'Entfernen';

  @override
  String get reportGroupMessage => 'Melden';

  @override
  String get snackMassageCopy => 'Der Nachrichtentext wurde in die Zwischenablage kopiert';

  @override
  String get messageRemoved => 'Diese Nachricht wurde gelöscht';

  @override
  String get membersEmpty => 'Dieser Gruppenchat hat keine Mitglieder';

  @override
  String get messageLengthRestriction => 'Eine Textnachricht kann bis zu 1.024 Zeichen enthalten. Bitte kürze deine Nachricht';

  @override
  String get yourUser => 'Du';

  @override
  String get passwordValidationRule4 => 'mindestens 1 Großbuchstabe';

  @override
  String get pleaseEnterRegistrationCode => 'Bitte Registrierungscode eingeben';

  @override
  String get pleaseEnterValidRegistrationCode => 'Bitte gib einen gültigen Registrierungscode ein';

  @override
  String get favorite => 'Favorit';

  @override
  String get recipe => 'Rezept';

  @override
  String get recipeDetails => 'Rezept Details';

  @override
  String get myDish => 'Mein Gericht';

  @override
  String get editMyDish => 'Mein Gericht bearbeiten';

  @override
  String get serving => 'Portion';

  @override
  String get logList => 'eintragen';

  @override
  String get clearMealList => 'Liste löschen';

  @override
  String get logListEmptyMessage => 'Noch nichts protokolliert?\n Was hast du zum Mittag gegessen?';

  @override
  String get backToDashboard => 'Zurück zum Dashboard';

  @override
  String get backToTodayLogging => 'Zurück zu Heute';

  @override
  String get hello => 'Hallo';

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodAfternoon => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get logYourWeight => 'Mein Gewicht';

  @override
  String get mealLog => 'Mein Essen';

  @override
  String get planYourMeals => 'Plane deine Mahlzeiten';

  @override
  String get planThisMeal => 'Plane diese Mahlzeit';

  @override
  String get diary => 'Tagebuch';

  @override
  String get mood => 'Stimmung';

  @override
  String get today => 'heute';

  @override
  String get physicalActivities => 'Bewegung';

  @override
  String get physicalActivitiesPreferences => 'Bewegungspräferenzen';

  @override
  String get trainingFrequency => 'Trainingsfrequenz';

  @override
  String get trainingFocus => 'Trainingsfokus';

  @override
  String get didItWorkOutForYou => 'Hat es für dich geklappt?';

  @override
  String get foodPreferencesDesc => 'Wir lieben es, dir persönliche und relevante Lebensmittelempfehlungen zu geben.';

  @override
  String get foodPreferencesItemOne => 'Lebensmittel, die du aus religiösen oder persönlichen Gründen nicht isst';

  @override
  String get foodPreferencesItemTwo => 'Wenn du deinen Fleisch-/Fischkonsum reduzieren willst';

  @override
  String get foodPreferencesItemThree => 'Allergien';

  @override
  String get foodPreferencesItemFour => 'Lebensmittel, die du nicht magst';

  @override
  String get physicalActivitiesPreferencesDesc => 'Wir lieben es, dir persönliche und relevante Bewegungsaktivitäten anzubieten.';

  @override
  String get physicalActivitiesPreferencesItemOne => 'Machst du schon Sport?';

  @override
  String get physicalActivitiesPreferencesItemTwo => 'Wie oft kannst du pro Woche trainieren?';

  @override
  String get physicalActivitiesPreferencesItemThree => 'Woran würdest du gerne arbeiten?';

  @override
  String get physicalActivitiesFrequencyTitle => 'Wie oft willst du pro Woche trainieren?';

  @override
  String get physicalActivitiesFrequencyItemOne => '1 Mal';

  @override
  String get physicalActivitiesFrequencyItemTwo => '2 Mal';

  @override
  String get physicalActivitiesFrequencyItemThree => '3 Mal';

  @override
  String get physicalActivitiesFrequencyItemFour => '4 Mal';

  @override
  String get physicalActivitiesFrequencyItemFive => '5 Mal';

  @override
  String get physicalActivitiesFrequencyItemSix => 'Derzeit nicht in der Lage zu trainieren';

  @override
  String get physicalActivitiesFrequencyZero => 'Ich bin derzeit nicht in der Lage zu trainieren';

  @override
  String get physicalActivitiesNoActivities => 'Keine Aktivitäten:';

  @override
  String get whatWouldYouLikeToStartWorkingOn => 'Womit würdest du gerne anfangen zu arbeiten?';

  @override
  String get buildUpMuscle => 'Muskeln aufbauen';

  @override
  String get inceaseYourStamina => 'Deine Ausdauer erhöhen';

  @override
  String get youCanAlsoOptionally => 'Optional kannst du auch an der Beweglichkeit deines Körpers arbeiten.';

  @override
  String get moreFlexibility => 'Flexibler werden';

  @override
  String get physicalActivitiesCompletedTitle => 'Warum ist es wichtig, sich zu bewegen?';

  @override
  String get physicalActivitiesCompletedDesc => 'Deine Präferenzen wurden zu deinem Profil hinzugefügt. Du kannst sie später aktualisieren.';

  @override
  String get physicalActivitiesUnlockedTitle => 'Bewegung freigeschaltet.';

  @override
  String get physicalActivitiesUnlockedText => 'Du bekommst Übungen empfohlen, basierend auf deine Präferenzen.';

  @override
  String get physicalExercises => 'Bewegung';

  @override
  String get perWeek => 'pro Woche';

  @override
  String get supportGroup => 'Meine Gruppe';

  @override
  String get account => 'Account';

  @override
  String get education => 'Wissen';

  @override
  String get preferableInTheMorning => 'Möglichst am Morgen';

  @override
  String get noWeightLogged => 'Kein Gewicht geloggt';

  @override
  String get ok => 'OK';

  @override
  String get todaysWeight => 'Heutiges Gewicht';

  @override
  String get all => 'Alle';

  @override
  String get general => 'Allgemeines';

  @override
  String get nutrition => 'Ernährung';

  @override
  String get mind => 'Psychologie';

  @override
  String get activity => 'Aktivität';

  @override
  String get noMealsLogged => 'Keine Mahlzeiten geloggt';

  @override
  String get noMealsPlanned => 'Keine Mahlzeiten geplant';

  @override
  String get noMealsLoggedYet => 'Noch keine Mahlzeiten geloggt';

  @override
  String get noMealsPlannedYet => 'Noch keine Mahlzeiten geplant';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get instructions => 'Anleitung';

  @override
  String get ingredients => 'Zutaten';

  @override
  String get addToMyDishes => 'Zu Meine Gerichte hinzufügen';

  @override
  String get addToMyDishedAs => 'Zu Meine Gerichte hinzufügen als';

  @override
  String get giveNameToThisDish => 'Benenne dieses Gericht';

  @override
  String get save => 'Speichern';

  @override
  String get cookingTime => 'Zubereitungszeit';

  @override
  String get preparation => 'Vorbereitung';

  @override
  String get preparationTime => 'Vorbereitungs\nZeit';

  @override
  String get show => 'Anzeigen';

  @override
  String get portions => 'Portionen';

  @override
  String get howToPrepare => 'Wie wird es vorbereitet';

  @override
  String get searchEmptyResultTitle => 'Leider keine Ergebnisse für diese Suche';

  @override
  String get searchEmptyResultText => 'Überprüfe vielleicht deine Rechtschreibung oder versuche einen anderen Begriff';

  @override
  String get createMyDish => 'Mein Gericht erstellen';

  @override
  String get logItem => 'Element loggen';

  @override
  String get deleteDish => 'Dieses Gericht löschen';

  @override
  String get deleteModalMessage => 'Bist du sicher, dass du dein Account löschen willst? Diese Aktion ist unumkehrbar';

  @override
  String get deleteAccount => 'Account löschen';

  @override
  String get signOut => 'Abmelden';

  @override
  String get yesDelete => 'Ja, löschen';

  @override
  String get deleteMealModalMessage => 'Bist du sicher, dass du diese Mahlzeit entfernen möchtest?';

  @override
  String deleteMultiDateMealModalMessage(String mealCategory) {
    return 'Entferne diese $mealCategory';
  }

  @override
  String get deleteMultiDateMealModalExplain => 'Du hast diese Mahlzeit an mehreren Tagen geplant. \nSie wird von allen Tagen entfernt';

  @override
  String get deleteMultiDateMealModalExplain2 => 'Wenn du sie von bestimmten Tagen entfernen möchtest, kannst du das im Datepicker tun';

  @override
  String get openDatepicker => 'Datepicker öffnen';

  @override
  String get remove => 'Entferne';

  @override
  String get recommendations => 'Empfehlungen';

  @override
  String get noCancel => 'Nein, abbrechen';

  @override
  String get recentSearch => 'Letzte Suche';

  @override
  String get dishWasSaved => 'Das Gericht wurde gespeichert';

  @override
  String get foodItemWasAddedToDish => 'Das Lebensmittel wurde dem Gericht hinzugefügt';

  @override
  String get foodItemWasDeletedFromDish => 'Das Lebensmittel wurde aus dem Gericht entfernt';

  @override
  String get invalidDishNameMessage => 'Gib diesem Gericht bitte einen Namen';

  @override
  String get invalidDishServingsAmountMessage => 'Die Portionsgröße kann nicht leer sein';

  @override
  String get invalidDishSelectedMealCategory => 'Mindestens eine Mahlzeitenkategorie sollte ausgewählt sein';

  @override
  String get invalidDishPortionsAmountMessage => 'Portionen können nicht leer sein';

  @override
  String get availableIn => 'Verfügbar in';

  @override
  String get psychology => 'Psychologie';

  @override
  String get medical => 'Medizinischer Einblick';

  @override
  String get community => 'community';

  @override
  String get invalidCreateDishFromMealMessage => 'Ein Gericht kann keine anderen Gerichte oder Rezepte enthalten. Bitte entferne Gerichte oder Rezepte und versuche es erneut';

  @override
  String get readText => 'Textversion öffnen';

  @override
  String get backToToday => 'Zurück zu Heute';

  @override
  String get backToEducation => 'Zurück zu Wissen';

  @override
  String get backToThePool => 'Zurück zum Pool';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get complete => 'Zurück zu Mein Plan ';

  @override
  String get todo => 'Todo';

  @override
  String get done => 'Erledigt';

  @override
  String get physicalActivity => 'Bewegung';

  @override
  String get selectYourProgram => 'Wähle dein Programm';

  @override
  String get selectExerciseType => 'Übungstyp';

  @override
  String get yourOwnActivity => 'Andere Aktivität';

  @override
  String countExercises(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Enthält die folgenden $count Übungen',
      one: 'Enthält die folgenden $count Übungen',
    );
    return '$_temp0';
  }

  @override
  String get strength => 'Kraft';

  @override
  String get endurance => 'Ausdauer';

  @override
  String get mobility => 'Beweglichkeit';

  @override
  String get yourLocation => 'Umgebung';

  @override
  String get home => 'Zuhause';

  @override
  String get office => 'Büro';

  @override
  String get outdoor => 'Draußen';

  @override
  String get desiredDifficulty => 'Schwierigkeitsgrad';

  @override
  String get easy => 'Einfach';

  @override
  String get medium => 'Mittel';

  @override
  String get hard => 'Schwer';

  @override
  String get logActivity => 'Aktivität loggen';

  @override
  String get whatPhysicalActivityDidYouDo => 'Welche Übung hast du gemacht?';

  @override
  String get errorActivityMessage => 'Text Aktivitätsname muss weniger als 30 Symbole enthalten';

  @override
  String get strengthPrograms => 'Kraftprogramme';

  @override
  String get yourProfile => 'Mein Profil';

  @override
  String get reportAbuse => 'Problem melden';

  @override
  String get inCaseOfEmergency => 'Notfallkontakte';

  @override
  String get personalDetails => 'Persönliche Details';

  @override
  String get testResults => 'Testergebnisse';

  @override
  String get preferences => 'Präferenzen';

  @override
  String get name => 'Name';

  @override
  String get email => 'E-Mail';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get changePassword => 'Passwort ändern';

  @override
  String get useFaceOrTouchId => 'Face oder Touch ID verwenden';

  @override
  String get requireLoginEachTime => 'Bei jeder Nutzung der App eine Anmeldung verlangen';

  @override
  String get food => 'Essen';

  @override
  String get group => 'Gruppe';

  @override
  String get groupSessions => 'Gruppe';

  @override
  String get foodPreferences => 'Essens-Präferenzen';

  @override
  String get dontEat => 'Was ich nicht esse';

  @override
  String get dontLike => 'Gefällt mir nicht';

  @override
  String get howHard => 'Wie schwierig war dieses Programm für dich?';

  @override
  String get veryEasy => 'sehr leicht';

  @override
  String get veryHard => 'sehr schwierig';

  @override
  String get rotateDevice => 'Bitte drehe dein Gerät';

  @override
  String get skipExplanation => 'Erklärung überspringen';

  @override
  String get repeat => 'Wiederholen';

  @override
  String exerciseCompleteMessage(String currentIndex, String length) {
    return 'Super! Du hast\nÜbung $currentIndex von $length abgeschlossen';
  }

  @override
  String get activitiesForThisWeek => 'Aktivitäten für diese Woche';

  @override
  String get didYouLikeThisProgram => 'Hat dir das Programm gefallen?';

  @override
  String get backToTodayNotLogged => 'Zurück zum heutigen Tag (nicht geloggt)';

  @override
  String get notReally => 'Nein';

  @override
  String get yesYes => 'Ja!';

  @override
  String get recommended => 'Empfohlen';

  @override
  String get alternatives => 'Alternativen';

  @override
  String equipment(String equipment) {
    return 'Material: $equipment';
  }

  @override
  String targetMuscles(String targetMuscles) {
    return 'Zielmuskeln: $targetMuscles';
  }

  @override
  String get breakBetweenExercises => 'kurze Pause vor der nächsten Übung';

  @override
  String get inProgress => 'in Arbeit';

  @override
  String logAs(String mealCategory) {
    return 'Loggen als $mealCategory';
  }

  @override
  String get skip => 'Überspringen';

  @override
  String get plannedMeals => 'geplante Mahlzeiten';

  @override
  String get loggedMeals => 'geloggte Mahlzeiten';

  @override
  String get hey => 'Hi';

  @override
  String get cancelled => 'Abgebrochen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get missed => 'Verpasst';

  @override
  String get saved => 'Gespeichert!';

  @override
  String get notEnrolledInGroup => 'Du bist derzeit keine Gruppe beigetreten';

  @override
  String get supportGroupPaidSubscriptionNotGrouped => 'Du hast ein bezahltes Abonnement, bist aber keiner Gruppe beigetreten';

  @override
  String get supportGroupTrialSubscriptionNotGrouped => 'Du befindest dich gerade in der kostenlosen Testphase. Diese Funktion wird erst mit einem kostenpflichtigen Abonnement verfügbar sein. Sobald deine kostenlose Testphase vorbei ist, kannst du dich hier oder in deinem Profil anmelden';

  @override
  String get updateRequired => 'Update erforderlich';

  @override
  String get updateRequiredBodyText1 => 'Um ein nahtloses Erlebnis und den Zugang zu neuen Funktionen zu gewährleisten, ist es wichtig, auf die neueste Version von LeanOnMe zu aktualisieren';

  @override
  String get updateRequiredBodyText2 => 'Die vorherige Version wird nicht mehr unterstützt';

  @override
  String get updatePoliciesDocuments => 'Wichtiges Update: Unsere Richtlinien haben sich geändert';

  @override
  String get updatePoliciesDocumentsBodyText1 => 'Um unsere App weiterhin nutzen zu können, überprüfe und akzeptiere bitte die folgenden Dokumente';

  @override
  String get updatePoliciesDocumentsBodyText2 => 'Wenn du mit den neuen Bedingungen nicht einverstanden bist, kannst du dein Konto löschen, indem du unseren Support kontaktierst unter';

  @override
  String get nextWeekTopic => 'Das Thema für die Sitzung der nächsten Woche wird in Kürze bekannt gegeben';

  @override
  String get registrationCodePlaceholder => 'Dein Zugangscode';

  @override
  String get registrationCodeTitle => 'Zugangscode eingeben';

  @override
  String get registrationCodeLabel => 'Gib den Zugangscode ein, den du per E-Mail erhalten hast.';

  @override
  String get checkAccessCode => 'Code prüfen';

  @override
  String get noAccessCodeYet => 'Noch kein Zugangscode? ';

  @override
  String get physicalActivitiesPreferencesLabel => 'Bewegungspräferenzen';

  @override
  String get requestCode => 'Anforderungscode';

  @override
  String get calorie => 'Kalorie';

  @override
  String get dencity => 'Dichte';

  @override
  String get protein => 'Protein';

  @override
  String get degree => 'gehalt';

  @override
  String get fiber => 'Ballaststoffe';

  @override
  String get dailyCalorieBudget => 'Tägliches Kalorienbudget';

  @override
  String get dailyCalorieBudgetDescription => 'Dein tägliches Kalorienbudget zeigt deine geschätzte Kalorienzufuhr an, die du zum Abnehmen benötigst. Je besser die Kaloriendichte, der Proteingehalt und der Ballaststoffgehalt deiner Ernährung sind, desto leichter wird es dir fallen, innerhalb dieses Bereichs Kalorien zu essen.';

  @override
  String get dailyCalorieBudgetLink => 'Was fehlt, wenn du nur die zählst.';

  @override
  String get calorieDensityHighQualityDescription => 'Gute Arbeit! Das ist eine sehr sättigende Mahlzeit. Die von dir gewählte Kombination von Lebensmitteln wird dir helfen, übermäßigen Hunger und Heißhunger zu bekämpfen!';

  @override
  String get calorieDensityHighQualityLabel => 'Sehr sättigend';

  @override
  String get calorieDensityMidQualityDescription => 'Die Dichte dieser Mahlzeit ist durchschnittlich. Wenn du den ganzen Tag über mit übermäßigem Hunger zu kämpfen hast, solltest du dir überlegen, ob du nicht mehr kalorienarme Optionen zu dir nimmst!';

  @override
  String get calorieDensityMidQualityLabel => 'Etwas sättigend';

  @override
  String get calorieDensityLowQualityDescription => 'Die Dichte der von dir protokollierten Mahlzeit ist hoch. Eine tägliche Dichte auf diesem Niveau macht es wahrscheinlicher, dass du heute zu viel isst.';

  @override
  String get calorieDensityLowQualityLabel => 'Nicht sättigend';

  @override
  String get proteinDegreeLowQualityDescription => 'Der Prozentsatz an Eiweiß in dieser Mahlzeit ist sehr niedrig. Du wirst wahrscheinlich den ganzen Tag mit übermäßigem Hunger und Heißhunger zu kämpfen haben. Wenn du den Eiweißanteil in dieser Mahlzeit auf über 25% erhöhst, wird sich die Qualität verbessern.';

  @override
  String get proteinDegreeLowQualityLabel => 'Verbesserung nötig';

  @override
  String get proteinDegreeLowMidQualityDescription => 'Der Prozentsatz an Eiweiß in dieser Mahlzeit ist etwas niedrig. Du könntest im Laufe des Tages mit übermäßigem Hunger und Heißhunger zu kämpfen haben. Wenn du den Eiweißanteil in dieser Mahlzeit auf über 25% erhöhst, wird sich die Qualität verbessern.';

  @override
  String get proteinDegreeLowMidQualityLabel => 'Könnte besser sein';

  @override
  String get proteinDegreeMidQualityDescription => 'Der Prozentsatz an Eiweiß in dieser Mahlzeit ist in Ordnung. Wenn du den ganzen Tag über mit übermäßigem Hunger und Heißhunger zu kämpfen hast, kannst du den Eiweißanteil in dieser Mahlzeit auf über 25% erhöhen.';

  @override
  String get proteinDegreeMidQualityLabel => 'Durchschnitt';

  @override
  String get proteinDegreeHighQualityDescription => 'Super! Der Proteingehalt dieser Mahlzeit wird dir helfen, übermäßigen Hunger und Heißhunger den ganzen Tag zu überwinden!';

  @override
  String get proteinDegreeHighQualityLabel => 'Gut';

  @override
  String get fiberHighQualityLabel => 'Hohe Qualität';

  @override
  String get fiberMidQualityLabel => 'Gemischte Qualität';

  @override
  String get fiberLowQualityLabel => 'Niedrige Qualität';

  @override
  String get notSignificant => 'Nicht signifikant';

  @override
  String get insignificant => 'Nicht signifikant';

  @override
  String get practice => 'Mein Plan';

  @override
  String get pool => 'Pool';

  @override
  String get mindDashboardTitle => 'Achtsamkeit';

  @override
  String get mindDashboardBtn => 'Übung auswählen';

  @override
  String get maintenanceLabel => 'Wartung';

  @override
  String get maintenancePageTitle => 'Wir sind bald wieder da!';

  @override
  String get maintenancePageDescription => 'Wir veröffentlichen gerade spannende neue Inhalte. Wenn du dich angemeldet hast, erhältst du eine Push-Benachrichtigung, sobald wir wieder online sind.\n\nMelde dich für unseren Newsletter an, um einen Vorgeschmack auf die kommenden Inhalte zu bekommen!';

  @override
  String get noAlternativesAvailable => 'Keine Alternativen verfügbar';

  @override
  String get chooseAlternative => 'Wähle eine Alternative';
}
