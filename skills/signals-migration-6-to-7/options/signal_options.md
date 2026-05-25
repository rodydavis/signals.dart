# Signal Options Migration

In version 7.0.0, individual parameter arguments like `autoDispose`, `debugLabel`, and custom parameters have been unified under a single, named `options` parameter.

---

## 1. Migrating `signal` and `computed` Creators

### A. General Signals
- **Before**:
  ```dart
  final counter = signal(0, autoDispose: true, debugLabel: 'counter');
  ```
- **After**:
  ```dart
  final counter = signal(0, options: SignalOptions(autoDispose: true, name: 'counter'));
  ```

### B. Computed Signals
- **Before**:
  ```dart
  final double = computed(() => counter.value * 2, autoDispose: true, debugLabel: 'double');
  ```
- **After**:
  ```dart
  final double = computed(() => counter.value * 2, options: ComputedOptions(autoDispose: true, name: 'double'));
  ```
