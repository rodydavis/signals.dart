import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'editor.dart';

final themeMode = signal<ThemeMode>(ThemeMode.system);

class App extends StatelessWidget {
  const App({super.key});

  ThemeData theme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        brightness: brightness,
      ),
      brightness: brightness,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Node Based Editor',
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      themeMode: themeMode.watch(context),
      home: const Editor(),
    );
  }
}
