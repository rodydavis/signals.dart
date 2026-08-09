# extension `SignalFutureUtils`

Extension on future to provide helpful methods for signals

---

## Members of `SignalFutureUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toFutureSignal** | `method` | `FutureSignal<T> toFutureSignal({Duration? timeout, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], AsyncSignalOptions<T>? options})` | Convert an existing future to [FutureSignal](/types/futuresignal)

```dart
import 'package:signals/signals.dart';

final future = Future(() => 1);
final signal = future.toSignal();
``` |
