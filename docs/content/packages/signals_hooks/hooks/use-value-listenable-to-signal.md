---
title: useValueListenableToSignal
description: Creates a new ReadonlySignal from a ValueListenable and subscribes to it.
---

Creates a new [ReadonlySignal](/types/readonlysignal) from a **ValueListenable** and subscribes to it.

This provides read-only interoperability with standard Flutter classes, allowing you to bridge any
**ValueListenable** (like **ScrollController**, **TextEditingController**, or other custom listenables) into a
reactive [ReadonlySignal](/types/readonlysignal).

<Success>
Perfect for listening to UI framework states such as scroll offsets, keyboard visibility, or text inputs in a
clean, functional reactive style.
</Success>

### Parameters
- **value**: The **ValueListenable** to bridge.
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ScrollTrackerWidget extends HookWidget {
  const ScrollTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    // Bridge the listenable offset to a reactive ReadonlySignal
    final scrollSignal = useValueListenableToSignal(scrollController);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Position: ${scrollSignal.value.toStringAsFixed(1)}'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        itemBuilder: (context, idx) => ListTile(title: Text('Row $idx')),
      ),
    );
  }
}
````
