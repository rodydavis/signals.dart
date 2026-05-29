---
title: useListSignal
description: Creates a new ListSignal and subscribes to it.
---

Creates a new [ListSignal](/types/listsignal) and subscribes to it.

A [ListSignal](/types/listsignal) provides a reactive wrapper around a standard Dart **List**. It tracks mutations
(such as <code>.add()</code>, <code>.remove()</code>, or setting an element at an index) and automatically triggers
rebuilds of the host **HookWidget** when they occur.

<Success>
Since Dart lists are objects, standard signals only track identity changes. <a href="/types/listsignal">ListSignal</a> tracks
in-place mutations as well, making it highly efficient for managing dynamic lists in your UI.
</Success>

### Parameters
- **value**: The initial list elements.
- **keys**: A list of objects to watch. If any key changes, the list signal is re-created.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class TodoListWidget extends HookWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Creates a reactive list managed by this widget
    final todos = useListSignal<String>([]);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => todos.add('Task ${todos.length + 1}'),
          child: const Text('Add Task'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, idx) => ListTile(
              title: Text(todos[idx]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => todos.removeAt(idx),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
````
