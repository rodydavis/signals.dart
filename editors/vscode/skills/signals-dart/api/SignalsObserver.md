# class `SignalsObserver`

You can observe all signal values in the dart application by providing an implementation of <code>SignalsObserver</code>:

```dart
abstract class SignalsObserver {
  void onSignalCreated(Signal instance);
  void onSignalUpdated(Signal instance, dynamic value);
  void onComputedCreated(Computed instance);
  void onComputedUpdated(Computed instance, dynamic value);
  static SignalsObserver? instance;
}
```

> There is a prebuilt <code>LoggingSignalsObserver</code> for printing updates to the console.

To add the observer override the instance at the start of the application:

```dart
void main() {
    SignalsObserver.instance = LoggingSignalsObserver(); // or custom observer
    ...
}
```

This will have a slight performance hit since every update will be tracked via the observer. It is recommended to only set the <code>SignalsObserver.instance</code> in debug or profile mode.

---

## Members of `SignalsObserver`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onSignalCreated** | `method` | `void onSignalCreated(Signal<T> instance, T value)` | Called when a signal is created. |
| **onSignalUpdated** | `method` | `void onSignalUpdated(Signal<T> instance, T value)` | Called when a signal is updated. |
| **onComputedCreated** | `method` | `void onComputedCreated(Computed<T> instance)` | Called when a computed is created. |
| **onComputedUpdated** | `method` | `void onComputedUpdated(Computed<T> instance, T value)` | Called when a computed is updated. |
| **onEffectCreated** | `method` | `void onEffectCreated(Effect instance)` | Called when a effect is created. |
| **onEffectCalled** | `method` | `void onEffectCalled(Effect instance)` | Called when a effect is called. |
| **onEffectRemoved** | `method` | `void onEffectRemoved(Effect instance)` | Called when a effect is disposed. |
| **instance** | `field` | `static SignalsObserver? instance` | The current observer instance. |
