# class `SignalOptions`

Configuration options for a [Signal](/types/signal) extending **signals.SignalOptions**.

---

## Members of `SignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **SignalOptions** | `constructor` | `SignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched, super.equality})` | Creates a new [SignalOptions](/types/signaloptions) instance. |
| **copyWith** | `method` | `SignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
