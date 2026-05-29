---
title: "Type: SetSignalExtension"
description: "API reference and details for SetSignalExtension from signals.dart."
---

# SetSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SetSignalExtension

```dart
extension SetSignalExtension on Signal<Set<E>>
```

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

### Members of SetSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | <code>method</code> | <code>dart bool add(E value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Iterable<E> elements)</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **remove** | <code>method</code> | <code>dart bool remove(Object? value)</code> |  |
| **removeAll** | <code>method</code> | <code>dart void removeAll(Iterable<Object?> elements)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(E element) test)</code> |  |
| **retainAll** | <code>method</code> | <code>dart void retainAll(Iterable<Object?> elements)</code> |  |
| **retainWhere** | <code>method</code> | <code>dart void retainWhere(bool Function(E element) test)</code> |  |

## References

The **SetSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

