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

##### <a name="instance"></a><code>static SignalsObserver? instance</code>

The current observer instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="onsignalcreated"></a><code>void onSignalCreated(Signal<T> instance, T value)</code>

Called when a signal is created.

##### <a name="onsignalupdated"></a><code>void onSignalUpdated(Signal<T> instance, T value)</code>

Called when a signal is updated.

##### <a name="oncomputedcreated"></a><code>void onComputedCreated(Computed<T> instance)</code>

Called when a computed is created.

##### <a name="oncomputedupdated"></a><code>void onComputedUpdated(Computed<T> instance, T value)</code>

Called when a computed is updated.

##### <a name="oneffectcreated"></a><code>void onEffectCreated(Effect instance)</code>

Called when a effect is created.

##### <a name="oneffectcalled"></a><code>void onEffectCalled(Effect instance)</code>

Called when a effect is called.

##### <a name="oneffectremoved"></a><code>void onEffectRemoved(Effect instance)</code>

Called when a effect is disposed.

</details>



---

## LoggingSignalsObserver

Logs all signals and computed changes to the console.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="oncomputedcreated"></a><code>void onComputedCreated(Computed<T> instance)</code>

##### <a name="oncomputedupdated"></a><code>void onComputedUpdated(Computed<T> instance, T value)</code>

##### <a name="onsignalcreated"></a><code>void onSignalCreated(Signal<T> instance, T value)</code>

##### <a name="onsignalupdated"></a><code>void onSignalUpdated(Signal<T> instance, T value)</code>

##### <a name="oneffectcreated"></a><code>void onEffectCreated(Effect instance)</code>

##### <a name="oneffectcalled"></a><code>void onEffectCalled(Effect instance)</code>

##### <a name="oneffectremoved"></a><code>void onEffectRemoved(Effect instance)</code>

##### <a name="log"></a><code>void log(String message)</code>

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

##### <a name="devtoolssignalsobserver"></a><a name="devtoolssignalsobserver"></a><code>DevToolsSignalsObserver()</code>

Create a DevToolsSignalsObserver and register the VM service extensions.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="enabled"></a><code>bool enabled</code>

Check if devTools is enabled

##### <a name="enabled"></a><code>enabled(bool value)</code>

Enable/Disable devTools

##### <a name="reassemble"></a><code>void reassemble()</code>

Reload the signals devTools

##### <a name="oncomputedcreated"></a><code>void onComputedCreated(Computed<T> instance)</code>

##### <a name="oncomputedupdated"></a><code>void onComputedUpdated(Computed<T> instance, T value)</code>

##### <a name="onsignalcreated"></a><code>void onSignalCreated(Signal<T> instance, T value)</code>

##### <a name="onsignalupdated"></a><code>void onSignalUpdated(Signal<T> instance, T value)</code>

##### <a name="log"></a><code>void log(String message)</code>

Logs a message to the console.

##### <a name="oneffectcreated"></a><code>void onEffectCreated(Effect instance)</code>

##### <a name="oneffectcalled"></a><code>void onEffectCalled(Effect instance)</code>

##### <a name="oneffectremoved"></a><code>void onEffectRemoved(Effect instance)</code>

##### <a name="getnodes"></a><code>Map<String, dynamic> getNodes()</code>

Returns a map representation of all active signals, computeds, and effects
in the reactive graph.

</details>



---

## disableSignalsDevTools

Disable the devtools


---

## reloadSignalsDevTools

Reload the devtools
