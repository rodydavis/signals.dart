---
title: Value Listenable
description: A global helper function to convert a Flutter **ValueListenable** to a ReadonlySignal.
---

## valueListenableToSignal

A global helper function to convert a Flutter **ValueListenable** to a [ReadonlySignal](/packages/preact_signals/core/readonly).

This helper is a functional equivalent of the `toSignal()` extension method.

### Example
```dart
final scrollPosition = ValueNotifier(0.0);
final scrollSignal = valueListenableToSignal(scrollPosition);
```


---

## SignalValueListenableUtils

Extension on **ValueListenable** to seamlessly bridge standard Flutter values to reactive signals.


### Methods

##### <a name="tosignal"></a>`ReadonlySignal<T> toSignal({String? debugLabel, bool autoDispose = false})`

## ReadonlySignal from ValueListenable

Converted **ValueListenable** objects become readable signals that automatically listen
to the underlying source. When the source updates, the signal updates.

The signal automatically manages the subscription, disposing of the listener when the
signal itself is disposed.

### Example: Converting a ValueNotifier
```dart
final ValueListenable<int> listenable = ValueNotifier(10);
final signal = listenable.toSignal();

print(signal.value); // 10
```

### Example: ValueListenable from ReadonlySignal
To convert back to a standard **ValueListenable** for native Flutter compatibility:
```dart
final signal = Signal(10);
final listenable = signal.toValueListenable();
```



---

## ValueListenableSignalMixin

**ValueListenable** implementation for [ReadonlySignal](/packages/preact_signals/core/readonly)


### Methods

##### <a name="runcallbackonlisten"></a>`bool runCallbackOnListen`

If true, the callback will be run when the listener is added

##### <a name="addlistener"></a>`void addListener(VoidCallback listener)`

##### <a name="removelistener"></a>`void removeListener(VoidCallback listener)`
