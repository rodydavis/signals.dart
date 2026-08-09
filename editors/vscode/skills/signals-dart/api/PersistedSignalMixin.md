# mixin `PersistedSignalMixin`

A mixin that adds local persistence capabilities to a standard [Signal](/types/signal).

By mixing in <code>PersistedSignalMixin<T></code> on a <code>Signal<T></code> subclass, the signal
will automatically retrieve its stored state on boot and save its state whenever
<code>.value</code> is mutated.

Classes mixing in <code>PersistedSignalMixin<T></code> must implement:
- **key**: A unique identifier string for the key-value database.
- **store**: An implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

### Serialization Customization
By default, the mixin uses standard JSON parsing (<code>jsonDecode</code> / <code>jsonEncode</code>).
If your data type <code>T</code> is not natively supported by JSON, override:
- **decode** to convert the raw string value back into type <code>T</code>.
- **encode** to serialize type <code>T</code> into a string.

---

## Members of `PersistedSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **key** | `method` | `String key` | The key to use for storing the value. |
| **store** | `method` | `SignalsKeyValueStore store` | The store to use for storing the value. |
| **loaded** | `field` | `bool loaded` | Whether the signal has been loaded from the store. |
| **init** | `method` | `Future<void> init()` | Initializes the signal by loading the value from the store. |
| **value** | `method` | `T value` |  |
| **value** | `method` | `value(T value)` |  |
| **load** | `method` | `Future<T> load()` | Loads the value from the store. |
| **save** | `method` | `Future<void> save(T value)` | Saves the value to the store. |
| **decode** | `method` | `T decode(String value)` | Decodes the value from a string. |
| **encode** | `method` | `String encode(T value)` | Encodes the value to a string. |
