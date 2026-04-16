# Signals Flutter Watch Engine

This directory contains the core logic for "surgical" rebuilds in Flutter. It allows developers to subscribe widgets to signals such that only the specific widget (or even a specific part of a widget) rebuilds when the state changes.

## Key Components

### [Watch / WatchBuilder](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/watch/widget.dart)
The primary widgets used to wrap reactive UI sections. They use a `Computed` signal to wrap their builder function, automatically tracking any signals accessed within that scope.

### [ElementWatcher](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/watch/element_watcher.dart)
A low-level utility that binds signal subscriptions to a Flutter `Element`. It uses **`WeakReference`** to ensure that once a widget is removed from the tree, its signal subscriptions are automatically cleaned up, even in `StatelessWidget`s.

### [Extension Helper](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/watch/extension.dart)
Provides the `watchSignal` function used by the `context.watch(signal)` extension. It manages the creation and retrieval of `ElementWatcher` instances for any given `BuildContext`.

## How it Works
When a signal is "watched" within a `build` method, the `ElementWatcher` subscribes to that signal. When the signal updates, the watcher calls `markNeedsBuild()` on the associated `Element`, triggering a surgical rebuild of that specific part of the widget tree.
