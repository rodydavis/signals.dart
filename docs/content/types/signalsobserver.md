---
title: "Type: SignalsObserver"
description: "API reference and details for SignalsObserver from signals.dart."
---

# SignalsObserver

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SignalsObserver

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

### Members of SignalsObserver

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onSignalCreated** | <code>method</code> | <code>dart void onSignalCreated(Signal<T> instance, T value)</code> | Called when a signal is created. |
| **onSignalUpdated** | <code>method</code> | <code>dart void onSignalUpdated(Signal<T> instance, T value)</code> | Called when a signal is updated. |
| **onComputedCreated** | <code>method</code> | <code>dart void onComputedCreated(Computed<T> instance)</code> | Called when a computed is created. |
| **onComputedUpdated** | <code>method</code> | <code>dart void onComputedUpdated(Computed<T> instance, T value)</code> | Called when a computed is updated. |
| **onEffectCreated** | <code>method</code> | <code>dart void onEffectCreated(Effect instance)</code> | Called when a effect is created. |
| **onEffectCalled** | <code>method</code> | <code>dart void onEffectCalled(Effect instance)</code> | Called when a effect is called. |
| **onEffectRemoved** | <code>method</code> | <code>dart void onEffectRemoved(Effect instance)</code> | Called when a effect is disposed. |
| **instance** | <code>field</code> | <code>dart static SignalsObserver? instance</code> | The current observer instance. |

## References

The **SignalsObserver** type is referenced and used in the following pages:

* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalsObserver](/packages/signals_core/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

