part of 'signals.dart';

/// Simple writeable signal
class Signal<T> extends signals.Signal<T>
    with ReadonlySignalMixin<T>, SignalsAutoDisposeMixin<T>
    implements ReadonlySignal<T> {
  /// Simple writeable signal.
  ///
  /// ```dart
  /// final count = signal(0);
  /// print(count.value); // 0
  /// count.value++;
  /// print(count.value); // 1
  /// ```
  Signal(
    T value, {
    SignalOptions<T>? options,
  }) : super(value, options) {
    autoDispose = options?.autoDispose ?? false;
    afterCreate(value);
    _initAutoDispose();
  }

  /// Lazy signal that can be created with type T that
  /// the value will be assigned later.
  ///
  /// ```dart
  /// final db = Signal.lazy<DatabaseConnection>();
  /// ...
  /// db.value = DatabaseConnect(...);
  /// ```
  Signal.lazy({
    SignalOptions<T>? options,
  }) : super.lazy(
          options,
        ) {
    autoDispose = options?.autoDispose ?? false;
  }

  @override
  void afterCreate(T val) {
    SignalsObserver.instance?.onSignalCreated(this, val);
    isInitialized = true;
  }

  @override
  void beforeUpdate(T val) {
    SignalsObserver.instance?.onSignalUpdated(this, val);
  }

  @override
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (disposed) {
      throw SignalsWriteAfterDisposeError(this);
    }
    if (force || !isInitialized) {
      beforeUpdate(val);
      internalSetValue(val);
      return true;
    }
    final isEqual = equalityCheck.equals(val, internalValue);
    if (!isEqual) {
      beforeUpdate(val);
      internalSetValue(val);
      return true;
    }
    return false;
  }

  @override
  T get value {
    if (!isInitialized) {
      throw LazySignalInitializationError(this);
    }
    if (disposed) {
      if (kDebugMode) {
        print(
          'signal warning: [$globalId|$name] has been '
          'read after disposed: ${StackTrace.current}',
        );
      }
    }
    return super.value;
  }

  /// Returns a readonly signal
  ReadonlySignal<T> readonly() => this;

  /// Override the current signal with a new value as if it was created with it
  ///
  /// This does not trigger any updates
  ///
  /// ```dart
  /// var counter = signal(0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  Signal<T> overrideWith(T val) {
    version = 0;
    afterCreate(val);
    internalValue = val;
    return this;
  }
}

/// Create a `signal<T>`
Signal<T> signal<T>(
  T value, {
  SignalOptions<T>? options,
}) {
  return Signal<T>(
    value,
    options: options,
  );
}

/// Lazy signal that can be created with type T that
/// the value will be assigned later.
///
/// ```dart
/// final db = lazySignal<DatabaseConnection>();
/// ...
/// db.value = DatabaseConnect(...);
/// ```
Signal<T> lazySignal<T>([
  SignalOptions<T>? options,
]) {
  return Signal<T>.lazy(
    options: options,
  );
}
