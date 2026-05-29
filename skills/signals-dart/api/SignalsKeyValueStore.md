# class `SignalsKeyValueStore`

An abstract class defining the persistence adapter contract for [PersistedSignal](/types/persistedsignal).

Implement this interface to bind <code>PersistedSignal</code> to your storage engine of
choice, such as local files, SQLite, SharedPreferences, Hive, or indexedDB.

### Example: Custom Shared Preferences Store (Flutter)
```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

class SharedPreferencesStore implements SignalsKeyValueStore {
  final SharedPreferences prefs;
  SharedPreferencesStore(this.prefs);

  @override
  Future<String?> getItem(String key) async {
    return prefs.getString(key);
  }

  @override
  Future<void> setItem(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    await prefs.remove(key);
  }
}
```

---

## Members of `SignalsKeyValueStore`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **setItem** | `method` | `Future<void> setItem(String key, String value)` | Sets an item in the store. |
| **getItem** | `method` | `Future<String?> getItem(String key)` | Gets an item from the store. |
| **removeItem** | `method` | `Future<void> removeItem(String key)` | Removes an item from the store. |
| **defaultStore** | `field` | `static SignalsKeyValueStore defaultStore` | The default store to be used if no store is provided. |
