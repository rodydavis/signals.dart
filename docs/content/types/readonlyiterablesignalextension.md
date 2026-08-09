---
title: "Type: ReadonlyIterableSignalExtension"
description: "API reference and details for ReadonlyIterableSignalExtension from signals.dart."
---

# ReadonlyIterableSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ReadonlyIterableSignalExtension

```dart
extension ReadonlyIterableSignalExtension on ReadonlySignal<Iterable<E>>
```

Helper extensions for [ReadonlySignal<Iterable>](/types/readonlysignal)

### Members of ReadonlyIterableSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | <code>method</code> | <code>dart bool any(bool Function(E element) test)</code> |  |
| **cast** | <code>method</code> | <code>dart Iterable<R> cast()</code> |  |
| **contains** | <code>method</code> | <code>dart bool contains(Object? value)</code> |  |
| **elementAt** | <code>method</code> | <code>dart E elementAt(int index)</code> |  |
| **every** | <code>method</code> | <code>dart bool every(bool Function(E element) test)</code> |  |
| **expand** | <code>method</code> | <code>dart Iterable<R> expand(Iterable<R> Function(E element) toElements)</code> |  |
| **first** | <code>method</code> | <code>dart E first</code> |  |
| **firstWhere** | <code>method</code> | <code>dart E firstWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart R fold(R initialValue, R Function(R previousValue, E element) combine)</code> |  |
| **followedBy** | <code>method</code> | <code>dart Iterable<E> followedBy(Iterable<E> other)</code> |  |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> |  |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> |  |
| **iterator** | <code>method</code> | <code>dart Iterator<E> iterator</code> |  |
| **join** | <code>method</code> | <code>dart String join([String separator = ""])</code> |  |
| **last** | <code>method</code> | <code>dart E last</code> |  |
| **lastWhere** | <code>method</code> | <code>dart E lastWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **length** | <code>method</code> | <code>dart int length</code> |  |
| **map** | <code>method</code> | <code>dart Iterable<R> map(R Function(E e) toElement)</code> |  |
| **reduce** | <code>method</code> | <code>dart E reduce(E Function(E value, E element) combine)</code> |  |
| **single** | <code>method</code> | <code>dart E single</code> |  |
| **singleWhere** | <code>method</code> | <code>dart E singleWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **skip** | <code>method</code> | <code>dart Iterable<E> skip(int count)</code> |  |
| **skipWhile** | <code>method</code> | <code>dart Iterable<E> skipWhile(bool Function(E value) test)</code> |  |
| **take** | <code>method</code> | <code>dart Iterable<E> take(int count)</code> |  |
| **takeWhile** | <code>method</code> | <code>dart Iterable<E> takeWhile(bool Function(E value) test)</code> |  |
| **toList** | <code>method</code> | <code>dart List<E> toList({bool growable = true})</code> |  |
| **toSet** | <code>method</code> | <code>dart Set<E> toSet()</code> |  |
| **where** | <code>method</code> | <code>dart Iterable<E> where(bool Function(E element) test)</code> |  |
| **whereType** | <code>method</code> | <code>dart Iterable<R> whereType()</code> |  |
| **forEach** | <code>method</code> | <code>dart void forEach(void Function(E element) action)</code> |  |

## References

The **ReadonlyIterableSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

