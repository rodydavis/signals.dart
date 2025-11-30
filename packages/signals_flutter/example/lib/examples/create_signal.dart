import 'package:flutter/material.dart';

import 'package:signals_flutter/signals_flutter.dart' as signals;

class CreateSignalExample extends StatefulWidget {
  const CreateSignalExample({
    super.key,
    this.title = 'CreateSignal Example',
  });

  final String title;

  @override
  State<CreateSignalExample> createState() => _CreateSignalExampleState();
}

class _CreateSignalExampleState extends State<CreateSignalExample>
    with signals.SignalsMixin {
  late final counter = createSignal(
    0,
    options: const signals.FlutterSignalOptions(name: 'Counter'),
  );

  void _incrementCounter() => counter.value++;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Builder(builder: (context) {
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
