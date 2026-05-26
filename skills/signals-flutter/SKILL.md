---
name: signals-flutter
description: Highly optimized Flutter UI bindings and GPU rendering for reactive signals.
---

# Flutter Reactive Signals Integration

This skill covers optimizing Flutter UI bindings, element-level reactive tracking, and high-frequency rendering utilizing the `signals_flutter` package.

## Related Documentation & Items

### Core Primitives
| Related File | Description |
|---|---|
| [signal.md](core/signal.md) | Standard writeable reactive state primitive containing value accessors, mutation mechanics, and basic custom options. |
| [computed.md](core/computed.md) | Lazy, memoized read-only derived state signal tracking reactive dependencies dynamically. |
| [effect.md](core/effect.md) | Synchronous observer managing active subscription loops, dynamic dependency updates, and lifecycle teardown. |
| [readonly.md](core/readonly.md) | Read-only signal views ensuring unidirectional data access flows. |
| [batch.md](core/batch.md) | Transactional state mutation blocks optimizing reactive computations and preventing rendering/recompute churn. |

### Asynchronous Operations
| Related File | Description |
|---|---|
| [future_signal.md](async/future_signal.md) | Single-evaluation asynchronous future state representation resolving the double-evaluation issue. |
| [stream_signal.md](async/stream_signal.md) | Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states. |
| [async_signal.md](async/async_signal.md) | Unifying async state container mapping loading, success data, and failure error states cleanly. |
| [computed_async.md](async/computed_async.md) | Composable asynchronous operations built over reactive signals with active race condition protection. |
| [computed_from.md](async/computed_from.md) | State aggregator signal merging multiple async signals into a single unified result. |

### Reactive Collections
| Related File | Description |
|---|---|
| [list_signal.md](collections/list_signal.md) | Optimized list wrapper proxying standard operations to support element-level reactivity. |
| [set_signal.md](collections/set_signal.md) | Custom set wrapper ignoring duplicates and notifying on unique mutations. |
| [map_signal.md](collections/map_signal.md) | Granular map wrapper supporting isolated dictionary element lookup triggers. |
| [iterable_signal.md](collections/iterable_signal.md) | Iterable wrapper mapping custom lazy traversals to dynamic subscription layers. |
| [queue_signal.md](collections/queue_signal.md) | Double-ended queue wrapper supporting optimized reactive pipeline structures. |

### Utility Primitives
| Related File | Description |
|---|---|
| [linked_signal.md](utils/linked_signal.md) | Writable computed signals supporting manual override resets and custom equivalence checks. |
| [tracked_signal.md](utils/tracked_signal.md) | State history wrapper enabling clean out-of-the-box undo/redo mechanisms. |
| [timer_signal.md](utils/timer_signal.md) | Periodically emitting stopwatch signal with built-in pause, resume, and reset. |
| [connect.md](utils/connect.md) | Dynamic event connector feeding multiple external data pipelines into single targets. |

### Flutter Widgets
| Related File | Description |
|---|---|
| [signal_builder.md](widgets/signal_builder.md) | Localized subtree rebuilding widget utilizing the named `builder` callback signature. |
| [signal_widget.md](widgets/signal_widget.md) | Component-level reactive stateless/stateful widgets resolving SignalsMixin deprecations. |
| [signal_effect.md](widgets/signal_effect.md) | Layout-safe side effect orchestrator mapping trigger events (e.g. snackbars, dialogs, routes) cleanly. |
| [signal_custom_paint.md](widgets/signal_custom_paint.md) | Ultra-high performance GPU render box bypass painting canvas operations at 120 FPS. |

### Flutter Extensions
| Related File | Description |
|---|---|
| [watch.md](extensions/watch.md) | [DEPRECATED] Legacy context-level watch extension (prefer SignalBuilder or SignalWidget). |

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
  builder: (context) => Text('Count: ${counter.value}'),
)
```

### B. Reactive Component Widgets (`SignalWidget` / `SignalStatefulWidget`)
In v7, `SignalsMixin` and `BuildContext.watch(context)` are **deprecated** (and will trigger warnings via custom lint rules). Instead of mixins or context extension watches, inherit from `SignalWidget` or `SignalStatefulWidget` for automatic, highly optimized reactive tracking inside standard widget trees:

```dart
// Reactive Stateless Widget
class MyWidget extends SignalWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Count: ${counter.value}');
  }
}
```

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
