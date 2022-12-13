abstract class AuthTokenManager {
  Future<String?> getToken();

  Future<void> setToken(String token);

  Future<void> removeToken();
}
