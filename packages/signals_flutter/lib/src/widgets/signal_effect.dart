import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart' as core;

/// A widget that enables executing scoped reactive side-effects inline within the widget tree.
/// 
/// `SignalEffect` (and its direct type alias [SignalListener]) allows you to run side-effects
/// (such as showing snackbars, opening dialogs, navigating, or logging metrics) in response
/// to signal updates, without triggering rebuilds of the child widget tree.
/// 
/// The [effect] callback runs immediately on mount and dynamically tracks any signals accessed
/// within its scope. The underlying subscription is automatically disposed when this widget
/// is removed from the tree. You can optionally return a cleanup function (e.g. `void Function()`)
/// to run before the next execution or when the widget is disposed.
/// 
/// ### Dialog and Snackbar Trigger Example
/// ```dart
/// final count = signal(0);
/// 
/// class SnackBarTrigger extends StatelessWidget {
///   const SnackBarTrigger({super.key});
/// 
///   @override
///   Widget build(BuildContext context) {
///     return SignalEffect(
///       effect: (context) {
///         // Triggers whenever 'count' updates:
///         if (count.value >= 10) {
///           ScaffoldMessenger.of(context).showSnackBar(
///             SnackBar(content: Text('Limit reached: ${count.value}!')),
///           );
///         }
///         // Optional: return cleanup callback
///         return () => print('Cleaning up effect');
///       },
///       child: ElevatedButton(
///         onPressed: () => count.value++,
///         child: const Text('Increment and Watch'),
///       ),
///     );
///   }
/// }
/// ```
/// 
/// > [!IMPORTANT]
/// > Do not perform synchronous state changes or trigger widget rebuilds directly inside
/// > the effect callback to prevent infinite reactive loops.
class SignalEffect extends StatefulWidget {
  /// Creates a [SignalEffect] widget.
  /// 
  /// The [effect] is executed inside a reactive effect.
  /// The [child] is rendered normally.
  const SignalEffect({
    required this.effect,
    required this.child,
    this.debugLabel,
    super.key,
  });

  /// The callback that runs inside the reactive effect.
  /// 
  /// Can optionally return a cleanup function (e.g. `void Function()`) that is run
  /// before the next execution of the callback or when the widget is disposed.
  final dynamic Function(BuildContext context) effect;

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
      () => widget.effect(context),
      options: core.EffectOptions(name: widget.debugLabel),
    );
  }

  @override
  void didUpdateWidget(covariant SignalEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.effect != widget.effect) {
      _cleanup?.call();
      _cleanup = core.effect(
        () => widget.effect(context),
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

/// Type alias for [SignalEffect] to provide a familiar and clear naming convention
/// for developers coming from other reactive libraries (like Bloc, Provider, or Flutter hooks).
typedef SignalListener = SignalEffect;
