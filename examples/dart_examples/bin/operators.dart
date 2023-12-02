import 'package:collection/collection.dart';
import 'package:signals/signals.dart';

/// Operators on Signals Collection
/// Combine Data Flow
void main() {
  final deepEq = const DeepCollectionEquality().equals;

  final s0 = [0, 1, 2].toSignal();

  // s1 fork s0 and add new values
  final s1 = s0 & [3, 4, 5];

  assert(deepEq(s0, [0, 1, 2]));
  assert(deepEq(s1, [0, 1, 2, 3, 4, 5]));

  // s0 got injected new values
  s0 << [3, 4, 5];

  assert(deepEq(s0, [0, 1, 2, 3, 4, 5]));

  final s4 = ['s', 'i', 'g'].toSignal();
  final s5 = ['n', 'a', 'l'].toSignal();

  // s6 is a new signal
  final s6 = s4 | s5;

  assert(deepEq(s6, ['s', 'i', 'g', 'n', 'a', 'l']));
}
