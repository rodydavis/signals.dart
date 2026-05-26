import 'package:flutter/widgets.dart';
import 'signal_widget.dart';
import 'signal_stateful_widget.dart';

/// Extension to convert standard Flutter widgets to reactive Signal widgets.
extension StatelessWidgetConvertWidgetExtension on StatelessWidget {
  /// Converts this [StatelessWidget] to a [SignalWidget].
  SignalWidget toSignalWidget() => ConvertedSignalWidget(this);
}

/// Extension to convert standard Flutter widgets to reactive Signal stateful widgets.
extension StatefulWidgetConvertWidgetExtension on StatefulWidget {
  /// Converts this [StatefulWidget] to a [SignalStatefulWidget].
  SignalStatefulWidget toSignalStatefulWidget() => ConvertedSignalStatefulWidget(this);
}

/// Extension to convert standard Flutter elements to their reactive counterparts.
extension StatelessElementConvertExtension on StatelessElement {
  /// Intercepts build to watch a signal if the element is a [SignalElement].
  void watchSignal(dynamic signal) {
    final self = this;
    if (self is SignalElement) {
      self.watchSignal(signal);
    }
  }
}

/// Extension to convert standard Flutter elements to their reactive counterparts.
extension StatefulElementConvertExtension on StatefulElement {
  /// Intercepts build to watch a signal if the element is a [SignalStatefulElement].
  void watchSignal(dynamic signal) {
    final self = this;
    if (self is SignalStatefulElement) {
      self.watchSignal(signal);
    }
  }
}

/// A wrapper [SignalWidget] that wraps a [StatelessWidget].
class ConvertedSignalWidget extends SignalWidget {
  /// The wrapped [StatelessWidget].
  final StatelessWidget widget;

  /// Creates a [ConvertedSignalWidget].
  const ConvertedSignalWidget(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}

/// A wrapper [SignalStatefulWidget] that wraps a [StatefulWidget].
class ConvertedSignalStatefulWidget extends SignalStatefulWidget {
  /// The wrapped [StatefulWidget].
  final StatefulWidget widget;

  /// Creates a [ConvertedSignalStatefulWidget].
  const ConvertedSignalStatefulWidget(this.widget, {super.key});

  @override
  StatefulElement createElement() => ConvertedSignalStatefulElement(this);

  @override
  State<StatefulWidget> createState() => widget.createState();
}

/// Element for [ConvertedSignalStatefulWidget] that overrides the widget getter
/// to return the wrapped [StatefulWidget], preventing dynamic cast errors in [State.widget].
class ConvertedSignalStatefulElement extends SignalStatefulElement {
  /// Constructor for [ConvertedSignalStatefulElement].
  ConvertedSignalStatefulElement(ConvertedSignalStatefulWidget widget)
      : super(widget.widget);
}
