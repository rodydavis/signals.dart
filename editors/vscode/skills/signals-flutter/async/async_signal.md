# `AsyncSignal<T>` and `AsyncState<T>`

`AsyncSignal<T>` is the base class for signals representing asynchronous work. It holds a value of type `AsyncState<T>`, which cleanly represents standard loading, success, and error lifecycles.

---

## 1. `AsyncState` Variants

- **`AsyncLoading<T>`**: Represents active async execution. Can be reloading (`AsyncDataReloading` / `AsyncErrorReloading`) or refreshing (`AsyncDataRefreshing` / `AsyncErrorRefreshing`).
- **`AsyncData<T>`**: Successfully resolved state wrapping the completed value.
- **`AsyncError<T>`**: Unsuccessfully resolved state wrapping the error and stack trace.

---

## 2. Pattern Matching with `.map` and `.maybeMap`

You can use pattern matching to safely transform or build UIs based on the current state:

```dart
final state = futureSignal.value;

final widget = state.map(
  data: (d) => Text('Data: ${d.value}'),
  error: (e) => Text('Error: ${e.error}'),
  loading: () => CircularProgressIndicator(),
);
```
