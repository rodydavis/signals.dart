import 'package:test/test.dart';
import 'package:signals_core/src/core/options.dart';

void main() {
  test('SignalOptions exists', () {
    final options = SignalOptions<int>(name: 'test', autoDispose: true);
    expect(options.name, 'test');
    expect(options.autoDispose, true);
  });

  test('EffectOptions exists', () {
    final options = EffectOptions(name: 'test', autoDispose: true);
    expect(options.name, 'test');
    expect(options.autoDispose, true);
  });
}
