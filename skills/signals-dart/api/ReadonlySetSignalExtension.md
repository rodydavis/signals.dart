# extension `ReadonlySetSignalExtension`

Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively.

```dart
import 'package:signals_core/signals_core.dart';

final setA = {1, 2, 3}.$;
final setB = {3, 4, 5}.$;
final diff = computed(() => setA.difference(setB.value)); // {1, 2}
```

---

## Members of `ReadonlySetSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `Set<R> cast()` |  |
| **containsAll** | `method` | `bool containsAll(Iterable<Object?> other)` |  |
| **difference** | `method` | `Set<E> difference(Set<Object?> other)` |  |
| **intersection** | `method` | `Set<E> intersection(Set<Object?> other)` |  |
| **lookup** | `method` | `E? lookup(Object? object)` |  |
| **union** | `method` | `Set<E> union(Set<E> other)` |  |
