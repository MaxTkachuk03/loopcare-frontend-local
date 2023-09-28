import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';

part 'authentication_state.freezed.dart';

part 'authentication_state.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(
    Account account,
  ) = Authenticated;

  const factory AuthenticationState.name() = Name;

  const factory AuthenticationState.password({
    required String name,
  }) = Password;

  const factory AuthenticationState.emailAddress({
    required String name,
    required String password,
    @JsonKey(ignore: true) RequestError? error,
  }) = EmailAddress;

  const factory AuthenticationState.waitedForConfirmation({
    required String name,
    required String password,
    required String email,
    required int accountId,
    @JsonKey(ignore: true) RequestError? error,
  }) = WaitedForConfirmation;

  const factory AuthenticationState.guest({
    String? email,
    @JsonKey(ignore: true) @Default(false) bool emailWasSend,
    @JsonKey(ignore: true) RequestError? error,
  }) = Guest;

  bool get isAuthenticated {
    return maybeWhen(
      orElse: () => false,
      authenticated: (_) => true,
    );
  }

  bool get isPreferencesComplete {
    return maybeWhen(
      orElse: () => false,
      authenticated: (state) => state.isPreferencesComplete,
    );
  }

  List<UnlockedFeatureType> get unlockedFeatures {
    return maybeWhen(
      orElse: () => [],
      authenticated: (state) => state.unlockedFeatures,
    );
  }

  int get id {
    return maybeWhen(
      orElse: () => -1,
      authenticated: (state) => state.id,
    );
  }

  String get name {
    return maybeWhen(
      orElse: () => '',
      authenticated: (state) => state.name,
    );
  }

  String? get email {
    return mapOrNull(
      authenticated: (state) => state.account.email,
    );
  }

  double? get height {
    return mapOrNull(
      authenticated: (state) => state.account.height,
    );
  }

  SexType? get gender {
    return mapOrNull(
      authenticated: (state) => state.account.gender,
    );
  }

  UserGroupingState? get groupingState {
    return mapOrNull(
      authenticated: (state) => state.account.groupingState,
    );
  }

  String? get nickname {
    return mapOrNull(
      authenticated: (state) => state.account.nickname,
    );
  }

  GenderPreferences? get genderPreferences {
    return mapOrNull(
      authenticated: (state) => state.account.genderPreference,
    );
  }

  String? get timezone {
    return mapOrNull(
      authenticated: (state) => state.account.timezone,
    );
  }

  DateTime? get groupingStartedAt {
    return mapOrNull(
      authenticated: (state) => state.account.groupingStartedAt,
    );
  }

  int? get trainingFrequency {
    return mapOrNull(
      authenticated: (state) => state.account.trainingFrequency,
    );
  }

  factory AuthenticationState.fromJson(Map<String, dynamic> json) => _$AuthenticationStateFromJson(json);
}
