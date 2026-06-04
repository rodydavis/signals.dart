---
title: "Type: useSignalEffect"
description: "API reference and details for useSignalEffect from signals.dart."
---

# useSignalEffect

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useSignalEffect

```dart
void useSignalEffect(dynamic Function() cb, {List<Object?> keys = const <Object>[], dynamic Function()? onDispose, String? debugLabel})
```

Creates a new reactive [effect](/types/effect) and registers it with the widget's lifecycle.

The effect is automatically created on build and is disposed of when the widget is unmounted.
Any reactive signal accessed inside the callback **cb** is tracked as a dependency, and the effect
is executed automatically whenever those signals change.

<Warning>
  Avoid modifying signals inside the effect callback that could trigger infinite loops or
  unintentional side effects.
</Warning>

### Parameters
- **cb**: The effect callback to execute when tracked dependencies change.
- **keys**: A list of objects to watch. If any key changes, the effect is disposed and re-created.
- **onDispose**: An optional callback executed when the effect itself is disposed.
- **debugLabel**: An optional debug label to identify the effect in developer tools.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class LoggerWidget extends HookWidget {
  const LoggerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useSignal(0);

    // Set up a side effect to log value changes
    useSignalEffect(
      () {
        debugPrint('The counter value is now: ${count.value}');
      },
      keys: [count],
      onDispose: () => debugPrint('Logger effect disposed'),
    );

    return TextButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
````

## References

The **useSignalEffect** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useSignalEffect](/packages/signals_hooks/hooks/use-signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

