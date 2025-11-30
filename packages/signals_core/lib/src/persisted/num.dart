import 'signal.dart';
import 'store.dart';

/// A `PersistedSignal` that stores a numeric value.
class PersistedNumSignal extends PersistedSignal<num> {
  /// Creates a new `NumSignal`.
  PersistedNumSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  num decode(String value) => num.parse(value);

  @override
  String encode(num value) => value.toString();
}

/// A `PersistedSignal` that stores a nullable numeric value.
class PersistedNullableNumSignal extends PersistedSignal<num?> {
  /// Creates a new `NullableNumSignal`.
  PersistedNullableNumSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  num? decode(String value) => value.isEmpty ? null : num.parse(value);

  @override
  String encode(num? value) => value?.toString() ?? '';
}
