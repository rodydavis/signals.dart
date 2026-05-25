import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A widget that creates a reactive effect inline within the widget tree.
///
/// The [callback] is executed inside a reactive effect and automatically
/// tracks any signals read within its scope. The effect is disposed when the
/// widget is removed from the widget tree.
///
/// ```dart
/// SignalEffect(
///   callback: (context) {
///     print('Counter value changed to ${counter.value}');
///   },
///   child: const Text('Counter Listener'),
/// )
/// ```
class SignalEffect extends StatefulWidget {
  /// Constructor for [SignalEffect].
  const SignalEffect({
    required this.callback,
    required this.child,
    this.debugLabel,
    super.key,
  });

  /// The callback that runs inside the reactive effect.
  final void Function(BuildContext context) callback;

  /// The child widget to render.
  final Widget child;

  /// Optional debug label for the effect.
  final String? debugLabel;

  @override
  State<SignalEffect> createState() => _SignalEffectState();
}

class _SignalEffectState extends State<SignalEffect> {
  core.EffectCleanup? _cleanup;

  @override
  void initState() {
    super.initState();
    _cleanup = core.effect(
      () => widget.callback(context),
      options: core.EffectOptions(name: widget.debugLabel),
    );
  }

  @override
  void didUpdateWidget(covariant SignalEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.callback != widget.callback) {
      _cleanup?.call();
      _cleanup = core.effect(
        () => widget.callback(context),
        options: core.EffectOptions(name: widget.debugLabel),
      );
    }
  }

  @override
  void dispose() {
    _cleanup?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Type alias for [SignalEffect].
typedef SignalListener = SignalEffect;
