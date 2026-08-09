---
title: "Type: ListSignalExtension"
description: "API reference and details for ListSignalExtension from signals.dart."
---

# ListSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ListSignalExtension

```dart
extension ListSignalExtension on Signal<List<E>>
```

Helper extensions for [Signal<List>](/types/signal)

### Members of ListSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **first** | <code>method</code> | <code>dart first(E val)</code> |  |
| **last** | <code>method</code> | <code>dart last(E val)</code> |  |
| **length** | <code>method</code> | <code>dart length(int value)</code> |  |
| **[]=** | <code>method</code> | <code>dart void []=(int index, E value)</code> |  |
| **add** | <code>method</code> | <code>dart void add(E value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Iterable<E> iterable)</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **fillRange** | <code>method</code> | <code>dart void fillRange(int start, int end, [E? fillValue])</code> |  |
| **insert** | <code>method</code> | <code>dart void insert(int index, E element)</code> |  |
| **insertAll** | <code>method</code> | <code>dart void insertAll(int index, Iterable<E> iterable)</code> |  |
| **remove** | <code>method</code> | <code>dart bool remove(Object? value)</code> |  |
| **removeAt** | <code>method</code> | <code>dart E removeAt(int index)</code> |  |
| **removeLast** | <code>method</code> | <code>dart E removeLast()</code> |  |
| **removeRange** | <code>method</code> | <code>dart void removeRange(int start, int end)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(E element) test)</code> |  |
| **replaceRange** | <code>method</code> | <code>dart void replaceRange(int start, int end, Iterable<E> replacements)</code> |  |
| **retainWhere** | <code>method</code> | <code>dart void retainWhere(bool Function(E element) test)</code> |  |
| **setAll** | <code>method</code> | <code>dart void setAll(int index, Iterable<E> iterable)</code> |  |
| **setRange** | <code>method</code> | <code>dart void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])</code> |  |
| **shuffle** | <code>method</code> | <code>dart void shuffle([Random? random])</code> |  |
| **sort** | <code>method</code> | <code>dart void sort([int Function(E a, E b)? compare])</code> |  |

## References

The **ListSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

