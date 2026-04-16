# Signals Monorepo Packages

This directory contains the various packages that make up the Signals reactivity ecosystem.

## Core Hierarchy

The packages are designed in a layered architecture to provide flexibility and performance.

### 1. The Engine
- **[preact_signals](file:///Users/rodydavis/Developer/signals.dart/packages/preact_signals/CONTEXT.md)**: The raw, low-level reactivity engine based on the "Pulse" algorithm.

### 2. Pure Dart Primitives
- **[signals_core](file:///Users/rodydavis/Developer/signals.dart/packages/signals_core/CONTEXT.md)**: The primary library for non-UI Dart code. Provides `FutureSignal`, `StreamSignal`, and collection-based signals.

### 3. Framework Integrations
- **[signals_flutter](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/CONTEXT.md)**: Native widgets and rebuild logic for Flutter applications.
- **[signals_hooks](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/CONTEXT.md)**: Declarative hooks for projects already using `flutter_hooks`.

### 4. Developer Experience (DX)
- **[signals_lint](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/CONTEXT.md)**: Static analysis rules and IDE assists.
- **[signals_devtools_extension](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/CONTEXT.md)**: Visual inspector for the Chrome/Flutter DevTools.

### 5. Consumption
- **[signals](file:///Users/rodydavis/Developer/signals.dart/packages/signals/CONTEXT.md)**: The recommended umbrella package that simplifies imports for most users.

## Maintenance
Each package is managed as an independent unit but cross-referenced in the **[Melos workspace](file:///Users/rodydavis/Developer/signals.dart/pubspec.yaml)** for unified testing and versioning.
