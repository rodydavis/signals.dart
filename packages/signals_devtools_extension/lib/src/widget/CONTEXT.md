# DevTools Extension Widgets

This directory contains reusable UI components for the Signals DevTools extension.

## Components

### [node_view.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/widget/node_view.dart)
Represents a single node (Signal or Computed) in the dependency graph.
- **Visuals**: Displays the node's label, its current value, and its type.
- **Interactivity**: Serves as the interactive anchor in the `GraphView` layout.

### [background_grid.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/widget/background_grid.dart)
Provides a configurable grid background for the graph canvas.
- **Purpose**: Helps with spatial orientation when navigating large dependency graphs.
- **Implementation**: Uses a custom painter to draw a grid that scales with the zoom level.
