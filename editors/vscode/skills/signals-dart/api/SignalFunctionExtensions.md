# extension `SignalFunctionExtensions`

Utility extension on a getter function <code>T Function()</code> to instantly convert it into a [Computed](/types/computed) signal.

---

## Members of `SignalFunctionExtensions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Computed<T> $` | Return a cached, derived [Computed<T>](/types/computed) signal from this getter function.

```dart
import 'package:signals_core/signals_core.dart';

final count = signal(0);
final doubleCount = (() => count.value * 2).$;

print(doubleCount.value); // 0
count.value = 5;
print(doubleCount.value); // 10
``` |
