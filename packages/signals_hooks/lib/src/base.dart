import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_core.dart';

class SignalHook<T, S extends ReadonlySignal<T>> extends Hook<S> {
  const SignalHook(this.target, {super.keys});

  final S target;

  @override
  SignalHookState<T, S> createState() => SignalHookState();
}

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
  Object? get debugValue => hook.target.value;

  @override
  String get debugLabel => '${hook.target.runtimeType}';
}
