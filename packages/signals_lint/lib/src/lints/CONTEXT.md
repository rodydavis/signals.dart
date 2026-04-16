# Signals Lint Rules

This directory contains custom static analysis rules designed to prevent common mistakes when working with signals in Dart and Flutter.

## Rules

### [avoid_create_in_build_method.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/lints/avoid_create_in_build_method.dart)
Implements the **`avoid_create_in_build_method`** rule.
- **Problem**: Signals should not be instantiated directly inside a Flutter `build` method, as they will be re-created every time the widget rebuilds, losing their state and potentially causing memory leaks or infinite loop cycles.
- **Solution**: Signals should be created as class members (if using a `StatefulWidget` or `SignalsMixin`) or outside the widget tree.
- **Detection**: The rule analyzes `build` method bodies for calls to `signal()`, `listSignal()`, `computed()`, and other factory functions.
