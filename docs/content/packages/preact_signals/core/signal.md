---
title: Signal
description: Represents a mutable reactive state container.
---

Represents a mutable reactive state container.

Signals hold a single **value** that can be read or modified. When a signal's value
is updated, any active computations (like [Computed](/packages/signals/core/computed)) or effects (like [effect](/packages/signals/core/effect)) that
read the signal's value are automatically notified and scheduled to re-run.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final count = Signal(0);

  effect(() {
    print('Count is: ${count.value}');
  });

  count.value = 5; // Triggers print: Count is: 5
}
```


### Constructors

##### <a name="signal"></a><a name="signal"></a>`Signal(this._internalValue, {String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})`

Creates a new [Signal](/packages/signals/core/signal) instance with the given initial value.

##### <a name="signal-lazy"></a><a name="lazy"></a>`Signal.lazy({String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})`

Creates a new lazy [Signal](/packages/signals/core/signal) instance that is computed on-demand upon first read.


### Properties

##### <a name="globalid"></a>`int globalId`

##### <a name="name"></a>`String? name`

##### <a name="watched"></a>`void Function()? watched`

##### <a name="unwatched"></a>`void Function()? unwatched`

##### <a name="batchsnapshotversion"></a>`int batchSnapshotVersion`

@internal
The global batch snapshot version tracked during mutation cycles.

##### <a name="version"></a>`int version`

Version numbers should always be >= 0, because the special value -1 is used
by Nodes to signify potentially unused but recyclable nodes.


### Methods

##### <a name="equalitycheck"></a>`SignalEquality<T> equalityCheck`

Get the active equality check

##### <a name="isinitialized"></a>`bool isInitialized`

Check if the value is set and not a lazy signal

##### <a name="isinitialized"></a>`isInitialized(bool val)`

@internal
Set if the signal is initialized.

##### <a name="internalvalue"></a>`T internalValue`

##### <a name="internalvalue"></a>`internalValue(T value)`

@internal
Set the internal raw value of the signal.

##### <a name="internalrefresh"></a>`bool internalRefresh()`

##### <a name="subscribetonode"></a>`void subscribeToNode(Node node)`

##### <a name="unsubscribefromnode"></a>`void unsubscribeFromNode(Node node)`

##### <a name="subscribe"></a>`void Function() subscribe(void Function(T value) fn)`

##### <a name="value"></a>`T value`

##### <a name="value"></a>`value(T val)`

Set the current value by a setter

##### <a name="set"></a>`bool set(T val, {bool force = false})`

Set the current value by a method

##### <a name="internalsetvalue"></a>`void internalSetValue(T val)`

@internal
Sets the internal value of the signal during batch updates.



---

## signal

Convenient global constructor for creating a mutable reactive state signal.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final name = signal('Jane');
```
