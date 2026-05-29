# Signals Flutter Widgets Skills

This directory provides developer/AI agent guidelines and coding instructions for using and optimizing reactive widgets in the `signals_flutter` environment.

## Purpose

To equip AI assistants with rules, guidelines, and patterns for using widget classes that surgically rebuild or paint in response to signal updates, minimizing redraw cost and UI performance bottlenecks.

## Detailed File Overviews

### [signal_widget.dart](signal_widget.md) / [signal_widget.md](signal_widget.md)
- **Guidance**: Instructions for implementing `SignalWidget` to support automatic, implicit dependency tracking during standard widget build methods.

### [signal_builder.md](signal_builder.md)
- **Guidance**: Best practices for implementing localized, surgical rebuilding of subtrees using `SignalBuilder` (and its deprecated alias `Watch`).

### [signal_effect.md](signal_effect.md)
- **Guidance**: Rules for running side-effect callbacks inside the widget tree using `SignalEffect` (and its typedef `SignalListener`), ensuring clean listener teardown.

### [signal_custom_paint.md](signal_custom_paint.md)
- **Guidance**: Guidelines for high-performance GPU canvas rendering via `SignalCustomPaint` and `SignalPainterWidget`, completely bypassing the widget build and layout cycles.

## Dependencies/Relationships

- **`skills/signals-flutter`**: Extends the general Flutter reactivity parent guide.
- **`signals_flutter` package**: Direct instructions for the widgets library.

## Usage/Exports

Exposes instructions for:
- Automatic implicit widgets (`SignalWidget`)
- Explicit surgical rebuilding (`SignalBuilder` / `Watch`)
- Reactive widget life-cycle effects (`SignalEffect` / `SignalListener`)
- Bypass building/layout paint widgets (`SignalCustomPaint` / `SignalPainterWidget`)
