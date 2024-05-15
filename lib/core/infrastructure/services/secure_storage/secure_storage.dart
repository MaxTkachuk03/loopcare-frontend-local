import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late FlutterSecureStorage _storage;

  Future<SecureStorage> init() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    return this;
  }

  Future<void> cleanStorage() => _storage.deleteAll();

  Future<String?> getValue(String key) => _storage.read(key: key);

  Future<void> remove(String key) => _storage.delete(key: key);

  Future<void> setValue(String key, String value) => _storage.write(key: key, value: value);
}
