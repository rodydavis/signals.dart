# Signals Flutter Extensions Skills

This directory provides developer/AI agent guidelines and coding instructions for context-level extensions in the `signals_flutter` environment.

## Purpose

To equip AI assistants with patterns, APIs, and guidelines for using Flutter-specific context extensions to bind signals directly to the widget tree's reactive rendering cycle.

## Detailed File Overviews

### [watch.md](watch.md)
- **Guidance**: Guidelines for using the `.watch(context)` extension method on `ReadonlySignal`.
- **Core Principles**: Explains how to seamlessly subscribe a `BuildContext` to signal modifications directly inside widget `build` methods.
- **Dynamic Memory Management**: Standardizes the teardown lifecycle utilizing dynamic VM Expandos and clean finalizer callbacks to prevent memory leaks when elements are unmounted.

## Dependencies/Relationships

- **`skills/signals-flutter`**: Extends the general Flutter reactivity parent guide.
- **`signals_flutter` package**: Details the `.watch()` extension method on signals within Flutter UI.

## Usage/Exports

Exposes instructions for:
- Context-level signal subscription (`watch`)
- Memory and teardown lifecycles for element contexts
