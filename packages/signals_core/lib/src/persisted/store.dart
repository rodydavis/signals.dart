import 'dart:async';

/// An abstract class that defines the contract for a key-value store
/// to be used with `PersistedSignal`.
abstract class SignalsKeyValueStore {
  /// Sets an item in the store.
  Future<void> setItem(String key, String value);

  /// Gets an item from the store.
  Future<String?> getItem(String key);

  /// Removes an item from the store.
  Future<void> removeItem(String key);

  /// The default store to be used if no store is provided.
  static SignalsKeyValueStore defaultStore = SignalsInMemoryKeyValueStore();
}

/// An in-memory implementation of `SignalsKeyValueStore`.
class SignalsInMemoryKeyValueStore implements SignalsKeyValueStore {
  /// The in-memory store.
  final store = <String, String?>{};

  @override
  Future<String?> getItem(String key) async {
    return store[key];
  }

  @override
  Future<void> removeItem(String key) async {
    store.remove(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    store[key] = value;
  }
}
