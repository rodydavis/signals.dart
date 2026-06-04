# Signals Umbrella API

This directory provides the primary entry point for the standard `signals` package.

## Entry Point

### [signals.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals/lib/signals.dart)
This library serves as a convenient umbrella export for **`signals_core`**.
- It re-exports the entire `signals_core` library, allowing consumers to simply import `package:signals/signals.dart` to access all reactive primitives, collection signals, and async helpers.
- This pattern simplifies onboarding by hiding the internal modularity (core vs. engine) from most users.
