import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('SignalOptionsBase', () {
    test('equality and hashCode', () {
      const opt1 = ReadonlySignalOptions<int>(name: 'test');
      const opt2 = ReadonlySignalOptions<int>(name: 'test');
      const opt3 = ReadonlySignalOptions<int>(name: 'different');

      // Test identical references
      expect(opt1 == opt1, isTrue);

      // Test equivalent properties
      expect(opt1 == opt2, isTrue);
      expect(opt1.hashCode, opt2.hashCode);

      // Test different properties
      expect(opt1 == opt3, isFalse);

      // Test null and different class comparisons
      expect((opt1 as dynamic) == null, isFalse);
      expect((opt1 as dynamic) == 'not an option', isFalse);
    });
  });

  group('EffectOptions', () {
    test('copyWith', () {
      const opt = EffectOptions(name: 'a');

      // copyWith without parameters should retain current properties
      final copiedNull = opt.copyWith();
      expect(copiedNull.name, 'a');

      // copyWith with explicit parameter overrides
      final copiedNew = opt.copyWith(name: 'b');
      expect(copiedNew.name, 'b');
    });

    test('equality and hashCode', () {
      const opt1 = EffectOptions(name: 'test');
      const opt2 = EffectOptions(name: 'test');
      const opt3 = EffectOptions(name: 'other');

      expect(opt1 == opt1, isTrue);
      expect(opt1 == opt2, isTrue);
      expect(opt1.hashCode, opt2.hashCode);
      expect(opt1 == opt3, isFalse);
      expect((opt1 as dynamic) == null, isFalse);
    });
  });

  group('ReadonlySignalOptions', () {
    test('copyWith', () {
      void watched1() {}
      void watched2() {}
      void unwatched1() {}
      void unwatched2() {}

      final opt = ReadonlySignalOptions<int>(
        name: 'a',
        watched: watched1,
        unwatched: unwatched1,
      );

      final copiedNull = opt.copyWith();
      expect(copiedNull.name, 'a');
      expect(copiedNull.watched, watched1);
      expect(copiedNull.unwatched, unwatched1);

      final copiedNew = opt.copyWith(
        name: 'b',
        watched: watched2,
        unwatched: unwatched2,
      );
      expect(copiedNew.name, 'b');
      expect(copiedNew.watched, watched2);
      expect(copiedNew.unwatched, unwatched2);
    });

    test('equality and hashCode', () {
      void watched() {}
      void unwatched() {}

      final opt1 = ReadonlySignalOptions<int>(
        name: 'test',
        watched: watched,
        unwatched: unwatched,
      );
      final opt2 = ReadonlySignalOptions<int>(
        name: 'test',
        watched: watched,
        unwatched: unwatched,
      );
      final opt3 = ReadonlySignalOptions<int>(
        name: 'test',
        watched: () {},
        unwatched: unwatched,
      );

      expect(opt1 == opt1, isTrue);
      expect(opt1 == opt2, isTrue);
      expect(opt1.hashCode, opt2.hashCode);
      expect(opt1 == opt3, isFalse);
    });
  });

  group('SignalOptions', () {
    test('copyWith', () {
      final opt = SignalOptions<int>(
        name: 'a',
        equality: SignalEquality.standard(),
      );

      final copiedNull = opt.copyWith();
      expect(copiedNull.name, 'a');
      expect(copiedNull.equalityCheck, SignalEquality.standard<int>());

      final copiedNew = opt.copyWith(
        name: 'b',
      );
      expect(copiedNew.name, 'b');
      expect(copiedNew.equalityCheck, SignalEquality.standard<int>());
    });

    test('equality and hashCode', () {
      final eq = SignalEquality.standard<int>();
      final opt1 = SignalOptions<int>(
        name: 'test',
        equality: eq,
      );
      final opt2 = SignalOptions<int>(
        name: 'test',
        equality: eq,
      );
      final opt3 = SignalOptions<int>(
        name: 'test',
        equality: SignalEquality.identity(),
      );

      expect(opt1 == opt1, isTrue);
      expect(opt1 == opt2, isTrue);
      expect(opt1.hashCode, opt2.hashCode);
      expect(opt1 == opt3, isFalse);
    });
  });

  group('ComputedOptions', () {
    test('copyWith', () {
      void watched() {}
      final opt = ComputedOptions<int>(
        name: 'a',
        watched: watched,
      );

      final copiedNull = opt.copyWith();
      expect(copiedNull.name, 'a');
      expect(copiedNull.watched, watched);

      final copiedNew = opt.copyWith(
        name: 'b',
      );
      expect(copiedNew.name, 'b');
      expect(copiedNew.watched, watched);
    });

    test('equality and hashCode', () {
      void watched() {}
      final opt1 = ComputedOptions<int>(
        name: 'test',
        watched: watched,
      );
      final opt2 = ComputedOptions<int>(
        name: 'test',
        watched: watched,
      );
      final opt3 = ComputedOptions<int>(
        name: 'test',
        watched: () {},
      );

      expect(opt1 == opt1, isTrue);
      expect(opt1 == opt2, isTrue);
      expect(opt1.hashCode, opt2.hashCode);
      expect(opt1 == opt3, isFalse);
    });
  });
}
