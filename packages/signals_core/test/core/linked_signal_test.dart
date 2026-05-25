import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('linkedSignal (Shorthand Syntax)', () {
    test('defaults to computed source value initially', () {
      final availableSizes = signal(['S', 'M', 'L']);
      final selectedSize = linkedSignal(() => availableSizes.value[0]);

      expect(selectedSize.value, 'S');
    });

    test('resets automatically when source dependencies change', () {
      final availableSizes = signal(['S', 'M', 'L']);
      final selectedSize = linkedSignal(() => availableSizes.value[0]);

      availableSizes.value = ['XL', 'XXL'];
      expect(selectedSize.value, 'XL');
    });

    test('allows manual override updates', () {
      final availableSizes = signal(['S', 'M', 'L']);
      final selectedSize = linkedSignal(() => availableSizes.value[0]);

      selectedSize.value = 'M';
      expect(selectedSize.value, 'M');
    });

    test('retains manual override as long as source dependencies do not change',
        () {
      final availableSizes = signal(['S', 'M', 'L']);
      final selectedSize = linkedSignal(() => availableSizes.value[0]);

      selectedSize.value = 'M';
      // Read again to ensure it doesn't reset lazily
      expect(selectedSize.value, 'M');
    });

    test('resets manual override when source dependencies change', () {
      final availableSizes = signal(['S', 'M', 'L']);
      final selectedSize = linkedSignal(() => availableSizes.value[0]);

      selectedSize.value = 'M';
      expect(selectedSize.value, 'M');

      // Mutate source dependency
      availableSizes.value = ['XL', 'XXL'];
      expect(selectedSize.value, 'XL');
    });
  });

  group('linkedSignalOptions (Advanced Syntax)', () {
    test('computes custom initial state correctly', () {
      final user = signal((id: 1, name: 'Alice'));
      final nickname = linkedSignalOptions<String, ({int id, String name})>(
        source: () => user.value,
        computation: (u, prev) => prev != null ? prev.value : u.name,
      );

      expect(nickname.value, 'Alice');
    });

    test('preserves manual override based on custom computation logic', () {
      final user = signal((id: 1, name: 'Alice'));
      final nickname = linkedSignalOptions<String, ({int id, String name})>(
        source: () => user.value,
        computation: (u, prev) {
          // If the user already set a custom nickname, keep it across source changes
          if (prev != null) {
            return prev.value;
          }
          return u.name;
        },
      );

      expect(nickname.value, 'Alice');

      // Override nickname manually
      nickname.value = 'Ali';
      expect(nickname.value, 'Ali');

      // Change user to Bob
      user.value = (id: 2, name: 'Bob');

      // The custom logic says: if there is a previous value, keep it!
      expect(nickname.value, 'Ali');
    });

    test('resets custom value based on previous source comparison', () {
      final user = signal((id: 1, name: 'Alice'));
      final nickname = linkedSignalOptions<String, ({int id, String name})>(
        source: () => user.value,
        computation: (u, prev) {
          // Only reset if the user ID actually changed
          if (prev != null && prev.source.id == u.id) {
            return prev.value;
          }
          return u.name;
        },
      );

      expect(nickname.value, 'Alice');

      // Override nickname manually
      nickname.value = 'Ali';
      expect(nickname.value, 'Ali');

      // Update same user with different name: same ID, should keep the override!
      user.value = (id: 1, name: 'Alisha');
      expect(nickname.value, 'Ali');

      // Change to a completely new user: different ID, should reset to Bob!
      user.value = (id: 2, name: 'Bob');
      expect(nickname.value, 'Bob');
    });
  });

  group('Reactive Dependencies & Effects', () {
    test('effects subscribe and trigger on linkedSignal updates', () {
      final source = signal(10);
      final linked = linkedSignal(() => source.value * 2);

      final loggedValues = <int>[];
      final dispose = effect(() {
        loggedValues.add(linked.value);
      });

      expect(loggedValues, [20]);

      // Change source: triggers effect
      source.value = 15;
      expect(loggedValues, [20, 30]);

      // Override manually: triggers effect
      linked.value = 99;
      expect(loggedValues, [20, 30, 99]);

      dispose();
    });

    test('computed signals react to linkedSignal updates', () {
      final source = signal(10);
      final linked = linkedSignal(() => source.value * 2);
      final isEven = computed(() => linked.value.isEven);

      expect(isEven.value, true);

      // Override with an odd number
      linked.value = 15;
      expect(isEven.value, false);

      // Mutate source back to even default
      source.value = 20; // default will be 40
      expect(isEven.value, true);
    });
  });

  group('Lifecycle & Disposal', () {
    test('can be disposed and releases resources', () {
      final source = signal(10);
      final linked = linkedSignal(() => source.value);

      expect(linked.value, 10);

      linked.dispose();
      expect(linked.disposed, true);
      expect(() => linked.value, throwsA(isA<SignalsReadAfterDisposeError>()));
    });
  });
}
