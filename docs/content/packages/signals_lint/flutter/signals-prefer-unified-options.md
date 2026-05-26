---
title: SignalsPreferUnifiedOptions
description: A Dart static analysis rule that detects deprecated positional or scattered named configuration.
---

A Dart static analysis rule that detects deprecated positional or scattered named configuration
parameters for signals and ensures they are bundled under a unified options object.

:::important
In <code>signals</code> v7, parameters like <code>autoDispose</code>, <code>equals</code>, or custom comparators are no longer
passed directly as separate parameters to signal creators. Instead, they must be bundled into
a unified, type-safe configuration object (such as **SignalOptions**, **ComputedOptions**, or [AsyncSignalOptions](/packages/signals/async/signal)).
:::

### Examples

**Incorrect:**
```dart
final counter = signal(0, autoDispose: true); // LINT: Scattered configuration parameters
```

**Correct:**
```dart
final counter = signal(
  0,
  options: SignalOptions(autoDispose: true), // OK: Unified options object
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signalspreferunifiedoptions"></a><a name="signalspreferunifiedoptions"></a>`SignalsPreferUnifiedOptions()`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="run"></a>`void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context)`

</details>
