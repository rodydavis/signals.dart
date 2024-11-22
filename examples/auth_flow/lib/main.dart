import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

typedef User = ({int id, String name});
typedef Setting = ({int userId, String key, bool value});

class ServerApi {
  // This uses a controller but this user stream could come from a
  // database or library like Firebase
  final _controller = StreamController<User?>();

  Stream<User?> userStream() => _controller.stream;

  Stream<List<Setting>> todosStream(int userId) {
    return Stream.value([
      (userId: userId, key: 'darkMode', value: true),
      (userId: userId, key: 'notifications', value: false),
    ]);
  }

  void login(User data) {
    _controller.add(data);
  }

  void logout() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}

class Auth {
  final api = ServerApi();

  /// Current user signal
  late final currentUser = api.userStream().toStreamSignal();

  late final settings = streamSignal(
    () => api.todosStream(currentUser().value?.id ?? 0),
    dependencies: [currentUser],
  );

  /// Computed signal that only emits when the user is logged in / out
  late final isLoggedIn = computed(
    () => currentUser().value != null,
  );

  /// Computed signal that returns the current user name or 'N/A'
  late final currentUserName = computed(
    () => currentUser().value?.name ?? 'N/A',
  );

  // Dispose of the stream controller
  void dispose() {
    currentUser.dispose();
    api.dispose();
  }

  /// Login with user data
  void login(User data) => api.login(data);

  /// Logout
  void logout() => api.logout();
}

final auth = Auth();

final router = GoRouter(
  refreshListenable: auth.isLoggedIn,
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        if (auth.currentUser().value == null) return '/login';
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

void main() => runApp(const MyApp());

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
                auth.login((id: 1, name: 'John Doe'));
                context.go('/');
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
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
                auth.login((id: 2, name: 'Jane Doe'));
                context.go('/');
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
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
    return Watch((context, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile: ${auth.currentUserName()}'),
          actions: [
            const DarkModeToggle(),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                auth.logout();
                context.go('/login');
              },
            ),
          ],
        ),
        body: auth.settings().map(
          data: (settings) {
            if (settings.isEmpty) {
              return const Center(child: Text('No settings found'));
            }
            return ListView.builder(
              itemCount: settings.length,
              itemBuilder: (context, index) {
                final setting = settings[index];
                return ListTile(
                  trailing: Text(setting.userId.toString()),
                  title: Text(setting.key),
                  subtitle: Text(setting.value.toString()),
                );
              },
            );
          },
          error: (e, s) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error loading settings'),
                  ElevatedButton(
                    onPressed: () {
                      auth.settings.refresh();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      );
    });
  }
}
