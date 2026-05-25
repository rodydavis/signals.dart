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

/// Options for creating a [LinkedSignal].
class LinkedSignalOptions<T, S> extends SignalOptions<T> {
  /// Custom computation logic that runs when the source changes.
  final T Function(S source, LinkedSignalPreviousState<T, S>? previous)?
      computation;

  /// Optional equality check for the source values.
  final bool Function(S a, S b)? sourceEquality;

  /// Creates [LinkedSignalOptions].
  LinkedSignalOptions({
    this.computation,
    this.sourceEquality,
    super.name,
    super.autoDispose,
  });

  @override
  LinkedSignalOptions<T, S> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    T Function(S source, LinkedSignalPreviousState<T, S>? previous)?
        computation,
    bool Function(S a, S b)? sourceEquality,
  }) {
    return LinkedSignalOptions<T, S>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      computation: computation ?? this.computation,
      sourceEquality: sourceEquality ?? this.sourceEquality,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinkedSignalOptions<T, S> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched &&
        other.computation == computation &&
        other.sourceEquality == sourceEquality;
  }

  @override
  int get hashCode => Object.hash(
        name,
        autoDispose,
        watched,
        unwatched,
        computation,
        sourceEquality,
      );
}

/// A writable computed signal that derives its value from a source,
/// but allows manual overrides. Whenever the source changes, the value
/// is reset back to the computed default.
class LinkedSignal<T, S> extends Signal<T> {
  final S Function() _source;
  final T Function(S source, LinkedSignalPreviousState<T, S>? previous)
      _computation;
  final bool Function(S a, S b) _sourceEquality;

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
    LinkedSignalOptions<T, S>? options,
  })  : _source = source,
        _computation =
            options?.computation ?? ((sourceVal, _) => sourceVal as T),
        _sourceEquality = options?.sourceEquality ?? identical,
        super.lazy(options: options) {
    _trigger = signal(0);
    _sourceComputed = computed(_source);

    _derivedComputed = computed(() {
      // Register dependency on the override trigger
      _trigger.value;

      final sourceVal = _sourceComputed.value;

      final sourceChanged = !_hasLastSourceValue ||
          !_sourceEquality(sourceVal, _lastSourceValue as S);

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

/// Creates a [LinkedSignal] that derives its value from a source,
/// but allows manual overrides. Whenever the source changes, the value
/// is reset back to the computed default.
LinkedSignal<T, S> linkedSignal<T, S>(
  S Function() source, {
  LinkedSignalOptions<T, S>? options,
}) {
  return LinkedSignal<T, S>(
    source: source,
    options: options,
  );
}
