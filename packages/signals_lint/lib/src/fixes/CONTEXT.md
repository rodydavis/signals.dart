# Signals Lint Fixes & Assists

This directory contains automated code fixes and IDE assists provided by the `signals_lint` package.

## Assists

### [wrap_with_watch.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_lint/lib/src/fixes/wrap_with_watch.dart)
Implements the **"Wrap with Watch"** IDE assist.
- **Functionality**: When a developer has their cursor on a widget constructor or variable, this assist provides a "Refactor" option to wrap that widget in a `Watch` widget or `WatchBuilder`.
- **Logic**: It uses the `custom_lint` framework to identify valid widget creation expressions and automate the boilerplate needed to make them reactive.
