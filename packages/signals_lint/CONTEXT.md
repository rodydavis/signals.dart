# signals_lint

Custom static analysis rules and IDE assists for the Signals ecosystem in Dart and Flutter.

## Overview

`signals_lint` enhances the developer experience by enforcing best practices and providing automated fixes/assists for common signal patterns. It integrates with the standard Dart static analysis tool via the `custom_lint` framework.

## Features

- **Performance Lints**: Detects and warns against anti-patterns, such as creating new signals inside Flutter `build()` methods, which causes unnecessary state resets and memory leaks.
- **IDE Assists**: Provides useful Quick Fixes and IDE code transformations, such as "Wrap with Watch" to quickly implement surgical, optimized widget rebuilds.

## Directory Structure

### [lib/](file:///Users/rodydavis/dev/signals.dart/packages/signals_lint/lib/CONTEXT.md)
Contains the linter plugin entry registration and rule definitions.
- **[src/](file:///Users/rodydavis/dev/signals.dart/packages/signals_lint/lib/src/CONTEXT.md)**: Implementation of static analysis rules and IDE quick fixes.

### [example/](file:///Users/rodydavis/dev/signals.dart/packages/signals_lint/example/)
A sandbox project containing code that deliberately triggers linter warnings to verify rule implementation and demo assists.

## Installation

Add this to your project's `pubspec.yaml`:

```yaml
dev_dependencies:
  custom_lint:
  signals_lint:
```

And update your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
```
