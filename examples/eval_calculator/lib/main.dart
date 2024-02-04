import 'package:flutter/material.dart';

import 'screens/spreadsheet.dart';
import 'screens/table.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const Home(title: 'Eval Calculator'),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Table Calculator'),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TableCalculator(),
            )),
          ),
          ListTile(
            title: const Text('Spreadsheet Calculator'),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SpreadsheetCalculator(),
            )),
          ),
        ],
      ),
    );
  }
}
