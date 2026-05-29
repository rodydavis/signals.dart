---
title: "Type: useChangeStackSignal"
description: "API reference and details for useChangeStackSignal from signals.dart."
---

# useChangeStackSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useChangeStackSignal

```dart
ChangeStackSignal<T> useChangeStackSignal(T value, {List<Object?> keys = const <Object>[], ChangeSignalOptions<T>? options})
```

Creates a new [ChangeStackSignal](/types/changestacksignal) and subscribes to it.

A [ChangeStackSignal](/types/changestacksignal) maintains an undo/redo history stack of value updates. This enables effortless
undo/redo mechanisms for user edits, document updates, or game actions.

<Success>
Use <code>.undo()</code> to step backwards, <code>.redo()</code> to step forwards, and check <code>.canUndo</code> and <code>.canRedo</code>
to determine button enabling states.
</Success>

### Parameters
- **value**: The initial value of the stack.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the change stack is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class SketchPadWidget extends HookWidget {
  const SketchPadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorStack = useChangeStackSignal<Color>(Colors.red, limit: 10);

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          color: colorStack.value,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: colorStack.canUndo ? () => colorStack.undo() : null,
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              onPressed: colorStack.canRedo ? () => colorStack.redo() : null,
            ),
          ],
        ),
        Wrap(
          children: [Colors.blue, Colors.green, Colors.orange, Colors.purple].map((col) {
            return GestureDetector(
              onTap: () => colorStack.value = col,
              child: Container(
                width: 40,
                height: 40,
                color: col,
                margin: const EdgeInsets.all(4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
````

## References

The **useChangeStackSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useChangeStackSignal](/packages/signals_hooks/hooks/use-change-stack-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

