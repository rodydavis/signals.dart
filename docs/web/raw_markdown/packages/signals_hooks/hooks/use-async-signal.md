---
title: useAsyncSignal
description: Creates a new mutable AsyncSignal initialized with a specific AsyncState and subscribes to it.
---

Creates a new mutable [AsyncSignal](/packages/signals/async/signal) initialized with a specific [AsyncState](/packages/signals/async/state) and subscribes to it.

Unlike [useFutureSignal](/packages/signals_hooks/hooks/use-future-signal) and [useStreamSignal](/packages/signals_hooks/hooks/use-stream-signal), an [AsyncSignal](/packages/signals/async/signal) exposes a mutable container where you can
manually publish asynchronous states (e.g. `AsyncState.loading()`, `AsyncState.data(...)`, or `AsyncState.error(...)`).

<Success>
This is perfect for manually managed async workflows, like handling a login button click where you want to
transitions states explicitly under your control.
</Success>

### Parameters
- **value**: The initial [AsyncState](/packages/signals/async/state) (e.g. `AsyncState.loading()` or `AsyncState.data(initialValue)`).
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
