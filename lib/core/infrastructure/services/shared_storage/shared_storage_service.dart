import 'dart:convert';

import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_data.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_list.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_user.dart';
import 'package:loopcare_frontend/core/domain/recent_search_user/recent_search_user_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/local_storage.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';

class SharedStorageService  {
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


  set recentSearches(RecentSearchUserList list) {
    _prefs.setValue<String>('recent_search', json.encode(list));
  }

  RecentSearchUserList get recentSearches {
    if (_prefs.containsKey('recent_search')) {
      return RecentSearchUserList.fromJson(
        json.decode(_prefs.getValue<String>('recent_search') ?? '') as Map<String, dynamic>,
      );
    } else {
      return RecentSearchUserList(users: []);
    }
  }

  List<String> searchValues(int userId, {SearchMode? type}) {
    final list = <String>[];
    if (hasRecentSearchUser(userId)) {
      final searchUser = recentSearches.users.firstWhere((entity) => entity.id == userId);
      if (type == null || type == SearchMode.all) {
        for (var e in searchUser.data.list) {
          list.add(e.query);
        }
      } else {
        searchUser.data.list.where((entity) => entity.type == type).forEach((e) => list.add(e.query));
      }
    }
    return list;
  }

  bool hasRecentSearchUser(int id) => recentSearches.users
      .where(
        (entity) => entity.id == id,
      )
      .isNotEmpty;

  void _addRecentSearchData(RecentSearchUser user, RecentSearchData data) {
    if (user.data.list.contains(data)) {
      return;
    }
    if (user.data.list.length > maxRecentSearchListSize - 1) {
      user.data.list.removeAt(maxRecentSearchListSize - 1);
      user.data.list[0] = data;
    } else {
      user.data.list.add(data);
    }
  }

  void findOrAddRecentUser(int id, RecentSearchData data) {
    final userList = recentSearches;
    final recentUser = userList.users.firstWhere(
      (entity) => entity.id == id,
      orElse: () {
        final user = RecentSearchUser(id: id, data: RecentSearchList(list: []));
        userList.users.add(user);
        return user;
      },
    );
    _addRecentSearchData(recentUser, data);
    recentSearches = userList;
  }
}
