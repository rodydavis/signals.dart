# class `QueueSignalOptions`

Configuration options for a [QueueSignal](/types/queuesignal).

---

## Members of `QueueSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **QueueSignalOptions** | `constructor` | `QueueSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [QueueSignalOptions](/types/queuesignaloptions) instance. |
| **copyWith** | `method` | `QueueSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Queue<T>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
