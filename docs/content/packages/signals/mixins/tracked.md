---
title: TrackedSignalMixin
description: A mixin that adds tracking for the initial and previous values to a Signal.
---

A mixin that adds tracking for the initial and previous values to a [Signal](/types/signal).

[TrackedSignalMixin](/types/trackedsignalmixin) stores the <code>initialValue</code> (the value the signal had when it was
created or initialized) and the <code>previousValue</code> (the value of the signal right before
the most recent update).

<Info>
If you are looking for full undo/redo capabilities, use <a href="/types/changestacksignalmixin">ChangeStackSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyTrackedSignal extends Signal<int> with TrackedSignalMixin<int> {
  MyTrackedSignal(super.internalValue);
}

void main() {
  final signal = MyTrackedSignal(0);

  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: null"

  signal.value = 1;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 0"

  signal.value = 2;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 1"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned on mutation.
If the value is mutated directly in-place without re-assigning, <code>initialValue</code> and
<code>previousValue</code> will end up pointing to the same modified instance as the current value.
</Warning>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="initialvalue"></a><code>T initialValue</code>

The initial value the signal was created with

##### <a name="previousvalue"></a><code>T? previousValue</code>

Get the previous value (if exists)

</details>



---

## trackedSignal

Create a signal that stores the initial and previous value


---

## TrackedSignal

A signal that stores the initial and previous value


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="trackedsignal"></a><a name="trackedsignal"></a><code>TrackedSignal(super.value, {TrackedSignalOptions<T>? options, @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: TrackedSignalOptions(name: ...) instead') String? debugLabel})</code>

A signal that stores the initial and previous value

</details>



---

## TrackedSignalOptions

Configuration options for a [TrackedSignal](/types/trackedsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="trackedsignaloptions"></a><a name="trackedsignaloptions"></a><code>TrackedSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched})</code>

Creates a new [TrackedSignalOptions](/types/trackedsignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>TrackedSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>
