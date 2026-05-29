# class `IterableSignalOptions`

Configuration options for a [IterableSignal](/types/iterablesignal).

---

## Members of `IterableSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **IterableSignalOptions** | `constructor` | `IterableSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [IterableSignalOptions](/types/iterablesignaloptions) instance. |
| **copyWith** | `method` | `IterableSignalOptions<E> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Iterable<E>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
