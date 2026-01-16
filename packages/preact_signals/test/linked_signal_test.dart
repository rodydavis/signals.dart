import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('LinkedSignal', () {
    group('Core Functionality', () {
      test('updates when source changes', () {
        final source = signal(0);
        final s = linkedSignal(() => source.value, (s, p) => s * 2);

        expect(s.value, 0);

        source.value = 1;
        expect(s.value, 2);

        source.value = 5;
        expect(s.value, 10);
      });

      test('allows manual override', () {
        final source = signal(0);
        final s = linkedSignal(() => source.value, (s, p) => s * 2);

        expect(s.value, 0);

        s.value = 100;
        expect(s.value, 100);

        // Source hasn't changed, so value remains overridden
        expect(s.value, 100);
      });

      test(
          'resets when source changes after manual override (Source Precedence)',
          () {
        final source = signal(0);
        final s = linkedSignal(() => source.value, (s, p) => s * 2);

        s.value = 100;
        expect(s.value, 100);

        source.value = 1;
        // Should reset to computation result, discarding manual override
        expect(s.value, 2);
      });

      test('passes previous value to computation', () {
        final source = signal(0);
        final s = linkedSignal<int, int>(
          () => source.value,
          (src, prev) => src + (prev ?? 0),
        );

        // Initial: src=0, prev=null -> 0 + 0 = 0
        expect(s.value, 0);

        source.value = 1;
        // src=1, prev=0 -> 1 + 0 = 1
        expect(s.value, 1);

        s.value = 10;
        // Manual override to 10

        source.value = 2;
        // src=2, prev=10 -> 2 + 10 = 12
        expect(s.value, 12);
      });
    });

    group('Advanced Features', () {
      test('works with diamond dependencies (Glitch Freedom)', () {
        final source = signal(0);
        final linked = linkedSignal(() => source.value, (s, p) => s * 2);
        final combined = computed(() => source.value + linked.value);

        // source=0, linked=0, combined=0
        expect(combined.value, 0);

        source.value = 1;
        // source=1, linked=2, combined=3
        expect(combined.value, 3);

        linked.value = 10;
        // source=1, linked=10, combined=11
        expect(combined.value, 11);

        source.value = 2;
        // source=2, linked=4 (reset), combined=6
        expect(combined.value, 6);
      });

      test('works with batching', () {
        final source = signal(0);
        final s = linkedSignal(() => source.value, (s, p) => s * 2);
        var callCount = 0;

        effect(() {
          s.value;
          callCount++;
        });

        expect(callCount, 1);

        batch(() {
          source.value = 1;
          // In a batch, updates are deferred.
          // Setting source marks linked as outdated.
          // Setting linked value updates the backing store.
          // When batch ends, effect runs.
          // Effect reads s.value.
          // s.value checks source. Source changed.
          // So it resets, overwriting the manual value set in the batch.
          s.value = 100;
        });

        // Source precedence applies even within batch
        expect(s.value, 100);
        expect(callCount, 2);
      });

      test('equality check prevents unnecessary updates', () {
        final source = signal(0);
        var computeCount = 0;
        final s = linkedSignal(
          () => source.value,
          (s, p) {
            computeCount++;
            return s;
          },
          options: LinkedSignalOptions(
            equalityCheck: SignalEquality.custom((a, b) => a == b),
          ),
        );

        expect(s.value, 0);
        expect(computeCount, 1);

        source.value = 0; // Same value
        // Source signal might not notify if value is same

        expect(s.value, 0);
        expect(computeCount, 1); // Should not recompute

        source.value = 1;
        expect(s.value, 1);
        expect(computeCount, 2);
      });

      test('peek does not trigger update', () {
        final source = signal(0);
        var computeCount = 0;
        final s = linkedSignal(
          () => source.value,
          (src, prev) {
            computeCount++;
            return src;
          },
        );

        expect(computeCount, 0); // Lazy
        expect(s.peek(), 0);
        expect(computeCount, 1);

        source.value = 1;
        // peek() on a Computed (which LinkedSignal uses internally) re-evaluates if outdated.
        expect(s.peek(), 1);
        expect(computeCount, 2);
      });
    });

    group('Edge Cases', () {
      test('nested linked signals', () {
        final source = signal(0);
        final s1 = linkedSignal(() => source.value, (s, p) => s * 2);
        final s2 = linkedSignal(() => s1.value, (s, p) => s + 1);

        // source=0 -> s1=0 -> s2=1
        expect(s2.value, 1);

        source.value = 1;
        // source=1 -> s1=2 -> s2=3
        expect(s2.value, 3);

        s1.value = 10;
        // source=1 (unchanged) -> s1=10 (manual) -> s2=11 (reset triggered by s1 change)
        expect(s2.value, 11);

        source.value = 2;
        // source=2 -> s1=4 (reset) -> s2=5 (reset)
        expect(s2.value, 5);
      });

      test('conditional source dependencies', () {
        final toggle = signal(true);
        final a = signal(10);
        final b = signal(20);

        final s = linkedSignal(
          () => toggle.value ? a.value : b.value,
          (src, prev) => src,
        );

        expect(s.value, 10);

        a.value = 15;
        expect(s.value, 15);

        toggle.value = false; // Switch to b
        expect(s.value, 20);

        a.value = 30; // Should be ignored
        expect(s.value, 20);

        b.value = 25;
        expect(s.value, 25);
      });

      test('nullable types', () {
        final source = signal<int?>(null);
        final s = linkedSignal<int?, int?>(
          () => source.value,
          (src, prev) => src,
        );

        expect(s.value, null);

        source.value = 1;
        expect(s.value, 1);

        s.value = null;
        expect(s.value, null);

        source.value = 2;
        expect(s.value, 2);
      });

      test('handles errors in computation', () {
        final source = signal(0);
        final s = linkedSignal(
          () => source.value,
          (src, prev) {
            if (src < 0) throw Exception('Negative source');
            return src;
          },
        );

        expect(s.value, 0);

        source.value = -1;
        expect(() => s.value, throwsException);

        source.value = 1;
        expect(s.value, 1);
      });

      test('untracked in computation', () {
        final source = signal(0);
        final other = signal(10);

        final s = linkedSignal(
          () => source.value,
          (src, prev) => src + untracked(() => other.value),
        );

        expect(s.value, 10); // 0 + 10

        other.value = 20;
        expect(s.value, 10); // Should not update because other is untracked

        source.value = 1;
        expect(s.value, 21); // 1 + 20 (recomputed because source changed)
      });
    });

    group('Examples', () {
      test('Shipping Options Scenario', () {
        // Scenario: Shipping method resets to 'Standard' when country changes,
        // but user can override it to 'Express'.

        final country = signal('USA');
        final shippingMethod = linkedSignal<String, String>(
          () => country.value,
          (c, prev) => 'Standard', // Default for any country
        );

        expect(shippingMethod.value, 'Standard');

        // User selects Express
        shippingMethod.value = 'Express';
        expect(shippingMethod.value, 'Express');

        // Country changes
        country.value = 'Canada';
        // Should reset to Standard
        expect(shippingMethod.value, 'Standard');
      });

      test('Counter with Reset', () {
        // Scenario: A counter that resets to 0 when a "reset" signal triggers.
        // Here we use the reset signal as the source.

        final resetTrigger = signal(0);
        final counter = linkedSignal<int, int>(
          () => resetTrigger.value,
          (trigger, prev) => 0, // Always reset to 0 on trigger change
        );

        expect(counter.value, 0);

        counter.value = 5;
        expect(counter.value, 5);

        counter.value++;
        expect(counter.value, 6);

        // Trigger reset
        resetTrigger.value++;
        expect(counter.value, 0);
      });
    });
    group('Angular Examples', () {
      test('Shopping Cart Quantity', () {
        final selectedProduct = signal('Apple');
        final quantity = linkedSignal<String, int>(
          () => selectedProduct.value,
          (product, prev) => 1, // Default quantity is 1
        );

        expect(quantity.value, 1);

        // User changes quantity
        quantity.value = 5;
        expect(quantity.value, 5);

        // User selects a different product
        selectedProduct.value = 'Banana';
        // Quantity should reset to 1
        expect(quantity.value, 1);
      });

      test('Filter Selection', () {
        final availableOptions = signal(['A', 'B', 'C']);
        final selectedOption = linkedSignal<List<String>, String>(
          () => availableOptions.value,
          (options, prev) => options.first, // Default to first option
        );

        expect(selectedOption.value, 'A');

        // User selects 'B'
        selectedOption.value = 'B';
        expect(selectedOption.value, 'B');

        // Options change
        availableOptions.value = ['D', 'E'];
        // Selection should reset to 'D'
        expect(selectedOption.value, 'D');
      });

      test('User Profile Email', () {
        final serverUser = signal({'id': 1, 'email': 'test@example.com'});
        final emailField = linkedSignal<Map<String, Object>, String>(
          () => serverUser.value,
          (user, prev) => user['email'] as String,
        );

        expect(emailField.value, 'test@example.com');

        // User types in the field
        emailField.value = 'new@example.com';
        expect(emailField.value, 'new@example.com');

        // Server update arrives (e.g. re-fetch)
        serverUser.value = {'id': 1, 'email': 'updated@example.com'};
        // Field should sync with server
        expect(emailField.value, 'updated@example.com');
      });
    });
  });
}
