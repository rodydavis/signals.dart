# signals (Umbrella Package)

This is the main "umbrella" package for the Signals ecosystem, providing a unified entry point for both core reactivity and Flutter integrations.

## Purpose

The `signals` package is designed to be the single dependency most users need to add to their projects. It acts as an orchestrator and re-exporter of the foundational logic from `signals_core` and the UI-specific utilities from `signals_flutter`.

## Entry Points

The package provides several library files to selectively import the desired feature set:

- **[signals.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals/lib/signals.dart)**: The main entry point. Re-exports `package:signals_core/signals_core.dart`.
- **[signals_flutter.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals/lib/signals_flutter.dart)**: Re-exports `package:signals_flutter/signals_flutter.dart`.
- **[signals_core.dart](file:///Users/rodydavis/dev/signals.dart/packages/signals/lib/signals_core.dart)**: Direct re-export of `signals_core`.
- **Extended variants**: 
    - `signals_core_extended.dart`
    - `signals_flutter_extended.dart`

## Key Dependencies

- **[signals_core](file:///Users/rodydavis/dev/signals.dart/packages/signals_core/CONTEXT.md)**: The underlying reactivity engine.
- **[signals_flutter](file:///Users/rodydavis/dev/signals.dart/packages/signals_flutter/CONTEXT.md)**: The Flutter integration layer.

## Usage

For most Dart and Flutter projects, simply add `signals` to your `pubspec.yaml` and import:

```dart
import 'package:signals/signals.dart';
// or for Flutter projects
import 'package:signals/signals_flutter.dart';
```
