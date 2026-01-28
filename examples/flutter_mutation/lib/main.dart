import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import 'home_page.dart';
import 'posts_repository.dart';

void main() {
  SignalsObserver.instance = null;

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  ThemeData buildTheme(BuildContext context, Brightness brightness) {
    return ThemeData(
      colorScheme: .fromSeed(seedColor: Colors.blue, brightness: brightness),
      brightness: brightness,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      visualDensity: .standard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<PostsRepository>(
      create: (_) => PostsRepository(),
      dispose: (_, value) => value.dispose(),
      child: MaterialApp(
        title: 'MutationSignal Example',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(context, Brightness.light),
        darkTheme: buildTheme(context, Brightness.dark),
        home: const HomePage(),
      ),
    );
  }
}
