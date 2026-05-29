# class `EffectOptions`

Configuration options for reactive [Effect](/types/effect)s extending **signals.EffectOptions**.

---

## Members of `EffectOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **autoDispose** | `field` | `bool autoDispose` | Automatically dispose the signal when there are no more listeners. |
| **onDispose** | `field` | `void Function()? onDispose` | Callback called when the effect is disposed. |
| **EffectOptions** | `constructor` | `EffectOptions({super.name, this.autoDispose = false, this.onDispose})` | Creates a new [EffectOptions](/types/effectoptions) instance. |
| **copyWith** | `method` | `EffectOptions copyWith({String? name, bool? autoDispose, void Function()? onDispose})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
