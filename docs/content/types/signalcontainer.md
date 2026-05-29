---
title: "Type: SignalContainer"
description: "API reference and details for SignalContainer from signals.dart."
---

# SignalContainer

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SignalContainer

Signal container used to create signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

Example of settings and SharedPreferences:

```dart
class Settings {
  final SharedPreferences prefs;
  EffectCleanup? _cleanup;

  Settings(this.prefs) {
    _cleanup = effect(() {
      for (final entry in setting.store.entries) {
        final value = entry.value.peek();
        if (prefs.getString(entry.key.$1) != value) {
          prefs.setString(entry.key.$1, value).ignore();
        }
      }
    });
  }

  late final setting = signalContainer<String, (String, String)>(
    (val) => signal(prefs.getString(val.$1) ?? val.$2),
    cache: true,
  );

  Signal<String> get darkMode => setting(('dark-mode', 'false'));

  void dispose() {
    _cleanup?.call();
    setting.dispose();
  }
}

void main() {
 // Load or find instance
 late final SharedPreferences prefs = ...;

 // Create settings
 final settings = Settings(prefs);

 // Get value
 print('dark mode: ${settings.darkMode}');

 // Update value
 settings.darkMode.value = 'true';
}
```

### Members of SignalContainer

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cache** | <code>field</code> | <code>dart bool cache</code> | If true then signals will be cached when created |
| **onEvict** | <code>field</code> | <code>dart void Function(Arg key, S signal)? onEvict</code> | Optional callback when a signal is removed/evicted from the cache |
| **store** | <code>field</code> | <code>dart store</code> | Store of created signals (if cache is true) |
| **SignalContainer** | <code>constructor</code> | <code>dart SignalContainer(this._create, {this.cache = false, this.onEvict})</code> | Signal container used to create multiple signals via args |
| **call** | <code>method</code> | <code>dart S call(Arg arg)</code> | Create the signal with the given args |
| **remove** | <code>method</code> | <code>dart S? remove(Arg arg)</code> | Remove a signal from the cache |
| **containsKey** | <code>method</code> | <code>dart bool containsKey(Arg arg)</code> | Check if signal is currently stored in the cache |
| **clear** | <code>method</code> | <code>dart void clear()</code> | Clear the cache |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> | Dispose of all created signals |
| **length** | <code>method</code> | <code>dart int length</code> | Returns the number of cached signals. |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> | Returns true if the cache is empty. |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> | Returns true if the cache is not empty. |
| **keys** | <code>method</code> | <code>dart Iterable<Arg> keys</code> | Returns all currently cached keys. |
| **values** | <code>method</code> | <code>dart Iterable<S> values</code> | Returns all currently cached signals. |
| **entries** | <code>method</code> | <code>dart Iterable<MapEntry<Arg, S>> entries</code> | Returns all currently cached entries. |
| **lookup** | <code>method</code> | <code>dart S? lookup(Arg arg)</code> | Retrieve the cached signal for **arg** if it exists, without creating a new one if it is missing. |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(Arg key, S signal) test)</code> | Filter and remove matching cached signals. |

## Function: signalContainer

```dart
SignalContainer<T, Arg, Signal<T>> signalContainer(Signal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Signal<T> signal)? onEvict})
```

Create a signal container used to instance signals based on args

```dart
final container = signalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');

cacheA.value = 'a';
cacheB.value = 'b';
cacheC.value = 'c';
```

## References

The **SignalContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

