import 'package:flutter/widgets.dart';

import '../../signals_core.dart';
import '../core/computed.dart';

/// Computed notifier widget
class ComputedProvider<T> extends InheritedNotifier<FlutterComputed<T>> {
  /// Computed notifier widget
  ComputedProvider({
    super.key,
    required super.child,
    required FlutterComputed<T> Function() create,
  }) : super(notifier: create());

  /// Signal notifier with a set value
  ComputedProvider.value({
    super.key,
    required super.child,
    required T Function() compute,
    String? debugLabel,
    bool autoDispose = false,
  }) : super(
          notifier: computed<T>(
            compute,
            debugLabel: debugLabel,
            autoDispose: autoDispose,
          ),
        );

  /// Find widget in tree
  static ComputedProvider<T>? providerOf<T>(
    BuildContext context, {
    bool listen = true,
  }) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<ComputedProvider<T>>();
    } else {
      return context.findAncestorWidgetOfExactType<ComputedProvider<T>>();
    }
  }

  /// Find signal in widget tree
  static Computed<T>? of<T>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance = ComputedProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
