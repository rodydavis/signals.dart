---
title: useExistingSignal
description: Subscribes to an existing ReadonlySignal (or Signal) and returns it.
---

Subscribes to an existing [ReadonlySignal](/types/readonlysignal) (or [Signal](/types/signal)) and returns it.

This is useful when you have a signal that is defined globally, inside a controller,
or provided via a dependency injection framework (like provider, get_it, or riverpod),
and you want to reactive-bind the **HookWidget** to rebuild whenever the signal emits
a new value.

<Info>
  If you only need the value of the signal inside the build method and do not
  need the signal instance itself, consider using <a href="/types/usesignalvalue">useSignalValue</a> instead.
</Info>

### Parameters
- **value**: The existing [ReadonlySignal](/types/readonlysignal) or [Signal](/types/signal) instance to subscribe to.
- **keys**: A list of objects to watch for changes. If any of the keys change,
  the hook is re-evaluated, unsubscribing from the old signal and subscribing
  to the new one.

### Returns
The same signal instance passed in **value**, allowing you to interact with it
directly (e.g., read its <code>.value</code> or write to it if it is a mutable [Signal](/types/signal)).

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

// A globally defined signal or one located in a service
final globalThemeMode = signal(ThemeMode.light);

class ThemeSelectorWidget extends HookWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Bind to the existing global signal
    final themeMode = useExistingSignal(globalThemeMode);

    return SwitchListTile(
      title: Text('Dark Mode: ${themeMode.value == ThemeMode.dark ? "On" : "Off"}'),
      value: themeMode.value == ThemeMode.dark,
      onChanged: (isDark) {
        themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
      },
    );
  }
}
````
