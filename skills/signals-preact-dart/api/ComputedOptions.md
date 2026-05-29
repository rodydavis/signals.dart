# class `ComputedOptions`

Configuration options for a [Computed](/types/computed) signal.

Enables configuring debugging names and subscription state event listeners
for computed derivations.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final doubleCount = computed(
  () => count.value * 2,
  options: ComputedOptions(
    name: 'double-count',
    watched: () => print('Computed doubleCount is active'),
    unwatched: () => print('Computed doubleCount is inactive'),
  ),
);
```

---

## Members of `ComputedOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ComputedOptions** | `constructor` | `ComputedOptions({super.name, super.watched, super.unwatched})` | Creates a new [ComputedOptions](/types/computedoptions) instance. |
| **copyWith** | `method` | `ComputedOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
