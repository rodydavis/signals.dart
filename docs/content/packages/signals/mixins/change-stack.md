---
title: ChangeStackSignalMixin
description: A mixin that adds undo, redo, and state history replay capabilities to a Signal.
---

A mixin that adds undo, redo, and state history replay capabilities to a [Signal](/types/signal).

[ChangeStackSignalMixin](/types/changestacksignalmixin) keeps track of past states of a signal's value in a double-ended
queue, allowing you to easily go back to previous values using **undo** and go forward to subsequent
values using **redo**. You can inspect if undo or redo are available via **canUndo** and **canRedo**.

You can also set a **limit** on the maximum size of the history stack, preventing memory leak
issues in long-running scenarios.

<Info>
If you only need access to the initial and immediate previous values of a signal (without a full
history stack or undo/redo mechanisms), use the lightweight <a href="/types/trackedsignalmixin">TrackedSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class HistorySignal extends Signal<int> with ChangeStackSignalMixin<int> {
  HistorySignal(super.internalValue);
}

void main() {
  final counter = HistorySignal(0);
  counter.limit = 5; // Cap history stack to 5 items

  counter.value = 1;
  counter.value = 2;
  counter.value = 3;

  print('Current: ${counter.value}'); // Prints: "Current: 3"
  print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"

  // Undo last change
  counter.undo();
  print('Undone: ${counter.value}'); // Prints: "Undone: 2"

  // Undo once more
  counter.undo();
  print('Undone: ${counter.value}'); // Prints: "Undone: 1"

  // Redo the previous undo
  counter.redo();
  print('Redone: ${counter.value}'); // Prints: "Redone: 2"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned when changed.
If you mutate an object in-place directly without replacing the value using <code>set</code> or the <code>.value</code>
setter, the history queue will store references to the same mutated object, and undo/redo
will appear to do nothing.
</Warning>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="limit"></a><code>int? limit</code>

Max values to keep in history

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="history"></a><code>Iterable<SignalChange<T>> history</code>

List of changes in the history

##### <a name="redos"></a><code>Iterable<SignalChange<T>> redos</code>

List of changes in the redo stack

##### <a name="canredo"></a><code>bool canRedo</code>

Can redo the previous change

##### <a name="canundo"></a><code>bool canUndo</code>

Can undo the previous change

##### <a name="set"></a><code>bool set(T val, {bool force = false})</code>

##### <a name="redo"></a><code>void redo()</code>

Redo Previous Undo

##### <a name="undo"></a><code>void undo()</code>

Undo Last Change

##### <a name="clear"></a><code>void clear()</code>

Clear the history for redo and undo

##### <a name="clearundo"></a><code>void clearUndo()</code>

Clear undo stack

##### <a name="clearredo"></a><code>void clearRedo()</code>

Clear redo stack

</details>
