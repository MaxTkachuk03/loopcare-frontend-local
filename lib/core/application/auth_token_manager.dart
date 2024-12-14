typedef AccessTokenSubscription = void Function();
typedef AccessTokenListener = void Function(String? token);

abstract class AuthTokenManager {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> setAccessToken(String token);

  Future<void> setRefreshToken(String token);

  Future<bool> updateAccessToken();

  Future<bool> updateRefreshToken();

  Future<void> removeAccessToken();

  Future<void> removeRefreshToken();

  AccessTokenSubscription addListener(AccessTokenListener listener);
}
