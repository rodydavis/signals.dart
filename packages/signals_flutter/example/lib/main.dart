import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key, this.title = 'Example'});

  final String title;

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> with SignalsAutoDisposeMixin {
  late final _counter = createSignal(
    context,
    0,
    debugLabel: 'Counter',
    autoDispose: true,
  );

  void _incrementCounter() => _counter.value++;

  @override
  void initState() {
    super.initState();
    _counter.onDispose(() {
      debugPrint('disposed ${_counter.globalId} counter!');
    });
    effect(() {
      debugPrint('count: ${_counter()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: 'Open another counter',
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Example(title: 'Another Counter'),
              ),
            ),
          ),
        ],
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
                '${_counter.watch(context)}',
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
