# `TimerSignal`

`TimerSignal` emits values at periodic durations, functioning like a high-performance reactive stopwatch.

---

## 1. Creation

```dart
// Ticks every second
final timer = timerSignal(
  const Duration(seconds: 1),
  options: SignalOptions(
    name: 'stopwatch_timer',
  ),
);
```

---

## 2. Controls
- **`.value`**: Resolves to the duration elapsed.
- **`.paused`**: A boolean signal that lets you pause and resume the timer execution.
- **`.reset()`**: Resets the timer back to `0`.
