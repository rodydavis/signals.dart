---
title: SignalContainer
description: Create a container that can create signals based on args
---

Signal container used to create signals based on args.

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});
final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

If you need the signal to be mutable use `signalContainer`.

```dart
final counters = signalContainer<int, int>((e) {
  return signal(e);
});
final counterA = counters(1);
final counterB = counters(2);
final counterC = counters(3);
counterA.value = 2;
counterB.value = 3;
counterC.value = 4;
```

By default the signal container does not cache signals and will return new ones every time. To cache pass in the flag.

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
}, cache: true);
final cacheA = container('cache-a');
final cacheB = container('cache-a');
print(cacheA == cacheB); // true
```

Example of signal container for settings and SharedPreferences:

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
