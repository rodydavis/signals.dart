# class `EffectOptions`

Configuration options for reactive [Effect](/types/effect)s.

Permits naming the effect for debugging, performance profiling,
and tracing within the signals developer tools.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

final logger = effect(
  () => print('Count changed to: ${count.value}'),
  options: const EffectOptions(name: 'counter-logger'),
);
```

---

## Members of `EffectOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **EffectOptions** | `constructor` | `EffectOptions({super.name})` | Creates a new [EffectOptions](/types/effectoptions) instance. |
| **copyWith** | `method` | `EffectOptions copyWith({String? name})` | Creates a copy of this options with custom overrides. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
