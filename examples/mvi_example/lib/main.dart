import 'package:flutter/material.dart';
import 'package:signals_mvi_example/login/login_page.dart';
import 'package:signals_mvi_example/login/view_model/login_view_model.dart';

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
      home: LoginPage(
        viewModel: LoginViewModel(),
      ),
    );
  }
}
