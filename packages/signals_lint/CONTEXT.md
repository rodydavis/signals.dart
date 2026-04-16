# signals_lint

Custom static analysis rules and IDE assists for the Signals ecosystem.

## Overview

`signals_lint` enhances the developer experience by enforcing best practices and providing automated fixes for common signal patterns in Dart and Flutter. It integrates with the standard `analysis_options.yaml` via the `custom_lint` package.

## Features

- **Performance Lints**: Warns against anti-patterns like creating signals inside `build()` methods to prevent memory leaks and state reset issues.
- **IDE Assists**: Provides "Wrap with Watch" code transformations to quickly implement surgical rebuilds.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/CONTEXT.md)
Contains the linter plugin registration and implementation.
- **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/CONTEXT.md)**: Implementation of rules and fixes.

### [example/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/example/)
A sandbox project used to test and demonstrate linter rules.

## Installation

Add this to your `pubspec.yaml`:

```yaml
dev_dependencies:
  custom_lint:
  signals_lint:
```

And update `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
```
