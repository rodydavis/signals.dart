import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final brightness = signal(Brightness.light, debugLabel: 'Brightness');
final isDark = computed(
  () => brightness.value == Brightness.dark,
  debugLabel: 'Is Dark',
);
final themeMode = computed(
  () {
    if (isDark.value) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  },
  debugLabel: 'Theme Mode',
);

void main() {
  SignalsObserver.instance = LoggingSignalsObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData theme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
      brightness: brightness,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      themeMode: themeMode.watch(
        context,
        debugLabel: 'Material app theme mode',
      ),
      home: const CounterExample(),
    );
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  late final Signal<int> counter = signal(0, debugLabel: 'Counter');

  void _incrementCounter() {
    counter.value++;
  }

  @override
  void initState() {
    super.initState();
    counter.onDispose(() {
      debugPrint('counter signal disposed');
    });
  }

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counter.listen(
      context,
      () {
        if (counter.value == 10) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.hideCurrentSnackBar();
          messenger.showSnackBar(
            const SnackBar(content: Text('You hit 10 clicks!')),
          );
        }
      },
      debugLabel: 'Counter Listener',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
        actions: [
          Builder(builder: (context) {
            final dark = isDark.watch(context, debugLabel: 'Dark mode toggle');
            return IconButton(
              onPressed: () {
                brightness.value = dark ? Brightness.light : Brightness.dark;
              },
              icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
            );
          }),
          IconButton(
            onPressed: () {
              if (mounted) {
                setState(() {
                  counter.dispose();
                });
              }
            },
            tooltip: 'Dispose signal',
            icon: const Icon(Icons.restore),
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
            Watch(
              (context) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium!,
                );
              },
              debugLabel: 'Counter text',
            ),
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
