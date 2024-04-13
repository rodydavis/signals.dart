import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';

/// Convience method to pass signals with [InheritedWidget]
class ComputedProvider<T> extends InheritedWidget {
  /// Convience method to pass signals with [InheritedWidget]
  const ComputedProvider({
    super.key,
    required super.child,
    required this.instance,
  });

  /// Internal signal instance
  final Computed<T> instance;

  /// Create a new [Computed] by value to provide in a widget tree
  ComputedProvider.value({
    super.key,
    required super.child,
    required T Function() compute,
    String? debugLabel,
    bool autoDispose = false,
  }) : instance = computed<T>(
          compute,
          debugLabel: debugLabel,
          autoDispose: autoDispose,
        );

  /// Look up a singal by its type
  static Computed<T> of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ComputedProvider<T>>()!
        .instance;
  }

  @override
  bool updateShouldNotify(ComputedProvider<T> oldWidget) {
    return oldWidget.instance.globalId == instance.globalId &&
        oldWidget.instance.version != instance.version;
  }
}
