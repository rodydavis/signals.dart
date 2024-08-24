part of 'watch.dart';

/// {@template watch}
/// ## Watch
///
/// To watch a signal for changes in Flutter, use the `Watch` widget. This will only rebuild this widget method and not the entire widget tree.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Watch((context) => Text('$signal'));
/// }
/// ```
///
/// This will also automatically unsubscribe when the widget is disposed.
///
/// Any inherited widgets referenced to inside the Watch scope will be subscribed to for updates ([MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html), [Theme](https://api.flutter.dev/flutter/material/Theme-class.html), etc.) and retrigger the builder method.
///
/// There is also a drop in replacement for builder:
///
/// ```diff
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
/// -  return Builder(
/// +  return Watch.builder(
///     builder: (context) => Text('$signal'),
///   );
/// }
/// ```
///
///
/// ## .watch(context)
///
/// If you need to map to a widget property use the `watch` extension method. This will infer the type and subscribe to the signal.
///
/// ```dart
/// final fontSize = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Text('Hello World',
///     style: TextStyle(fontSize:fontSize.watch(context)),
///   );
/// }
/// ```
///
/// It is recommended to use `Watch` instead of `.watch(context)` as it will automatically unsubscribe when the widget is disposed instead of waiting on the garbage collector via [WeakReferences](https://api.flutter.dev/flutter/dart-core/WeakReference-class.html).
///
/// ## .listen(context, cb)
///
/// Alternatively if need to listen for changes to a signal but not rebuild the widget you can use the listen extension.
///
/// ```dart
/// final counter = signal(0);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   counter.listen(context, () {
///     if (counter.value == 10) {
///       final messenger = ScaffoldMessenger.of(context);
///       messenger.hideCurrentSnackBar();
///       messenger.showSnackBar(
///         const SnackBar(content: Text('You hit 10 clicks!')),
///       );
///     }
///   });
/// ...
/// }
/// ```
///
/// This can be used in the build method and will call the callback method in the same way it would rebuild the widget (only when mounted).
///
/// ### Rebuilds
///
/// To protect against unnecessary rebuilds, the `watch` extension will only subscribe once to the nearest element and mark the widget as dirty.
///
/// This means that if you have multiple widgets that are watching the same signal, only the first one will be subscribed to the signal and multiple updates will be batched together.
///
/// It is also possible to isolate the rebuilds with the `Builder` widget, however it is recommended to use `Watch` or `SignalWidget` instead.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   // Called once
///   return Column(
///     children: [
///       Builder(
///         builder: (context) {
///           // Called every time the signal changes
///           final count = signal.watch(context);
///           return Text('$count');
///         },
///       ),
///       Text('Not rebuilt'),
///     ],
///   );
/// }
/// ```
///
/// ## Selectors
///
/// With signals instead of using `select` you instead create a new `computed` signal that is derived from the original signal.
///
/// ```dart
/// final signal = signal((a: 1, b: 2));
/// final computed = computed(() => signal.value.a);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Watch((_) => Text('$computed'));
/// }
/// ```
///
/// It is also possible to select from the signal directly:
///
/// ```dart
/// final signal = signal((a: 1, b: 2));
/// final computed = signal.select((s) => s.value.a);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Watch((_) => Text('$computed'));
/// }
/// ```
/// @link https://dartsignals.dev/flutter/watch
/// {@endtemplate}
class Watch<T extends Widget> extends StatefulWidget {
  /// Minimal builder for signal changes that rerender a widget tree.
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

  /// Drop in replacement for the Flutter builder widget.
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

  /// The widget to rebuild when any signals change
  final T Function(BuildContext context) builder;

  /// Optional debug label to use for devtools
  final String? debugLabel;

  /// List of optional dependencies to watch
  final List<ReadonlySignal<dynamic>> dependencies;

  @override
  State<Watch<T>> createState() => _WatchState<T>();
}

class _WatchState<T extends Widget> extends State<Watch<T>> with SignalsMixin {
  late var result = this.createComputed(() => widget.builder(context));
  bool _init = true;

  @override
  void initState() {
    super.initState();
    for (final dep in widget.dependencies) {
      this.bindSignal(dep);
    }
  }

  // coverage:ignore-start
  @override
  void reassemble() {
    super.reassemble();
    final target = SignalsObserver.instance;
    if (target is DevToolsSignalsObserver) {
      target.reassemble();
    }
    print('hot reload! ${result.version}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      result.recompute();
      if (mounted) setState(() {});
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
  void didUpdateWidget(covariant Watch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dependencies != widget.dependencies) {
      for (final dep in oldWidget.dependencies) {
        final idx = widget.dependencies.indexOf(dep);
        if (idx == -1) unbindSignal(dep);
      }
      for (final dep in widget.dependencies) {
        this.bindSignal(dep);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return result.value;
  }
}
