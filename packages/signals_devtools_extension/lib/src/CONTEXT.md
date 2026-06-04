# Signals DevTools Extension Implementation

This directory contains the Flutter-based UI and state management for the Signals DevTools extension.

## Extension Lifecycle (`nodes_state.dart`)
The extension communicates with the target application via the Dart Tooling Daemon (DTD).
- **Initialization**: `initNodes()` subscribes to `serviceManager.service?.onExtensionEvent`.
- **Event Handling**: Listens for `ext.signals.*` events (create, update, remove, reassemble).
- **Data Model**: The `$Node` class represents a reactive primitive in the target app, tracking its type, label, value, and dependency links.
- **Refresh**: `refreshNodes()` calls the `ext.signals.getAllNodes` service extension to perform a full synchronization.

## UI Components

### [signals_devtools_extension.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/signals_devtools_extension.dart)
The layout manager providing navigation between different visualization modes (List and Graph).

### [node_table.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/node_table.dart)
A tabular view of all active signals.
- **Details**: Shows values and provides expandable sections for **Sources** and **Targets**.
- **Reactivity**: Uses the `Watch` widget to update automatically as the target app sends events.

### [node_graph.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/node_graph.dart)
A visual node-link diagram representing the signal dependency tree.
- **Library**: Built using `GraphView`.
- **Layout**: Uses a Fruchterman-Reingold force-directed layout.
- **Relationships**: Visualizes data flow with colored edges (orange for sources, green for targets).

## Widgets

- **[node_view.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/widget/node_view.dart)**: Individual node card in the graph.
- **[background_grid.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/widget/background_grid.dart)**: Decorative grid for the infinite canvas.
