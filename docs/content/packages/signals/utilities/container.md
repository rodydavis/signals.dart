---
title: SignalContainer
description: Signal container used to create signals based on args.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalcontainer"></a><a name="signalcontainer"></a>`SignalContainer(this._create, {this.cache = false, this.onEvict})`

Signal container used to create multiple signals via args

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="cache"></a>`bool cache`

If true then signals will be cached when created

##### <a name="onevict"></a>`void Function(Arg key, S signal)? onEvict`

Optional callback when a signal is removed/evicted from the cache

##### <a name="store"></a>`store`

Store of created signals (if cache is true)

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="call"></a>`S call(Arg arg)`

Create the signal with the given args

##### <a name="remove"></a>`S? remove(Arg arg)`

Remove a signal from the cache

##### <a name="containskey"></a>`bool containsKey(Arg arg)`

Check if signal is currently stored in the cache

##### <a name="clear"></a>`void clear()`

Clear the cache

##### <a name="dispose"></a>`void dispose()`

Dispose of all created signals

##### <a name="length"></a>`int length`

Returns the number of cached signals.

##### <a name="isempty"></a>`bool isEmpty`

Returns true if the cache is empty.

##### <a name="isnotempty"></a>`bool isNotEmpty`

Returns true if the cache is not empty.

##### <a name="keys"></a>`Iterable<Arg> keys`

Returns all currently cached keys.

##### <a name="values"></a>`Iterable<S> values`

Returns all currently cached signals.

##### <a name="entries"></a>`Iterable<MapEntry<Arg, S>> entries`

Returns all currently cached entries.

##### <a name="lookup"></a>`S? lookup(Arg arg)`

Retrieve the cached signal for **arg** if it exists, without creating a new one if it is missing.

##### <a name="removewhere"></a>`void removeWhere(bool Function(Arg key, S signal) test)`

Filter and remove matching cached signals.

</details>



---

## signalContainer

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
