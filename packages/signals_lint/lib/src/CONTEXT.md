# Signals Lint Implementation

This directory contains the logic for custom analysis rules and code assists using the `custom_lint` framework.

## Rules (`lints/`)

### [avoid_create_in_build_method.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/lints/avoid_create_in_build_method.dart)
Warns developers when they instantiate signals inside a Flutter `build()` method.
- **Rationale**: Creating signals in `build` is an anti-pattern because the signal (and its state) would be recreated every time the widget rebuilds.
- **Detection**: Uses `TypeChecker` to identify `Signal`, `Computed`, `SignalValueNotifier`, and `SignalValueListenable` types within a `build` method context.

## Assists (`fixes/`)

### [wrap_with_watch.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/fixes/wrap_with_watch.dart)
Provides a "Quick Assist" in the IDE to wrap any widget-creating expression with the `Watch` widget.
- **Usage**: Select a widget instantiation and choose "Wrap with Watch".
- **Implementation**: Automatically inserts `Watch((context) => ...)` around the target node.

## Utilities

- **[utils.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/utils.dart)**: Contains shared internal helpers for AST analysis and code generation.
