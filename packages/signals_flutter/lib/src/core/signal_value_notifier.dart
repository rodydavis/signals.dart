part of 'signal_value_listenable.dart';

/// [Signal] + [ValueNotifier]
class SignalValueNotifier<T>
    extends SignalValueListenable<T, ValueNotifier<T>, Signal<T>>
    implements ValueNotifier<T>, WrappedSignal<T> {
  /// [SignalValueListenable] from value
  SignalValueNotifier(
    T val, {
    String? debugLabel,
    bool autoDispose = false,
  }) : super.merge(
          ValueNotifier<T>(val),
          signal<T>(
            val,
            debugLabel: debugLabel,
            autoDispose: autoDispose,
          ),
        );

  /// Merge [ValueNotifier] and [Signal]
  SignalValueNotifier.merge(super.notifier, super.source) : super.merge();

  /// [SignalValueNotifier] from [Signal]
  SignalValueNotifier.fromSignal(Signal<T> val)
      : super.merge(
          ValueNotifier<T>(val.value),
          val,
        );

  /// [SignalValueNotifier] from [ValueNotifier]
  SignalValueNotifier.fromValueNotifier(
    ValueNotifier<T> val, {
    String? debugLabel,
    bool autoDispose = false,
  }) : super.merge(
          val,
          signal<T>(
            val.value,
            debugLabel: debugLabel,
            autoDispose: autoDispose,
          ),
        );

  @override
  bool get hasListeners => notifier.hasListeners;

  @override
  void notifyListeners() => notifier.notifyListeners();

  @override
  set value(T newValue) {
    source.value = newValue;
  }

  @override
  void forceUpdate([T? val]) {
    return source.forceUpdate(val);
  }

  @override
  Signal<T> overrideWith(T value) {
    return source.overrideWith(value);
  }

  @override
  ReadonlySignal<T> readonly() {
    return source.readonly();
  }

  @override
  void set(T val, {bool force = false}) {
    return source.set(val, force: force);
  }
}

/// [Signal] + [ValueNotifier]
SignalValueNotifier<T> signalValueNotifier<T>(
  T val, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return SignalValueNotifier<T>(
    val,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
