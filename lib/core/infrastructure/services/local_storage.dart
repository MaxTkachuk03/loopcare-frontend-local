import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Set<String> get keys => _prefs.getKeys();

  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  bool containsKey(String key) => _prefs.containsKey(key);

  Future<bool> removeKey(String key) => _prefs.remove(key);
}
