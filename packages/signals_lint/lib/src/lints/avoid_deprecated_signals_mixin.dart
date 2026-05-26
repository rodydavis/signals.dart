// ignore_for_file: deprecated_member_use
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _errorMessage =
    'SignalsMixin is deprecated in v7 to avoid unnecessary state overhead.';
const _correctionMessage =
    'Migrate your widget to extend SignalWidget / SignalStatefulWidget, or use SignalBuilder to surgically wrap only the rebuildable widgets.';

/// A Dart static analysis rule that detects and warns against using the deprecated `SignalsMixin` in v7.
///
/// :::warning
/// In `signals` v7, `SignalsMixin` was deprecated to avoid unnecessary state tracking and
/// CPU/memory overhead. For optimal performance and a cleaner reactive codebase, you should
/// migrate to specialized widgets like [SignalWidget], [SignalStatefulWidget], or [SignalBuilder].
/// :::
///
/// ### Examples
///
/// **Incorrect:**
/// ```dart
/// class MyWidget extends StatefulWidget with SignalsMixin { // LINT: Deprecated SignalsMixin
///   @override
///   Widget build(BuildContext context) {
///     return Text('${counter.value}');
///   }
/// }
/// ```
///
/// **Correct (using SignalWidget):**
/// ```dart
/// class MyWidget extends SignalWidget {
///   const MyWidget({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Text('${counter.value}'); // OK: Rebuilds are handled implicitly and efficiently
///   }
/// }
/// ```
class SignalsAvoidDeprecatedSignalsMixin extends DartLintRule {
  const SignalsAvoidDeprecatedSignalsMixin() : super(code: _code);

  static const _code = LintCode(
    name: 'signals_avoid_deprecated_signals_mixin',
    problemMessage: _errorMessage,
    correctionMessage: _correctionMessage,
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final withClause = node.withClause;
      if (withClause == null) return;

      for (final mixinType in withClause.mixinTypes) {
        final element = mixinType.element;
        if (element != null && element.name == 'SignalsMixin') {
          reporter.atNode(mixinType, code);
          return;
        }
        // Fallback name matching if type resolution is incomplete
        if (mixinType.name.lexeme == 'SignalsMixin') {
          reporter.atNode(mixinType, code);
          return;
        }
      }
    });
  }
}
