# Collection Options Migration

In version 7.0.0, all collection-based signal creators (`listSignal`, `setSignal`, `mapSignal`, etc.) have unified their parameters under explicit collection option classes to ensure strong typing.

---

## 1. Migrating Collection Signals

### A. `listSignal`
- **Before**:
  ```dart
  final items = listSignal([1, 2], autoDispose: true, debugLabel: 'list');
  ```
- **After**:
  ```dart
  final items = listSignal(
    [1, 2],
    options: ListSignalOptions(
      autoDispose: true,
      name: 'list',
    ),
  );
  ```

### B. `setSignal`
- **Before**:
  ```dart
  final set = setSignal({1}, debugLabel: 'set');
  ```
- **After**:
  ```dart
  final set = setSignal(
    {1},
    options: SetSignalOptions(
      name: 'set',
    ),
  );
  ```
- Repeat the exact same pattern for `mapSignal` (`MapSignalOptions`), `iterableSignal` (`IterableSignalOptions`), and `queueSignal` (`QueueSignalOptions`).
