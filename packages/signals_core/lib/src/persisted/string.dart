import 'signal.dart';
import 'store.dart';

/// A `PersistedSignal` that stores a string value.
class PersistedStringSignal extends PersistedSignal<String> {
  /// Creates a new `StringSignal`.
  PersistedStringSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  String decode(String value) => value;

  @override
  String encode(String value) => value;
}

/// A `PersistedSignal` that stores a nullable string value.
///
/// > [!warning] An empty value is considered null
class PersistedNullableStringSignal extends PersistedSignal<String?> {
  /// Creates a new `NullableStringSignal`.
  PersistedNullableStringSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  String? decode(String value) => value.isEmpty ? null : value;

  @override
  String encode(String? value) => value?.toString() ?? '';
}
