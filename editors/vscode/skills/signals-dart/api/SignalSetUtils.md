# extension `SignalSetUtils`

Utility extension methods on **Set** to convert them to [SetSignal](/types/setsignal)s.

---

## Members of `SignalSetUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `SetSignal<T> toSignal({SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})` | Convert this existing **Set** to a reactive [SetSignal](/types/setsignal).

```dart
import 'package:signals/signals.dart';

final mySet = {1, 2, 3};
final signal = mySet.toSignal();
``` |
