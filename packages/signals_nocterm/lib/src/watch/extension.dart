part of 'watch.dart';

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  core.ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  final ctx = context;
  if (ctx.component is Watch) return signal.value;
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
        'component',
        ctx.component.runtimeType.toString(),
        identityHashCode(ctx.component).toString(),
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
  if (ctx.component is Watch) return;
  if (ctx is StatefulElement) {
    final state = ctx.state;
    if (state is SignalsMixin) {
      return state.unwatchSignal(signal);
    }
  }
  final key = identityHashCode(ctx);
  _elementRefs.remove(key)?.unwatch(signal);
}

/// Extension on [core.ReadonlySignal] to provide [watch] and [unwatch] methods.
extension SignalWatchExtension<T> on core.ReadonlySignal<T> {
  /// Watch a signal value and rebuild the context of the [Element]
  /// if mounted and mark it as dirty.
  ///
  /// ```dart
  /// final count = signal(0);
  ///
  /// @override
  /// Component build(BuildContext context) {
  ///   final value = count.watch(context);
  ///   return Text('Count: $value');
  /// }
  /// ```
  T watch(BuildContext context, {String? debugLabel}) {
    return watchSignal(context, this, debugLabel: debugLabel);
  }

  /// Unwatch a signal value and stop rebuilding the context.
  void unwatch(BuildContext context) {
    unwatchSignal(context, this);
  }
}
