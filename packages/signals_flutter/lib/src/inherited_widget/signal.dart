import 'package:flutter/widgets.dart';

import '../../signals_core.dart';
import '../core/signal.dart';

/// Signal notifier widget
class SignalProvider<T> extends InheritedNotifier<FlutterSignal<T>> {
  /// Signal notifier widget
  SignalProvider({
    super.key,
    required super.child,
    required FlutterSignal<T> Function() create,
  }) : super(notifier: create());

  /// Signal notifier with a set value
  SignalProvider.value({
    super.key,
    required super.child,
    required T value,
    String? debugLabel,
    bool autoDispose = false,
  }) : super(
          notifier: signal<T>(
            value,
            debugLabel: debugLabel,
            autoDispose: autoDispose,
          ),
        );

  /// Find widget in tree
  static SignalProvider<T>? providerOf<T>(
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
  static Signal<T>? of<T>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance = SignalProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
