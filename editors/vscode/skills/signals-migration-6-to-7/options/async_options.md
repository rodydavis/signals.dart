# Async Options Migration

In version 7.0.0, async constructors like `futureSignal` and `streamSignal` have deprecated individual arguments in favor of the unified `AsyncSignalOptions` class object.

---

## 1. Migrating `futureSignal` and `streamSignal`

### A. `futureSignal`
- **Before**:
  ```dart
  final profile = futureSignal(() => fetch(), lazy: false, initialValue: 0, debugLabel: 'user');
  ```
- **After**:
  ```dart
  final profile = futureSignal(
    () => fetch(),
    options: AsyncSignalOptions(
      lazy: false,
      initialValue: 0,
      name: 'user',
    ),
  );
  ```

### B. `streamSignal`
- **Before**:
  ```dart
  final messages = streamSignal(() => stream, cancelOnError: true, debugLabel: 'chat');
  ```
- **After**:
  ```dart
  final messages = streamSignal(
    () => stream,
    options: AsyncSignalOptions(
      cancelOnError: true,
      name: 'chat',
    ),
  );
  ```
