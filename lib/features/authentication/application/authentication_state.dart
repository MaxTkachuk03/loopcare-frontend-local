import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/user.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';

part 'authentication_state.freezed.dart';

part 'authentication_state.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.pascal)
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();

  const factory AuthenticationState.authenticated(
    User user,
  ) = Authenticated;

  const factory AuthenticationState.guest({
    @JsonKey(ignore: true) @Default(false) bool progress,
    @JsonKey(ignore: true) RequestError? error,
  }) = Guest;

  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);
}
