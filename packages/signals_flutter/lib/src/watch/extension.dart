part of 'watch.dart';

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  core.ReadonlySignal<T> signal, {
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
    final key = identityHashCode(ctx);
    if (_elementRefs[key] == null) {
      final label = [
        'widget',
        ctx.widget.runtimeType.toString(),
        identityHashCode(ctx.widget).toString(),
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
void unwatchSignal<T>(BuildContext context, core.ReadonlySignal<T> signal) {
  final ctx = context;
  if (ctx.widget is Watch) return;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      return state.unwatchSignal(signal);
    }
  }
  final key = identityHashCode(ctx);
  _elementRefs.remove(key)?.unwatch(signal);
}
