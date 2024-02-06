import 'dart:async';

import '../core/signals.dart';
import 'signal.dart';
import 'state.dart';

class StreamSignal<T> extends AsyncSignal<T> {
  late final Computed<Stream<T>> _stream;
  bool _fetching = false;
  final bool? cancelOnError;
  StreamSubscription<T>? _subscription;
  final void Function()? _onDone;
  bool _done = false;
  bool get isDone => _done;
  final List<ReadonlySignal<dynamic>> dependencies;
  EffectCleanup? _cleanup;

  Future<T> get last => _stream.value.last;
  Future<T> get first => _stream.value.first;

  StreamSignal(
    Stream<T> Function() callback, {
    this.cancelOnError,
    super.debugLabel,
    super.equality,
    T? initialValue,
    this.dependencies = const [],
    void Function()? onDone,
    bool lazy = true,
    super.autoDispose,
  })  : _onDone = onDone,
        super(initialValue != null
            ? AsyncState.data(initialValue)
            : AsyncState.loading()) {
    _stream = computed(
      () {
        for (final dep in dependencies) {
          dep.value;
        }
        return callback();
      },
      equality: identical,
    );
    if (!lazy) value;
  }

  Future<void> execute(Stream<T> src) async {
    if (_done || _fetching) return;
    _fetching = true;
    try {
      _subscription = src.listen(
        setValue,
        onError: setError,
        onDone: _finish,
        cancelOnError: cancelOnError,
      );
    } catch (error, stackTrace) {
      setError(error, stackTrace);
      if (cancelOnError ?? true) {
        _finish();
      }
    }
  }

  void _finish() async {
    _done = true;
    _onDone?.call();
    await _subscription?.cancel();
    _subscription = null;
  }

  bool get isPaused => _subscription?.isPaused ?? false;

  void pause([Future<void>? resume]) {
    _subscription?.pause(resume);
    set(value, force: true);
  }

  void resume() {
    _subscription?.resume();
    set(value, force: true);
  }

  Future<void> cancel() async {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> reload() async {
    super.reload();
    _stream.recompute();
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    await execute(_stream.value);
  }

  @override
  Future<void> refresh() async {
    super.refresh();
    _stream.recompute();
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    await execute(_stream.value);
  }

  @override
  void reset([AsyncState<T>? value]) {
    super.reset(value);
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _cleanup?.call();
    _subscription?.cancel();
    reset();
  }

  @override
  AsyncState<T> get value {
    _cleanup ??= _stream.subscribe((src) {
      reset();
      execute(src);
    });
    return super.value;
  }
}

StreamSignal<T> streamSignal<T>(
  Stream<T> Function() callback, {
  T? initialValue,
  String? debugLabel,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  SignalEquality<AsyncState<T>>? equality,
  void Function()? onDone,
  bool? cancelOnError,
  bool lazy = true,
  bool autoDispose = false,
}) {
  return StreamSignal(
    callback,
    initialValue: initialValue,
    debugLabel: debugLabel,
    dependencies: dependencies,
    equality: equality,
    onDone: onDone,
    cancelOnError: cancelOnError,
    lazy: lazy,
    autoDispose: autoDispose,
  );
}
