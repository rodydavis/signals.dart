import 'package:flutter/widgets.dart';

import 'watch.dart';

/// Easy replacement for [StatelessWidget] that will rebuild
abstract class SignalWidget extends StatefulWidget {
  const SignalWidget({super.key});

  @override
  State<StatefulWidget> createState() => _SignalStatefulWidgetState();

  @protected
  Widget build(BuildContext context);
}

class _SignalStatefulWidgetState extends State<SignalWidget> {
  @override
  Widget build(BuildContext context) {
    return Watch(widget.build);
  }
}
