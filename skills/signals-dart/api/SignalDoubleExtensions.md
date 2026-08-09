# extension `SignalDoubleExtensions`

Utility extension on **double** to easily lift a double into a reactive [Signal](/types/signal).

---

## Members of `SignalDoubleExtensions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<double> $` | Lift a primitive **double** into a reactive [Signal<double>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 3.14.$;
print(doubleSignal.value); // 3.14
``` |
