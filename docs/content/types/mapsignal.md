---
title: "Type: MapSignal"
description: "API reference and details for MapSignal from signals.dart."
---

# MapSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: MapSignal

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

### Members of MapSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MapSignal** | <code>constructor</code> | <code>dart MapSignal(super.value, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [MapSignal](/types/mapsignal) with the given **value**. |
| **<<** | <code>method</code> | <code>dart MapSignal<K, V> <<(Map<K, V> other)</code> | Inject: Update current signal value with iterable |
| **&** | <code>method</code> | <code>dart MapSignal<K, V> &(Map<K, V> other)</code> | Fork: create a new signal with value is the concatenation of source signal and iterable parameter |
| **|** | <code>method</code> | <code>dart MapSignal<K, V> |(Signal<Map<K, V>> other)</code> | Pipe: create a new signal by sending value from source to other |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Function: mapSignal

```dart
MapSignal<K, V> mapSignal(Map<K, V> map, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})
```

Creates a [MapSignal](/types/mapsignal) initialized with the provided **map**.

This is a convenience helper function for creating reactive map signals.

```dart
import 'package:signals/signals.dart';

final settings = mapSignal({'theme': 'dark'});
```

## References

The **MapSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [MapSignal](/packages/signals_flutter/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [MapSignal](/packages/signals_core/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [MapSignal](/packages/signals/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [useMapSignal](/packages/signals_hooks/hooks/use-map-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

