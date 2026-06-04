import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = signal(0);
    // This should trigger signals_avoid_deprecated_watch_extension
    s.watch(context);
    return Text('$s');
  }
}
