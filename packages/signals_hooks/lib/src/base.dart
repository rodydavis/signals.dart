import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart';

/// A custom [Hook] that registers a subscription on a [ReadonlySignal] or [Signal] instance.
///
/// Ensures the host [HookWidget] rebuilds when the signal emits changes, and
/// safely unsubscribes when the hook is updated or disposed.
class SignalHook<T, S extends ReadonlySignal<T>> extends Hook<S> {
  const SignalHook(this.target, {super.keys});

  final S target;

  @override
  SignalHookState<T, S> createState() => SignalHookState();
}

/// The active lifecycle state for [SignalHook], maintaining the underlying subscription disposer.
class SignalHookState<T, S extends ReadonlySignal<T>>
    extends HookState<S, SignalHook<T, S>> {
  void Function()? _cleanup;

  @override
  void initHook() {
    _listener();
    super.initHook();
  }

  @override
  void dispose() {
    _cleanup?.call();
    super.dispose();
  }

  void _listener() {
    _cleanup = hook.target.subscribe((_) {
      if (context.mounted) setState(() {});
    });
  }

  @override
  void didUpdateHook(SignalHook<T, S> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.target != oldHook.target) {
      _cleanup?.call();
      _listener();
    }
  }

  @override
  S build(BuildContext context) => hook.target;

  @override
  Object? get debugValue {
    if (hook.target.isInitialized) {
      try {
        return hook.target.value;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  String get debugLabel => '${hook.target.runtimeType}';
}
