abstract class StorageActions {
  Future<bool> setValue<T extends Object?>(String key, T value);

  T? getValue<T extends Object?>(String key);

  Future<bool> remove(String key);

  Future<bool> cleanStorage();
}
