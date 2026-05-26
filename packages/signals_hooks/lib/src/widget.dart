import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart' as core;

/// A hook that implicitly tracks any signal read during the build phase of a [HookWidget]
/// and automatically rebuilds the widget when they change.
_ImplicitSignalTrackingHookState _useImplicitSignalTracking() {
  return use(const _ImplicitSignalTrackingHook());
}

class _ImplicitSignalTrackingHook
    extends Hook<_ImplicitSignalTrackingHookState> {
  const _ImplicitSignalTrackingHook();

  @override
  _ImplicitSignalTrackingHookState createState() =>
      _ImplicitSignalTrackingHookState();
}

class _ImplicitSignalTrackingHookState extends HookState<
    _ImplicitSignalTrackingHookState, _ImplicitSignalTrackingHook> {
  final _watch = <int, VoidCallback>{};
  bool _initializing = false;

  void watchSignal(core.ReadonlySignal value) {
    _watch.putIfAbsent(
      value.globalId,
      () => value.subscribe((val) {
        if (_initializing) return;
        setState(() {});
      }),
    );
  }

  void updateWatch(Set<core.ReadonlySignal> signals) {
    _initializing = true;
    try {
      final toRemove = <int>[];
      _watch.forEach((id, dispose) {
        if (!signals.any((s) => s.globalId == id)) {
          dispose();
          toRemove.add(id);
        }
      });
      for (final id in toRemove) {
        _watch.remove(id);
      }
      for (final signal in signals) {
        watchSignal(signal);
      }
    } finally {
      _initializing = false;
    }
  }

  @override
  void dispose() {
    for (final dispose in _watch.values) {
      dispose();
    }
    _watch.clear();
    super.dispose();
  }

  @override
  _ImplicitSignalTrackingHookState build(BuildContext context) => this;
}

/// A premium reactive [HookWidget] that both supports Flutter Hooks and implicitly tracks and rebuilds on signal changes.
///
/// `SignalHookWidget` establishes a dynamic reactive context directly at the Flutter element layer.
/// Any signal accessed via `.value` inside the [buildWidget] method is **implicitly tracked** and
/// subscribed to. At the same time, you can call any hooks (like `useSignal`, `useFocusNode`, etc.)
/// within [buildWidget].
///
/// This provides the ultimate developer experience, combining the power of implicit, boilerplate-free
/// signal tracking with the rich lifecycle management of Flutter Hooks.
///
/// ### Dual Reactivity Example
/// ```dart
/// final globalCartCount = signal(0);
///
/// class MyDualWidget extends SignalHookWidget {
///   const MyDualWidget({super.key});
///
///   @override
///   Widget buildWidget(BuildContext context) {
///     // 1. Declare hooks seamlessly:
///     final controller = useTextEditingController();
///     final focusNode = useFocusNode();
///     final localCounter = useSignal(0);
///
///     // 2. Implicit tracking of external/global signals:
///     // No .watch(context) needed! Just accessing .value tracks it.
///     return Column(
///       children: [
///         TextField(controller: controller, focusNode: focusNode),
///         Text('Global Signal: ${globalCartCount.value}'),
///         Text('Local Signal: ${localCounter.value}'),
///       ],
///     );
///   }
/// }
/// ```
abstract class SignalHookWidget extends HookWidget {
  /// Constructor for [SignalHookWidget].
  const SignalHookWidget({super.key});

  /// Subclasses override this method instead of [build] to define their widget tree.
  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final state = _useImplicitSignalTracking();

    final signals = <core.ReadonlySignal>{};
    final oldOnSignalRead = core.onSignalRead;
    core.onSignalRead = (signal) {
      if (signal is core.ReadonlySignal) {
        signals.add(signal);
      }
    };

    try {
      return buildWidget(context);
    } finally {
      core.onSignalRead = oldOnSignalRead;
      state.updateWatch(signals);
    }
  }
}

/// A premium, localized builder widget that behaves exactly like [SignalHookWidget]
/// but in a builder format.
///
/// Allows mixing hooks and implicit signal tracking within a localized subtree builder callback.
///
/// ### Example Usage
/// ```dart
/// final count = signal(0);
///
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: SignalHookBuilder(
///         builder: (context) {
///           // Call standard hooks inside the builder:
///           final controller = useTextEditingController();
///           final focusNode = useFocusNode();
///
///           // Access signals implicitly. Only this subtree will rebuild when count changes:
///           return Column(
///             children: [
///               TextField(controller: controller, focusNode: focusNode),
///               Text('Counter: ${count.value}'),
///             ],
///           );
///         },
///       ),
///     ),
///   );
/// }
/// ```
class SignalHookBuilder extends SignalHookWidget {
  /// Creates a [SignalHookBuilder] widget.
  const SignalHookBuilder({
    super.key,
    required this.builder,
  });

  /// The widget builder callback.
  final Widget Function(BuildContext context) builder;

  @override
  Widget buildWidget(BuildContext context) => builder(context);
}
