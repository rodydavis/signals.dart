# extension `SignalNumExtensions`

Utility extension on **num** to easily lift a number into a reactive [Signal](/types/signal).

---

## Members of `SignalNumExtensions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<num> $` | Lift a primitive **num** into a reactive [Signal<num>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final counter = 10.$;
print(counter.value); // 10
``` |
