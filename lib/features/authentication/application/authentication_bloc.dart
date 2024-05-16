import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/application/socket_service_chat/chat_socket_service.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/unlock_feature/unlock_feature.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/validate_email_data.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/chat/application/chat_bloc/group_chat_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/dto/registration_physical_fitness_data.dart';
import 'package:uuid/uuid.dart';

part 'authentication_bloc.freezed.dart';
part 'authentication_bloc.g.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final DioClient client;
  final AuthTokenManager authTokenManager;
  final SharedStorageService _sharedPref;
  final SocketService _socketService = SocketService.instance;
  final ChatSocketService _chatSocketService = ChatSocketService.instance;
  final GroupChatBloc _chatBloc = GetIt.instance<GroupChatBloc>();
  AccessTokenSubscription? _accessTokenSubscription;

  AuthenticationBloc(
    this._authenticationService,
    this.client,
    this.authTokenManager,
    this._sharedPref,
  ) : super(const AuthenticationState.guest(AuthenticationData())) {
    on<AuthenticationInit>(_onAuthenticationInit);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<SignUp>(_onSignUp);
    on<ResendEmail>(_onResendEmail);
    on<ForgotPassword>(_onForgotPassword);
    on<UpdateName>(_onUpdateName);
    on<UpdateEmail>(_onUpdateEmail);
    on<GetAccount>(_onGetAccount);
    on<DeleteAccount>(_onDeleteAccount);
    on<ConnectSockets>(_onConnectSockets);
    on<ChangeAccountGroupStatus>(_onChangeAccountGroupStatus);
    on<UnlockedFeature>(_onUnlockFeature);
    on<SyncChatState>(_onSyncChatState);
    on<AuthenticatedCheck>(_onAuthenticatedCheck);
    on<StartTrackUser>(_onStartTrackUser);

    hydrate();
    _accessTokenSubscription = authTokenManager.addListener((token) {
      if (token == null) {
        add(const AuthenticationEvent.init());
      }
    });
  }

  @override
  Future<void> close() async {
    _accessTokenSubscription?.call();
    await super.close();
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    final data = AuthenticationData.fromJson(json);

    if (!data.accountId.isNegative) {
      return AuthenticationState.gotAccount(data);
    } else if (data.emailWasSend) {
      return AuthenticationState.waitedForConfirmation(data);
    } else {
      return AuthenticationState.guest(data);
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) => state.data.toJson();

  FutureOr<void> _onSyncChatState(
    SyncChatState event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (_sharedPref.account?.groupingState == UserGroupingState.grouped) {
      _chatBloc.add(const GroupChatEvent.getUnreadCount());
      _chatBloc.add(const GroupChatEvent.getMessages(refresh: true));
    }
  }

  FutureOr<void> _onAuthenticationInit(
    AuthenticationInit event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.guest(AuthenticationData()));
  }

  FutureOr<void> _onLogin(
    Login event,
    Emitter<AuthenticationState> emit,
  ) async {
    final data = LoginData(email: event.email.toLowerCase(), password: event.password);

    final response = await _authenticationService.login(data);

    response.fold(
      (error) {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.loginFail,
          {
            'email': event.email,
            'message': error.error.toString(),
          },
        );
        emit(AuthenticationState.init(state.data));
        emit(AuthenticationState.guest(state.data.copyWith(error: error)));
      },
      (response) async {
        final customerIoId = response.customerIoId ?? response.id.toString();

        CustomerIoService.userAuthenticated(
          customerIoId: customerIoId,
          email: event.email,
          id: response.id,
          name: response.name,
        );

        await authTokenManager.setAccessToken(response.accessToken);
        await authTokenManager.setRefreshToken(response.refreshToken);

        _connectSockets();

        final account = _sharedPref.account = Account(
          id: response.id,
          customerIoId: response.customerIoId,
          name: response.name,
          email: response.email,
          country: response.country,
          gender: response.gender,
          sex: response.sex,
          emailApproveDate: response.emailApproveDate,
          subscription: response.subscription,
          createdAt: response.createdAt,
        );

        add(const AuthenticationEvent.getAccount());

        emit(
          AuthenticationState.authenticated(
            state.data.copyWith(
              customerIoId: response.customerIoId ?? '',
              accountId: response.id,
              account: account,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onLogout(
    Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationService.logout();
    await authTokenManager.removeAccessToken();
    await authTokenManager.removeRefreshToken();

    _sharedPref.removeAccount();

    emit(const AuthenticationState.guest(AuthenticationData()));

    _socketService.disconnect();
    _chatSocketService.disconnect();
  }

  FutureOr<void> _onSignUp(
    SignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    final data = SignUpData(
      name: state.data.name,
      email: state.data.email.toLowerCase(),
      customerIoId: state.data.customerIoId,
      password: event.password,
      isConsentApproved: true,
      isLegalApproved: true,
      happiness: event.registrationPhysicalFitnessData.happiness,
      bmi: event.registrationPhysicalFitnessData.bmi,
      height: event.registrationPhysicalFitnessData.height,
      weight: event.registrationPhysicalFitnessData.weight,
      birthDate: event.registrationPhysicalFitnessData.birthday,
      sex: event.registrationPhysicalFitnessData.sex,
      gender: event.registrationPhysicalFitnessData.gender,
      mentalHealthTest: event.mentalHealthTest,
      medicalOnboarding: event.medicalOnboarding,
    );

    final response = await _authenticationService.signUp(data);

    response.fold(
      (error) => emit(
        AuthenticationState.error(
          state.data.copyWith(error: error),
        ),
      ),
      (response) async {
        AnalyticsEventService.instance.logEvent(
          CIOEvents.onboardingNewUserCreated,
          parameters: {
            CustomDefinitions.value: state.data.email,
            CustomDefinitions.confirmed: 'false',
          },
        );

        CustomerIoService.track(event: CIOEvents.onboardingTermsAndConditionsPrivacyPolicyAccept);
        CustomerIoService.track(event: CIOEvents.onboardingPasswordCreated);
        CustomerIoService.track(event: CIOEvents.onboardingNewUserCreated);
        CustomerIoService.setUserVerifiedState(verified: false);
        CustomerIoService.setUserId(id: response.id);

        await authTokenManager.setAccessToken(response.accessToken);
        await authTokenManager.setRefreshToken(response.refreshToken);

        final account = _sharedPref.account = Account(
          id: response.id,
          customerIoId: response.customerIoId,
          name: response.name,
          email: response.email,
          country: response.country,
          gender: response.gender,
          sex: response.sex,
          emailApproveDate: response.emailApproveDate,
          subscription: response.subscription,
          createdAt: response.createdAt,
        );

        add(const AuthenticationEvent.getAccount());

        emit(
          AuthenticationState.waitedForConfirmation(
            state.data.copyWith(
              customerIoId: state.data.customerIoId,
              email: data.email,
              accountId: response.id,
              name: state.data.name,
              password: event.password,
              emailWasSend: true,
              account: account,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<AuthenticationState> emit,
  ) async {
    state.mapOrNull(
      guest: (state) async {
        emit(
          state.copyWith(
            data: state.data.copyWith(
              emailWasSend: false,
              error: null,
            ),
          ),
        );

        final data = ForgotPasswordData(email: event.email.toLowerCase());

        final response = await _authenticationService.forgotPassword(data);

        response.fold(
          (error) => emit(
            state.copyWith(data: state.data.copyWith(error: error)),
          ),
          (response) => emit(
            state.copyWith(
              data: state.data.copyWith(
                emailWasSend: true,
                email: data.email,
                error: null,
              ),
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onResendEmail(
    ResendEmail event,
    Emitter<AuthenticationState> emit,
  ) async {
    state.whenOrNull(
      waitedForConfirmation: (data) async {
        final response = await _authenticationService.resendSignUp(data.accountId);

        response.leftMap(
          (error) => emit(state.copyWith(data: data.copyWith(error: error))),
        );
      },
    );
  }

  FutureOr<void> _onStartTrackUser(
    StartTrackUser event,
    Emitter<AuthenticationState> emit,
  ) {
    String email = '';
    String name = '';
    int id = -1;
    String customerIoId = '';

    if (state.data.accountEmail != null) {
      email = state.data.accountEmail!;
    } else if (state.data.email.isNotEmpty) {
      email = state.data.email;
    }

    if (state.data.accountName.isNotEmpty) {
      name = state.data.name;
    } else if (state.data.name.isNotEmpty) {
      name = state.data.name;
    }

    if (!state.data.id.isNegative) {
      id = state.data.id;
    } else if (!state.data.accountId.isNegative) {
      id = state.data.accountId;
    }

    if (state.data.customerIoId.isNotEmpty) {
      customerIoId = state.data.customerIoId;
    } else if (state.data.account?.customerIoId != null) {
      customerIoId = state.data.account!.customerIoId!;
    } else if (state.data.account != null) {
      customerIoId = id.toString();
    }


    if (state.data.account != null) {
      CustomerIoService.userAuthenticated(
        customerIoId: customerIoId,
        email: email,
        id: id,
        name: name,
      );
    } else if (customerIoId.isNotEmpty) {
      CustomerIoService.onboardingResume(
        customerIoId: customerIoId,
      );
    } else if (email.isNotEmpty) {
      customerIoId = const Uuid().v4();

      CustomerIoService.onboardingResumeWithEmail(
        customerIoId: customerIoId,
        email: email,
      );

      emit(
        state.copyWith(
          data: state.data.copyWith(
            customerIoId: customerIoId,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onChangeAccountGroupStatus(
    ChangeAccountGroupStatus event,
    Emitter<AuthenticationState> emit,
  ) {
    state.whenOrNull(
      authenticated: (data) {
        final account = _sharedPref.account = _sharedPref.account?.copyWith(
          groupingState: event.groupingState,
        );

        emit(
          state.copyWith(
            data: state.data.copyWith(
              account: account,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUnlockFeature(
    UnlockedFeature event,
    Emitter<AuthenticationState> emit,
  ) async {
    await state.whenOrNull(
      authenticated: (data) async {
        final response = await _authenticationService.unlockFeature(event.feature);

        response.fold(
          (l) => null,
          (r) {
            final account = _sharedPref.account = _sharedPref.account?.copyWith(
              features: r.features.where((feature) => feature.unlocked).toList(),
            );

            emit(
              state.copyWith(
                data: state.data.copyWith(
                  account: account,
                ),
              ),
            );

            if (event.feature.feature == UnlockedFeatureType.grouping.name) {
              add(const AuthenticationEvent.changeAccountGroupStatus(UserGroupingState.unlockedPreferences));
            }
          },
        );
      },
    );
  }

  FutureOr<void> _onAuthenticatedCheck(
    AuthenticatedCheck event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _authenticationService.emailApproveDate(state.data.accountId);

    response.fold(
      (l) => null,
      (r) {
        if (r.emailApproveDate != null) {
          AnalyticsEventService.instance.logEvent(
            FirebaseEvents.userEmail,
            parameters: {
              CustomDefinitions.value: state.data.email,
              CustomDefinitions.confirmed: 'true',
            },
          );

          CustomerIoService.track(event: CIOEvents.onboardingEmailConfirmed);
          CustomerIoService.track(event: CIOEvents.onboardingNewUserVerified);
          CustomerIoService.setUserVerifiedState(verified: true);

          emit(AuthenticationState.guest(state.data));
        }
      },
    );
  }

  FutureOr<void> _onUpdateName(
    UpdateName event,
    Emitter<AuthenticationState> emit,
  ) async {
    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.userName,
      parameters: {
        CustomDefinitions.value: event.name,
      },
    );

    emit(
      state.copyWith(
        data: state.data.copyWith(
          name: event.name,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateEmail(
    UpdateEmail event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(
        data: state.data.copyWith(
          email: '',
          emailVerified: false,
          emailWasSend: false,
          error: null,
        ),
      ),
    );

    final data = ValidateEmailData(event.email);
    final response = await _authenticationService.checkEmail(data);

    response.fold(
      (error) => emit(
        state.copyWith(
          data: state.data.copyWith(
            email: event.email,
            error: error,
          ),
        ),
      ),
      (result) {
        String cioId = state.data.customerIoId;

        if (cioId.isEmpty) {
          cioId = const Uuid().v4();
        }

        if (event.update) {
          CustomerIoService.changeUserEmail(
            email: event.email,
          );
        } else {
          CustomerIoService.onboardingStarted(
            id: cioId,
            name: state.data.name,
            email: event.email,
            receiveAnEmails: event.receiveAnEmails ?? false,
          );
        }

        emit(
          state.copyWith(
            data: state.data.copyWith(
              customerIoId: cioId,
              email: event.email,
              emailVerified: true,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onConnectSockets(
    ConnectSockets event,
    Emitter<AuthenticationState> emit,
  ) async {
    _connectSockets();
  }

  FutureOr<void> _onGetAccount(
    GetAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _authenticationService.fetchAccount();

    response.fold(
      (_) => null,
      (r) {
        final account = Account(
          id: r.id,
          customerIoId: r.customerIoId,
          name: r.name,
          email: r.email,
          country: r.country,
          gender: r.gender,
          sex: r.sex,
          height: r.physicalFitness.height,
          bmi: r.physicalFitness.bmi,
          birthDate: r.physicalFitness.birthDate,
          groupingState: r.groupingState,
          groupId: r.groupId,
          groupingStartedAt: r.groupingStartedAt,
          nickname: r.groupingPreferences?.nickname,
          genderPreference: r.groupingPreferences?.genderPreference,
          timezone: r.groupingPreferences?.timezone,
          diabetes: r.diabetes?.name ?? '',
          foodPreferencesHates: r.foodPreferences?.hates,
          foodPreferencesDislikes: r.foodPreferences?.dislike,
          foodPreferencesAllergic: r.foodPreferences?.allergic,
          features: r.features.where((feature) => feature.unlocked).toList(),
          physicalActivitiesPreferences: r.physicalActivitiesPreferences,
          emailApproveDate: r.emailApproveDate,
          mentalHealthTests: r.mentalHealthTests,
          subscription: r.subscription,
          medicalOnboarding: r.medicalOnboarding,
          createdAt: r.physicalFitness.createdAt,
        );

        _sharedPref.account = account;

        emit(AuthenticationState.gotAccount(state.data.copyWith(account: account)));

        add(const AuthenticationEvent.syncChatState());
      },
    );
  }

  FutureOr<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    await state.mapOrNull(
      authenticated: (state) async {
        final response = await _authenticationService.deleteAccount();

        response.fold(
          (l) => null,
          (r) {
            _sharedPref.cleanStorage();
            add(const AuthenticationEvent.logout());
          },
        );
      },
    );
  }

  void _connectSockets() {
    _socketService.startListen();
    _chatSocketService.startListen();
  }
}
