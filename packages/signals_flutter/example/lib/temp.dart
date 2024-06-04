import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final routerGuardSignal = Signal<bool?>(null);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final navKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    routerGuardSignal.listen(context, () {
      while (navKey.currentState?.canPop() == true) {
        navKey.currentState?.pop();
      }
      final isUserLoggedIn = routerGuardSignal.value;
      if (isUserLoggedIn == true) {
        navKey.currentState!.pushNamed('/main');
      } else if (isUserLoggedIn == false) {
        navKey.currentState!.pushNamed('/login');
      }
    });
    return MaterialApp(
      navigatorKey: navKey,
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/main': (_) => const Scaffold(body: Text('Main')),
        '/login': (_) => const Scaffold(body: Text('Login')),
      },
      initialRoute: '/splash',
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      routerGuardSignal.value = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Splash'));
  }
}
