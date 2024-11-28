part of 'watch.dart';

/// ## Watch
///
/// To watch a signal for changes in Flutter, use the `Watch` widget. This will only rebuild this widget method and not the entire widget tree.
///
/// ```dart
/// final signal = signal(10);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   return Watch((context, _) => Text('$signal'));
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
///     builder: (context, _) => Text('$signal'),
///   );
/// }
/// ```
class Watch<T extends Widget> extends StatelessWidget {
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
  final List<core.ReadonlySignal<dynamic>> dependencies;

  @override
  Widget build(BuildContext context) {
    return WatchBuilder(
      // key: key,
      builder: (context, _) => builder(context),
      debugLabel: debugLabel,
      dependencies: dependencies,
    );
  }
}
