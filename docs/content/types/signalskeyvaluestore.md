---
title: "Type: SignalsKeyValueStore"
description: "API reference and details for SignalsKeyValueStore from signals.dart."
---

# SignalsKeyValueStore

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SignalsKeyValueStore

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

### Members of SignalsKeyValueStore

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **setItem** | <code>method</code> | <code>dart Future<void> setItem(String key, String value)</code> | Sets an item in the store. |
| **getItem** | <code>method</code> | <code>dart Future<String?> getItem(String key)</code> | Gets an item from the store. |
| **removeItem** | <code>method</code> | <code>dart Future<void> removeItem(String key)</code> | Removes an item from the store. |
| **defaultStore** | <code>field</code> | <code>dart static SignalsKeyValueStore defaultStore</code> | The default store to be used if no store is provided. |

## References

The **SignalsKeyValueStore** type is referenced and used in the following pages:

* [PersistedSignal](/packages/signals_flutter/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [PersistedSignal](/packages/signals_core/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [PersistedSignal](/packages/signals/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

