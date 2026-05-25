part of 'signals.dart';

/// Previous state of a [LinkedSignal], containing both the [source] value
/// and the computed [value] from that source version.
class LinkedSignalPreviousState<T, S> {
  /// The source value.
  final S source;

  /// The computed value.
  final T value;

  /// Creates a [LinkedSignalPreviousState].
  LinkedSignalPreviousState(this.source, this.value);
}

/// A writable computed signal that derives its value from a source,
/// but allows manual overrides. Whenever the source changes, the value
/// is reset back to the computed default.
class LinkedSignal<T, S> extends Signal<T> {
  final S Function() _source;
  final T Function(S source, LinkedSignalPreviousState<T, S>? previous)
      _computation;
  final bool Function(S a, S b) _equalityCheck;

  bool _hasLastSourceValue = false;
  S? _lastSourceValue;
  T? _lastValue;

  bool _hasOverride = false;
  T? _overrideValue;

  late final Signal<int> _trigger;
  late final Computed<T> _derivedComputed;
  late final Computed<S> _sourceComputed;
  void Function()? _cleanupSubscription;

  /// Creates a new [LinkedSignal].
  LinkedSignal({
    required S Function() source,
    required T Function(S source, LinkedSignalPreviousState<T, S>? previous)
        computation,
    bool Function(S a, S b)? equalityCheck,
    super.debugLabel,
    super.autoDispose = false,
  })  : _source = source,
        _computation = computation,
        _equalityCheck = equalityCheck ?? identical,
        super.lazy() {
    _trigger = signal(0);
    _sourceComputed = computed(_source);

    _derivedComputed = computed(() {
      // Register dependency on the override trigger
      _trigger.value;

      final sourceVal = _sourceComputed.value;

      final sourceChanged = !_hasLastSourceValue ||
          !_equalityCheck(sourceVal, _lastSourceValue as S);

      if (sourceChanged) {
        final prev = _hasLastSourceValue
            ? LinkedSignalPreviousState<T, S>(
                _lastSourceValue as S,
                _lastValue as T,
              )
            : null;

        final defaultValue = _computation(sourceVal, prev);
        _lastSourceValue = sourceVal;
        _hasLastSourceValue = true;
        _lastValue = defaultValue;
        _hasOverride = false;
        return defaultValue;
      }

      if (_hasOverride) {
        return _overrideValue as T;
      }

      return _lastValue as T;
    });

    // Subscribe to synchronize the values immediately and on every update
    _cleanupSubscription = _derivedComputed.subscribe((val) {
      super.set(val, force: true);
    });
  }

  @override
  bool set(T val, {bool force = false}) {
    if (disposed) {
      throw SignalsWriteAfterDisposeError(this);
    }
    _overrideValue = val;
    _lastValue = val;
    _hasOverride = true;
    _trigger.value++;
    return true;
  }

  @override
  T get value {
    if (disposed) {
      throw SignalsReadAfterDisposeError(this);
    }
    return super.value;
  }

  @override
  set value(T val) {
    set(val);
  }

  @override
  void dispose() {
    _cleanupSubscription?.call();
    _sourceComputed.dispose();
    _derivedComputed.dispose();
    _trigger.dispose();
    super.dispose();
  }
}

/// Creates a shorthand basic [LinkedSignal] that resets to its computed source
/// value whenever its dependencies change, but allows manual edits.
LinkedSignal<T, T> linkedSignal<T>(
  T Function() source, {
  bool Function(T a, T b)? equalityCheck,
  String? debugLabel,
  bool autoDispose = false,
}) {
  return LinkedSignal<T, T>(
    source: source,
    computation: (sourceVal, _) => sourceVal,
    equalityCheck: equalityCheck,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Creates a custom [LinkedSignal] with explicit source and computation logic.
LinkedSignal<T, S> linkedSignalOptions<T, S>({
  required S Function() source,
  required T Function(S source, LinkedSignalPreviousState<T, S>? previous)
      computation,
  bool Function(S a, S b)? equalityCheck,
  String? debugLabel,
  bool autoDispose = false,
}) {
  return LinkedSignal<T, S>(
    source: source,
    computation: computation,
    equalityCheck: equalityCheck,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
