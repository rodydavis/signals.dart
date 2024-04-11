part of 'watch.dart';

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  if (context.widget is Watch) return signal.value;
  if (context is Element) {
    final key = context.hashCode;
    if (_elementRefs[key] == null) {
      final label =
          'widget=${context.widget.runtimeType}:${context.widget.hashCode}';
      final watcher = ElementWatcher(
        key,
        label,
        WeakReference(context),
      );
      _elementRefs[key] = watcher;
      _removeSignalWatchers();
    }
    _elementRefs[key]?.watch(signal);
  }
  // Grab the current value without subscribing
  return signal.peek();
}

/// Remove all subscribers for a given signal for watchers
void unwatchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  if (context.widget is Watch) return;
  final key = context.hashCode;
  _elementRefs.remove(key)?.unwatch(signal);
}

/// Used to listen for updates on a signal but not rebuild the nearest element
///
/// ```dart
/// final counter = signal(0);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   listenSignal(context, counter, () {
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
void listenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  void Function() callback, {
  String? debugLabel,
}) {
  if (context is Element) {
    final key = context.hashCode;
    if (_elementRefs[key] == null) {
      final label =
          'widget=${context.widget.runtimeType}:${context.widget.hashCode}';
      final watcher = ElementWatcher(key, label, WeakReference(context));
      _elementRefs[key] = watcher;
      _removeSignalWatchers();
    }
    _elementRefs[key]?.listen(signal, callback);
  }
}

/// Remove all subscribers for a given signal for watchers
void unlistenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  void Function() callback, {
  String? debugLabel,
}) {
  final key = context.hashCode;
  _elementRefs.remove(key)?.unlisten(signal, callback);
}
