---
title: MapSignal
description: A reactive Signal that holds a **Map** and implements the **Map** interface.
---

A reactive [Signal](/packages/signals/core/signal) that holds a **Map** and implements the **Map** interface.

[MapSignal](/packages/signals/value/map) lets you listen to changes on a map reactively and mutate it directly using
standard map operations (like adding/modifying keys with `operator []=`, `addAll`, `remove`,
`clear`, etc.). Any mutations automatically trigger reactive updates to all active listeners
(e.g., inside an [effect](/packages/signals/core/effect) or [computed](/packages/signals/flutter/computed)).

Additionally, [MapSignal](/packages/signals/value/map) defines convenient operators:
- `<<` injects/adds all entries from another map into the current map.
- `&` forks/concatenates the map with another map into a new [MapSignal](/packages/signals/value/map).
- `|` pipes/concatenates the map with another signal holding a map into a new [MapSignal](/packages/signals/value/map).

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
do not need to assign `settings.value = ...` manually!
</Success>


### Constructors

##### <a name="mapsignal"></a><a name="mapsignal"></a>`MapSignal(super.value, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [MapSignal](/packages/signals/value/map) with the given **value**.


### Methods

##### <a name="<<"></a>`MapSignal<K, V> <<(Map<K, V> other)`

Inject: Update current signal value with iterable

##### <a name="&"></a>`MapSignal<K, V> &(Map<K, V> other)`

Fork: create a new signal with value is the concatenation of source signal and iterable parameter

##### <a name="|"></a>`MapSignal<K, V> |(Signal<Map<K, V>> other)`

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`



---

## mapSignal

Creates a [MapSignal](/packages/signals/value/map) initialized with the provided **map**.

This is a convenience helper function for creating reactive map signals.

```dart
import 'package:signals/signals.dart';

final settings = mapSignal({'theme': 'dark'});
```
