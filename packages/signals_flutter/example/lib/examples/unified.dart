import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

final counter = Counter(0);

void main(List<String> args) {
  runApp(App(count: counter));
}

class App extends StatelessWidget {
  const App({super.key, required this.count});

  final Counter count;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Example(count: count),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.count,
  });

  final Counter count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unified Signal Example'),
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
                '${count.watch(context)}',
                style: Theme.of(context).textTheme.titleLarge,
              );
            }),
            StreamBuilder(
              stream: count,
              builder: (context, snapshot) {
                return Text(
                  'Stream: ${snapshot.data}',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: count,
              builder: (context, value, child) {
                return Text(
                  'ValueNotifier: $value',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            Watch.builder(
              builder: (context) {
                return Text(
                  'Watch: ${count.value}',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: count.increment,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: count.decrement,
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UnifiedSignal<T> extends Signal<T>
    with ValueNotifierSignalMixin<T>, StreamSignalMixin<T>, SinkSignalMixin<T> {
  UnifiedSignal(super.internalValue);
}

class Counter extends UnifiedSignal<int> {
  Counter([super.internalValue = 0]);
  void increment() => value++;
  void decrement() => value--;
}
