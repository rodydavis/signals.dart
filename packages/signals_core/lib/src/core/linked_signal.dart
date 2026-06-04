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

/// {@template linked_signal}
/// A highly powerful, mutable computed signal that derives its default value from an underlying source,
/// but allows manual write overrides. Crucially, **whenever the underlying source value changes, the signal**
/// **automatically discards any local manual overrides and resets back to the newly computed default.**
///
/// This hybrid behavior is the perfect solution for synchronizing local edit state with external remote state.
///
/// ### 1. Real-World Use Case: Profile Form Editor
/// Imagine you are building a profile editor where the user can modify their username:
/// - The initial/remote username is fetched from a database and held in a source signal.
/// - The text input field is bound to a local signal.
/// - The user should be able to edit the field locally (overriding the remote default).
/// - If the selected user changes (e.g., they switch to a different profile in a list), the text field must automatically discard any local changes and reset to the new user's username.
///
/// ```dart
/// // The remote/source state
/// final selectedUser = signal(User(id: 1, name: 'Alice'));
///
/// // The local editable state linked to the remote source
/// final username = linkedSignal(() => selectedUser.value.name);
///
/// print(username.value); // 'Alice'
///
/// // User edits the text field:
/// username.value = 'Bob';
/// print(username.value); // 'Bob' (local override active)
///
/// // Switch remote profile:
/// selectedUser.value = User(id: 2, name: 'Charlie');
///
/// // Local overrides are discarded and reset to the new source:
/// print(username.value); // 'Charlie'
/// ```
///
/// ### 2. Custom Computations using `LinkedSignalOptions`
/// By default, a linked signal directly passes the source value through. You can customize this mapping using a custom `computation` function that has access to both the current source value and the previous state:
///
/// ```dart
/// final counter = signal(10);
///
/// final doubled = linkedSignal(
///   () => counter.value,
///   options: LinkedSignalOptions(
///     computation: (sourceVal, prev) {
///       print('Source changed to $sourceVal. Previous value was: ${prev?.value}');
///       return sourceVal * 2;
///     },
///   ),
/// );
/// ```
///
/// ### 3. Custom Source Equality
/// To prevent unnecessary resets, you can supply a custom `sourceEquality` callback. The signal will only reset when the equality check returns `false`:
///
/// ```dart
/// final selectedUser = signal(User(id: 1, name: 'Alice'));
///
/// final username = linkedSignal(
///   () => selectedUser.value,
///   options: LinkedSignalOptions(
///     // Only reset when the user ID actually changes:
///     sourceEquality: (a, b) => a.id == b.id,
///   ),
/// );
/// ```
///
/// <Info>
///   Always use `LinkedSignal` rather than manual `effect` listeners to synchronize local editable values with remote defaults. It is simpler, avoids race conditions, and consumes significantly less memory.
/// </Info>
/// {@endtemplate}
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

/// {@macro linked_signal}
LinkedSignal<T, S> linkedSignal<T, S>(
  S Function() source, {
  LinkedSignalOptions<T, S>? options,
}) {
  return LinkedSignal<T, S>(
    source: source,
    options: options,
  );
}
