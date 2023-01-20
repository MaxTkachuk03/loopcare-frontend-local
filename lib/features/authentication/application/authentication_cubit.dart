import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

@singleton
class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState.guest());

  void login() async {}

  void signUp() async {}

  void forgotPassword() async {}

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) =>
      AuthenticationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
