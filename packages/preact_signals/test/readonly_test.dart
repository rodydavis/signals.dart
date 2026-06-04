import 'package:preact_signals/preact_signals.dart';
import 'package:preact_signals/src/node.dart';
import 'package:test/test.dart';

class SimpleReadonlySignal<T> with ReadonlySignal<T> {
  final T _val;
  SimpleReadonlySignal(this._val);

  @override
  T get value => _val;
}

void main() {
  group('ReadonlySignal Mixin Defaults', () {
    test('default properties and unimplemented throwers', () {
      final s = SimpleReadonlySignal<int>(10);

      // Verify mixin default null fallbacks
      expect(s.name, isNull);
      expect(s.watched, isNull);
      expect(s.unwatched, isNull);

      // Verify unimplemented throwers on a custom implementation
      expect(() => s.globalId, throwsA(isA<UnimplementedError>()));
      expect(() => s.internalValue, throwsA(isA<UnimplementedError>()));
      expect(() => s.subscribe((v) {}), throwsA(isA<UnimplementedError>()));
      expect(
        () => s.subscribeToNode(Node()),
        throwsA(isA<UnimplementedError>()),
      );
      expect(
        () => s.unsubscribeFromNode(Node()),
        throwsA(isA<UnimplementedError>()),
      );
      expect(() => s.version, throwsA(isA<UnimplementedError>()));
      expect(() => s.internalRefresh(), throwsA(isA<UnimplementedError>()));
    });

    test('serializers, helpers, and invocation methods', () {
      final s = readonly<int>(42);

      // Verify toString()
      expect(s.toString(), '42');

      // Verify toJson()
      expect(s.toJson(), 42);

      // Verify call()
      expect(s(), 42);

      // Verify get()
      expect(s.get(), 42);

      // Verify peek()
      expect(s.peek(), 42);
    });
  });
}
