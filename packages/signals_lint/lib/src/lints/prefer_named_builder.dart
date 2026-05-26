// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _errorMessage =
    'Use of positional builder arguments in Watch / SignalBuilder is discouraged.';
const _correctionMessage =
    'Use the named "builder:" parameter to ensure compatibility and consistency with the v7 API.';

/// A Dart static analysis rule that detects positional builder parameters in `Watch`
/// or `SignalBuilder` constructors and encourages using the named `builder` argument.
///
/// :::note
/// In `signals` v7, to make the API more readable and consistent with standard Flutter components,
/// `Watch` and `SignalBuilder` support the named `builder` parameter. Using positional
/// parameters can be harder to read and may be deprecated in future versions.
/// :::
///
/// ### Examples
///
/// **Incorrect:**
/// ```dart
/// Watch((context) { // LINT: Positional builder argument
///   return Text('${counter.value}');
/// });
/// ```
///
/// **Correct:**
/// ```dart
/// Watch(
///   builder: (context) => Text('${counter.value}'), // OK: Named builder parameter
/// );
/// ```
class SignalsPreferNamedBuilder extends DartLintRule {
  const SignalsPreferNamedBuilder() : super(code: _code);

  static const _code = LintCode(
    name: 'signals_prefer_named_builder',
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
    context.registry.addInstanceCreationExpression((node) {
      final name = node.constructorName.type.element?.name;
      if (name != 'SignalBuilder' && name != 'Watch') return;

      final arguments = node.argumentList.arguments;
      for (final argument in arguments) {
        if (argument is! NamedExpression) {
          reporter.atNode(argument, code);
          return;
        }
      }
    });
  }
}
