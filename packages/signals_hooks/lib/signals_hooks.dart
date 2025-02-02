library signals_hooks;

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// Bind an existing signal to the hook widget
T useExistingSignal<T extends ReadonlySignal>(T value) {
  final target = useMemoized(() => value, []);
  return use(_SignalHook('useExistingSignal', target));
}

/// Create a new signal
FlutterSignal<T> useSignal<T>(T value) {
  final target = useMemoized(() => signal(value), []);
  return use(_SignalHook('useSignal', target));
}

/// Create a new computed signal
FlutterComputed<T> useComputed<T>(T Function() cb) {
  final instance = useRef(cb);
  instance.value = cb;
  final target = useMemoized(() => computed<T>(() => instance.value()), []);
  return use(_SignalHook('useComputed', target));
}

/// Create a signal effect
void useSignalEffect(dynamic Function() cb) {
  final instance = useRef(cb);
  instance.value = cb;
  useEffect(() => effect(instance.value), []);
  return;
}

class _SignalHook<T, S extends ReadonlySignal<T>> extends Hook<S> {
  const _SignalHook(this.type, this.initialData);

  final String type;
  final S initialData;

  @override
  _SignalHookState<T, S> createState() => _SignalHookState();
}

class _SignalHookState<T, S extends ReadonlySignal<T>>
    extends HookState<S, _SignalHook<T, S>> {
  late final _instance = hook.initialData;
  void Function()? _cleanup;

  @override
  void initHook() {
    _cleanup = effect(() {
      _instance.value;
      setState(() {});
    });
    super.initHook();
  }

  @override
  void dispose() {
    _cleanup?.call();
  }

  @override
  S build(BuildContext context) => _instance;

  @override
  Object? get debugValue => _instance.value;

  @override
  String get debugLabel => '${hook.type}<$T>';
}
