---
title: SignalsObserver
description: You can observe all signal values in the dart application by providing an implementation of <code>SignalsObserver</code>:.
---

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


### Properties

<details>
<summary> View Properties </summary>

##### <a name="instance"></a>`static SignalsObserver? instance`

The current observer instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="onsignalcreated"></a>`void onSignalCreated(Signal<T> instance, T value)`

Called when a signal is created.

##### <a name="onsignalupdated"></a>`void onSignalUpdated(Signal<T> instance, T value)`

Called when a signal is updated.

##### <a name="oncomputedcreated"></a>`void onComputedCreated(Computed<T> instance)`

Called when a computed is created.

##### <a name="oncomputedupdated"></a>`void onComputedUpdated(Computed<T> instance, T value)`

Called when a computed is updated.

##### <a name="oneffectcreated"></a>`void onEffectCreated(Effect instance)`

Called when a effect is created.

##### <a name="oneffectcalled"></a>`void onEffectCalled(Effect instance)`

Called when a effect is called.

##### <a name="oneffectremoved"></a>`void onEffectRemoved(Effect instance)`

Called when a effect is disposed.

</details>
