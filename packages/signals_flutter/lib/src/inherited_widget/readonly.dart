import 'package:flutter/widgets.dart';

import '../core/readonly.dart';

/// ReadonlySignal notifier widget
class ReadonlySignalProvider<T extends FlutterReadonlySignal>
    extends InheritedNotifier<T> {
  /// ReadonlySignal notifier widget
  ReadonlySignalProvider({
    super.key,
    required super.child,
    required T Function() create,
  }) : super(notifier: create());

  /// Find widget in tree
  static ReadonlySignalProvider<T>? providerOf<T extends FlutterReadonlySignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<ReadonlySignalProvider<T>>();
    } else {
      return context.findAncestorWidgetOfExactType<ReadonlySignalProvider<T>>();
    }
  }

  /// Find signal in widget tree
  static T? of<T extends FlutterReadonlySignal>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance =
        ReadonlySignalProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
