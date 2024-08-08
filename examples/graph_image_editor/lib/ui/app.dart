import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'editor.dart';

final theme = AppTheme();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Image Graph Editor',
      home: const Editor(),
      themeMode: theme.mode.watch(context),
      theme: theme.light,
      darkTheme: theme.dark,
    );
  }
}

class AppTheme {
  ThemeData get light => ThemeData.light();
  ThemeData get dark => ThemeData.dark();
  final mode = signal(ThemeMode.system);
}
