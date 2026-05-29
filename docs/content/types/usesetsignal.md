---
title: "Type: useSetSignal"
description: "API reference and details for useSetSignal from signals.dart."
---

# useSetSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useSetSignal

```dart
SetSignal<T> useSetSignal(Set<T> value, {List<Object?> keys = const <Object>[], SetSignalOptions<T>? options})
```

Creates a new [SetSignal](/types/setsignal) and subscribes to it.

A [SetSignal](/types/setsignal) provides a reactive wrapper around a standard Dart **Set**. It tracks mutations
(such as <code>.add()</code>, <code>.remove()</code>, <code>.clear()</code>) and automatically triggers rebuilds of the host **HookWidget**.

<Success>
Useful for managing collections of unique items, like active filters, selected item IDs,
or tagged items in a multi-select interface.
</Success>

### Parameters
- **value**: The initial set elements.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the set signal is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class CategoryFilterWidget extends HookWidget {
  const CategoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategories = useSetSignal<String>({});

    void toggleCategory(String cat) {
      if (selectedCategories.contains(cat)) {
        selectedCategories.remove(cat);
      } else {
        selectedCategories.add(cat);
      }
    }

    return Row(
      children: ['Tech', 'News', 'Lifestyle'].map((cat) {
        final isSelected = selectedCategories.contains(cat);
        return FilterChip(
          label: Text(cat),
          selected: isSelected,
          onSelected: (_) => toggleCategory(cat),
        );
      }).toList(),
    );
  }
}
````

## References

The **useSetSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useSetSignal](/packages/signals_hooks/hooks/use-set-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

