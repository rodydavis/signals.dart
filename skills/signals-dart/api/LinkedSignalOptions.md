# class `LinkedSignalOptions`

Options for creating a [LinkedSignal](/types/linkedsignal).

---

## Members of `LinkedSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **computation** | `field` | `T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation` | Custom computation logic that runs when the source changes. |
| **sourceEquality** | `field` | `bool Function(S a, S b)? sourceEquality` | Optional equality check for the source values. |
| **LinkedSignalOptions** | `constructor` | `LinkedSignalOptions({this.computation, this.sourceEquality, super.name, super.autoDispose})` | Creates [LinkedSignalOptions](/types/linkedsignaloptions). |
| **copyWith** | `method` | `LinkedSignalOptions<T, S> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, T Function(S source, LinkedSignalPreviousState<T, S>? previous)? computation, bool Function(S a, S b)? sourceEquality})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
