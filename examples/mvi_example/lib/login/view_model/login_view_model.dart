import 'package:signals_mvi_example/core/base_view_model.dart';
import 'package:signals_mvi_example/login/view_model/login_effect.dart';
import 'package:signals_mvi_example/login/view_model/login_event.dart';
import 'package:signals_mvi_example/login/view_model/login_state.dart';

export 'login_effect.dart';
export 'login_event.dart';
export 'login_state.dart';

final class LoginViewModel
    extends BaseViewModel<LoginState, LoginEvent, LoginEffect> {
  LoginViewModel() : super(const LoginState());

  @override
  void onEvent(LoginEvent event) => switch (event) {
        EmailChanged() => _onEmailChanged(event.email),
        PasswordChanged() => _onPasswordChanged(event.password),
        LoginRequested() => _onLoginRequested(),
      };

  void _onEmailChanged(String email) {
    updateState(state.value.copyWith(email: email));
  }

  void _onPasswordChanged(String password) {
    updateState(state.value.copyWith(password: password));
  }

  Future<void> _onLoginRequested() async {
    updateState(state.value.copyWith(isAuthenticating: true));

    // Simulate a HTTP request
    await Future<void>.delayed(const Duration(seconds: 2));

    updateState(state.value.copyWith(isAuthenticating: false));

    if (state.value.email == 'admin@admin.com' &&
        state.value.password == '123456') {
      addEffect(LoginSuccess());
      return;
    }

    addEffect(LoginError());
  }
}
