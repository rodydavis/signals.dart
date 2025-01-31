import 'package:signals_mvi_example/core/base_view_model.dart';

sealed class LoginEffect extends BaseEffect {}

final class LoginSuccess extends LoginEffect {}

final class LoginError extends LoginEffect {}
