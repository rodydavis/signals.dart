# class `AsyncError`

State for an [AsyncState](/types/asyncstate) with an error

---

## Members of `AsyncError`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncError** | `constructor` | `AsyncError(this.error, this.stackTrace)` | State for an [AsyncState](/types/asyncstate) with an error |
| **hasValue** | `method` | `bool hasValue` |  |
| **hasError** | `method` | `bool hasError` |  |
| **value** | `method` | `T? value` |  |
| **isLoading** | `method` | `bool isLoading` |  |
| **isRefreshing** | `method` | `bool isRefreshing` |  |
| **isReloading** | `method` | `bool isReloading` |  |
| **requireValue** | `method` | `T requireValue` |  |
| **error** | `field` | `Object error` |  |
| **stackTrace** | `field` | `StackTrace stackTrace` |  |
| **==** | `method` | `bool ==(covariant AsyncState other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
