# signals_devtools_extension

A Flutter DevTools extension for inspecting and debugging reactive state in Signals-enabled applications.

## Overview

`signals_devtools_extension` provides a visual interface for developers to inspect the current state of their signals, track updates in real-time, and visualize the complex dependency graph of Computeds and Effects. It hooks into the service extensions exposed by `signals_core`.

## Features

- **Node Table**: Search and browse all active signals, their current values, and their metadata.
- **Dependency Graph**: A visual representation of how signals flow into each other.
- **Real-time Updates**: Signals update in the UI as they change in the running application.
- **Hot Reload Integration**: Automatically synchronizes with the application state after hot reloads or reassembles.

## Directory Structure

### [lib/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/CONTEXT.md)
The implementation of the extension UI.
- **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/lib/src/CONTEXT.md)**: State management, graph rendering, and table views.

### [web/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_devtools_extension/web/)
Browser-specific assets for the extension.

## Integration

The extension is automatically loaded by the Flutter DevTools when the running application depends on a compatible version of `signals_core`.

## Development

Run the extension in debug mode using:
```bash
flutter run -d chrome --web-port 8080
```
Then connect it to a running app's DevTools instance.
