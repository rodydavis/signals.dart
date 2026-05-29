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



---

## LoggingSignalsObserver

Logs all signals and computed changes to the console.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="oncomputedcreated"></a>`void onComputedCreated(Computed<T> instance)`

##### <a name="oncomputedupdated"></a>`void onComputedUpdated(Computed<T> instance, T value)`

##### <a name="onsignalcreated"></a>`void onSignalCreated(Signal<T> instance, T value)`

##### <a name="onsignalupdated"></a>`void onSignalUpdated(Signal<T> instance, T value)`

##### <a name="oneffectcreated"></a>`void onEffectCreated(Effect instance)`

##### <a name="oneffectcalled"></a>`void onEffectCalled(Effect instance)`

##### <a name="oneffectremoved"></a>`void onEffectRemoved(Effect instance)`

##### <a name="log"></a>`void log(String message)`

Logs a message to the console.

</details>



---

## onSignalRead

Global callback when any signal is read.


---

## signalsDevToolsEnabled

Manually enable/disable signals devtools


---

## DevToolsSignalsObserver

Signals DevTools observer


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="devtoolssignalsobserver"></a><a name="devtoolssignalsobserver"></a>`DevToolsSignalsObserver()`

Create a DevToolsSignalsObserver and register the VM service extensions.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="enabled"></a>`bool enabled`

Check if devTools is enabled

##### <a name="enabled"></a>`enabled(bool value)`

Enable/Disable devTools

##### <a name="reassemble"></a>`void reassemble()`

Reload the signals devTools

##### <a name="oncomputedcreated"></a>`void onComputedCreated(Computed<T> instance)`

##### <a name="oncomputedupdated"></a>`void onComputedUpdated(Computed<T> instance, T value)`

##### <a name="onsignalcreated"></a>`void onSignalCreated(Signal<T> instance, T value)`

##### <a name="onsignalupdated"></a>`void onSignalUpdated(Signal<T> instance, T value)`

##### <a name="log"></a>`void log(String message)`

Logs a message to the console.

##### <a name="oneffectcreated"></a>`void onEffectCreated(Effect instance)`

##### <a name="oneffectcalled"></a>`void onEffectCalled(Effect instance)`

##### <a name="oneffectremoved"></a>`void onEffectRemoved(Effect instance)`

##### <a name="getnodes"></a>`Map<String, dynamic> getNodes()`

Returns a map representation of all active signals, computeds, and effects
in the reactive graph.

</details>



---

## disableSignalsDevTools

Disable the devtools


---

## reloadSignalsDevTools

Reload the devtools
