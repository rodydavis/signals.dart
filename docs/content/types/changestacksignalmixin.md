---
title: "Type: ChangeStackSignalMixin"
description: "API reference and details for ChangeStackSignalMixin from signals.dart."
---

# ChangeStackSignalMixin

<Info>
  <strong>Kind:</strong> <code>mixin</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Mixin: ChangeStackSignalMixin

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

### Members of ChangeStackSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **limit** | <code>field</code> | <code>dart int? limit</code> | Max values to keep in history |
| **history** | <code>method</code> | <code>dart Iterable<SignalChange<T>> history</code> | List of changes in the history |
| **redos** | <code>method</code> | <code>dart Iterable<SignalChange<T>> redos</code> | List of changes in the redo stack |
| **canRedo** | <code>method</code> | <code>dart bool canRedo</code> | Can redo the previous change |
| **canUndo** | <code>method</code> | <code>dart bool canUndo</code> | Can undo the previous change |
| **set** | <code>method</code> | <code>dart bool set(T val, {bool force = false})</code> |  |
| **redo** | <code>method</code> | <code>dart void redo()</code> | Redo Previous Undo |
| **undo** | <code>method</code> | <code>dart void undo()</code> | Undo Last Change |
| **clear** | <code>method</code> | <code>dart void clear()</code> | Clear the history for redo and undo |
| **clearUndo** | <code>method</code> | <code>dart void clearUndo()</code> | Clear undo stack |
| **clearRedo** | <code>method</code> | <code>dart void clearRedo()</code> | Clear redo stack |

## References

The **ChangeStackSignalMixin** type is referenced and used in the following pages:

* [TrackedSignalMixin](/packages/signals_flutter/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_flutter/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [TrackedSignalMixin](/packages/signals_core/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_core/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [TrackedSignalMixin](/packages/signals/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

