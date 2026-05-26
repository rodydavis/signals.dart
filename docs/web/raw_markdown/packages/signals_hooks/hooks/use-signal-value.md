---
title: useSignalValue
description: Subscribes to an existing ReadonlySignal (or Signal) and returns its current value.
---

Subscribes to an existing [ReadonlySignal](/packages/preact_signals/core/readonly) (or [Signal](/packages/signals/core/signal)) and returns its current value.

This is a convenience hook that is equivalent to invoking `useExistingSignal(signal).value`.
It triggers a rebuild of the host **HookWidget** whenever the signal's value changes.

<Success>
This hook is the preferred way to consume external/global signals when you only
need read-only access to their values and want standard Flutter Hook ergonomics.
</Success>

### Parameters
- **value**: The existing [ReadonlySignal](/packages/preact_signals/core/readonly) or [Signal](/packages/signals/core/signal) instance to retrieve the value from and subscribe to.
- **keys**: A list of objects to watch for changes. If any key changes, the hook will be re-evaluated
  and subscribe to the new signal.

### Returns
The current value **T** of the signal.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

final cartItemCountSignal = signal(0);

class CartBadge extends HookWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // Directly extract and subscribe to the signal's value
    final itemCount = useSignalValue(cartItemCountSignal);

    return Badge(
      label: Text('$itemCount'),
      child: const Icon(Icons.shopping_cart),
    );
  }
}
````
