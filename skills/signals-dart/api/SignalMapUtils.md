# extension `SignalMapUtils`

Utility extension methods on **Map** to convert them to [MapSignal](/types/mapsignal)s.

---

## Members of `SignalMapUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `MapSignal<K, V> toSignal({MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **Map** to a reactive [MapSignal](/types/mapsignal).

```dart
import 'package:signals/signals.dart';

final myMap = {'key': 'value'};
final signal = myMap.toSignal();
``` |
