---
title: "Type: useAsyncSignal"
description: "API reference and details for useAsyncSignal from signals.dart."
---

# useAsyncSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useAsyncSignal

```dart
AsyncSignal<T> useAsyncSignal(AsyncState<T> value, {List<Object?> keys = const <Object>[], AsyncSignalOptions<T>? options})
```

Creates a new mutable [AsyncSignal](/types/asyncsignal) initialized with a specific [AsyncState](/types/asyncstate) and subscribes to it.

Unlike [useFutureSignal](/types/usefuturesignal) and [useStreamSignal](/types/usestreamsignal), an [AsyncSignal](/types/asyncsignal) exposes a mutable container where you can
manually publish asynchronous states (e.g. <code>AsyncState.loading()</code>, <code>AsyncState.data(...)</code>, or <code>AsyncState.error(...)</code>).

<Success>
This is perfect for manually managed async workflows, like handling a login button click where you want to
transitions states explicitly under your control.
</Success>

### Parameters
- **value**: The initial [AsyncState](/types/asyncstate) (e.g. <code>AsyncState.loading()</code> or <code>AsyncState.data(initialValue)</code>).
- **keys**: A list of objects to watch. If any key changes, the async signal will be re-created.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class LoginButton extends HookWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Start in idle data state
    final loginState = useAsyncSignal<void>(AsyncState.data(null));

    Future<void> performLogin() async {
      loginState.value = AsyncState.loading();
      try {
        await apiLogin();
        loginState.value = AsyncState.data(null);
      } catch (err, stack) {
        loginState.value = AsyncState.error(err, stack);
      }
    }

    return loginState.value.map(
      data: (_) => ElevatedButton(
        onPressed: performLogin,
        child: const Text('Login'),
      ),
      error: (err, _) => Column(
        children: [
          Text('Error: $err', style: const TextStyle(color: Colors.red)),
          ElevatedButton(onPressed: performLogin, child: const Text('Retry')),
        ],
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
````

## References

The **useAsyncSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

