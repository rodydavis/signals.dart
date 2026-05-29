# class `ReadonlySignalOptions`

Configuration options for a [ReadonlySignal](/types/readonlysignal) extending **signals.ReadonlySignalOptions**.

---

## Members of `ReadonlySignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **toSignalOptions** | `method` | `SignalOptions<T> toSignalOptions` | Convert to [SignalOptions](/types/signaloptions) |
| **ReadonlySignalOptions** | `constructor` | `ReadonlySignalOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})` | Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance. |
| **copyWith** | `method` | `ReadonlySignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
