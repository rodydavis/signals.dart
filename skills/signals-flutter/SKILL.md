---
name: signals-flutter
description: Highly optimized Flutter UI bindings and GPU rendering for reactive signals.
---

# Flutter Reactive Signals Integration

This skill covers optimizing Flutter UI bindings, element-level reactive tracking, and high-frequency rendering utilizing the `signals_flutter` package.

## Related Documentation & Items

### Widgets
| Related File | Description |
|---|---|
| [signal_builder.md](widgets/signal_builder.md) | Localized subtree rebuilding widget utilizing the named `builder` callback signature. |
| [signal_widget.md](widgets/signal_widget.md) | Component-level reactive stateless/stateful widgets resolving SignalsMixin deprecations. |
| [signal_effect.md](widgets/signal_effect.md) | Layout-safe side effect orchestrator mapping trigger events (e.g. snackbars, dialogs, routes) cleanly. |
| [signal_custom_paint.md](widgets/signal_custom_paint.md) | Ultra-high performance GPU render box bypass painting canvas operations at 120 FPS. |

### Extensions
| Related File | Description |
|---|---|
| [watch.md](extensions/watch.md) | Dynamic VM Expando element-level tracking context extensions supporting automatic teardowns. |

---

## Core Primitives Quick Start Guide

The signals library exposes five core functions which are the building blocks to model any reactive business logic.

### 1. `signal(initialValue)`
Creates a new mutable signal container. You read a signal's value or subscribe to updates by accessing `.value`.
```dart
final counter = signal(0);
print(counter.value); // 0
counter.value = 1; // Mutates value and schedules dependent updates
```

#### `.peek()`
Reads a signal's current value *without* subscribing to its mutations.
```dart
final counter = signal(0);
final logCount = signal(0);

effect(() {
  print(counter.value);
  // Read using peek to avoid subscribing/triggering loop
  logCount.value = logCount.peek() + 1;
});
```

### 2. `untracked(fn)`
Executes a callback that reads signals without subscribing to any of them.
```dart
final counter = signal(0);
final count = signal(0);

effect(() {
  print(counter.value);
  count.value = untracked(() => count.value + 1);
});
```

### 3. `computed(fn)`
Combines the values of multiple signals into a lazy, memoized derived signal.
```dart
final first = signal('John');
final last = signal('Doe');
final fullName = computed(() => '${first.value} ${last.value}');
print(fullName.value); // John Doe
```

### 4. `effect(fn)`
Orchestrates immediate synchronous side effects by running a callback and subscribing to any signals read within it.
```dart
final name = signal('Jane');
final dispose = effect(() => print('Hello $name'));
dispose(); // Clean up subscription
```

### 5. `batch(fn)`
Groups multiple signal writes into a single transaction, executing all dependent computed evaluations and effects exactly once at the end.
```dart
final a = signal(0);
final b = signal(0);

batch(() {
  a.value = 1;
  b.value = 2;
});
```

---

## 1. Widget Rebuild Optimization

### A. `SignalBuilder` (Preferred)
Provides localized, context-isolated widget rebuilding. Wrap only the smallest possible widgets in `SignalBuilder` to keep rendering extremely high-performance.
```dart
SignalBuilder(
  builder: (context, value) => Text('Count: $value'),
)
```

### B. Element-Level `.watch(context)` Extension
Attaches subscriptions safely using VM Expando and a clean Finalizer teardown loop to avoid leaks.
- Avoid mixins like `SignalsMixin`.
- Use `.watch(context)` when context-based subtree scoping is required.

---

## 2. High-Frequency Rendering (`SignalCustomPaint`)

For ultra-high-frequency drawing driven by signals, bypass Flutter's heavy widget layout/rebuild lifecycle entirely.
`SignalCustomPaint` and `SignalPainterWidget` write directly to the GPU via `markNeedsPaint()` calls inside custom proxy render boxes:

```dart
SignalCustomPaint(
  painter: MySignalPainter(progressSignal),
  child: Container(),
)
```

---

## 3. Side Effects in Widget Trees (`SignalEffect`)

Use `SignalEffect` / `SignalListener` to trigger asynchronous side-effects (e.g., showing snackbars, navigation, showing modals) cleanly inside the widget lifecycle.
```dart
SignalEffect(
  callback: (context) {
    if (errorMessage.value != null) {
      showDialog(context: context, builder: (_) => Alert(errorMessage.value!));
    }
  },
  child: ChildWidget(),
)
```
