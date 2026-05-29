import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = signal(0);
    // This should trigger signals_prefer_named_builder
    return SignalBuilder(
      builder: (context) => Text('$s'),
    );
  }
}
