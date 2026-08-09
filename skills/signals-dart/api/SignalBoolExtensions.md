# extension `SignalBoolExtensions`

Utility extension on **bool** to easily lift a boolean into a reactive [Signal](/types/signal).

---

## Members of `SignalBoolExtensions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<bool> $` | Lift a primitive **bool** into a reactive [Signal<bool>](/types/signal).

```dart
import 'package:signals_core/signals_core.dart';

final isEnabled = true.$;
print(isEnabled.value); // true
``` |
