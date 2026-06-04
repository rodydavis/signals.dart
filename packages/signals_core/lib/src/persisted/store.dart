import 'dart:async';

/// An abstract class defining the persistence adapter contract for [PersistedSignal].
///
/// Implement this interface to bind `PersistedSignal` to your storage engine of
/// choice, such as local files, SQLite, SharedPreferences, Hive, or indexedDB.
///
/// ### Example: Custom Shared Preferences Store (Flutter)
/// ```dart
/// import 'package:shared_preferences/shared_preferences.dart';
/// import 'package:signals/signals.dart';
///
/// class SharedPreferencesStore implements SignalsKeyValueStore {
///   final SharedPreferences prefs;
///   SharedPreferencesStore(this.prefs);
///
///   @override
///   Future<String?> getItem(String key) async {
///     return prefs.getString(key);
///   }
///
///   @override
///   Future<void> setItem(String key, String value) async {
///     await prefs.setString(key, value);
///   }
///
///   @override
///   Future<void> removeItem(String key) async {
///     await prefs.remove(key);
///   }
/// }
/// ```
///
/// @link https://dartsignals.dev/utilities/persisted
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

/// An in-memory, volatile implementation of [SignalsKeyValueStore].
///
/// This serves as a fallback engine and does not persist across restarts/reload.
///
/// @link https://dartsignals.dev/utilities/persisted
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
