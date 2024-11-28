import 'package:flutter/widgets.dart';

import '../core/readonly.dart';
import '../core/signal.dart';

/// Signal notifier widget
class SignalProvider<T extends FlutterReadonlySignal>
    extends InheritedNotifier<T> {
  /// Signal notifier widget
  SignalProvider({
    super.key,
    required T Function() create,
    required super.child,
  }) : _setup = create;

  final T Function() _setup;

  @override
  // ignore: overridden_fields
  late final T notifier = _setup();

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
