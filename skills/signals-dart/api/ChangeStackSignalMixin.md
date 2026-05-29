# mixin `ChangeStackSignalMixin`

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

---

## Members of `ChangeStackSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | `field` | `int? limit` | Max values to keep in history |
| **history** | `method` | `Iterable<SignalChange<T>> history` | List of changes in the history |
| **redos** | `method` | `Iterable<SignalChange<T>> redos` | List of changes in the redo stack |
| **canRedo** | `method` | `bool canRedo` | Can redo the previous change |
| **canUndo** | `method` | `bool canUndo` | Can undo the previous change |
| **set** | `method` | `bool set(T val, {bool force = false})` |  |
| **redo** | `method` | `void redo()` | Redo Previous Undo |
| **undo** | `method` | `void undo()` | Undo Last Change |
| **clear** | `method` | `void clear()` | Clear the history for redo and undo |
| **clearUndo** | `method` | `void clearUndo()` | Clear undo stack |
| **clearRedo** | `method` | `void clearRedo()` | Clear redo stack |
