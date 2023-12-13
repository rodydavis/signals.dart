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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: themeMode.watch(context, debugLabel: 'Material app theme mode'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Signal<int> counter = signal(0, debugLabel: 'Counter');

  void _incrementCounter() {
    counter.value++;
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
        title: Text(widget.title),
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
