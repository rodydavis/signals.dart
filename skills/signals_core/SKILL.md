---
name: signals_core
description: Advanced reactive state primitives, collections, mixins, and utilities of signals_core.
---

# Signals Core Advanced Primitives

This skill details advanced state management primitives, reactive collections, async features, and value options semantics in `signals_core`.

## Related Documentation & Items

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

---

## 1. Writable Computed Signal (`linkedSignal`)

A writable computed signal (`LinkedSignal`) provides a derived default value that can be overridden manually, resetting back to the derived default whenever its upstream dependencies mutate.

### Usage
```dart
// Basic reset shorthand:
final size = signal('M');
final selection = linkedSignal(() => size.value);

// Advanced structural comparison:
final user = signal((id: 1, name: 'Alice'));
final name = linkedSignalOptions<String, ({int id, String name})>(
  source: () => user.value,
  computation: (u, prev) {
    if (prev != null && prev.source.id == u.id) {
      return prev.value; // Retain manual override
    }
    return u.name; // Reset on ID changes
  },
);
```

---

## 2. Collections and Async Primitives

### A. Collections
Always use specialized collections (`listSignal`, `setSignal`, `mapSignal`, etc.) to wrap collections to ensure optimized mutations (only triggering updates when elements actually change).
```dart
final list = listSignal([1, 2], options: ListSignalOptions(autoDispose: true));
list.add(3); // Reacts to changes
```

### B. Optimized FutureSignal
`FutureSignal` inherits directly from `AsyncSignal` to bypass Stream subscription overhead and tracks its dependencies manually via computed execution, executing future computations exactly once (avoiding double-evaluation loops).
```dart
final search = signal('');
final results = futureSignal(() => fetchResults(search.value));
```

---

## 3. Options Classes Value Semantics

All signal option objects support full value semantics (`copyWith`, custom equality, and `hashCode` overrides) for flexible copying and accurate comparisons:
- `SignalOptions`
- `ComputedOptions`
- `AsyncSignalOptions`
- `LinkedSignalOptions`
- `ListSignalOptions` / `SetSignalOptions` / `MapSignalOptions`
