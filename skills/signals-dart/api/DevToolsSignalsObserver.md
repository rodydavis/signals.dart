# class `DevToolsSignalsObserver`

> [!WARNING]
> This API is deprecated. Avoid using it in new code.

Signals DevTools observer

---

## Members of `DevToolsSignalsObserver`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **DevToolsSignalsObserver** | `constructor` | `DevToolsSignalsObserver()` | Create a DevToolsSignalsObserver and register the VM service extensions. |
| **enabled** | `method` | `bool enabled` | Check if devTools is enabled |
| **enabled** | `method` | `enabled(bool value)` | Enable/Disable devTools |
| **reassemble** | `method` | `void reassemble()` | Reload the signals devTools |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` |  |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` |  |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` |  |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` |  |
| **log** | `method` | `void log(String message)` | Logs a message to the console. |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` |  |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` |  |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` |  |
| **getNodes** | `method` | `Map<String, dynamic> getNodes()` | Returns a map representation of all active signals, computeds, and effects
in the reactive graph. |
