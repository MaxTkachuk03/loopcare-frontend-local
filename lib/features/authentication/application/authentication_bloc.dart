import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/permissions_service.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/domain/account/gender_preferences.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/domain/analytics/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics.dart';
import 'package:loopcare_frontend/core/domain/analytics/usage_analytics/usage_analytics_events.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_sync_service/app_sync_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/apps_flyer_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/facebook_events_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/mixpanel/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service_buddy/buddy_socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/socket_service_chat/chat_socket_service.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_service.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/account_document_version_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/device_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/forgot_password_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/login_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/sign_up_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/update_user_email_data.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/validate_email_data.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy.dart';
import 'package:loopcare_frontend/features/onboarding/application/dto/registration_physical_fitness_data.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:uuid/uuid.dart';

part 'authentication_bloc.freezed.dart';
part 'authentication_bloc.g.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final AuthTokenManager _authTokenManager;
  final SharedStorageService _sharedPref;
  final AppSyncService _syncService;
  final ChatSocketService _chatSocketService = ChatSocketService.instance;
  final BuddySocketService _socketServiceBuddy = BuddySocketService.instance;
  final SocketService _socketService = SocketService.instance;

  AccessTokenSubscription? _accessTokenSubscription;

  AuthenticationBloc(
    this._authenticationService,
    this._authTokenManager,
    this._sharedPref,
    this._syncService,
  ) : super(const AuthenticationState.guest(AuthenticationData())) {
    on<AuthenticationInit>(_onAuthenticationInit);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<SignUp>(_onSignUp);
    on<ResendEmail>(_onResendEmail);
    on<ForgotPassword>(_onForgotPassword);
    on<UpdateName>(_onUpdateName);
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdateUserEmail>(_onUpdateUserEmail);
    on<GetAccount>(_onGetAccount);
    on<DeleteAccount>(_onDeleteAccount);
    on<ConnectSockets>(_onConnectSockets);
    on<ChangeAccountGroupStatus>(_onChangeAccountGroupStatus);
    on<UnlockedFeature>(_onUnlockFeature);
    on<SyncChatState>(_onSyncChatState);
    on<AuthenticatedCheck>(_onAuthenticatedCheck);
    on<StartTrackUser>(_onStartTrackUser);
    on<UpdatePolicy>(_onUpdatePolicy);
    on<SendAppsFlyerData>(_onSendAppsFlyerData);
    on<UploadAvatar>(_onUploadAvatar);

    hydrate();
    _accessTokenSubscription = _authTokenManager.addListener((token) {
      if (token == null) {
        add(const AuthenticationEvent.init());
      }
    });

    _syncService.stream.listen(
      (event) => event.whenOrNull(
        refreshAccount: () => add(const AuthenticationEvent.getAccount()),
      ),
    );
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
      _syncService.refreshChatMessages();
    }
  }

  FutureOr<void> _onUploadAvatar(
    UploadAvatar event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    final res = await _authenticationService.uploadAvatar(event.data);

    res.fold(
      (l) => emit(AuthenticationState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        final updatedAccount =
            _sharedPref.account = state.data.account?.copyWith(avatarUrl: r.data);

        emit(AuthenticationState.avatarUploaded(state.data.copyWith(
          account: updatedAccount,
          isLoading: false,
        )));
      },
    );
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
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    final data = LoginData(email: event.email.toLowerCase(), password: event.password);
    final response = await _authenticationService.login(data);

    response.fold(
      (error) {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.loginFail,
          parameters: {
            'email': event.email,
            'message': error.message.tr(),
          },
        );
        emit(AuthenticationState.init(state.data.copyWith(isLoading: false)));
        emit(AuthenticationState.guest(state.data.copyWith(error: error, isLoading: false)));
      },
      (response) {
        final customerIoId = response.customerIoId ?? response.id.toString();

        CustomerIoService.userAuthenticated(
          customerIoId: customerIoId,
          email: event.email,
          id: response.id,
          name: response.name,
        );

        _authTokenManager.setAccessToken(response.accessToken);
        _authTokenManager.setRefreshToken(response.refreshToken);

        _connectSockets(response.accessToken);

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
          features: response.features,
          avatarUrl: response.avatarUrl,
        );

        emit(
          AuthenticationState.authenticated(
            state.data.copyWith(
              customerIoId: response.customerIoId ?? '',
              accountId: response.id,
              account: account,
              isLoading: false,
            ),
          ),
        );
        MixpanelEventService.instance.identify(id: response.id);
      },
    );
  }

  FutureOr<void> _onLogout(
    Logout event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    await _authenticationService.logout();
    await _authTokenManager.removeAccessToken();
    await _authTokenManager.removeRefreshToken();
    MixpanelEventService.instance.track(
      AppMixpanelEvents.logoutUser,
      parameters: {
        AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
      },
    );

    _sharedPref.removeAccount();

    emit(const AuthenticationState.guest(AuthenticationData()));

    _socketServiceBuddy.disconnect();
    _socketService.disconnect();
    _chatSocketService.disconnect();
    MixpanelEventService.instance.reset();
  }

  FutureOr<void> _onSignUp(
    SignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    final data = SignUpData(
      name: state.data.name,
      email: state.data.email.toLowerCase(),
      customerIoId: state.data.customerIoId,
      password: event.password,
      isConsentApproved: true,
      isLegalApproved: true,
      consentToEmail: state.data.consentToEmail,
      enablePushNotifications: state.data.enablePushNotifications,
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
    final usageAnalytics = UsageAnalytics();

    response.fold(
      (error) => emit(
        AuthenticationState.error(state.data.copyWith(error: error, isLoading: false)),
      ),
      (response) {
        _authTokenManager.setAccessToken(response.accessToken);
        _authTokenManager.setRefreshToken(response.refreshToken);

        _connectSockets(response.accessToken);

        const AnalyticsEventService(includeAppsFlyer: true).logEvent(
          eventName: AnalyticsEvents.onboardingNewUserCreated,
          parameters: {
            AnalyticsParameters.value: state.data.email,
            AnalyticsParameters.confirmed: 'false',
          },
        );

        FacebookEventsService.logEvent(
          eventName: AnalyticsEvents.onboardingNewUserCreated,
          parameters: {
            AnalyticsParameters.value: state.data.email,
            AnalyticsParameters.confirmed: 'false',
          },
        );

        usageAnalytics.track(
            eventName: UsageAnalyticsEvents.onboardingTermsAndConditionsPrivacyPolicyAccept);
        usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingPasswordCreated);
        usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingNewUserCreated);
        CustomerIoService.setUserVerifiedState(verified: false);
        CustomerIoService.setUserId(id: response.id);

        MixpanelEventService.instance.alias(response.id);

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
          features: response.features,
        );

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
              isLoading: false,
            ),
          ),
        );
        add(const AuthenticationEvent.sendApsFlyerData());
        add(const AuthenticationEvent.getAccount());
      },
    );
  }

  FutureOr<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<AuthenticationState> emit,
  ) async {
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
    final account = _sharedPref.account = _sharedPref.account?.copyWith(
      groupingState: event.groupingState,
    );

    emit(state.copyWith(data: state.data.copyWith(account: account)));
  }

  FutureOr<void> _onUnlockFeature(
    UnlockedFeature event,
    Emitter<AuthenticationState> emit,
  ) async {
    final account = _sharedPref.account;
    final accountFeatures = _sharedPref.account?.features;

    if (account == null || accountFeatures == null) return;

    final updatedAccount = _sharedPref.account = account.unlockFeature(event.feature);

    emit(state.copyWith(data: state.data.copyWith(account: updatedAccount)));

    if (event.feature.isGrouping) {
      add(
        const AuthenticationEvent.changeAccountGroupStatus(
          UserGroupingState.unlockedPreferences,
        ),
      );
    }
  }

  FutureOr<void> _onAuthenticatedCheck(
    AuthenticatedCheck event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _authenticationService.emailApproveDate(state.data.accountId);
    final usageAnalytics = UsageAnalytics();

    response.fold(
      (l) => null,
      (r) {
        if (r.emailApproveDate != null) {
          const AnalyticsEventService().logEvent(
            eventName: AnalyticsEvents.userEmail,
            parameters: {
              AnalyticsParameters.value: state.data.email,
              AnalyticsParameters.confirmed: 'true',
            },
          );

          usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingEmailConfirmed);
          usageAnalytics.track(eventName: UsageAnalyticsEvents.onboardingNewUserVerified);
          CustomerIoService.setUserVerifiedState(verified: true);

          emit(AuthenticationState.gotEmailVerification(state.data));
          emit(AuthenticationState.gotAccount(state.data));
        }
      },
    );
  }

  FutureOr<void> _onUpdateName(
    UpdateName event,
    Emitter<AuthenticationState> emit,
  ) async {
    const AnalyticsEventService().logEvent(
      eventName: AnalyticsEvents.userName,
      parameters: {
        AnalyticsParameters.value: event.name,
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

  FutureOr<void> _onUpdateUserEmail(
    UpdateUserEmail event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    final UpdateUserEmailData data = UpdateUserEmailData(event.email, event.password);

    final response = await _authenticationService.updateUserEmail(data);

    response.fold(
      (l) => emit(
          AuthenticationState.errorUpdateEmail(state.data.copyWith(error: l, isLoading: false))),
      (r) {
        CustomerIoService.changeUserEmail(email: event.email);

        final updatedAccount =
            _sharedPref.account = state.data.account?.copyWith(email: event.email);

        emit(AuthenticationState.emailWasUpdated(state.data.copyWith(
          email: event.email,
          account: updatedAccount,
          isLoading: false,
        )));
      },
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
        final isNotificationGranted = PermissionsService.instance.isNotificationGranted;

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
            receiveEmails: event.receiveAnEmails ?? false,
            receiveNotification: isNotificationGranted,
          );
        }

        emit(
          state.copyWith(
            data: state.data.copyWith(
              customerIoId: cioId,
              email: event.email,
              emailVerified: true,
              consentToEmail: event.receiveAnEmails ?? false,
              enablePushNotifications: isNotificationGranted,
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
    final accessToken = await _authTokenManager.getAccessToken();
    if (accessToken == null) return;

    _connectSockets(accessToken);
  }

  FutureOr<void> _onGetAccount(
    GetAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationState.isLoading(state.data.copyWith(isLoading: true)));

    final response = await _authenticationService.fetchAccount();

    response.fold(
      (l) => emit(AuthenticationState.error(state.data.copyWith(error: l))),
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
          buddyState: r.buddyState,
          buddy: r.buddy,
          groupingStartedAt: r.groupingStartedAt,
          nickname: r.groupingPreferences?.nickname,
          genderPreference: r.groupingPreferences?.genderPreference,
          timezone: r.groupingPreferences?.timezone,
          diabetes: r.diabetes?.name ?? '',
          foodPreferencesHates: r.foodPreferences?.hates,
          foodPreferencesDislikes: r.foodPreferences?.dislike,
          foodPreferencesAllergic: r.foodPreferences?.allergic,
          features: r.features,
          physicalActivitiesPreferences: r.physicalActivitiesPreferences,
          emailApproveDate: r.emailApproveDate,
          mentalHealthTests: r.mentalHealthTests,
          subscription: r.subscription,
          medicalOnboarding: r.medicalOnboarding,
          createdAt: r.physicalFitness.createdAt,
          avatarUrl: r.avatarUrl,
        );

        _sharedPref.account = account;

        if (_sharedPref.privacyPolicyVersion > account.privacyPolicyVersion ||
            _sharedPref.termsAndConditionsVersion > account.termsAndConditionsVersion) {
          emit(AuthenticationState.needUpdatePolicies(state.data.copyWith(account: account)));
        } else {
          _syncService.updateBuddyStatus();

          emit(
            AuthenticationState.gotAccount(
              state.data.copyWith(
                account: account,
              ),
            ),
          );
        }

        add(const AuthenticationEvent.syncChatState());
      },
    );
  }

  FutureOr<void> _onDeleteAccount(
    DeleteAccount event,
    Emitter<AuthenticationState> emit,
  ) async {
    final response = await _authenticationService.deleteAccount();

    response.fold(
      (error) => emit(AuthenticationState.error(state.data.copyWith(error: error))),
      (_) {
        _sharedPref.cleanStorage();
        add(const AuthenticationEvent.logout());
      },
    );
  }

  FutureOr<void> _onUpdatePolicy(
    UpdatePolicy event,
    Emitter<AuthenticationState> emit,
  ) async {
    final data = AccountDocumentVersionData(
      termsAndConditionsVersion: event.termsAndConditionsVersion,
      privacyPolicyVersion: event.privacyPolicyVersion,
    );

    final response = await _authenticationService.updateDocumentVersion(data);

    response.fold(
      (error) => emit(AuthenticationState.error(state.data.copyWith(error: error))),
      (_) {
        final account = _sharedPref.account = _sharedPref.account?.copyWith(
          privacyPolicyVersion: event.privacyPolicyVersion,
          termsAndConditionsVersion: event.termsAndConditionsVersion,
        );

        emit(
          AuthenticationState.gotAccount(
            state.data.copyWith(account: account),
          ),
        );
      },
    );
  }

  void _connectSockets(String accessToken) {
    _socketServiceBuddy.startListen(accessToken);
    _socketService.startListen(accessToken);
    _chatSocketService.startListen(accessToken);
  }

  FutureOr<void> _onSendAppsFlyerData(
    SendAppsFlyerData data,
    Emitter<AuthenticationState> emit,
  ) async {
    final appsId = await AppsFlyerService.getAppsFlyerId();

    if (appsId == null) return;

    final deviceData = DeviceData(uid: appsId, platform: Platform.isIOS ? 'ios' : 'android');
    final response = await _authenticationService.sendAppsFlyerDeviceData(deviceData);

    response.fold(
      (error) => emit(AuthenticationState.error(state.data.copyWith(error: error))),
      (_) {},
    );
  }
}
