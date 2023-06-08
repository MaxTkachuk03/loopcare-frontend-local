import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

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

  String get name {
    return maybeWhen(
      orElse: () => '',
      authenticated: (state) => state.name,
    );
  }

  factory AuthenticationState.fromJson(Map<String, dynamic> json) => _$AuthenticationStateFromJson(json);
}
