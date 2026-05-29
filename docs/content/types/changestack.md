---
title: "Type: changeStack"
description: "API reference and details for changeStack from signals.dart."
---

# changeStack

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: changeStack

```dart
ChangeStackSignal<T> changeStack(T value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})
```

Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided **value**.

This is a convenience helper function for creating reactive undo/redo history signals.
You can pass a **limit** to restrict the maximum history stack size.

```dart
import 'package:signals/signals.dart';

final s = changeStack(0, limit: 10);
s.value = 1;
s.undo(); // Returns to 0
```

## References

The **changeStack** type is referenced and used in the following pages:

* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ChangeStackSignal](/packages/signals_core/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>

