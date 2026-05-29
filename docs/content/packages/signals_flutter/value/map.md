---
title: MapSignal
description: A reactive Signal that holds a Map and implements the Map interface.
---

A reactive [Signal](/types/signal) that holds a **Map** and implements the **Map** interface.

[MapSignal](/types/mapsignal) lets you listen to changes on a map reactively and mutate it directly using
standard map operations (like adding/modifying keys with <code>operator []=</code>, <code>addAll</code>, <code>remove</code>,
<code>clear</code>, etc.). Any mutations automatically trigger reactive updates to all active listeners
(e.g., inside an [effect](/types/effect) or [computed](/types/computed)).

Additionally, [MapSignal](/types/mapsignal) defines convenient operators:
- <code><<</code> injects/adds all entries from another map into the current map.
- <code>&</code> forks/concatenates the map with another map into a new [MapSignal](/types/mapsignal).
- <code>|</code> pipes/concatenates the map with another signal holding a map into a new [MapSignal](/types/mapsignal).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final settings = mapSignal<String, dynamic>({
    'theme': 'light',
    'notifications': true,
  });

  effect(() {
    print('Theme is currently: ${settings['theme']}');
  }); // Prints: "Theme is currently: light"

  // Update key/value pair directly (triggers updates)
  settings['theme'] = 'dark'; // Prints: "Theme is currently: dark"

  // Expose standard Map methods
  settings.remove('notifications');
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign <code>settings.value = ...</code> manually!
</Success>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="mapsignal"></a><a name="mapsignal"></a><code>MapSignal(super.value, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})</code>

Creates a [MapSignal](/types/mapsignal) with the given **value**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="<<"></a><code>MapSignal<K, V> <<(Map<K, V> other)</code>

Inject: Update current signal value with iterable

##### <a name="&"></a><code>MapSignal<K, V> &(Map<K, V> other)</code>

Fork: create a new signal with value is the concatenation of source signal and iterable parameter

##### <a name="|"></a><code>MapSignal<K, V> |(Signal<Map<K, V>> other)</code>

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## mapSignal

Creates a [MapSignal](/types/mapsignal) initialized with the provided **map**.

This is a convenience helper function for creating reactive map signals.

```dart
import 'package:signals/signals.dart';

final settings = mapSignal({'theme': 'dark'});
```
