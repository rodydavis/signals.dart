import 'package:flutter/widgets.dart';

import '../core/computed.dart';

/// Computed notifier widget
class ComputedProvider<T extends FlutterComputed> extends InheritedNotifier<T> {
  /// Computed notifier widget
  ComputedProvider({
    super.key,
    required super.child,
    required T Function() create,
  }) : super(notifier: create());

  /// Find widget in tree
  static ComputedProvider<T>? providerOf<T extends FlutterComputed>(
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
  static T? of<T extends FlutterComputed>(
    BuildContext context, {
    bool listen = true,
  }) {
    final instance = ComputedProvider.providerOf<T>(context, listen: listen);
    return instance?.notifier;
  }
}
