# Utility Classes and Constants

This directory provides supporting utilities for the Signals library, including environment detection, deep equality comparisons, and time-based signals.

## File Overviews

### [constants.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/utils/constants.dart)
Ported from the Flutter framework, this file provides canonical environment flags:
- `kDebugMode`: True for debug builds.
- `kReleaseMode`: True for production builds.
- `kProfileMode`: True for performance profiling.
- `kIsWeb`: Detection for JS-based environments.
- `precisionErrorTolerance`: Global epsilon (1e-10) for float comparisons.

### [deep_collection_equality.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/utils/deep_collection_equality.dart)
A recursive equality checker for collections. It ensures that signals containing complex data structures (nested maps, lists, sets) can detect when their contents have actually changed, rather than just relying on reference equality.

### [timer.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/lib/src/utils/timer.dart)
Implements `TimerSignal`, a reactive wrapper around `Stream.periodic`. It emits a `TimerSignalEvent` (iteration count and timestamp) at a specified duration.
- Use `timerSignal(Duration)` or `duration.toSignal()` to create.
- Inherits from `StreamSignal` and integrates with `AsyncState`.

## Key Relationships

- **Core Module**: `DeepCollectionEquality` is often used by signals to override default equality checks.
- **Async Module**: `TimerSignal` is built on top of `StreamSignal` from the async directory.
