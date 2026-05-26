// ignore_for_file: deprecated_member_use
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _errorMessage =
    'Use of deprecated BuildContext.watch() or BuildContext.unwatch() extensions is discouraged in v7.';
const _correctionMessage =
    'Migrate to SignalBuilder, SignalWidget, or SignalStatefulWidget for implicit and safer reactive updates.';

/// A Dart static analysis rule that detects and warns against using the deprecated
/// `.watch(context)` and `.unwatch(context)` extension methods in v7.
///
/// :::warning
/// The `.watch(context)` extension was deprecated in `signals` v7 due to performance concerns
/// and unexpected side effects with Flutter's build lifecycle. Using it can trigger unnecessary
/// widget rebuilds. In v7, you must migrate to specialized reactive components like
/// [SignalBuilder], [SignalWidget], or [SignalStatefulWidget].
/// :::
///
/// ### Examples
///
/// **Incorrect:**
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   final value = counter.watch(context); // LINT: Deprecated watch extension
///   return Text('$value');
/// }
/// ```
///
/// **Correct:**
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return SignalBuilder(
///     builder: (context) => Text('${counter.value}'), // OK
///   );
/// }
/// ```
class SignalsAvoidDeprecatedWatchExtension extends DartLintRule {
  const SignalsAvoidDeprecatedWatchExtension() : super(code: _code);

  static const _code = LintCode(
    name: 'signals_avoid_deprecated_watch_extension',
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
    final readonlySignalType = TypeChecker.fromName(
      'ReadonlySignal',
      packageName: 'signals_core',
    );

    context.registry.addMethodInvocation((node) {
      final name = node.methodName.name;
      if (name != 'watch' && name != 'unwatch') return;

      final target = node.realTarget;
      if (target == null) return;

      final targetType = target.staticType;
      if (targetType == null) return;

      if (readonlySignalType.isAssignableFromType(targetType)) {
        reporter.atNode(node.methodName, code);
      }
    });
  }
}
