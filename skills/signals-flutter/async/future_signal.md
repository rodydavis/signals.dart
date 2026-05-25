# `FutureSignal<T>`

`FutureSignal<T>` is a highly optimized async signal that wraps a Dart `Future` to represent its lifecycle states (`AsyncLoading`, `AsyncData`, `AsyncError`).

---

## 1. Creation

```dart
final userId = signal(1);

final userProfile = futureSignal(
  () => fetchUserProfile(userId.value),
  options: AsyncSignalOptions(
    initialValue: null,
    lazy: true,
  ),
);
```

---

## 2. Dynamic Upstream Tracking & Single Evaluation

In `signals.dart` v7, `FutureSignal` implements manual dependency tracking of any signals read inside the future-creator callback using a manual listener.
- **Single Evaluation**: Transitions from `AsyncLoading` to `AsyncData` or `AsyncError` do not trigger redundant computed evaluations, solving the double-evaluation issue reported in Issue #433.
- **`reload()` / `refresh()`**: Exposes standard reloading controls to manually restart the future computation.
