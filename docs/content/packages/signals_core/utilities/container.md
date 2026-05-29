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

##### <a name="signalcontainer"></a><a name="signalcontainer"></a><code>SignalContainer(this._create, {this.cache = false, this.onEvict})</code>

Signal container used to create multiple signals via args

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="cache"></a><code>bool cache</code>

If true then signals will be cached when created

##### <a name="onevict"></a><code>void Function(Arg key, S signal)? onEvict</code>

Optional callback when a signal is removed/evicted from the cache

##### <a name="store"></a><code>store</code>

Store of created signals (if cache is true)

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="call"></a><code>S call(Arg arg)</code>

Create the signal with the given args

##### <a name="remove"></a><code>S? remove(Arg arg)</code>

Remove a signal from the cache

##### <a name="containskey"></a><code>bool containsKey(Arg arg)</code>

Check if signal is currently stored in the cache

##### <a name="clear"></a><code>void clear()</code>

Clear the cache

##### <a name="dispose"></a><code>void dispose()</code>

Dispose of all created signals

##### <a name="length"></a><code>int length</code>

Returns the number of cached signals.

##### <a name="isempty"></a><code>bool isEmpty</code>

Returns true if the cache is empty.

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

Returns true if the cache is not empty.

##### <a name="keys"></a><code>Iterable<Arg> keys</code>

Returns all currently cached keys.

##### <a name="values"></a><code>Iterable<S> values</code>

Returns all currently cached signals.

##### <a name="entries"></a><code>Iterable<MapEntry<Arg, S>> entries</code>

Returns all currently cached entries.

##### <a name="lookup"></a><code>S? lookup(Arg arg)</code>

Retrieve the cached signal for **arg** if it exists, without creating a new one if it is missing.

##### <a name="removewhere"></a><code>void removeWhere(bool Function(Arg key, S signal) test)</code>

Filter and remove matching cached signals.

</details>



---

## readonlySignalContainer

Create a signal container used to instance signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

The signals cannot be updated but allows for
using computed where the value is only derived from other signals.


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


---

## streamSignalContainer

Create a signal container for StreamSignals based on args.

```dart
final container = streamSignalContainer<Message, int>((roomId) {
  return streamSignal(() => listenToRoom(roomId));
});
```


---

## computedContainer

Create a signal container for computed signals based on args.

```dart
final container = computedContainer<int, int>((arg) {
  return computed(() => sourceSignal.value * arg);
});
```


---

## futureSignalContainer

Create a signal container for FutureSignals based on args.

```dart
final container = futureSignalContainer<Post, int>((id) {
  return futureSignal(() => fetchPost(id));
});
```
