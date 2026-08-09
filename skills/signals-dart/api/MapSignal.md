# function `mapSignal`

Creates a [MapSignal](/types/mapsignal) initialized with the provided **map**.

This is a convenience helper function for creating reactive map signals.

```dart
import 'package:signals/signals.dart';

final settings = mapSignal({'theme': 'dark'});
```

---

## Signature

```dart
MapSignal<K, V> mapSignal(Map<K, V> map, {MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})
```

