import 'package:flutter/widgets.dart';
import "package:preact_signals/preact_signals.dart" as signals;

import 'memorized.dart';

void Function() effect<T>(BuildContext? context, Function() fn) {
  final effect = withMemorized(context, () => signals.Effect(fn)..call());
  return effect.dispose;
}
