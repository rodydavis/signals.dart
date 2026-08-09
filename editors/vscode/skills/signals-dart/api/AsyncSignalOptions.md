# class `AsyncSignalOptions`

Configuration options for an [AsyncSignal](/types/asyncsignal).

---

## Members of `AsyncSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | `field` | `T? initialValue` | The initial value of the async signal. |
| **dependencies** | `field` | `List<ReadonlySignal<dynamic>> dependencies` | The list of dependencies to watch/listen to. |
| **onDone** | `field` | `void Function()? onDone` | Optional function called when a stream completes. |
| **cancelOnError** | `field` | `bool? cancelOnError` | Whether to cancel the stream subscription on error. |
| **lazy** | `field` | `bool lazy` | Whether the execution is lazy. |
| **AsyncSignalOptions** | `constructor` | `AsyncSignalOptions({this.initialValue, this.dependencies = const [], this.onDone, this.cancelOnError, this.lazy = true, super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [AsyncSignalOptions](/types/asyncsignaloptions) instance. |
| **copyWith** | `method` | `AsyncSignalOptions<T> copyWith({T? initialValue, List<ReadonlySignal<dynamic>>? dependencies, void Function()? onDone, bool? cancelOnError, bool? lazy, bool? autoDispose, String? name, void Function()? watched, void Function()? unwatched})` | Creates a copy of this options with custom overrides. |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
