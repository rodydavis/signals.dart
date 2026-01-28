part of 'watch.dart';

/// A component that rebuilds when any signal it depends on changes.
///
/// Use this component for fine-grained rebuilds. Only the subtree inside
/// the [Watch] component will rebuild when a signal changes.
///
/// ## Example
///
/// ```dart
/// final count = signal(0);
///
/// class MyComponent extends StatelessComponent {
///   const MyComponent({super.key});
///
///   @override
///   Component build(BuildContext context) {
///     return Column(
///       children: [
///         // Only this part rebuilds when count changes
///         Watch((context) => Text('Count: ${count()}')),
///         // This part never rebuilds
///         Text('Static text'),
///       ],
///     );
///   }
/// }
/// ```
class Watch extends StatefulComponent {
  /// Creates a [Watch] component.
  const Watch(
    this.builder, {
    super.key,
  });

  /// The builder function that returns the component tree.
  ///
  /// This function is called whenever any signal accessed inside it changes.
  final Component Function(BuildContext context) builder;

  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  core.EffectCleanup? _cleanup;
  Component? _child;

  @override
  void initState() {
    super.initState();
    _rebuild();
  }

  @override
  void didUpdateComponent(Watch oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.builder != component.builder) {
      _rebuild();
    }
  }

  void _rebuild() {
    _cleanup?.call();
    _cleanup = core.effect(() {
      final child = component.builder(context);
      if (_child != child) {
        _child = child;
        _scheduleRebuild();
      }
    });
  }

  void _scheduleRebuild() async {
    if (!mounted) return;

    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase != SchedulerPhase.idle) {
      await scheduler.endOfFrame;
      if (!mounted) return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _cleanup?.call();
    _cleanup = null;
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return _child ?? const SizedBox.shrink();
  }
}

/// A builder component that rebuilds when any signal it depends on changes.
///
/// This is an alternative to [Watch] that provides access to the current
/// signal value through a callback pattern.
///
/// ## Example
///
/// ```dart
/// final count = signal(0);
///
/// WatchBuilder<int>(
///   signal: count,
///   builder: (context, value, child) {
///     return Text('Count: $value');
///   },
/// )
/// ```
class WatchBuilder<T> extends StatefulComponent {
  /// Creates a [WatchBuilder] component.
  const WatchBuilder({
    super.key,
    required this.signal,
    required this.builder,
    this.child,
  });

  /// The signal to watch.
  final core.ReadonlySignal<T> signal;

  /// The builder function that returns the component tree.
  final Component Function(BuildContext context, T value, Component? child)
      builder;

  /// An optional child component that doesn't depend on the signal.
  ///
  /// This child is passed to the builder and won't be rebuilt when
  /// the signal changes.
  final Component? child;

  @override
  State<WatchBuilder<T>> createState() => _WatchBuilderState<T>();
}

class _WatchBuilderState<T> extends State<WatchBuilder<T>> {
  VoidCallback? _cleanup;
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = component.signal.value;
    _subscribe();
  }

  @override
  void didUpdateComponent(WatchBuilder<T> oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.signal != component.signal) {
      _unsubscribe();
      _value = component.signal.value;
      _subscribe();
    }
  }

  void _subscribe() {
    _cleanup = component.signal.subscribe((value) {
      _scheduleRebuild(value);
    });
  }

  void _unsubscribe() {
    _cleanup?.call();
    _cleanup = null;
  }

  void _scheduleRebuild(T value) async {
    if (!mounted) return;

    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase != SchedulerPhase.idle) {
      await scheduler.endOfFrame;
      if (!mounted) return;
    }

    setState(() {
      _value = value;
    });
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    return component.builder(context, _value, component.child);
  }
}
