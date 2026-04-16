# Signals Flutter Extensions

This directory contains convenience extensions that integrate signals into the standard Flutter developer workflow.

## Key Extensions

### [signal.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extensions/signal.dart)
Provides the ubiquitous **`.watch(context)`** extension on all signals. This is the primary way to subscribe a widget's `BuildContext` to a signal, ensuring surgical rebuilds with minimal boilerpate.

### [value_notifier.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extensions/value_notifier.dart) & [value_listenable.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extensions/value_listenable.dart)
Provide **`toSignal()`** extensions on Flutter's core notification classes. These allow developers to wrap existing Flutter state in a reactive signal, enabling compatibility between signals and standard Flutter widgets.

### [untracked_value.dart](file:///Users/rodydavis/Developer/signals.dart/packages/signals_flutter/lib/src/extensions/untracked_value.dart)
Provides a getter to read a signal's value without creating a reactive subscription, equivalent to calling `untracked(() => signal.value)`.
