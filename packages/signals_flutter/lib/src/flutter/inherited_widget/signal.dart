import 'package:flutter/widgets.dart';

import '../../../signals_flutter.dart';

/// Convience method to pass signals with [InheritedWidget]
class SignalProvider<T> extends InheritedWidget {
  /// Convience method to pass signals with [InheritedWidget]
  const SignalProvider({
    super.key,
    required super.child,
    required this.instance,
  });

  /// Create a new [Signal] by value to provide in a widget tree
  SignalProvider.value({
    super.key,
    required super.child,
    required T value,
    String? debugLabel,
    bool autoDispose = false,
  }) : instance = signal<T>(
          value,
          debugLabel: debugLabel,
          autoDispose: autoDispose,
        );

  /// Internal signal instance
  final Signal<T> instance;

  /// Look up a singal by its type
  static Signal<T> of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SignalProvider<T>>()!
        .instance;
  }

  @override
  bool updateShouldNotify(SignalProvider<T> oldWidget) {
    return oldWidget.instance.globalId == instance.globalId &&
        oldWidget.instance.version != instance.version;
  }
}
