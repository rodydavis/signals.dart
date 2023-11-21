# Dart Signals

Based on the [following article](http://webcache.googleusercontent.com/search?q=cache:https://medium.com/gft-engineering/implementing-signals-in-javascript-step-by-step-9d0be46fb014&sca_esv=583538769&strip=1&vwsrc=0) and then updated based on [preact signal boosting](https://preactjs.com/blog/signal-boosting).

## Dart Example

```dart
// Create signals
final count = signal(0);
final multiplier = signal(2);

// Creating a computed value
final multipliedCount = computed(() {
    return count.value * multiplier.value;
});

effect(() {
    print('Effect called: Count is ${count.value} and multiplier is ${multiplier.value}');
});

expect(multipliedCount.value, 0);

count.value = 1;
expect(multipliedCount.value, 2);

multiplier.value = 3;
expect(multipliedCount.value, 3);
```

This should print:

```
Effect called: Count is 0 and multiplier is 2
Effect called: Count is 1 and multiplier is 2
Effect called: Count is 1 and multiplier is 3
```

See [preact_signals/example](packages/preact_signals/example/web/main.dart) for a full example.

## Flutter Example

Reacting to signal changes can be done with one extension method: `watch(context)`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_preact_signals/flutter_preact_signals.dart';

void main() {
  runApp(const MyApp());
}

final brightness = signal(Brightness.light);
final counter = signal(0);

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
      themeMode: brightness.watch(context) == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _incrementCounter() {
    counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Builder(builder: (context) {
            final isDark = brightness.watch(context) == Brightness.dark;
            return IconButton(
              onPressed: () {
                brightness.value = isDark ? Brightness.light : Brightness.dark;
              },
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
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
            Text(
              '${counter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium!,
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
```
