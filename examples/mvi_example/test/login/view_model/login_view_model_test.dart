import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_mvi_example/login/view_model/login_view_model.dart';

void main() {
  late LoginViewModel viewModel;

  setUp(() {
    viewModel = LoginViewModel();
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('View model initial state should be LoginState', () {
    expect(viewModel.state.value, isA<LoginState>());
  });

  test('test EmailChanged event', () async {
    viewModel.addEvent(EmailChanged('test'));

    await Future.microtask(() {});

    expect(viewModel.state.value.email, 'test');
  });

  test('test PasswordChanged event', () async {
    viewModel.addEvent(PasswordChanged('test'));

    await Future.microtask(() {});

    expect(viewModel.state.value.password, 'test');
  });

  test('test LoginRequested event with incorrect credentials', () {
    fakeAsync((async) {
      final viewModel = LoginViewModel()..addEvent(LoginRequested());

      async.flushMicrotasks();

      expect(viewModel.state.value.isAuthenticating, true);

      async.elapse(const Duration(seconds: 2));

      expect(viewModel.state.value.isAuthenticating, false);

      expect(viewModel.effects, emits(isA<LoginError>()));

      async.flushTimers();
    });
  });

  test('test LoginRequested event with correct credentials', () {
    fakeAsync((async) {
      final viewModel = LoginViewModel()
        ..addEvent(EmailChanged('admin@admin.com'));

      async.flushMicrotasks();

      viewModel.addEvent(PasswordChanged('123456'));
      async.flushMicrotasks();

      viewModel.addEvent(LoginRequested());
      async.flushMicrotasks();

      expect(viewModel.state.value.isAuthenticating, true);

      async.elapse(const Duration(seconds: 2));

      expect(viewModel.state.value.isAuthenticating, false);
      expect(viewModel.effects, emits(isA<LoginSuccess>()));

      async.flushTimers();
    });
  });
}
