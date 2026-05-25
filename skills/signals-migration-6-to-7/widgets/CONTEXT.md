# Signals Migration 6 to 7 Widgets

This directory provides developer/AI agent guidelines and prompt engineering instructions for migrating Flutter widget bindings from version 6.x to version 7.x of `signals_flutter`.

## Purpose

To equip AI assistants with rules, refactoring examples, and patterns for migrating Flutter components. This includes shifting from the deprecated `SignalsMixin` to `SignalWidget`/ builders and refactoring `SignalBuilder` to use the required named `builder` parameter.

## Detailed File Overviews

### [builder_migration.md](builder_migration.md)
- **Guidance**: Migration rules for rebuilding subtrees.
- **Core Principles**: Replaces the positional signature in `SignalBuilder` with the required named `builder` parameter: `SignalBuilder(builder: (context, value) => ...)` instead of `SignalBuilder((context, value) => ...)`.

### [mixin_migration.md](mixin_migration.md)
- **Guidance**: Guidelines for refactoring deprecated widget state mixins.
- **Core Principles**: Documents replacing `State with SignalsMixin` with pure stateless `SignalWidget`s, stateful `SignalStatefulWidget`s, or surgical inline `SignalBuilder`s. This removes unnecessary state overhead and avoids build-phase scheduler binding errors.

## Dependencies/Relationships

- **`skills/signals-migration-6-to-7`**: Extends the general migration parent guide.
- **`signals_flutter` package**: Details breaking changes and architectural updates within the widgets and mixins layers.

## Usage/Exports

Exposes migration rules and examples for:
- Refactoring `SignalBuilder` arguments to the named parameter pattern
- Upgrading `SignalsMixin` states to highly optimized `SignalWidget` structures
