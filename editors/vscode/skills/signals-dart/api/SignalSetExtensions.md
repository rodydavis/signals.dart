# extension `SignalSetExtensions`

Utility extension on **Set** to easily lift a set into a reactive [Signal](/types/signal).

---

## Members of `SignalSetExtensions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **$** | `method` | `Signal<Set<E>> $` | Lift a primitive **Set** into a reactive [Signal<Set<E>>].

```dart
import 'package:signals_core/signals_core.dart';

final tags = {'sports', 'news'}.$;
print(tags.value); // {'sports', 'news'}
``` |
