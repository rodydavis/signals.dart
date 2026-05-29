import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';


void main() {
  SignalsObserver.instance = null;

  group('computedFrom overloads and record extensions', () {
    test('computedFrom1 & ComputedFromExt1', () async {
      final s1 = signal(1);
      
      // Global function
      final f1 = computedFrom1<String, int>(s1, (a) => 'val: $a');
      expect(f1.peek().isLoading, true);
      await f1.future;
      expect(f1.value.requireValue, 'val: 1');

      // Record extension
      final ext1 = (s1,).computedFrom((a) => 'ext: $a');
      expect(ext1.peek().isLoading, true);
      await ext1.future;
      expect(ext1.value.requireValue, 'ext: 1');
    });

    test('computedFrom2 & ComputedFromExt2', () async {
      final s1 = signal(1);
      final s2 = signal('a');

      // Global function
      final f2 = computedFrom2<String, int, String>(s1, s2, (a, b) => '$a$b');
      await f2.future;
      expect(f2.value.requireValue, '1a');

      // Record extension
      final ext2 = (s1, s2).computedFrom((a, b) => '$b$a');
      await ext2.future;
      expect(ext2.value.requireValue, 'a1');

      // Reactive update
      s1.value = 2;
      await f2.future;
      expect(f2.value.requireValue, '2a');
    });

    test('computedFrom3 & ComputedFromExt3', () async {
      final s1 = signal(1);
      final s2 = signal('a');
      final s3 = signal(true);

      final f = computedFrom3<String, int, String, bool>(s1, s2, s3, (a, b, c) => '$a$b$c');
      await f.future;
      expect(f.value.requireValue, '1atrue');

      final ext = (s1, s2, s3).computedFrom((a, b, c) => '$c$b$a');
      await ext.future;
      expect(ext.value.requireValue, 'truea1');
    });

    test('computedFrom4 & ComputedFromExt4', () async {
      final s1 = signal(1);
      final s2 = signal(2);
      final s3 = signal(3);
      final s4 = signal(4);

      final f = computedFrom4<int, int, int, int, int>(s1, s2, s3, s4, (a, b, c, d) => a + b + c + d);
      await f.future;
      expect(f.value.requireValue, 10);

      final ext = (s1, s2, s3, s4).computedFrom((a, b, c, d) => a * b * c * d);
      await ext.future;
      expect(ext.value.requireValue, 24);
    });

    test('computedFrom5 & ComputedFromExt5', () async {
      final s1 = signal(1);
      final s2 = signal(1);
      final s3 = signal(1);
      final s4 = signal(1);
      final s5 = signal(1);

      final f = computedFrom5<int, int, int, int, int, int>(s1, s2, s3, s4, s5, (a, b, c, d, e) => a + b + c + d + e);
      await f.future;
      expect(f.value.requireValue, 5);

      final ext = (s1, s2, s3, s4, s5).computedFrom((a, b, c, d, e) => '$a$b$c$d$e');
      await ext.future;

      expect(ext.value.requireValue, '11111');
    });

    test('computedFrom6 & ComputedFromExt6', () async {
      final s = signal(1);
      final f = computedFrom6<int, int, int, int, int, int, int>(s, s, s, s, s, s, (a, b, c, d, e, g) => a + b + c + d + e + g);
      await f.future;
      expect(f.value.requireValue, 6);

      final ext = (s, s, s, s, s, s).computedFrom((a, b, c, d, e, g) => a + b + c + d + e + g);
      await ext.future;
      expect(ext.value.requireValue, 6);
    });

    test('computedFrom7 & ComputedFromExt7', () async {
      final s = signal(1);
      final f = computedFrom7<int, int, int, int, int, int, int, int>(s, s, s, s, s, s, s, (a, b, c, d, e, g, h) => a + b + c + d + e + g + h);
      await f.future;
      expect(f.value.requireValue, 7);

      final ext = (s, s, s, s, s, s, s).computedFrom((a, b, c, d, e, g, h) => a + b + c + d + e + g + h);
      await ext.future;
      expect(ext.value.requireValue, 7);
    });

    test('computedFrom8 & ComputedFromExt8', () async {
      final s = signal(1);
      final f = computedFrom8<int, int, int, int, int, int, int, int, int>(s, s, s, s, s, s, s, s, (a, b, c, d, e, g, h, i) => a + b + c + d + e + g + h + i);
      await f.future;
      expect(f.value.requireValue, 8);

      final ext = (s, s, s, s, s, s, s, s).computedFrom((a, b, c, d, e, g, h, i) => a + b + c + d + e + g + h + i);
      await ext.future;
      expect(ext.value.requireValue, 8);
    });

    test('computedFrom9 & ComputedFromExt9', () async {
      final s = signal(1);
      final f = computedFrom9<int, int, int, int, int, int, int, int, int, int>(s, s, s, s, s, s, s, s, s, (a, b, c, d, e, g, h, i, j) => a + b + c + d + e + g + h + i + j);
      await f.future;
      expect(f.value.requireValue, 9);

      final ext = (s, s, s, s, s, s, s, s, s).computedFrom((a, b, c, d, e, g, h, i, j) => a + b + c + d + e + g + h + i + j);
      await ext.future;
      expect(ext.value.requireValue, 9);
    });

    test('computedFrom10 & ComputedFromExt10', () async {
      final s = signal(1);
      final f = computedFrom10<int, int, int, int, int, int, int, int, int, int, int>(s, s, s, s, s, s, s, s, s, s, (a, b, c, d, e, g, h, i, j, k) => a + b + c + d + e + g + h + i + j + k);
      await f.future;
      expect(f.value.requireValue, 10);

      final ext = (s, s, s, s, s, s, s, s, s, s).computedFrom((a, b, c, d, e, g, h, i, j, k) => a + b + c + d + e + g + h + i + j + k);
      await ext.future;
      expect(ext.value.requireValue, 10);
    });
  });
}
