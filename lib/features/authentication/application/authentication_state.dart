part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.init(AuthenticationData data) = InitialAuthenticationState;

  const factory AuthenticationState.isLoading(AuthenticationData data) =
      AuthenticationStateIsLoading;

  const factory AuthenticationState.error(AuthenticationData data) = ErrorAuthenticationState;

  const factory AuthenticationState.logout(AuthenticationData data) = LogoutState;

  const factory AuthenticationState.waitedForConfirmation(AuthenticationData data) =
      WaitedConfirmationState;

  const factory AuthenticationState.guest(AuthenticationData data) = GuestAuthenticationState;

  const factory AuthenticationState.authenticated(AuthenticationData data) = AuthenticatedState;

  const factory AuthenticationState.gotAccount(AuthenticationData data) = GotAccountState;

  const factory AuthenticationState.gotEmailVerification(AuthenticationData data) =
      GotEmailVerification;

  const factory AuthenticationState.needUpdatePolicies(AuthenticationData data) =
      NeedUpdatePolicies;
  const factory AuthenticationState.emailWasUpdated(AuthenticationData data) =
      AuthenticationStateEmailWasUpdated;

  const factory AuthenticationState.errorUpdateEmail(AuthenticationData data) =
      AuthenticationStateErrorUpdateEmail;

  const factory AuthenticationState.avatarUploaded(AuthenticationData data) =
      AuthenticationStateAvatarUploaded;
}

@freezed
class AuthenticationData with _$AuthenticationData {
  const AuthenticationData._();

  const factory AuthenticationData({
    @Default('') String customerIoId,
    @Default('') String email,
    @Default('') String name,
    @Default('') String password,
    @Default(false) bool emailWasSend,
    @Default(false) bool emailVerified,
    @Default(false) bool consentToEmail,
    @Default(false) bool enablePushNotifications,
    @Default(-1) int accountId,
    Account? account,
    @Default(false) bool isLoading,
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false) RequestError? error,
  }) = _AuthenticationData;

  factory AuthenticationData.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationDataFromJson(json);

  bool get hasAvatar => account?.avatarUrl != null;

  String get avatar => account?.avatarUrl ?? '';

  bool get hasActiveSubscription => (account?.hasActiveSubscription ?? false);

  int get id => account?.id ?? -1;

  String get accountName => account?.name ?? '';

  String? get accountEmail => account?.email;

  double? get height => account?.height;

  GenderType? get gender => account?.gender;

  UserGroupingState? get groupingState => account?.groupingState;

  String? get nickname => account?.nickname;

  GenderPreferences? get genderPreferences => account?.genderPreference;

  String? get timezone => account?.timezone;

  DateTime? get groupingStartedAt => account?.groupingStartedAt;

  int? get groupId => account?.groupId;

  int? get trainingFrequency => account?.trainingFrequency;

  bool get disableGroupSessions => account?.disableGroupSessions ?? false;

  BuddyStatus? get buddyState => account?.buddyState;

  Buddy? get buddy => account?.buddy;

  bool get isFoodLoggingUnlocked => account?.isFoodLoggingUnlocked ?? false;

  bool get isMoodLoggingUnlocked => account?.isMoodLoggingUnlocked ?? false;

  bool get isCalorieDensityUnlocked => account?.isCalorieDensityUnlocked ?? false;

  bool get isProteinDegreeUnlocked => account?.isProteinDegreeUnlocked ?? false;

  bool get isCarbohydrateRatioUnlocked => account?.isCarbohydrateRatioUnlocked ?? false;

  bool get isNutritionScalesLocked =>
      !isCalorieDensityUnlocked && !isProteinDegreeUnlocked && !isCarbohydrateRatioUnlocked;

  bool get isCalorieTrackerUnlocked => account?.isCalorieTrackerUnlocked ?? false;

  bool get isGroupSessionsUnlocked =>
      (account?.isGroupSessionsUnlocked ?? false) && !disableGroupSessions;

  bool get isPhysicalActivitiesUnlocked => account?.isPhysicalActivitiesUnlocked ?? false;

  bool get isReflectionsUnlocked => account?.isReflectionsUnlocked ?? false;

  bool get isBuddyUnlocked => account?.isBuddyUnlocked ?? false;

  bool get isSmartGoalUnlocked => account?.isSmartGoalsUnlocked ?? false;

  bool get isUserGrouped => groupingState == UserGroupingState.grouped;

  bool get isMixedGender => account?.isMixedGender ?? false;

  String get nameCapitalised {
    if (name.isNotEmpty) {
      return name.capitalizeEachWordFirstLetter();
    } else if (account != null) {
      return account!.name.capitalizeEachWordFirstLetter();
    } else {
      return '';
    }
  }

  String get errorKey => error?.message ?? LocalizedTexts.errorSomethingWentWrong;
}
