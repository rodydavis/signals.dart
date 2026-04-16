# Signals Hooks API

This directory provides the entry point for the Signals Flutter Hooks integration.

## Entry Point

### [signals_hooks.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/signals_hooks.dart)
The primary library for using signals with `flutter_hooks`. It re-exports **[signals_flutter](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/CONTEXT.md)** and provides a comprehensive set of `use*` hooks.

## Modules

The hooks are categorized into several internal modules:
- **[core.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/src/core.dart)**: Basic signal, computed, and effect hooks.
- **[async.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/src/async.dart)**: Hooks for futures and streams.
- **[value.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/src/value.dart)**: Hooks for collections (List, Map, Set) and undo/redo stacks.
- **[flutter.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_hooks/lib/src/flutter.dart)**: Integration with standard Flutter `ValueNotifier` and `ValueListenable`.
