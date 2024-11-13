import 'package:loopcare_frontend/core/infrastructure/services/secure_storage/secure_storage.dart';

const _accessTokenKey = 'access_token';
const _refreshTokenKey = 'refresh_token';

class SecureStorageService {
  late SecureStorage _storage;

  Future<SecureStorageService> init() async {
    _storage = await SecureStorage().init();
    return this;
  }

  Future<void> cleanStorage() => _storage.cleanStorage();

  Future<void> setAccessToken(String value) => _storage.setValue(_accessTokenKey, value);

  Future<void> setRefreshToken(String value) => _storage.setValue(_refreshTokenKey, value);

  Future<String?> getAccessToken() => _storage.getValue(_accessTokenKey);

  Future<String?> getRefreshToken() => _storage.getValue(_refreshTokenKey);

  Future<void> removeAccessToken() => _storage.remove(_accessTokenKey);

  Future<void> removeRefreshToken() => _storage.remove(_refreshTokenKey);
}
