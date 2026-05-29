# class `LoggingSignalsObserver`

Logs all signals and computed changes to the console.

---

## Members of `LoggingSignalsObserver`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` |  |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` |  |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` |  |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` |  |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` |  |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` |  |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` |  |
| **log** | `method` | `void log(String message)` | Logs a message to the console. |
