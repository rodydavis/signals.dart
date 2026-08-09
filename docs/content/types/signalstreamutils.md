---
title: "Type: SignalStreamUtils"
description: "API reference and details for SignalStreamUtils from signals.dart."
---

# SignalStreamUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalStreamUtils

```dart
extension SignalStreamUtils on Stream<T>
```

Extension on **Stream** to provide convenient utilities to convert streams into reactive signals.

```dart
import 'package:signals_core/signals_core.dart';

final myStream = Stream.periodic(Duration(seconds: 1), (x) => x).take(5);
final mySignal = myStream.toStreamSignal();
```

### Members of SignalStreamUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toStreamSignal** | <code>method</code> | <code>dart StreamSignal<T> toStreamSignal({bool? cancelOnError, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], void Function()? onDone, AsyncSignalOptions<T>? options})</code> | Convert a stream to a signal |
| **toSyncSignal** | <code>method</code> | <code>dart ReadonlySignal<T> toSyncSignal(T initialData)</code> | Convert a **Stream** to a synchronous [ReadonlySignal](/types/readonlysignal) and provide an initial value. |

## References

The **SignalStreamUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

