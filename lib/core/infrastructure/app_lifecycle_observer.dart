import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/application/socket_service/socket_service.dart';
import 'package:loopcare_frontend/core/application/socket_service_chat/chat_socket_service.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart' as dioClient;
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class AppLifeCycleStateListener extends StatefulWidget {
  final Widget child;

  const AppLifeCycleStateListener({super.key, required this.child});

  @override
  State<AppLifeCycleStateListener> createState() => _AppLifeCycleStateListenerState();
}

class _AppLifeCycleStateListenerState extends State<AppLifeCycleStateListener> {
  late final AppLifecycleListener lifeCycleListener;
  late AuthTokenManager authTokenManager;
  AuthenticationBloc? get _authenticationBloc => GetIt.instance<AuthenticationBloc>();

  @override
  void initState() {
    super.initState();
    authTokenManager = GetIt.instance<AuthTokenManager>();
    lifeCycleListener = AppLifecycleListener(
      onStateChange: _onLifeCycleChanged,
      onResume: _onResume,
    );
  }

  @override
  void dispose() {
    lifeCycleListener.dispose();
    super.dispose();
  }

  void _onLifeCycleChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      // TODO: Handle this case.
      case AppLifecycleState.resumed:
      // TODO: Handle this case.
      case AppLifecycleState.inactive:
      // TODO: Handle this case.
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
      case AppLifecycleState.paused:
      // TODO: Handle this case.
    }
  }

  _onResume() {
    _refreshTokenState();
    _syncChatState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<bool> updateAccessToken() async {
    final token = await authTokenManager.getRefreshToken();
    if (token == null) return false;
    final request = await dioClient
        .handleProcess(dioOptions.post('/auth/accessToken', data: {'refreshToken': token}))
        .then(parseResponse(UpdatedAccessTokenResponse.fromJson));

    request.fold(
      (error) => _authenticationBloc?.add(const AuthenticationEvent.logout()),
      (response) => authTokenManager.setAccessToken(response.accessToken),
    );

    return request.isRight();
  }

  Future<bool> _refreshToken() async {
    final accessTokenIsUpdated = await updateAccessToken();
    if (accessTokenIsUpdated) {
      SocketService.instance.reconnect();
      ChatSocketService.instance.reconnect();
    }
    return accessTokenIsUpdated;
  }

  void _syncChatState() => _authenticationBloc?.add(const AuthenticationEvent.syncChatState());

  void _refreshTokenState() => _authenticationBloc?.state.mapOrNull(authenticated: (_) => _refreshToken());
}
