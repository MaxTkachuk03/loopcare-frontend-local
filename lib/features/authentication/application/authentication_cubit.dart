import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';

@singleton
class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationCubit(
    this._authenticationService,
  ) : super(const AuthenticationState.guest());

  void login() async {}

  void signUp(String email) async {
    state.mapOrNull(
      guest: (state) async {
        final name = state.name;
        final password = state.password;

        if (name == null || password == null) return;

        final data = SignUpData(name: name, email: email, password: password);

        final response = await _authenticationService.signUp(data);

        response.fold(
          (error) {
            emit(state.copyWith(error: error));
          },
          (response) {},
        );
      },
    );
  }

  void changeGuestName(String name) {
    state.mapOrNull(
      guest: (state) async {
        emit(state.copyWith(name: name));
      },
    );
  }

  void changeGuestPassword(String password) {
    state.mapOrNull(
      guest: (state) async {
        emit(state.copyWith(password: password));
      },
    );
  }

  void forgotPassword() async {}

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) =>
      AuthenticationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
