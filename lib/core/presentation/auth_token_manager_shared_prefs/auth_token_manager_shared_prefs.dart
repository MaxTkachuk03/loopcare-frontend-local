import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:loopcare_frontend/core/application/auth_token_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

@Singleton(as: AuthTokenManager)
class TokenManagerSharedPrefs extends AuthTokenManager {
  final SharedStorageService _sharedPreferences;
  final AuthTokenService _authTokenService;

  final Set<AccessTokenListener> _listeners = {};

  TokenManagerSharedPrefs(this._authTokenService, this._sharedPreferences);

  _updateListener(String? token) {
    for (var l in _listeners) {
      l(token);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString(_accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _sharedPreferences.getString(_refreshTokenKey);
  }

  @override
  Future<void> removeAccessToken() async {
    _sharedPreferences.remove(_accessTokenKey);
    _updateListener(null);
  }

  @override
  Future<void> removeRefreshToken() async {
    _sharedPreferences.remove(_refreshTokenKey);
  }

  @override
  Future<bool> updateAccessToken() async {
    final token = await getRefreshToken();

    if (token == null) return false;

    final request = await _authTokenService.updateAccessToken(token);

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

    final request = await _authTokenService.updateRefreshToken(token);

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
    _sharedPreferences.setString(_accessTokenKey, token);
    _updateListener(token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    _sharedPreferences.setString(_refreshTokenKey, token);
  }

  @override
  AccessTokenSubscription addListener(AccessTokenListener listener) {
    _listeners.add(listener);

    return () {
      _listeners.remove(listener);
    };
  }
}
