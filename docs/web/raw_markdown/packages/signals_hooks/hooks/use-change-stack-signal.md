---
title: useChangeStackSignal
description: Creates a new ChangeStackSignal and subscribes to it.
---

Creates a new [ChangeStackSignal](/packages/signals/value/change-stack) and subscribes to it.

A [ChangeStackSignal](/packages/signals/value/change-stack) maintains an undo/redo history stack of value updates. This enables effortless
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
