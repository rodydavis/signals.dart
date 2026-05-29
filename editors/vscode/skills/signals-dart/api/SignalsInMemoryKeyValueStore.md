# class `SignalsInMemoryKeyValueStore`

An in-memory, volatile implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

This serves as a fallback engine and does not persist across restarts/reload.

---

## Members of `SignalsInMemoryKeyValueStore`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **store** | `field` | `store` | The in-memory store. |
| **getItem** | `method` | `Future<String?> getItem(String key)` |  |
| **removeItem** | `method` | `Future<void> removeItem(String key)` |  |
| **setItem** | `method` | `Future<void> setItem(String key, String value)` |  |
