import 'dart:convert';

import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/local_storage.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';

class SharedStorageService {
  late LocalStorage _prefs;
  final maxRecentSearchListSize = 10;

  SharedStorageService();

  Future<SharedStorageService> init() async {
    _prefs = await LocalStorage().init();
    return this;
  }

  Future<bool> cleanStorage() => _prefs.cleanStorage();

  Future<bool> setString(String key, String value) => _prefs.setValue<String>(key, value);

  String? getString(String key) => _prefs.getValue<String>(key);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  bool containsKey(String key) => _prefs.containsKey(key);

  Future<bool> remove(String key) => _prefs.remove(key);

  Set<String> get keys => _prefs.keys;

  set partlyCompletedModule(int value) => _prefs.setValue('partly_completedModule', value);

  int get partlyCompletedModule => _prefs.getValue<int?>('partly_completedModule') ?? 1;

  set storeVersion(int value) => _prefs.setValue('store_version', value);

  int get storeVersion => _prefs.getValue<int?>('store_version') ?? 1;

  set privacyPolicyVersion(int value) => _prefs.setValue('privacy_policy_version', value);

  int get privacyPolicyVersion => _prefs.getValue<int?>('privacy_policy_version') ?? 1;

  set termsAndConditionsVersion(int value) =>
      _prefs.setValue('terms_and_conditions_version', value);

  int get termsAndConditionsVersion => _prefs.getValue<int?>('terms_and_conditions_version') ?? 1;

  set localVersion(int value) => _prefs.setValue('local_version', value);

  int get localVersion => _prefs.getValue<int?>('local_version') ?? 1;

  set account(Account? account) => setString('account', json.encode(account));

  bool get isRiverOverviewVisited => _prefs.getValue<bool?>('river_overview_visited') ?? false;

  void riverOverviewVisited() {
    if (!_prefs.containsKey('river_overview_visited')) {
      _prefs.setValue<bool>('river_overview_visited', true);
    }
  }

  Account? get account => containsKey('account')
      ? Account.fromJson(json.decode(getString('account') ?? '') as Map<String, dynamic>)
      : null;

  Future<bool> removeAccount() => _prefs.remove('account');

  void setGroupPreferencesMessageVisibility(int userId, UserGroupingState state) {
    final key = userId.toString();

    final String jsonMap = _prefs.getString(key) ?? '[]';
    List<dynamic> messages = jsonDecode(jsonMap);
    final messagesSet = messages.toSet();
    messagesSet.add(state.name);
    _prefs.setValue(key, jsonEncode(messagesSet.toList()));
  }

  bool hasSawGroupPreferencesMessage(int userId, UserGroupingState state) {
    final key = userId.toString();
    final String jsonMap = _prefs.getString(key) ?? '[]';
    List<dynamic> messages = jsonDecode(jsonMap);

    return messages.contains(state.name);
  }
}
