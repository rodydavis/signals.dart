import 'package:flutter/widgets.dart';

import '../core/signal.dart';

/// Signal notifier widget
class SignalProvider<T extends FlutterSignal> extends InheritedNotifier<T> {
  /// Signal notifier widget
  SignalProvider({
    super.key,
    required super.child,
    required T Function() create,
  }) : super(notifier: create());

  /// Find widget in tree
  static SignalProvider<T>? providerOf<T extends FlutterSignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<SignalProvider<T>>();
    } else {
      return context.findAncestorWidgetOfExactType<SignalProvider<T>>();
    }
  }

  /// Find signal in widget tree
  static T? of<T extends FlutterSignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance = SignalProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
