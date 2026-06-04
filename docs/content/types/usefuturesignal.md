---
title: "Type: useFutureSignal"
description: "API reference and details for useFutureSignal from signals.dart."
---

# useFutureSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useFutureSignal

```dart
FutureSignal<T> useFutureSignal(Future<T> Function() value, {List<Object?> keys = const <Object>[], AsyncSignalOptions<T>? options})
```

Creates a new [FutureSignal](/types/futuresignal) and subscribes to it.

A [FutureSignal](/types/futuresignal) wraps a standard Dart **Future** in a reactive state container, allowing you to
easily read the asynchronous operation's progress (<code>loading</code>, <code>error</code>, <code>data</code>) directly
in your build method without needing <code>FutureBuilder</code>.

<Success>
The signal automatically manages the lifecycle of the future and rebuilds the host widget
when the future transitions from loading to data or error.
</Success>

### Parameters
- **value**: A callback returning the **Future** to execute.
- **keys**: A list of objects to watch for changes. If any key in this list changes, the existing future
  is cancelled/ignored and a new future is created and subscribed to.
- **initialValue**: An optional initial value to display before the future completes.
- **dependencies**: An optional list of signals that this future depends on. If any dependency changes,
  the future is automatically re-run.
- **lazy**: If true (default), the future won't start executing until the signal's value is first read.
- **debugLabel**: An optional debug label to identify this signal in devtools.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class UserProfileWidget extends HookWidget {
  final int userId;
  const UserProfileWidget({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    // Re-fetches user profile if userId changes
    final userSignal = useFutureSignal(
      () => fetchUserProfile(userId),
      keys: [userId],
    );

    return userSignal.value.map(
      data: (user) => ListTile(
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
      error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
````

## References

The **useFutureSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useFutureSignal](/packages/signals_hooks/hooks/use-future-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

