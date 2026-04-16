# Authentication Flow Example

This example demonstrates how to integrate Signals with **GoRouter** to create a reactive navigation system and manage global authentication state.

## Concepts

### Reactive Routing
The **[router](file:///Users/rodydavis/Developer/signals.dart/examples/auth_flow/lib/main.dart)** uses an `auth.isLoggedIn` computed signal as its `refreshListenable`. When the login state changes, the router automatically triggers its redirect logic, moving the user between the login and home screens seamlessly.

### Stream to Signal Bridge
The authentication state is derived from a `StreamController` in the `ServerApi`.
- **`toStreamSignal()`**: Used to convert the user stream into a reactive signal.
- **Dependency Tracking**: The `settings` signal automatically refreshes whenever the `currentUser` signal changes, demonstrating how signals can depend on each other across asynchronous boundaries.

### Scoped vs. Global State
- **Global**: `auth` and `themeMode` are global signals used throughout the app.
- **Local**: `HomeScreen` uses a local `counter` signal, demonstrating that signals can be safely used within `StatefulWidget`s without interfering with global state.

## UI Patterns

- **[Watch](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/watch/CONTEXT.md)**: Used in `HomeScreen` and `ProfileScreen` for surgical rebuilds of text and loading indicators.
- **[ThemeMode Integration](file:///Users/rodydavis/Developer/signals.dart/examples/auth_flow/lib/main.dart)**: Demonstrates using `themeMode.watch(context)` directly in the `MaterialApp` to react to brightness changes.
