# class `ChangeSignalOptions`

Configuration options for a [ChangeStackSignal](/types/changestacksignal).

---

## Members of `ChangeSignalOptions`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | `field` | `int? limit` | The limit of changes to keep in the undo/redo stack. |
| **ChangeSignalOptions** | `constructor` | `ChangeSignalOptions({this.limit, super.name, super.autoDispose, super.watched, super.unwatched})` | Creates a new [ChangeSignalOptions](/types/changesignaloptions) instance. |
| **copyWith** | `method` | `ChangeSignalOptions<T> copyWith({int? limit, String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})` |  |
| **==** | `method` | `bool ==(Object other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
