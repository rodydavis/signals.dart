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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Example(),
    );
  }
}

class Counter extends FlutterSignal<int> {
  Counter([super.value = 0]);

  void increment() => value++;
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    this.title = 'Example',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SignalProvider<Counter>(
      create: () => Counter(0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Builder(builder: (context) {
                final counter = SignalProvider.of<Counter>(context);
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          final counter = SignalProvider.of<Counter>(context, listen: false)!;
          return FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
