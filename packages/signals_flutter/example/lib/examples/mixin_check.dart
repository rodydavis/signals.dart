import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SignalsMixin {
  late final counter = this.createSignal(0);
  late final counterText = this.createComputed(() => counter.value.toString());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(counterText.value)),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  counter.value++;
                },
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  counter.value--;
                },
                child: const Text('Decrement'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
