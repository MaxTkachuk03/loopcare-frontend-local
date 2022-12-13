import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/auth_token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = 'auth_token';

@Singleton(as: AuthTokenManager)
class TokenManagerSharedPrefs extends AuthTokenManager {
  final SharedPreferences _sharedPreferences;

  TokenManagerSharedPrefs(this._sharedPreferences);

  @override
  Future<String?> getToken() async {
    return _sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> removeToken() async {
    _sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<void> setToken(String token) async {
    _sharedPreferences.setString(_tokenKey, token);
  }
}
