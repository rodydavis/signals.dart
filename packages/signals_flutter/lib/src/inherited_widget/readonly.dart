import 'package:flutter/widgets.dart';

import '../../signals_core.dart';
import '../core/readonly.dart';

/// Signal notifier widget
class ReadonlySignalProvider<T>
    extends InheritedNotifier<FlutterReadonlySignal<T>> {
  /// Signal notifier widget
  const ReadonlySignalProvider({
    super.key,
    required super.child,
    required FlutterReadonlySignal<T> source,
  }) : super(notifier: source);

  /// Signal notifier with a set value
  ReadonlySignalProvider.value({
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
  static ReadonlySignalProvider<T>? providerOf<T>(
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
  static ReadonlySignal<T>? of<T>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance =
        ReadonlySignalProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
