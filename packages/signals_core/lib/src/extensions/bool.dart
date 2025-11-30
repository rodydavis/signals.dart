import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<bool>]
extension BoolSignalExtension on ReadonlySignal<bool> {
  /// The logical conjunction ("and") of this and [other].
  ///
  /// Returns `true` if both this and [other] are `true`, and `false` otherwise.
  bool operator &(bool other) => other & value;

  /// The logical disjunction ("inclusive or") of this and [other].
  ///
  /// Returns `true` if either this or [other] is `true`, and `false` otherwise.
  bool operator |(bool other) => other | value;

  /// The logical exclusive disjunction ("exclusive or") of this and [other].
  ///
  /// Returns whether this and [other] are neither both `true` nor both `false`.
  bool operator ^(bool other) => other ^ value;
}

/// Extensions for [bool]
extension SignalBoolExtensions on bool {
  /// Return a signal from a bool value
  Signal<bool> get $ => signal<bool>(this);
}
