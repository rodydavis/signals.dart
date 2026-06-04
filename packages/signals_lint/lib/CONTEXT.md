# Signals Lint API

This directory provides the entry point for the Signals custom linter plugin.

## Plugin Entry Point

### [signals_lint.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/signals_lint.dart)
Registers all custom lint rules and assists with the `custom_lint` server.

- **getLintRules**: Currently includes `SignalsAvoidCreateInBuildMethod`.
- **getAssists**: Currently includes `WrapWithWatch`.

## Structure

The implementation logic is organized into rules and fixes within the **[src/](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/CONTEXT.md)** directory.
