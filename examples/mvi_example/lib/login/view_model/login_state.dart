import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:signals_mvi_example/core/base_view_model.dart';

part 'login_state.g.dart';

@CopyWith()
final class LoginState extends BaseState with EquatableMixin {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isAuthenticating = false,
    this.error = '',
  });
  final String email;
  final String password;
  final bool isAuthenticating;
  final String error;

  @override
  List<Object?> get props => [email, password, isAuthenticating, error];
}
