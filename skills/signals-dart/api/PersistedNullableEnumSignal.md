# class `PersistedNullableEnumSignal`

A <code>PersistedSignal</code> that stores a nullable enum value.

---

## Members of `PersistedNullableEnumSignal`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **PersistedNullableEnumSignal** | `constructor` | `PersistedNullableEnumSignal(super.val, String key, this.values, {SignalsKeyValueStore? store})` | Creates a new <code>NullableEnumSignal</code>. |
| **values** | `field` | `List<T> values` |  |
| **decode** | `method` | `T? decode(String value)` |  |
| **encode** | `method` | `String encode(T? value)` |  |
