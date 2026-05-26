---
title: Value Notifier
description: A global helper function to convert a Flutter **ValueNotifier** to a mutable Signal.
---

## valueNotifierToSignal

A global helper function to convert a Flutter **ValueNotifier** to a mutable [Signal](/packages/signals/core/signal).

Updates to either the notifier or the returned signal will automatically update the other.
This helper is a functional equivalent of the `toSignal()` extension method.

### Example
```dart
final textControllerValue = ValueNotifier('');
final textSignal = valueNotifierToSignal(textControllerValue);
```


---

## SignalValueNotifierUtils

Extension on **ValueNotifier** to seamlessly bridge standard Flutter mutable values to reactive signals.


### Methods

##### <a name="tosignal"></a>`Signal<T> toSignal({String? debugLabel, bool autoDispose = false})`

## Bi-directional Signal and ValueNotifier Interoperability

Converted **ValueNotifier** objects become mutable [Signal](/packages/signals/core/signal) instances. Setting the value
on the signal or the notifier automatically propagates the update to the other.

The subscription is fully memory-safe and automatically unsubscribed when the signal
is disposed.

### Example: Converting a ValueNotifier to a Signal
```dart
final notifier = ValueNotifier(10);
final signal = notifier.toSignal();

signal.value = 20;
print(notifier.value); // 20

notifier.value = 30;
print(signal.value); // 30
```

### Example: Converting a Signal to a ValueNotifier
To bridge back to a standard **ValueNotifier** for Flutter compatibility:
```dart
final signal = Signal(10);
final notifier = signal.toValueNotifier();
```



---

## ValueNotifierSignalMixin

**ValueNotifier** implementation for [Signal](/packages/signals/core/signal)


### Methods

##### <a name="runcallbackonlisten"></a>`bool runCallbackOnListen`

If true, the callback will be run when the listener is added

##### <a name="addlistener"></a>`void addListener(VoidCallback listener)`

##### <a name="removelistener"></a>`void removeListener(VoidCallback listener)`

##### <a name="haslisteners"></a>`bool hasListeners`

##### <a name="notifylisteners"></a>`void notifyListeners()`
