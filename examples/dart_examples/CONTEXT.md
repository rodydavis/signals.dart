# Dart CLI Signals Examples

A collection of non-UI examples demonstrating the core power of Signals in pure Dart applications, such as backend services, CLI tools, or data processing pipelines.

## Examples

### [async.dart](file:///Users/rodydavis/Developer/signals.dart/examples/dart_examples/bin/async.dart)
Demonstrates the lifecycle of asynchronous signals.
- Shows how **`futureSignal`** and **`streamSignal`** handle states automatically.
- Explains the use of `AsyncState` for data, error, and loading transitions.

### [pipes.dart](file:///Users/rodydavis/Developer/signals.dart/examples/dart_examples/bin/pipes.dart)
Explores the "piping" capabilities of the library.
- **Signal to Stream**: Converting reactive state into a broadcast or single-subscription stream.
- **Stream to Signal**: Using `toSignal()` to integrate existing reactive streams into a signal-based dependency graph.

### [operators.dart](file:///Users/rodydavis/Developer/signals.dart/examples/dart_examples/bin/operators.dart)
Focuses on functional composition.
- Demonstrates how to use **`computed`** as a powerful operator for filtering, transforming, and combining multiple state sources.

### [timer.dart](file:///Users/rodydavis/Developer/signals.dart/examples/dart_examples/bin/timer.dart)
A specialized example for **`TimerSignal`**.
- Useful for recurring tasks, polling, or tracking elapsed time without manual timer management.

## Key Takeaways
These examples highlight that Signals.dart is NOT just for Flutter. It is a robust, performant state engine that can replace more complex tools like RxDart in many server-side or CLI scenarios while remaining easy to test.
