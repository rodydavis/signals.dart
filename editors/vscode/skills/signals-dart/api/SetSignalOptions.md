# class `SetSignalOptions`

Configuration options for a [SetSignal](/types/setsignal).

---

## Members of `SetSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SetSignalOptions** | `constructor` | `SetSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [SetSignalOptions](/types/setsignaloptions) instance. |
| **copyWith** | `method` | `SetSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Set<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
