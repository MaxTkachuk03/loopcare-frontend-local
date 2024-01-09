import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/dto/updated_access_token_response.dart';
import 'package:loopcare_frontend/core/application/dto/updated_refresh_token_response.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_client.dart' as dioClient;
import 'package:loopcare_frontend/core/infrastructure/dio_client/dio_options.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/parse_response.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';

class AppLifeCycleStateListener extends StatefulWidget {
  final Widget child;

  const AppLifeCycleStateListener({super.key, required this.child});

  @override
  State<AppLifeCycleStateListener> createState() => _AppLifeCycleStateListenerState();
}

class _AppLifeCycleStateListenerState extends State<AppLifeCycleStateListener> {
  late final AppLifecycleListener lifeCycleListener;
  late AuthTokenManager authTokenManager;
  late AuthenticationCubit? _authenticationCubit;

  @override
  void initState() {
    authTokenManager = GetIt.instance<AuthTokenManager>();
    _authenticationCubit = GetIt.instance<AuthenticationCubit>();
    lifeCycleListener = AppLifecycleListener(
      onStateChange: _onLifeCycleChanged,
      onDetach: _onDetach,
      onPause: _onPause,
      onResume: _onResume,
    );
    super.initState();
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

  _onDetach() => debugPrint('devcpp on Detach');

  _onPause() => debugPrint('devcpp on Pause');

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
      (error) {
        authTokenManager.removeRefreshToken();
        authTokenManager.removeAccessToken();
      },
      (response) {
        authTokenManager.setAccessToken(response.accessToken);
      },
    );
    return request.isRight();
  }

  Future<bool> updateRefreshToken() async {
    final token = await authTokenManager.getRefreshToken();

    if (token == null) return false;

    final request = await dioClient
        .handleProcess(dioOptions.post('/auth/refreshToken', data: {'refreshToken': token}))
        .then(parseResponse(UpdatedRefreshTokenResponse.fromJson));
    request.fold(
      (error) {
        authTokenManager.removeRefreshToken();
        authTokenManager.removeAccessToken();
      },
      (response) {
        authTokenManager.setRefreshToken(response.refreshToken);
      },
    );
    return request.isRight();
  }

  Future<bool> _refreshToken() async {
    final accessTokenIsUpdated = await updateAccessToken();
    final refreshTokenIsUpdated = await updateRefreshToken();
    final isRefreshed = accessTokenIsUpdated && refreshTokenIsUpdated;
    return isRefreshed;
  }

  void _syncChatState() => _authenticationCubit?.syncChatState();

  void _refreshTokenState() => _authenticationCubit?.state.mapOrNull(authenticated: (_) => _refreshToken());
}
