part of 'watch.dart';

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
@Deprecated('use SignalsMixin in StatefulWidget or Watch in StatelessWidget')
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  final ctx = context;
  if (ctx.widget is Watch) return signal.value;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      return state.watchSignal(signal);
    }
  }
  if (ctx is Element) {
    final key = ctx.hashCode;
    if (_elementRefs[key] == null) {
      final label = [
        'widget',
        ctx.widget.runtimeType.toString(),
        ctx.widget.hashCode.toString(),
      ].join('=');
      final watcher = ElementWatcher(
        key,
        label,
        WeakReference(ctx),
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
@Deprecated('use SignalsMixin in StatefulWidget or Watch in StatelessWidget')
void unwatchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  final ctx = context;
  if (ctx.widget is Watch) return;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      return state.unwatchSignal(signal);
    }
  }
  final key = ctx.hashCode;
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
@Deprecated('use SignalsMixin in StatefulWidget')
void listenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  void Function() callback, {
  String? debugLabel,
}) {
  final ctx = context;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      state.listenSignal(signal, callback, debugLabel: debugLabel);
      return;
    }
  }
  if (ctx is Element) {
    final key = ctx.hashCode;
    if (_elementRefs[key] == null) {
      final label = [
        'widget',
        ctx.widget.runtimeType.toString(),
        ctx.widget.hashCode.toString(),
      ].join('=');
      final watcher = ElementWatcher(key, label, WeakReference(ctx));
      _elementRefs[key] = watcher;
      _removeSignalWatchers();
    }
    _elementRefs[key]?.listen(signal, callback);
  }
}

/// Remove all subscribers for a given signal for watchers
@Deprecated('use SignalsMixin in StatefulWidget')
void unlistenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  void Function() callback, {
  String? debugLabel,
}) {
  final ctx = context;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      state.unlistenSignal(signal, callback);
      return;
    }
  }
  final key = ctx.hashCode;
  _elementRefs.remove(key)?.unlisten(signal, callback);
}
