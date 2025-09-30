import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Enum>]
extension EnumSignalExtension on ReadonlySignal<Enum> {
  /// A numeric identifier for the enumerated value.
  ///
  /// The values of a single enumeration are numbered
  /// consecutively from zero to one less than the
  /// number of values.
  /// This is also the index of the value in the
  /// enumerated type's static `values` list.
  int get index => value.index;

  /// The name of the enum value.
  ///
  /// The name is a string containing the source identifier used
  /// to declare the enum value.
  ///
  /// For example, given a declaration like:
  /// ```dart
  /// enum MyEnum {
  ///   value1,
  ///   value2
  /// }
  /// ```
  /// the result of `MyEnum.value1.name` is the string `"value1"`.
  String get name => value.name;
}

/// Extensions for [Enum]
extension SignalEnumExtensions<T extends Enum> on T {
  /// Return a signal from a Enum value
  Signal<T> get $ => signal<T>(this);
}
