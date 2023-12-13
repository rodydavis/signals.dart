import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signals Async Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  final throwError = signal(false);
  final delay = signal(500);
  late final _futureSignal = futureSignal(() => _future());

  Future<int> _future() async {
    await Future.delayed(Duration(milliseconds: delay.value));
    if (throwError.value) {
      throw Exception('Error');
    } else {
      return Random().nextInt(1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Watch((_) {
                return SwitchListTile(
                  title: const Text('Throw Error'),
                  value: throwError.value,
                  onChanged: (value) => throwError.value = value,
                );
              }),
              Watch((context) {
                return ListTile(
                  title: const Text('Result'),
                  subtitle: _futureSignal.value.map(
                    data: (value) {
                      return Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.headlineMedium!,
                      );
                    },
                    error: (error, _) {
                      return Text(
                        'error:$error',
                        style: Theme.of(context).textTheme.headlineMedium!,
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    reloading: () {
                      return Text(
                        'reloading',
                        style: Theme.of(context).textTheme.headlineMedium!,
                      );
                    },
                    refreshing: () {
                      return Text(
                        'refreshing',
                        style: Theme.of(context).textTheme.headlineMedium!,
                      );
                    },
                  ),
                );
              }),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      child: const Text('Reload'),
                      onPressed: () => _futureSignal.reload(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      child: const Text('Refresh'),
                      onPressed: () => _futureSignal.refresh(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
