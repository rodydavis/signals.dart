import 'dart:collection';
import 'dart:math';

import '../core/signals.dart';

part 'list.dart';
part 'map.dart';
part 'set.dart';
part 'queue.dart';
part 'iterable.dart';
part 'change_stack.dart';

/// Value Signal mixin (list/map/set)
mixin ValueSignalMixin<T> on Signal<T> {
  @override
  T get initialValue => initialValueException();

  /// Throw an error for access initial value
  static T initialValueException<T>() => throw Exception(
        'Initial value does not work on value signals '
        'since they hold a single reference',
      );

  @override
  T get previousValue => previousValueException();

  /// Throw an error for access previous value
  static T previousValueException<T>() => throw Exception(
        'Previous value does not work on value signals '
        'since they hold a single reference',
      );
}
