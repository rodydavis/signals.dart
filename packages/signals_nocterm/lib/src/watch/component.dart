part of 'watch.dart';

/// ## Watch
///
/// To watch a signal for changes in Nocterm, use the `Watch` component. This will only rebuild this component method and not the entire component tree.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Component build(BuildContext context) {
///   return Watch((context) => Text('$signal'));
/// }
/// ```
///
/// This will also automatically unsubscribe when the component is disposed.
///
/// Any inherited components referenced inside the Watch scope will be subscribed to for updates and retrigger the builder method.
///
/// There is also a drop in replacement for builder:
///
/// ```diff
/// final signal = signal(10);
/// ...
/// @override
/// Component build(BuildContext context) {
/// -  return Builder(
/// +  return Watch.builder(
///     builder: (context) => Text('$signal'),
///   );
/// }
/// ```
class Watch<T extends Component> extends StatelessComponent {
  /// Minimal builder for signal changes that rerender a component tree.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// Watch((context) => Text('$counter'))
  /// ```
  const Watch(
    this.builder, {
    super.key,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// Drop in replacement for the Nocterm builder component.
  ///
  /// ```diff
  /// final counter = signal(0);
  /// ...
  /// - Builder(
  /// + Watch.builder(
  ///   builder: (context) {
  ///     return Text('$counter');
  ///   }
  /// )
  /// ```
  const Watch.builder({
    super.key,
    required this.builder,
    this.debugLabel,
    this.dependencies = const [],
  });

  /// The component to rebuild when any signals change
  final T Function(BuildContext context) builder;

  /// Optional debug label to use for devtools
  final String? debugLabel;

  /// List of optional dependencies to watch
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  Component build(BuildContext context) {
    return WatchBuilder(
      builder: (context, _) => builder(context),
      debugLabel: debugLabel,
      dependencies: dependencies,
    );
  }
}

/// ## WatchBuilder
///
/// A builder component that rebuilds when any signal it depends on changes.
/// This is the internal implementation used by [Watch].
///
/// ```dart
/// final counter = signal(0);
/// ...
/// WatchBuilder(
///   builder: (context, child) => Text('$counter'),
///   child: const ExpensiveWidget(), // Optional cached child
/// )
/// ```
class WatchBuilder<T extends Component> extends StatefulComponent {
  /// Minimal builder for signal changes that rerender a component tree.
  ///
  /// ```dart
  /// final counter = signal(0);
  /// ...
  /// WatchBuilder(
  ///   builder: (context, child) => Text('$counter'),
  /// )
  /// ```
  const WatchBuilder({
    super.key,
    required this.builder,
    this.debugLabel,
    this.dependencies = const [],
    this.child,
  });

  /// The component to rebuild when any signals change
  final T Function(BuildContext context, Component? child) builder;

  /// Optional debug label to use for devtools
  final String? debugLabel;

  /// Cached component to pass in
  final Component? child;

  /// List of optional dependencies to watch
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  State<WatchBuilder<T>> createState() => _WatchBuilderState<T>();
}

class _WatchBuilderState<T extends Component> extends State<WatchBuilder<T>>
    with SignalsMixin {
  late final result = createComputed(
    () {
      return component.builder(context, component.child);
    },
    debugLabel: component.debugLabel,
  );
  bool _init = true;

  @override
  void initState() {
    super.initState();
    for (final dep in component.dependencies) {
      bindSignal(dep);
    }
  }

  // coverage:ignore-start
  @override
  void reassemble() {
    super.reassemble();
    final target = core.SignalsObserver.instance;
    if (target is core.DevToolsSignalsObserver) {
      target.reassemble();
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      result.recompute();
      if (mounted) setState(() {});
      result.value;
    });
  }
  // coverage:ignore-end

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // Called on first build (we do not need to rebuild yet)
      _init = false;
      return;
    }
    result.recompute();
  }

  @override
  void didUpdateComponent(covariant WatchBuilder<T> oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.dependencies != component.dependencies) {
      for (final dep in oldComponent.dependencies) {
        final idx = component.dependencies.indexOf(dep);
        if (idx == -1) unbindSignal(dep);
      }
      for (final dep in component.dependencies) {
        bindSignal(dep);
      }
    } else if (oldComponent.builder != component.builder) {
      result.recompute();
    }
  }

  @override
  Component build(BuildContext context) {
    return result.value;
  }
}
