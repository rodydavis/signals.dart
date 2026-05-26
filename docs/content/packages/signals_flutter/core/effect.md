---
title: Effect
description: Represents a passive observer that runs arbitrary side-effect code in response to signal changes.
---

Represents a passive observer that runs arbitrary side-effect code in response to signal changes.

An [Effect](/packages/signals/core/effect) tracks which signals are accessed within its callback function,
and automatically schedules itself to re-run whenever those dependencies change.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

void main() {
  final logger = Effect(() {
    print('Active count is: ${count.value}');
    return () => print('Cleaning up effect!');
  });

  count.value = 1; // Prints: "Cleaning up effect!" then "Active count is: 1"
  logger.dispose();
}
```


### Constructors

##### <a name="effect"></a><a name="effect"></a>`Effect(this.fn, {String? name, EffectOptions? options})`

Creates a new [Effect](/packages/signals/core/effect) instance with the callback **fn**.


### Properties

##### <a name="fn"></a>` Function()? fn`

@internal
The effect callback.

##### <a name="globalid"></a>`int globalId`

##### <a name="cleanup"></a>`Function? cleanup`

@internal
The cleanup callback.

##### <a name="nextbatchedeffect"></a>`Effect? nextBatchedEffect`

@internal
The next effect in the batched effects queue.

##### <a name="flags"></a>`int flags`

##### <a name="name"></a>`String? name`

The name of the effect for debugging.


### Methods

##### <a name="callback"></a>`void callback()`

@internal
Executes the callback function and schedules cleanups.

##### <a name="start"></a>`void Function() start()`

@internal
Starts tracking dependency subscriptions.

##### <a name="notify"></a>`void notify()`

##### <a name="dispose"></a>`void dispose()`

Dispose of the effect and stop future callbacks

##### <a name="call"></a>`void Function() call()`

Activate the effect starting with the callback

##### <a name="cleanupeffect"></a>`void cleanupEffect()`

@internal
Runs the user-defined cleanup callback if registered.

##### <a name="disposeeffect"></a>`void disposeEffect()`

@internal
Disposes resources held by the effect.

##### <a name="endeffect"></a>`void endEffect(Listenable? prevContext)`

@internal
Concludes the current effect evaluation round and restores the evaluation context context.



---

## effect

Convenient global constructor for creating and immediately starting an [Effect](/packages/signals/core/effect).

Returns a disposer function that can be called to stop the effect and unsubscribe
it from all tracked signals.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final dispose = effect(() {
  print('Count is: ${count.value}');
});

void main() {
  count.value = 10; // Prints: Count is: 10
  dispose(); // Unsubscribes and cleans up resources
}
```
