---
title: "Type: ReadonlyListSignalExtension"
description: "API reference and details for ReadonlyListSignalExtension from signals.dart."
---

# ReadonlyListSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ReadonlyListSignalExtension

```dart
extension ReadonlyListSignalExtension on ReadonlySignal<List<E>>
```

Helper extensions for [ReadonlySignal<List>](/types/readonlysignal)

### Members of ReadonlyListSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | <code>method</code> | <code>dart List<R> cast()</code> |  |
| **last** | <code>method</code> | <code>dart E last</code> |  |
| **+** | <code>method</code> | <code>dart List<E> +(List<E> other)</code> |  |
| **[]** | <code>method</code> | <code>dart E [](int index)</code> |  |
| **asMap** | <code>method</code> | <code>dart Map<int, E> asMap()</code> |  |
| **expand** | <code>method</code> | <code>dart Iterable<R> expand(Iterable<R> Function(E element) toElements)</code> |  |
| **firstWhere** | <code>method</code> | <code>dart E firstWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart R fold(R initialValue, R Function(R previousValue, E element) combine)</code> |  |
| **followedBy** | <code>method</code> | <code>dart Iterable<E> followedBy(Iterable<E> other)</code> |  |
| **getRange** | <code>method</code> | <code>dart Iterable<E> getRange(int start, int end)</code> |  |
| **indexOf** | <code>method</code> | <code>dart int indexOf(E element, [int start = 0])</code> |  |
| **indexWhere** | <code>method</code> | <code>dart int indexWhere(bool Function(E element) test, [int start = 0])</code> |  |
| **lastIndexOf** | <code>method</code> | <code>dart int lastIndexOf(E element, [int? start])</code> |  |
| **lastIndexWhere** | <code>method</code> | <code>dart int lastIndexWhere(bool Function(E element) test, [int? start])</code> |  |
| **reversed** | <code>method</code> | <code>dart Iterable<E> reversed</code> |  |
| **sorted** | <code>method</code> | <code>dart List<E> sorted([int Function(E a, E b)? compare])</code> | Return a new array that is sorted by the **compare** function |
| **sublist** | <code>method</code> | <code>dart List<E> sublist(int start, [int? end])</code> |  |

## References

The **ReadonlyListSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

