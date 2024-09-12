import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/auth_token_service.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/secure_storage/secure_storage_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';

// TODO: remove parameters
const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

@Singleton(as: AuthTokenManager)
class TokenManagerSharedPrefs extends AuthTokenManager {
  final SecureStorageService _secureStorage;
  // TODO: remove dependency
  final SharedStorageService _sharedPreferences;
  final AuthTokenService authTokenService;

  final Set<AccessTokenListener> _listeners = {};

  TokenManagerSharedPrefs(this.authTokenService, this._secureStorage, this._sharedPreferences);

  void _updateListener(String? token) {
    for (var l in _listeners) {
      l(token);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    final accessTokenFromShared = _sharedPreferences.getString(_accessTokenKey);
    if (accessTokenFromShared != null) {
      _sharedPreferences.remove(_accessTokenKey);
      await setAccessToken(accessTokenFromShared);
    }

    String? accessToken;
    try {
      accessToken = await _secureStorage.getAccessToken();
    } on PlatformException catch (e) {
      MixpanelEventService.instance.track(
        AppMixpanelEvents.accessTokenSecureStorageError,
        parameters: {
          AnalyticsParameters.errorMessage: e.message,
        },
      );
    }

    return accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final refreshTokenFromShared = _sharedPreferences.getString(_refreshTokenKey);
    if (refreshTokenFromShared != null) {
      _sharedPreferences.remove(_refreshTokenKey);
      await setRefreshToken(refreshTokenFromShared);
    }

    return _secureStorage.getRefreshToken();
  }

  @override
  Future<void> removeAccessToken() async {
    _sharedPreferences.remove(_accessTokenKey);
    _secureStorage.removeAccessToken();
    _updateListener(null);
  }

  @override
  Future<void> removeRefreshToken() async {
    _sharedPreferences.remove(_refreshTokenKey);
    _secureStorage.removeRefreshToken();
  }

  @override
  Future<bool> updateAccessToken() async {
    final token = await getRefreshToken();

    if (token == null) return false;

    final request = await authTokenService.updateAccessToken(token);
    request.fold(
      (error) {
        removeRefreshToken();
        removeAccessToken();
      },
      (response) {
        setAccessToken(response.accessToken);
      },
    );

    return request.isRight();
  }

  @override
  Future<bool> updateRefreshToken() async {
    final token = await getRefreshToken();

    if (token == null) return false;

    final request = await authTokenService.updateRefreshToken(token);

    request.fold(
      (error) {
        removeRefreshToken();
        removeAccessToken();
      },
      (response) {
        setRefreshToken(response.refreshToken);
      },
    );

    return request.isRight();
  }

  @override
  Future<void> setAccessToken(String token) async {
    _secureStorage.setAccessToken(token);
    _updateListener(token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    _secureStorage.setRefreshToken(token);
  }

  @override
  AccessTokenSubscription addListener(AccessTokenListener listener) {
    _listeners.add(listener);

    return () => _listeners.remove(listener);
  }
}
