# class `MapSignalOptions`

Configuration options for a [MapSignal](/types/mapsignal).

---

## Members of `MapSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MapSignalOptions** | `constructor` | `MapSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})` | Creates a new [MapSignalOptions](/types/mapsignaloptions) instance. |
| **copyWith** | `method` | `MapSignalOptions<K, V> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Map<K, V>>? equality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
