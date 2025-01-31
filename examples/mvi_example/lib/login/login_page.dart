import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_mvi_example/core/view_model_mixin.dart';
import 'package:signals_mvi_example/login/view_model/login_view_model.dart';
import 'package:signals_mvi_example/posts/data/posts_repository.dart';
import 'package:signals_mvi_example/posts/posts_screen.dart';
import 'package:signals_mvi_example/posts/view_model/posts_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.viewModel,
    super.key,
  });
  final LoginViewModel viewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ViewModelMixin<LoginPage, LoginViewModel> {
  @override
  LoginViewModel provideViewModel() => widget.viewModel;

  @override
  void onEffect(LoginEffect effect) => switch (effect) {
        LoginSuccess() => _onLoginSuccess(),
        LoginError() => _onLoginError(),
      };

  void _onLoginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => PostsScreen(
          viewModel: PostsViewModel(
            postsRepository: PostsRepository(),
          ),
        ),
      ),
    );
  }

  void _onLoginError() {
    showDialog<void>(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Oops!'),
        content: Text('Authentication failed. Please try again.'),
      ),
    );
  }

  Future<void> _onLogin(BuildContext context) async {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }

    addEvent(LoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    // select only the isAuthenticating property from the state
    final isAuthenticating = computed(
      () => viewModel.state.value.isAuthenticating,
      debugLabel: 'isAuthenticating',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('MVI Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Watch(
          (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  enabled: !isAuthenticating.value,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'admin@admin.com',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (value) => addEvent(EmailChanged(value)),
                ),
                const SizedBox(height: 8),
                TextField(
                  enabled: !isAuthenticating.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '123456',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: true,
                  onChanged: (value) => addEvent(PasswordChanged(value)),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed:
                      isAuthenticating.value ? null : () => _onLogin(context),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: isAuthenticating.value
                      ? const Center(child: CircularProgressIndicator())
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
