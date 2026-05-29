# class `ComputedOptions`

Configuration options for a [Computed](/types/computed) extending **signals.ComputedOptions**.

---

## Members of `ComputedOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **ComputedOptions** | `constructor` | `ComputedOptions({super.name, this.autoDispose = false, super.watched, super.unwatched})` | Creates a new [ComputedOptions](/types/computedoptions) instance. |
| **copyWith** | `method` | `ComputedOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
