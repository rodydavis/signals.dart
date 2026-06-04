import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // This should trigger signals_avoid_create_in_build_method
    final s = signal(0);
    return Text('$s');
  }
}
