# Signals Flutter Render

This directory provides low-level, high-performance rendering components that integrate the reactive signal system directly with Flutter's rendering pipeline (GPU), bypassing standard widget build and layout cycles.

## Purpose

To enable high-performance, surgical repainting of canvas drawings by directly subscribing to reactive signals. When observed signals fire, they trigger a direct repaint (`markNeedsPaint()`) on the `RenderObject`, completely bypassing Flutter's widget-rebuilding (`build`) and layout (`performLayout`) phases.

## Detailed File Overviews

### [paint.dart](paint.dart)

The core source file defining high-performance rendering components, painter classes, and their respective `RenderObject`s.

#### Core Logic & Classes:
- **`SignalCustomPainter`**: An abstract delegate class resembling Flutter's native `CustomPainter` but accepting a list of `ReadonlySignal` dependencies. Subclasses implement the custom canvas drawing in the `paint(Canvas, Size)` method.
- **`SignalCustomPaint`**: A `SingleChildRenderObjectWidget` wrapper for `SignalCustomPainter` that manages the creation and update of the corresponding render object.
- **`RenderSignalCustomPaint`**: A `RenderProxyBox` that delegates its canvas drawing to a `SignalCustomPainter` and binds its repaint schedule directly to the painter's signals.
  - *Painter Safety*: During its `paint()` phase, it temporarily suspends active signal read tracking (`core.onSignalRead = null`) and restores the old listener afterward. This prevents any signal access in the paint cycle from corrupting or registering unwanted dependencies on outer execution contexts.
- **`RenderSignalProxyBox`**: A low-level `RenderProxyBox` subclass that takes a list of reactive signals and subscribes to them. On signal updates, it schedules a direct repaint via `markNeedsPaint()`. It manages clean subscription lifetimes, unsubscribing from all signals on `detach()` to prevent memory leaks.
- **`SignalProxyWidget`**: A widget wrapper around `RenderSignalProxyBox` that exposes direct signal-bound painting and sizing capability to the widget tree.
- **`SignalPainterWidget`**: A highly optimized leaf render object widget that binds a custom painting callback `painter(Canvas, Size, double)` to a double-valued progress signal.
- **`RenderSignalBox`**: The low-level `RenderBox` utilized by `SignalPainterWidget`. It registers to the progress signal, triggers `markNeedsPaint()` upon changes, layouts to fill available constraints (`size = constraints.biggest`), and implements *Painter Safety* by disabling `onSignalRead` during paint execution.

## Dependencies/Relationships

- **`signals_core`**: Subscribes directly to `ReadonlySignal` instances using the low-level `subscribe()` API. Uses `core.onSignalRead` to implement painter safety.
- **Flutter Rendering System (`package:flutter/rendering.dart`)**: Subclasses core pipeline elements like `RenderBox`, `RenderProxyBox`, and `PaintingContext`.

## Usage/Exports

The following core classes are exposed by this folder to enable custom painting and high-performance layout:
- `SignalCustomPainter`
- `SignalCustomPaint`
- `SignalProxyWidget`
- `SignalPainterWidget`
