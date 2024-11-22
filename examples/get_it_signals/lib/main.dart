import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

final getIt = GetIt.instance;

typedef User = ({int id, String name});

class Auth {
  /// Current user signal
  final currentUser = signal<User?>(null);

  /// Computed signal that only emits when the user is logged in / out
  late final isLoggedIn = computed(() => currentUser() != null);

  /// Computed signal that returns the current user name or 'N/A'
  late final currentUserName = computed(() => currentUser()?.name ?? 'N/A');

  // This uses a controller but this user stream could come from a
  // database or library like Firebase
  final _controller = StreamController<User?>();

  // Listen to auth state changes and update the current user
  late Connect<User?, User?> _authListener;

  Auth() {
    // Listen to the stream and update the current user
    _authListener = connect(currentUser) << _controller.stream;
  }

  // Dispose of the stream controller
  void dispose() {
    _authListener.dispose();
  }

  /// Login with user data
  void login(User data) {
    _controller.add(data);
  }

  /// Logout
  void logout() {
    _controller.add(null);
  }
}

@visibleForTesting
class MockAuth extends Auth {}

void setup(bool testing) {
  if (testing) {
    getIt.registerSingleton<Auth>(
      MockAuth(),
      dispose: (e) => e.dispose(),
    );
  } else {
    getIt.registerSingleton<Auth>(
      Auth(),
      dispose: (e) => e.dispose(),
    );
  }
}

void main() {
  setup(false);
  runApp(const MyApp());
}

final router = GoRouter(
  refreshListenable: getIt.get<Auth>().isLoggedIn,
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        if (!getIt.get<Auth>().isLoggedIn()) return '/login';
        return null;
      },
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData theme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
      brightness: brightness,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Auth Example',
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      themeMode: themeMode.watch(context),
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

final brightness = signal(Brightness.light);
final themeMode = computed(() {
  if (brightness() == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

class DarkModeToggle extends StatelessWidget {
  const DarkModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((_, __) {
      final isDark = brightness() == Brightness.dark;
      return IconButton(
        onPressed: () {
          brightness.value = isDark ? Brightness.light : Brightness.dark;
        },
        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      );
    });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final counter = signal(0);

  void _incrementCounter() {
    counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          const DarkModeToggle(),
          IconButton(
            onPressed: () {
              context.push('/profile');
            },
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Count value:'),
            Watch((context, _) {
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to continue'),
            ElevatedButton(
              onPressed: () {
                getIt.get<Auth>().login((id: 1, name: 'John Doe'));
                context.go('/');
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register to continue'),
            ElevatedButton(
              onPressed: () {
                getIt.get<Auth>().login((id: 2, name: 'Jane Doe'));
                context.go('/');
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          const DarkModeToggle(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              getIt.get<Auth>().logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile'),
            Watch((context, _) {
              return Text(
                getIt.get<Auth>().currentUserName(),
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
    );
  }
}
