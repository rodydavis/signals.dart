# class `ListSignalOptions`

Configuration options for a [ListSignal](/types/listsignal).

---

## Members of `ListSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ListSignalOptions** | `constructor` | `ListSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [ListSignalOptions](/types/listsignaloptions) instance. |
| **copyWith** | `method` | `ListSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<List<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
