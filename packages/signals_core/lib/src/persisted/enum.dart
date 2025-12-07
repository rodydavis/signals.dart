import 'signal.dart';
import 'store.dart';

mixin _EnumPersistedSignal<T extends Enum> {
  /// The possible values of the enum.
  List<T> get values;

  T? _get(String? name) {
    if (name != null && name.isNotEmpty) {
      for (final v in values) {
        if (v.name == name) return v;
      }
    }
    return null;
  }
}

/// A `PersistedSignal` that stores an enum value.
class PersistedEnumSignal<T extends Enum> extends PersistedSignal<T>
    with _EnumPersistedSignal<T> {
  /// Creates a new `EnumSignal`.
  PersistedEnumSignal(
    super.val,
    String key,
    this.values, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  final List<T> values;

  @override
  T decode(String value) => _get(value)!;

  @override
  String encode(T value) => value.name;
}

/// A `PersistedSignal` that stores a nullable enum value.
class PersistedNullableEnumSignal<T extends Enum> extends PersistedSignal<T?>
    with _EnumPersistedSignal<T> {
  /// Creates a new `NullableEnumSignal`.
  PersistedNullableEnumSignal(
    super.val,
    String key,
    this.values, {
    SignalsKeyValueStore? store,
  }) : super(
          key: key,
          store: store ?? SignalsKeyValueStore.defaultStore,
        );

  @override
  final List<T> values;

  @override
  T? decode(String value) => _get(value);

  @override
  String encode(T? value) => value?.name ?? '';
}
