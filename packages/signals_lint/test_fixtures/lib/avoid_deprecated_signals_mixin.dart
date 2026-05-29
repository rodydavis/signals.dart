import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// This should trigger signals_avoid_deprecated_signals_mixin
class _MyWidgetState extends State<MyWidget> with SignalsMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
