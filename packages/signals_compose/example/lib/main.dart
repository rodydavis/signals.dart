import 'package:flutter/material.dart';
import 'package:signals_compose/signals_compose.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Counter(),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final count = signal(context, 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(child: Text('Count: ${count.value}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
