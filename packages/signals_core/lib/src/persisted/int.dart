import 'signal.dart';
import 'store.dart';

/// A `PersistedSignal` that stores an integer value.
class PersistedIntSignal extends PersistedSignal<int> {
  /// Creates a new `IntSignal`.
  PersistedIntSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  int decode(String value) => int.parse(value);

  @override
  String encode(int value) => value.toString();
}

/// A `PersistedSignal` that stores a nullable integer value.
class PersistedNullableIntSignal extends PersistedSignal<int?> {
  /// Creates a new `NullableIntSignal`.
  PersistedNullableIntSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  int? decode(String value) => value.isEmpty ? null : int.parse(value);

  @override
  String encode(int? value) => value?.toString() ?? '';
}
