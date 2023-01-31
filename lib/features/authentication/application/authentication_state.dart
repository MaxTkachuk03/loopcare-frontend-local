import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/user/user.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'authentication_state.freezed.dart';

part 'authentication_state.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(
    User user,
  ) = Authenticated;

  const factory AuthenticationState.waitedForConfirmation({
    required String name,
    required String password,
    required String email,
    required int userId,
    @JsonKey(ignore: true) RequestError? error,
  }) = WaitedForConfirmation;

  const factory AuthenticationState.guest({
    String? name,
    String? password,
    String? email,
    @JsonKey(ignore: true) @Default(false) bool emailWasSend,
    @JsonKey(ignore: true) RequestError? error,
  }) = Guest;

  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);
}
