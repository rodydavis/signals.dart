import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// Custom painter that automatically repaints when any of the provided signals change,
/// bypassing the widget build and layout phases.
abstract class SignalCustomPainter {
  /// The list of signals to observe for changes.
  final List<core.ReadonlySignal<dynamic>> signals;

  /// Creates a new [SignalCustomPainter].
  const SignalCustomPainter({required this.signals});

  /// Paint on the canvas.
  void paint(Canvas canvas, Size size);

  /// Return true if the painter should be updated when the widget configuration changes.
  bool shouldRepaint(covariant SignalCustomPainter oldDelegate);
}

/// A high-performance custom paint widget that subscribes to signals
/// and repaints its canvas directly on the GPU without triggering widget rebuilds or layout.
class SignalCustomPaint extends SingleChildRenderObjectWidget {
  /// The painter to draw on the canvas.
  final SignalCustomPainter painter;

  /// Creates a new [SignalCustomPaint].
  const SignalCustomPaint({
    super.key,
    required this.painter,
    super.child,
  });

  @override
  RenderSignalCustomPaint createRenderObject(BuildContext context) {
    return RenderSignalCustomPaint(painter: painter);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSignalCustomPaint renderObject) {
    renderObject.painter = painter;
  }
}

/// The [RenderObject] for [SignalCustomPaint] that delegates drawing to [SignalCustomPainter].
class RenderSignalCustomPaint extends RenderSignalProxyBox {
  SignalCustomPainter _painter;

  /// Creates a new [RenderSignalCustomPaint].
  RenderSignalCustomPaint({
    required SignalCustomPainter painter,
  })  : _painter = painter,
        super(signals: painter.signals);

  /// Gets the custom painter delegate.
  SignalCustomPainter get painter => _painter;

  /// Sets a new custom painter delegate and triggers a repaint if necessary.
  set painter(SignalCustomPainter val) {
    if (_painter == val) return;
    _painter = val;
    signals = val.signals;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Painter Safety: Suspend signal tracking during the paint cycle to prevent active context corruption
    final oldOnSignalRead = core.onSignalRead;
    core.onSignalRead = null;
    try {
      final canvas = context.canvas;
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      _painter.paint(canvas, size);
      canvas.restore();
      super.paint(context, offset);
    } finally {
      core.onSignalRead = oldOnSignalRead;
    }
  }
}

/// A low-level [RenderProxyBox] that subscribes to multiple reactive signals
/// and automatically schedules repaints without layout/rebuild when signals fire.
class RenderSignalProxyBox extends RenderProxyBox {
  List<core.ReadonlySignal<dynamic>> _signals;

  /// Creates a new [RenderSignalProxyBox] with the specified list of observed [signals].
  RenderSignalProxyBox({
    required List<core.ReadonlySignal<dynamic>> signals,
  }) : _signals = List.from(signals) {
    _subscribe();
  }

  /// Gets the current list of signals being observed.
  List<core.ReadonlySignal<dynamic>> get signals => _signals;

  /// Sets a new list of observed signals and resubscribes to them.
  set signals(List<core.ReadonlySignal<dynamic>> val) {
    if (identical(_signals, val)) return;
    _unsubscribe();
    _signals = List.from(val);
    _subscribe();
    markNeedsPaint();
  }

  final List<void Function()> _disposers = [];

  void _subscribe() {
    for (final signal in _signals) {
      _disposers.add(
        signal.subscribe((_) {
          // Skip rebuild and layout, go straight to repaint
          markNeedsPaint();
        }),
      );
    }
  }

  void _unsubscribe() {
    for (final dispose in _disposers) {
      dispose();
    }
    _disposers.clear();
  }

  @override
  void detach() {
    _unsubscribe();
    super.detach();
  }
}

/// A low-level widget wrapper around [RenderSignalProxyBox] for custom painting / sizing needs.
class SignalProxyWidget extends SingleChildRenderObjectWidget {
  /// The list of signals to observe.
  final List<core.ReadonlySignal<dynamic>> signals;

  /// Creates a new [SignalProxyWidget].
  const SignalProxyWidget({
    super.key,
    required this.signals,
    super.child,
  });

  @override
  RenderSignalProxyBox createRenderObject(BuildContext context) {
    return RenderSignalProxyBox(signals: signals);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSignalProxyBox renderObject) {
    renderObject.signals = signals;
  }
}

/// A high-performance leaf render object widget that bypasses Build/Layout and paints on canvas.
class SignalPainterWidget extends LeafRenderObjectWidget {
  /// The progress signal whose value will be passed to [painter].
  final core.ReadonlySignal<double> progress;

  /// The custom painting callback function.
  final void Function(Canvas canvas, Size size, double value) painter;

  /// Creates a new [SignalPainterWidget].
  const SignalPainterWidget({
    super.key,
    required this.progress,
    required this.painter,
  });

  @override
  RenderSignalBox createRenderObject(BuildContext context) {
    return RenderSignalBox(progress: progress, painter: painter);
  }

  @override
  void updateRenderObject(BuildContext context, RenderSignalBox renderObject) {
    renderObject
      ..progress = progress
      ..painter = painter;
  }
}

/// The low-level [RenderBox] used by [SignalPainterWidget] to directly subscribe to a progress signal and paint.
class RenderSignalBox extends RenderBox {
  core.ReadonlySignal<double> _progress;
  void Function(Canvas canvas, Size size, double value) _painter;
  void Function()? _disposer;

  /// Creates a new [RenderSignalBox] drawing using [_painter] and driven by [_progress] signal.
  RenderSignalBox({
    required core.ReadonlySignal<double> progress,
    required void Function(Canvas canvas, Size size, double value) painter,
  })  : _progress = progress,
        _painter = painter {
    _subscribe();
  }

  /// Sets a new progress signal and resubscribes to updates.
  set progress(core.ReadonlySignal<double> val) {
    if (_progress == val) return;
    _unsubscribe();
    _progress = val;
    _subscribe();
    markNeedsPaint();
  }

  /// Sets a new custom painter delegate.
  set painter(void Function(Canvas canvas, Size size, double value) val) {
    _painter = val;
    markNeedsPaint();
  }

  void _subscribe() {
    _disposer = _progress.subscribe((_) {
      markNeedsPaint();
    });
  }

  void _unsubscribe() {
    _disposer?.call();
    _disposer = null;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Painter Safety: Suspend signal tracking during the paint cycle to prevent active context corruption
    final oldOnSignalRead = core.onSignalRead;
    core.onSignalRead = null;
    try {
      context.canvas.save();
      context.canvas.translate(offset.dx, offset.dy);
      _painter(context.canvas, size, _progress.peek());
      context.canvas.restore();
    } finally {
      core.onSignalRead = oldOnSignalRead;
    }
  }

  @override
  void detach() {
    _unsubscribe();
    super.detach();
  }
}
