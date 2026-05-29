# extension `SetSignalExtension`

Helper extensions for [Signal<Set<E>>] to perform mutation operations that automatically notify downstreams.

Under the hood, these methods mutate the underlying set and call <code>set(..., force: true)</code> to trigger all listeners and computations.

```dart
import 'package:signals_core/signals_core.dart';

final tags = <String>{}.$;

effect(() {
  print('Tags: ${tags.value}');
});

tags.add('dart'); // Automatically prints: Tags: {dart}
tags.addAll(['flutter', 'signals']); // Automatically prints: Tags: {dart, flutter, signals}
```

---

## Members of `SetSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `bool add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> elements)` |  |
| **clear** | `method` | `void clear()` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAll** | `method` | `void removeAll(Iterable<Object?> elements)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **retainAll** | `method` | `void retainAll(Iterable<Object?> elements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
