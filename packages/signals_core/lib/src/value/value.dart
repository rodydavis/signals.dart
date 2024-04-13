import 'dart:collection';
import 'dart:math';

import '../core/signals.dart';

part 'list.dart';
part 'map.dart';
part 'set.dart';
part 'iterable.dart';
part 'change_stack.dart';

/// Value Signal mixin (list/map/set)
mixin ValueSignalMixin<T> on Signal<T> {
  @override
  T get initialValue => initialValueExcpetion();

  /// Throw an error for access initial value
  static T initialValueExcpetion<T>() => throw Exception(
        'Initial value does not work on value signals '
        'since they hold a single reference',
      );

  @override
  T get previousValue => previousValueExcpetion();

  /// Throw an error for access previous value
  static T previousValueExcpetion<T>() => throw Exception(
        'Previous value does not work on value signals '
        'since they hold a single reference',
      );
}
