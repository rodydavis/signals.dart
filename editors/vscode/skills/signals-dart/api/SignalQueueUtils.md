# extension `SignalQueueUtils`

Utility extension methods on **Queue** to convert them to [QueueSignal](/types/queuesignal)s.

---

## Members of `SignalQueueUtils`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | `method` | `QueueSignal<T> toSignal({QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})` | Convert an existing list to [QueueSignal](/types/queuesignal) |
