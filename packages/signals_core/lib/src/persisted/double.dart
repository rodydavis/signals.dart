import 'signal.dart';
import 'store.dart';

/// A `PersistedSignal` that stores an double value.
class PersistedDoubleSignal extends PersistedSignal<double> {
  /// Creates a new `DoubleSignal`.
  PersistedDoubleSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  double decode(String value) => double.parse(value);

  @override
  String encode(double value) => value.toString();
}

/// A `PersistedSignal` that stores a nullable double value.
class PersistedNullableDoubleSignal extends PersistedSignal<double?> {
  /// Creates a new `NullableDoubleSignal`.
  PersistedNullableDoubleSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  double? decode(String value) => value.isEmpty ? null : double.parse(value);

  @override
  String encode(double? value) => value?.toString() ?? '';
}
