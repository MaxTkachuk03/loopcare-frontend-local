import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/domain/user/user.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';

@singleton
class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  final AuthenticationService _authenticationService;
  final DioClient client;
  final AuthTokenManager authTokenManager;

  AuthenticationCubit(
    this._authenticationService,
    this.client,
    this.authTokenManager,
  ) : super(const AuthenticationState.guest());

  void login(String email, String password) async {
    final data = LoginData(email: email, password: password);

    final response = await _authenticationService.login(data);

    response.fold(
      (error) {
        emit(AuthenticationState.guest(error: error));
      },
      (response) {
        authTokenManager.setToken(response.accessToken);

        // TODO: get user from backend
        emit(
            const AuthenticationState.authenticated(User(id: 1, name: 'Test')));
      },
    );
  }

  void logout() async {
    await _authenticationService.logout();
    await authTokenManager.removeToken();
    emit(const AuthenticationState.guest());
  }

  Future<void> authenticatedCheck() async {
    await state.mapOrNull(waitedForConfirmation: (state) async {
      final response =
          await _authenticationService.emailApproveDate(state.userId);

      response.fold((l) => null, (r) {
        if (r.emailApproveDate != null) {
          emit(
            // TODO: get user from backend
            const AuthenticationState.authenticated(
              User(id: 1, name: 'Nastya'),
            ),
          );
        }
      });
    });
  }

  void signUp(String email) async {
    state.mapOrNull(
      emailAddress: (state) async {
        final data = SignUpData(
          name: state.name,
          email: email,
          password: state.password,
          isConsentApproved: true,
          isLegalApproved: true,
        );

        final response = await _authenticationService.signUp(data);

        response.fold(
          (error) {
            emit(state.copyWith(error: error));
          },
          (response) {
            emit(AuthenticationState.waitedForConfirmation(
              email: data.email,
              userId: response.userId,
              name: state.name,
              password: state.password,
            ));
          },
        );
      },
    );
  }

  void resendEmail() async {
    state.mapOrNull(waitedForConfirmation: (state) async {
      final response = await _authenticationService.resendSignUp(state.userId);

      response.leftMap(
        (error) {
          emit(state.copyWith(error: error));
        },
      );
    });
  }

  void forgotPassword(String email) async {
    state.mapOrNull(
      guest: (state) async {
        emit(state.copyWith(emailWasSend: false, error: null));

        final data = ForgotPasswordData(email: email);

        final response = await _authenticationService.forgotPassword(data);

        response.fold(
          (error) {
            emit(state.copyWith(error: error));
          },
          (response) {
            emit(state.copyWith(
              emailWasSend: true,
              email: data.email,
              error: null,
            ));
          },
        );
      },
    );
  }

  void changeAddress() {
    state.mapOrNull(waitedForConfirmation: (state) {
      emit(AuthenticationState.emailAddress(
        name: state.name,
        password: state.password,
      ));
    });
  }

  void changeToNameState() {
    state.mapOrNull(
      guest: (state) {
        emit(const AuthenticationState.name());
      },
    );
  }

  void changeToPasswordState(String name) {
    state.mapOrNull(
      name: (state) {
        emit(AuthenticationState.password(name: name));
      },
    );
  }

  void changeToEmailState(String password) {
    state.mapOrNull(
      password: (state) {
        emit(AuthenticationState.emailAddress(
            name: state.name, password: password));
      },
    );
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) =>
      AuthenticationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
