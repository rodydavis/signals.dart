---
title: "Type: SignalQueueUtils"
description: "API reference and details for SignalQueueUtils from signals.dart."
---

# SignalQueueUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalQueueUtils

```dart
extension SignalQueueUtils on Queue<T>
```

Utility extension methods on **Queue** to convert them to [QueueSignal](/types/queuesignal)s.

### Members of SignalQueueUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart QueueSignal<T> toSignal({QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})</code> | Convert an existing list to [QueueSignal](/types/queuesignal) |

## References

The **SignalQueueUtils** type is referenced and used in the following pages:

* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

