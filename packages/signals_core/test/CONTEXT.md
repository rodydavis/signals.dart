# Signals Core Testing Strategy

This directory contains the comprehensive test suite for the `signals_core` package. The tests are structured to match the internal organizational pattern of the library.

## Test Categories

### [core/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/core/)
Focuses on the fundamental reactivity primitives.
- **Signal & Computed**: Verifies dependency tracking, lazy evaluation, and equality checks.
- **Effect & Batch**: Tests side-effect execution and atomic batching logic.
- **Observer**: Verifies global observation and debugging hooks.

### [async/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/async/)
Tests asynchronous signal behavior.
- Covers `FutureSignal`, `StreamSignal`, and `AsyncComputed`.
- Verifies proper handling of errors and completion states.

### [value/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/value/)
Verifies the reactive behavior of built-in collections.
- Tests for `ListSignal`, `SetSignal`, and `MapSignal`.
- Ensures internal mutations are properly tracked and emitted.

### [mixins/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/mixins/) & [extensions/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/test/extensions/)
Tests the ergonomic API layer and integration helpers.

## Running Tests
Tests are executed using the standard Dart test runner or via Melos:
```bash
melos run test:core
```
All tests are designed to run in both the VM and compiled JS environments to ensure full cross-platform compatibility.
