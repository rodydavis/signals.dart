---
name: signals-migration-6-to-7
description: Detailed guidelines, patterns, and rules for migrating codebases from signals.dart version 6.x to version 7.x.
---

# Migrating from signals.dart v6 to v7

This guide provides comprehensive instructions for migrating applications and packages using `signals.dart` from version 6.x to 7.0.0.

## Related Documentation & Items

| Related File | Description |
|---|---|
| [signal_options.md](options/signal_options.md) | Guide to migrating scattered parameters (e.g. `autoDispose`, `debugLabel`) of `signal` and `computed` creators to the new unified options classes. |
| [async_options.md](options/async_options.md) | Guidelines for migrating asynchronous signal creators (`futureSignal`, `streamSignal`) to use `AsyncSignalOptions`. |
| [collection_options.md](options/collection_options.md) | Instructions on migrating collection-based signal creators to strongly typed collection options classes. |
| [builder_migration.md](widgets/builder_migration.md) | Migration path for `SignalBuilder` constructor to use the required named `builder` parameter. |
| [mixin_migration.md](widgets/mixin_migration.md) | Safe refactoring guidelines for replacing the deprecated `SignalsMixin` with `SignalWidget` or localized builders. |

---

## 1. Unified Options Classes (Named Parameter Pattern)

In v6, signals, computed, effects, and async signals accepted individual parameters like `autoDispose`, `debugLabel`, `lazy`, etc.
In v7, all parameters have been unified under a single, cohesive `options` class parameter.

### A. General Signals
- **Before (v6)**:
  ```dart
  final count = signal(0, autoDispose: true, debugLabel: 'counter');
  ```
- **After (v7)**:
  ```dart
  final count = signal(0, options: SignalOptions(autoDispose: true, name: 'counter'));
  ```

### B. Computed Signals
- **Before (v6)**:
  ```dart
  final double = computed(() => count.value * 2, autoDispose: true, debugLabel: 'double');
  ```
- **After (v7)**:
  ```dart
  final double = computed(() => count.value * 2, options: ComputedOptions(autoDispose: true, name: 'double'));
  ```

### C. Collections Signals (`listSignal`, `setSignal`, `mapSignal`, etc.)
All collections now accept unified options objects corresponding to their types (e.g. `ListSignalOptions`, `SetSignalOptions`, `MapSignalOptions`, `IterableSignalOptions`, `QueueSignalOptions`).
- **Before (v6)**:
  ```dart
  final list = listSignal([1, 2], autoDispose: true);
  ```
- **After (v7)**:
  ```dart
  final list = listSignal([1, 2], options: ListSignalOptions(autoDispose: true));
  ```

---

## 2. Async Signals Refactoring

All async creators (`futureSignal`, `streamSignal`, `asyncSignal`, `computedFrom`, `computedAsync`) now accept only the primary value/callback parameter followed by a named `options` parameter (`AsyncSignalOptions`). All other parameters have been marked `@Deprecated`.

- **Before (v6)**:
  ```dart
  final s = futureSignal(() => fetch(), lazy: false, initialValue: 0);
  ```
- **After (v7)**:
  ```dart
  final s = futureSignal(() => fetch(), options: AsyncSignalOptions(lazy: false, initialValue: 0));
  ```

---

## 3. Flutter Integration Upgrades

### A. Deprecation of `SignalsMixin`
`SignalsMixin` is deprecated to prevent state overhead. Use localized widgets or builders instead.
- **Migration**:
  - Replace `State with SignalsMixin` with a stateless `SignalWidget` or a stateful `SignalStatefulWidget`.
  - Alternatively, use localized `SignalBuilder` widgets to wrap only the widgets that depend on signal updates.

### B. `SignalBuilder` Named `builder` Parameter
The `SignalBuilder` widget now uses a required named parameter `builder` instead of a positional argument.
- **Before (v6)**:
  ```dart
  SignalBuilder(
    (context, value) => Text('$value'),
  )
  ```
- **After (v7)**:
  ```dart
  SignalBuilder(
    builder: (context, value) => Text('$value'),
  )
  ```

### C. Side Effects with `SignalEffect` / `SignalListener`
If you were executing side effects inside builds or mixins, migrate them to the localized `SignalEffect` (or alias `SignalListener`) widget which manages mounting, didUpdateWidget, and unmounting teardown lifecycle hooks safely.
```dart
SignalEffect(
  callback: (context) {
    if (error.value != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.value!)));
    }
  },
  child: MyWidget(),
)
```

---

## 4. Writable Computed Signals (`linkedSignal`)

If you had custom logic synchronizing external updates back to a computed signal, migrate them to the native `linkedSignal` or `LinkedSignalOptions`.

```dart
final original = signal('Alice');
final display = linkedSignal(() => original.value);

print(display.value); // 'Alice'
display.value = 'Bob'; // Override manual write
original.value = 'Charlie'; // Source changes -> resets display to 'Charlie'
```

---

## 5. Automated Refactoring via `signals_lint`

To make migrating from v6 to v7 completely effortless, the **`signals_lint`** tool analyzes your code and surfaces instant, automated quick-fixes/assists under your IDE's action menu (`Alt+Enter` or `Cmd+.`):

- **Strips legacy `with SignalsMixin`** and replaces the widget with a high-performance `SignalStatefulWidget` automatically.
- **Converts positional `Watch`** and `Watch.builder` instances into unified `SignalBuilder` components.
- **Promotes standard `StatelessWidget` and `StatefulWidget`** widgets to reactive `SignalWidget` and `SignalStatefulWidget` widgets on command.
- **Quickly wraps any widget** expression in a surgically targeted `SignalBuilder`.
