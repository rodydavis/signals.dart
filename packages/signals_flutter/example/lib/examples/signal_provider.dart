import 'package:flutter/material.dart';
import 'package:signals_flutter/extended.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SignalProviderExample extends StatelessWidget {
  const SignalProviderExample({
    super.key,
    this.title = 'SignalProvider Example',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SignalProvider<int>(
      create: () => signal(0),
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
                return Text(
                  '${SignalProvider.of<int>(context)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              SignalProvider.of<int>(context, listen: false).value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
