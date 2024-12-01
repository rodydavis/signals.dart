import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SignalsMixin {
  late final counter = createSignal(1);

  @override
  Widget build(BuildContext context) {
    return Text('Count: $counter');
  }
}

class Counter extends ValueNotifier<int> {
  Counter(super.value);
}
