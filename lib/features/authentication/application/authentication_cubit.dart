import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/dto/registration_physical_fitness_data.dart';

@singleton
class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  final AuthenticationService _authenticationService;
  final DioClient client;
  final AuthTokenManager authTokenManager;
  final SharedStorageService _sharedPref;
  final SocketService _socketService = SocketService.instance;
  AccessTokenSubscription? _accessTokenSubscription;

  AuthenticationCubit(
    this._authenticationService,
    this.client,
    this.authTokenManager,
    this._sharedPref,
  ) : super(const AuthenticationState.guest()) {
    hydrate();
    _accessTokenSubscription = authTokenManager.addListener((token) {
      if (token == null) {
        emit(const AuthenticationState.guest());
      }
    });
  }

  @override
  Future<void> close() async {
    _accessTokenSubscription?.call();
    await super.close();
  }

  Future<bool> updateAccessToken() async {
    return authTokenManager.updateAccessToken();
  }

  Future<bool> updateRefreshToken() async {
    return authTokenManager.updateRefreshToken();
  }

  void login(String email, String password) async {
    final data = LoginData(email: email, password: password);

    final response = await _authenticationService.login(data);

    response.fold(
      (error) {
        emit(const AuthenticationState.init());
        emit(AuthenticationState.guest(error: error));
      },
      (response) {
        authTokenManager.setAccessToken(response.accessToken);
        authTokenManager.setRefreshToken(response.refreshToken);

        _socketService.startListen();

        emit(
          AuthenticationState.authenticated(
            Account(
              id: response.id,
              name: response.name,
              email: response.email,
              country: response.country,
              gender: response.gender,
              bioGender: response.bioGender,
              emailApproveDate: response.emailApproveDate,
            ),
          ),
        );
      },
    );
  }

  void changeAccountGroupStatus(UserGroupingState groupingState) {
    state.mapOrNull(authenticated: (s) {
      emit(s.copyWith(account: s.account.copyWith(groupingState: groupingState)));
    });
  }

  void unlockFeature(UnlockedFeatureType feature) async {
    await state.mapOrNull(
      authenticated: (state) async {
        final response = await _authenticationService.unlockFeature(feature.name);

        response.fold(
          (l) => null,
          (r) {
            emit(
              state.copyWith(
                account: state.account.copyWith(
                  unlockedFeatures: r.unlockedFeatures,
                ),
              ),
            );

            if (feature == UnlockedFeatureType.grouping) {
              changeAccountGroupStatus(UserGroupingState.unlockedPreferences);
            }
          },
        );
      },
    );
  }

  void getAccount() async {
    await state.mapOrNull(
      authenticated: (state) async {
        final response = await _authenticationService.fetchAccount();
        response.fold(
          (l) => null,
          (r) {
            emit(
              state.copyWith(
                account: Account(
                  id: r.id,
                  name: r.name,
                  email: r.email,
                  country: r.country,
                  gender: r.gender,
                  bioGender: r.bioGender,
                  height: r.physicalFitness.height,
                  weight: r.physicalFitness.weight,
                  bmi: r.physicalFitness.bmi,
                  birthDate: r.physicalFitness.birthDate,
                  groupingState: r.groupingState,
                  groupingStartedAt: r.groupingStartedAt,
                  nickname: r.groupingPreferences?.nickname,
                  genderPreference: r.groupingPreferences?.genderPreference,
                  timezone: r.groupingPreferences?.timezone,
                  diabetes: r.diabetes.name,
                  foodPreferencesHates: r.foodPreferences.hates,
                  foodPreferencesDislikes: r.foodPreferences.dislike,
                  foodPreferencesAllergic: r.foodPreferences.allergic,
                  unlockedFeatures: r.unlockedFeatures,
                  physicalActivitiesPreferences: r.physicalActivitiesPreferences,
                  emailApproveDate: r.emailApproveDate,
                  mentalHealthTests: r.mentalHealthTests,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteAccount() async {
    await state.mapOrNull(
      authenticated: (state) async {
        final response = await _authenticationService.deleteAccount();

        response.fold(
          (l) => null,
          (r) {
            _sharedPref.cleanStorage();
            logout();
          },
        );
      },
    );
  }

  void logout() async {
    await _authenticationService.logout();
    await authTokenManager.removeAccessToken();
    await authTokenManager.removeRefreshToken();
    emit(const AuthenticationState.guest());
    _socketService.disconnect();
  }

  Future<void> authenticatedCheck() async {
    await state.mapOrNull(waitedForConfirmation: (state) async {
      final response = await _authenticationService.emailApproveDate(state.accountId);

      response.fold((l) => null, (r) {
        if (r.emailApproveDate != null) {
          emit(const AuthenticationState.guest());
        }
      });
    });
  }

  void signUp(
    String email,
    RegistrationPhysicalFitnessData registrationPhysicalFitnessData,
    MentalHealthTestAnswer mentalHealthTest,
  ) async {
    state.mapOrNull(
      emailAddress: (state) async {
        final data = SignUpData(
          name: state.name,
          email: email,
          password: state.password,
          isConsentApproved: true,
          isLegalApproved: true,
          bmi: registrationPhysicalFitnessData.bmi,
          height: registrationPhysicalFitnessData.height,
          weight: registrationPhysicalFitnessData.weight,
          birthDate: registrationPhysicalFitnessData.birthday,
          bioGender: registrationPhysicalFitnessData.bioGender,
          gender: registrationPhysicalFitnessData.gender,
          mentalHealthTest: mentalHealthTest,
        );

        final response = await _authenticationService.signUp(data);

        response.fold(
          (error) {
            emit(state.copyWith(error: error));
          },
          (response) {
            emit(
              AuthenticationState.waitedForConfirmation(
                email: data.email,
                accountId: response.id,
                name: state.name,
                password: state.password,
              ),
            );
          },
        );
      },
    );
  }

  void resendEmail() async {
    state.mapOrNull(waitedForConfirmation: (state) async {
      final response = await _authenticationService.resendSignUp(state.accountId);

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

  void previousStep() {
    state.maybeMap(
      orElse: () => emit(const AuthenticationState.guest()),
      waitedForConfirmation: (state) {
        emit(
          AuthenticationState.emailAddress(name: state.name, password: state.password),
        );
      },
      emailAddress: (state) {
        emit(
          AuthenticationState.password(name: state.name),
        );
      },
      password: (state) => emit(const AuthenticationState.name()),
    );
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
        emit(AuthenticationState.emailAddress(name: state.name, password: password));
      },
    );
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) => AuthenticationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
