import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

Future<int?> myFuture() async {
  print('myFuture');
  await Future.delayed(const Duration(milliseconds: 1000));
  int number = Random().nextInt(10);
  if (number.isEven) {
    return number;
  } else {
    throw Exception('Exception');
  }
}

final myFutureSignal = asyncSignalFromFuture(myFuture, initialValue: null);

final counter = signal(0);

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
  void _random() async {
    counter.value++;
    myFutureSignal.reload();
  }

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
            Text(
              '${counter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Watch(
              (context) => myFutureSignal.map(
                value: (value) {
                  print('value:$value');
                  return Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!,
                  );
                },
                error: (error) {
                  print('error:$error');
                  return Text(
                    'error:$error',
                    style: Theme.of(context).textTheme.headlineMedium!,
                  );
                },
                loading: () {
                  print('loading');
                  return const CircularProgressIndicator();
                },
                reloading: (val) {
                  print('reloading');
                  return Text(
                    'reloading:$val',
                    style: Theme.of(context).textTheme.headlineMedium!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _random,
        tooltip: 'Random',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
