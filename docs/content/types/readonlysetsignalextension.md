---
title: "Type: ReadonlySetSignalExtension"
description: "API reference and details for ReadonlySetSignalExtension from signals.dart."
---

# ReadonlySetSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ReadonlySetSignalExtension

```dart
extension ReadonlySetSignalExtension on ReadonlySignal<Set<E>>
```

Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively.

```dart
import 'package:signals_core/signals_core.dart';

final setA = {1, 2, 3}.$;
final setB = {3, 4, 5}.$;
final diff = computed(() => setA.difference(setB.value)); // {1, 2}
```

### Members of ReadonlySetSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | <code>method</code> | <code>dart Set<R> cast()</code> |  |
| **containsAll** | <code>method</code> | <code>dart bool containsAll(Iterable<Object?> other)</code> |  |
| **difference** | <code>method</code> | <code>dart Set<E> difference(Set<Object?> other)</code> |  |
| **intersection** | <code>method</code> | <code>dart Set<E> intersection(Set<Object?> other)</code> |  |
| **lookup** | <code>method</code> | <code>dart E? lookup(Object? object)</code> |  |
| **union** | <code>method</code> | <code>dart Set<E> union(Set<E> other)</code> |  |

## References

The **ReadonlySetSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

