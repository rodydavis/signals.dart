import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<bool>], enabling direct reactive logical conjunction (&), disjunction (|), and exclusive or (^) operations.
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// final a = true.$;
/// final b = false.$;
/// final andResult = a & b.value; // false
/// final orResult = a | b.value; // true
/// ```
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

/// Utility extension on [bool] to easily lift a boolean into a reactive [Signal].
extension SignalBoolExtensions on bool {
  /// Lift a primitive [bool] into a reactive [Signal<bool>].
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// final isEnabled = true.$;
  /// print(isEnabled.value); // true
  /// ```
  Signal<bool> get $ => signal<bool>(this);
}
