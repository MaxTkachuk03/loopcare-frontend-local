part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.init(AuthenticationData data) = InitialAuthenticationState;

  const factory AuthenticationState.error(AuthenticationData data) = ErrorAuthenticationState;

  const factory AuthenticationState.logout(AuthenticationData data) = LogoutState;

  const factory AuthenticationState.waitedForConfirmation(AuthenticationData data) = WaitedConfirmationState;

  const factory AuthenticationState.guest(AuthenticationData data) = GuestAuthenticationState;

  const factory AuthenticationState.authenticated(AuthenticationData data) = AuthenticatedState;
}

@freezed
class AuthenticationData with _$AuthenticationData {
  const AuthenticationData._();

  const factory AuthenticationData({
    @Default('') String email,
    @Default('') String name,
    @Default('') String password,
    @Default(false) bool emailWasSend,
    @Default(false) bool emailVerified,
    @Default(-1) int accountId,
    Account? account,
    @JsonKey(includeFromJson: false, includeToJson: false) RequestError? error,
  }) = _AuthenticationData;

  factory AuthenticationData.fromJson(Map<String, dynamic> json) => _$AuthenticationDataFromJson(json);

  List<UnlockedFeatureType> get unlockedFeatures => account?.unlockedFeatures ?? [];

  bool get hasActiveSubscription => (account?.hasActiveSubscription ?? false);

  int get id => account?.id ?? -1;

  String get accountName => account?.name ?? '';

  DateTime? get emailApproveDate => account?.emailApproveDate;

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

  String? get buddyState => account?.buddyState;

  Buddy? get buddy => account?.buddy;

  bool get isFoodLoggingUnlocked => unlockedFeatures.contains(UnlockedFeatureType.meals);

  bool get isGroupSessionsUnlocked =>
      unlockedFeatures.contains(UnlockedFeatureType.grouping) && !disableGroupSessions;

  bool get isPhysicalActivitiesUnlocked => unlockedFeatures.contains(UnlockedFeatureType.physicalActivities);

  bool get isAssignmentsUnlocked => unlockedFeatures.contains(UnlockedFeatureType.assignments);

  bool get isBuddyUnlocked => unlockedFeatures.contains(UnlockedFeatureType.buddy);

  bool get isUserGrouped => groupingState == UserGroupingState.grouped;

  bool get isMixedGender => account?.isMixedGender ?? false;

  bool get isAuthenticated => this is AuthenticatedState;

  String get nameCapitalised => name.isNotEmpty ? name.capitalize() : '';
}
