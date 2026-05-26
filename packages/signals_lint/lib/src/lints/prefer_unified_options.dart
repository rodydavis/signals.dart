// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _errorMessage =
    'Positional or direct named parameters for signal configuration are deprecated in v7.';
const _correctionMessage =
    'Bundle configuration parameters under a unified options object (e.g. SignalOptions, ComputedOptions, AsyncSignalOptions).';

/// A Dart static analysis rule that detects deprecated positional or scattered named configuration
/// parameters for signals and ensures they are bundled under a unified options object.
///
/// :::important
/// In `signals` v7, parameters like `autoDispose`, `equals`, or custom comparators are no longer
/// passed directly as separate parameters to signal creators. Instead, they must be bundled into
/// a unified, type-safe configuration object (such as [SignalOptions], [ComputedOptions], or [AsyncSignalOptions]).
/// :::
///
/// ### Examples
///
/// **Incorrect:**
/// ```dart
/// final counter = signal(0, autoDispose: true); // LINT: Scattered configuration parameters
/// ```
///
/// **Correct:**
/// ```dart
/// final counter = signal(
///   0,
///   options: SignalOptions(autoDispose: true), // OK: Unified options object
/// );
/// ```
class SignalsPreferUnifiedOptions extends DartLintRule {
  const SignalsPreferUnifiedOptions() : super(code: _code);

  static const _code = LintCode(
    name: 'signals_prefer_unified_options',
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
    const creatorNames = {
      'signal',
      'computed',
      'listSignal',
      'setSignal',
      'mapSignal',
      'iterableSignal',
      'queueSignal',
      'futureSignal',
      'streamSignal',
      'asyncSignal',
      'computedFrom',
      'computedAsync',
      'linkedSignal',
    };

    const deprecatedParams = {
      'autoDispose',
      'debugLabel',
      'lazy',
      'initialValue',
    };

    context.registry.addMethodInvocation((node) {
      final name = node.methodName.name;
      if (!creatorNames.contains(name)) return;

      final arguments = node.argumentList.arguments;
      for (final argument in arguments) {
        if (argument is NamedExpression) {
          final paramName = argument.name.label.name;
          if (deprecatedParams.contains(paramName)) {
            reporter.atNode(argument, code);
            return;
          }
        }
      }
    });
  }
}
