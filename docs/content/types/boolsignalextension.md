---
title: "Type: BoolSignalExtension"
description: "API reference and details for BoolSignalExtension from signals.dart."
---

# BoolSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: BoolSignalExtension

```dart
extension BoolSignalExtension on ReadonlySignal<bool>
```

Helper extensions for [ReadonlySignal<bool>](/types/readonlysignal), enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations.

```dart
import 'package:signals_core/signals_core.dart';

final a = true.$;
final b = false.$;
final andResult = a & b.value; // false
final orResult = a | b.value; // true
```

### Members of BoolSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **&** | <code>method</code> | <code>dart bool &(bool other)</code> | The logical conjunction ("and") of this and **other**. |
| **|** | <code>method</code> | <code>dart bool |(bool other)</code> | The logical disjunction ("inclusive or") of this and **other**. |
| **^** | <code>method</code> | <code>dart bool ^(bool other)</code> | The logical exclusive disjunction ("exclusive or") of this and **other**. |

## References

The **BoolSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

