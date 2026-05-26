import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

// A mock store for testing
class MockStore extends SignalsInMemoryKeyValueStore {}

enum TestEnum { a, b, c }

void main() {
  late MockStore store;

  setUp(() {
    store = MockStore();
    SignalsKeyValueStore.defaultStore = store;
  });

  group('Persisted Signals', () {
    group('PersistedBoolSignal', () {
      test('it should persist a bool value', () async {
        final signal = PersistedBoolSignal(true, 'bool_key');
        await signal.init();
        expect(signal.value, true);

        signal.value = false;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('bool_key');
        expect(item, 'false');

        final signal2 = PersistedBoolSignal(true, 'bool_key');
        await signal2.init();
        expect(signal2.value, false);
      });
    });

    group('PersistedNullableBoolSignal', () {
      test('it should persist a nullable bool value', () async {
        final signal = PersistedNullableBoolSignal(true, 'nullable_bool_key');
        await signal.init();
        expect(signal.value, true);

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_bool_key');
        expect(item, '');

        final signal2 = PersistedNullableBoolSignal(true, 'nullable_bool_key');
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedDoubleSignal', () {
      test('it should persist a double value', () async {
        final signal = PersistedDoubleSignal(1.0, 'double_key');
        await signal.init();
        expect(signal.value, 1.0);

        signal.value = 2.0;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('double_key');
        expect(item, '2.0');

        final signal2 = PersistedDoubleSignal(1.0, 'double_key');
        await signal2.init();
        expect(signal2.value, 2.0);
      });
    });

    group('PersistedNullableDoubleSignal', () {
      test('it should persist a nullable double value', () async {
        final signal =
            PersistedNullableDoubleSignal(1.0, 'nullable_double_key');
        await signal.init();
        expect(signal.value, 1.0);

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_double_key');
        expect(item, '');

        final signal2 =
            PersistedNullableDoubleSignal(1.0, 'nullable_double_key');
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedEnumSignal', () {
      test('it should persist an enum value', () async {
        final signal =
            PersistedEnumSignal(TestEnum.a, 'enum_key', TestEnum.values);
        await signal.init();
        expect(signal.value, TestEnum.a);

        signal.value = TestEnum.b;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('enum_key');
        expect(item, 'b');

        final signal2 =
            PersistedEnumSignal(TestEnum.a, 'enum_key', TestEnum.values);
        await signal2.init();
        expect(signal2.value, TestEnum.b);
      });
    });

    group('PersistedNullableEnumSignal', () {
      test('it should persist a nullable enum value', () async {
        final signal = PersistedNullableEnumSignal(
          TestEnum.a,
          'nullable_enum_key',
          TestEnum.values,
        );
        await signal.init();
        expect(signal.value, TestEnum.a);

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_enum_key');
        expect(item, '');

        final signal2 = PersistedNullableEnumSignal(
          TestEnum.a,
          'nullable_enum_key',
          TestEnum.values,
        );
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedIntSignal', () {
      test('it should persist an int value', () async {
        final signal = PersistedIntSignal(1, 'int_key');
        await signal.init();
        expect(signal.value, 1);

        signal.value = 2;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('int_key');
        expect(item, '2');

        final signal2 = PersistedIntSignal(1, 'int_key');
        await signal2.init();
        expect(signal2.value, 2);
      });
    });

    group('PersistedNullableIntSignal', () {
      test('it should persist a nullable int value', () async {
        final signal = PersistedNullableIntSignal(1, 'nullable_int_key');
        await signal.init();
        expect(signal.value, 1);

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_int_key');
        expect(item, '');

        final signal2 = PersistedNullableIntSignal(1, 'nullable_int_key');
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedNumSignal', () {
      test('it should persist a num value', () async {
        final signal = PersistedNumSignal(1, 'num_key');
        await signal.init();
        expect(signal.value, 1);

        signal.value = 2.5;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('num_key');
        expect(item, '2.5');

        final signal2 = PersistedNumSignal(1, 'num_key');
        await signal2.init();
        expect(signal2.value, 2.5);
      });
    });

    group('PersistedNullableNumSignal', () {
      test('it should persist a nullable num value', () async {
        final signal = PersistedNullableNumSignal(1, 'nullable_num_key');
        await signal.init();
        expect(signal.value, 1);

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_num_key');
        expect(item, '');

        final signal2 = PersistedNullableNumSignal(1, 'nullable_num_key');
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedStringSignal', () {
      test('it should persist a string value', () async {
        final signal = PersistedStringSignal('a', 'string_key');
        await signal.init();
        expect(signal.value, 'a');

        signal.value = 'b';
        await Future.delayed(Duration.zero);
        final item = await store.getItem('string_key');
        expect(item, 'b');

        final signal2 = PersistedStringSignal('a', 'string_key');
        await signal2.init();
        expect(signal2.value, 'b');
      });
    });

    group('PersistedNullableStringSignal', () {
      test('it should persist a nullable string value', () async {
        final signal =
            PersistedNullableStringSignal('a', 'nullable_string_key');
        await signal.init();
        expect(signal.value, 'a');

        signal.value = null;
        await Future.delayed(Duration.zero);
        final item = await store.getItem('nullable_string_key');
        expect(item, '');

        final signal2 =
            PersistedNullableStringSignal('a', 'nullable_string_key');
        await signal2.init();
        expect(signal2.value, null);
      });
    });

    group('PersistedSignal', () {
      test('it should persist a json value', () async {
        final signal = PersistedSignal<Map<String, dynamic>>(
          {'a': 1},
          key: 'json_key',
          store: store,
        );
        await signal.init();
        expect(signal.value, {'a': 1});

        signal.value = {'b': 2};
        await Future.delayed(Duration.zero);
        final item = await store.getItem('json_key');
        expect(item, '{"b":2}');

        final signal2 = PersistedSignal<Map<String, dynamic>>(
          {'a': 1},
          key: 'json_key',
          store: store,
        );
        await signal2.init();
        expect(signal2.value, {'b': 2});
      });
    });

    group('Nullable Persisted Signal direct encode/decode fallback coverage', () {
      test('PersistedNullableBoolSignal', () {
        final signal = PersistedNullableBoolSignal(null, 'test');
        expect(signal.encode(null), '');
        expect(signal.encode(true), 'true');
        expect(signal.encode(false), 'false');
        expect(signal.decode(''), isNull);
        expect(signal.decode('true'), true);
      });
      test('PersistedNullableDoubleSignal', () {
        final signal = PersistedNullableDoubleSignal(null, 'test');
        expect(signal.encode(null), '');
        expect(signal.encode(1.23), '1.23');
        expect(signal.decode(''), isNull);
        expect(signal.decode('1.23'), 1.23);
      });
      test('PersistedNullableEnumSignal', () {
        final signal = PersistedNullableEnumSignal<TestEnum>(null, 'test', TestEnum.values);
        expect(signal.encode(null), '');
        expect(signal.encode(TestEnum.b), 'b');
        expect(signal.decode(''), isNull);
        expect(signal.decode('b'), TestEnum.b);
      });
      test('PersistedNullableIntSignal', () {
        final signal = PersistedNullableIntSignal(null, 'test');
        expect(signal.encode(null), '');
        expect(signal.encode(42), '42');
        expect(signal.decode(''), isNull);
        expect(signal.decode('42'), 42);
      });
      test('PersistedNullableNumSignal', () {
        final signal = PersistedNullableNumSignal(null, 'test');
        expect(signal.encode(null), '');
        expect(signal.encode(4.2), '4.2');
        expect(signal.decode(''), isNull);
        expect(signal.decode('4.2'), 4.2);
      });
      test('PersistedNullableStringSignal', () {
        final signal = PersistedNullableStringSignal(null, 'test');
        expect(signal.encode(null), '');
        expect(signal.encode('hello'), 'hello');
        expect(signal.decode(''), isNull);
        expect(signal.decode('hello'), 'hello');
      });
    });
  });
}
