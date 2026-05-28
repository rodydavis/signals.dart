// ignore_for_file: non_constant_identifier_names
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';
import 'package:signals_lint/src/lints/avoid_create_in_build_method.dart';
import 'package:signals_lint/src/lints/avoid_deprecated_signals_mixin.dart';
import 'package:signals_lint/src/lints/avoid_deprecated_watch_extension.dart';
import 'package:signals_lint/src/lints/prefer_named_builder.dart';
import 'package:signals_lint/src/lints/prefer_unified_options.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AvoidCreateInBuildMethodTest);
    defineReflectiveTests(AvoidDeprecatedSignalsMixinTest);
    defineReflectiveTests(AvoidDeprecatedWatchExtensionTest);
    defineReflectiveTests(PreferNamedBuilderTest);
    defineReflectiveTests(PreferUnifiedOptionsTest);
  });
}

@reflectiveTest
class AvoidCreateInBuildMethodTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = SignalsAvoidCreateInBuildMethod();
    newPackage('flutter').addFile('lib/flutter.dart', r'''
class Widget {}
class BuildContext {}
class StatelessWidget extends Widget {
  Widget build(BuildContext context) => Widget();
}
class State<T extends Widget> {
  Widget build(BuildContext context) => Widget();
}
''');
    newPackage('signals_core').addFile('lib/signals_core.dart', r'''
class Signal<T> {}
Signal<T> signal<T>(T value) => Signal<T>();
''');
    newPackage('signals').addFile('lib/signals.dart', r'''
export 'package:signals_core/signals_core.dart';
''');
    super.setUp();
  }

  Future<void> test_reports_create_in_build_method() async {
    const code = r'''
import 'package:flutter/flutter.dart';
import 'package:signals/signals.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = signal(0);
    return Widget();
  }
}
''';
    final offset1 = code.indexOf('final s = signal(0)');
    final length1 = 'final s = signal(0)'.length;
    final offset2 = code.indexOf('signal(0)');
    final length2 = 'signal(0)'.length;

    await assertDiagnostics(code, [
      lint(offset1 + 6, length1 - 6), // Matches 's = signal(0)'
      lint(offset2, length2),         // Matches 'signal(0)'
    ]);
  }
}

@reflectiveTest
class AvoidDeprecatedSignalsMixinTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = SignalsAvoidDeprecatedSignalsMixin();
    super.setUp();
  }

  Future<void> test_reports_deprecated_mixin() async {
    const code = r'''
class State {}
mixin SignalsMixin {}
class _MyWidgetState extends State with SignalsMixin {}
''';
    final offset = code.lastIndexOf('SignalsMixin');
    final length = 'SignalsMixin'.length;

    await assertDiagnostics(code, [
      lint(offset, length),
    ]);
  }
}

@reflectiveTest
class AvoidDeprecatedWatchExtensionTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = SignalsAvoidDeprecatedWatchExtension();
    newPackage('flutter').addFile('lib/flutter.dart', r'''
class BuildContext {}
''');
    newPackage('signals_core').addFile('lib/signals_core.dart', r'''
import 'package:flutter/flutter.dart';
class Signal<T> {
  void watch(BuildContext context) {}
}
Signal<T> signal<T>(T value) => Signal<T>();
''');
    newPackage('signals').addFile('lib/signals.dart', r'''
export 'package:signals_core/signals_core.dart';
''');
    super.setUp();
  }

  Future<void> test_reports_deprecated_watch() async {
    const code = r'''
import 'package:flutter/flutter.dart';
import 'package:signals/signals.dart';

void foo(BuildContext context, Signal<int> s) {
  s.watch(context);
}
''';
    final offset = code.lastIndexOf('watch');
    final length = 'watch'.length;

    await assertDiagnostics(code, [
      lint(offset, length),
    ]);
  }
}

@reflectiveTest
class PreferNamedBuilderTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = SignalsPreferNamedBuilder();
    newPackage('signals_flutter').addFile('lib/signals_flutter.dart', r'''
class SignalBuilder {
  SignalBuilder([dynamic builder]);
  SignalBuilder.builder([dynamic builder]);
}
''');
    super.setUp();
  }

  Future<void> test_reports_unnamed_builder() async {
    const code = r'''
import 'package:signals_flutter/signals_flutter.dart';

void foo() {
  final b = new SignalBuilder((context) => null);
}
''';
    final match = '(context) => null';
    final offset = code.indexOf(match);

    await assertDiagnostics(code, [
      lint(offset, match.length),
    ]);
  }
}

@reflectiveTest
class PreferUnifiedOptionsTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = SignalsPreferUnifiedOptions();
    newPackage('signals_core').addFile('lib/signals_core.dart', r'''
class Signal<T> {}
Signal<T> signal<T>(T value, {bool? autoDispose, String? debugLabel}) => Signal<T>();
''');
    super.setUp();
  }

  Future<void> test_reports_fire_immediately_parameter() async {
    const code = r'''
import 'package:signals_core/signals_core.dart';

void foo() {
  final s = signal(0, autoDispose: true);
}
''';
    final match = 'autoDispose: true';
    final offset = code.indexOf(match);

    await assertDiagnostics(code, [
      lint(offset, match.length),
    ]);
  }
}
