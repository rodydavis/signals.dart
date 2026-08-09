# extension `ReadonlySignalUtils`

Utility extensions on [ReadonlySignal](/types/readonlysignal) to bridge reactive programming with asynchronous streams and select sub-states.

---

## Members of `ReadonlySignalUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toStream** | `method` | `Stream<T> toStream()` | Convert a signal to a **Stream** to be consumed as
a read only stream. |
| **select** | `method` | `Computed<R> select(R Function(ReadonlySignal<T>) selector, [ComputedOptions<R>? options])` | Select a sub-state value from this signal and return a computed signal that only notifies when that specific sub-state changes.

This is highly useful for nesting or destructuring complex objects or maps without triggering downstream updates on changes to unrelated fields.

```dart
import 'package:signals_core/signals_core.dart';

final user = signal({'name': 'John', 'age': 30});
final name = user.select((val) => val()['name'] as String);

effect(() => print('Name changed: ${name.value}'));

// Unrelated field update: does NOT trigger the name effect!
user.value = {'name': 'John', 'age': 31};

// Related field update: triggers the name effect!
user.value = {'name': 'Jane', 'age': 31};
``` |
