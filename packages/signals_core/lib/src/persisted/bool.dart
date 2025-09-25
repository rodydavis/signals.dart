import 'signal.dart';
import 'store.dart';

/// A `PersistedSignal` that stores a boolean value.
class PersistedBoolSignal extends PersistedSignal<bool> {
  /// Creates a new `BoolSignal`.
  PersistedBoolSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  bool decode(String value) => value.toLowerCase() == 'true';

  @override
  String encode(bool value) => value.toString();
}

/// A `PersistedSignal` that stores a nullable string value.
class PersistedPersistedBoolSignal extends PersistedSignal<bool?> {
  /// Creates a new `PersistedBoolSignal`.
  PersistedPersistedBoolSignal(
    super.val,
    String key, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  bool? decode(String value) =>
      value.isEmpty ? null : value.toLowerCase() == 'true';

  @override
  String encode(bool? value) => value?.toString() ?? '';
}
