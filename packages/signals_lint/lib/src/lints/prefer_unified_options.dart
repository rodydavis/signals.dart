// ignore_for_file: deprecated_member_use
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

const _errorMessage =
    'Positional or direct named parameters for signal configuration are deprecated in v7.';
const _correctionMessage =
    'Bundle configuration parameters under a unified options object (e.g. SignalOptions, ComputedOptions, AsyncSignalOptions).';

/// A Dart static analysis rule that detects deprecated positional or scattered named configuration
/// parameters for signals and ensures they are bundled under a unified options object.
class SignalsPreferUnifiedOptions extends AnalysisRule {
  SignalsPreferUnifiedOptions()
      : super(
          name: 'signals_prefer_unified_options',
          description: 'Prefer unified options object for signal configurations.',
        );

  static const _code = LintCode(
    'signals_prefer_unified_options',
    _errorMessage,
    correctionMessage: _correctionMessage,
  );

  @override
  LintCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addMethodInvocation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final SignalsPreferUnifiedOptions rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  static const creatorNames = {
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
    'mutationSignal',
    'computedFrom',
    'computedAsync',
    'linkedSignal',
  };

  static const deprecatedParams = {
    'autoDispose',
    'debugLabel',
    'lazy',
    'initialValue',
  };

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final name = node.methodName.name;
    if (!creatorNames.contains(name)) return;

    final arguments = node.argumentList.arguments;
    for (final argument in arguments) {
      if (argument is NamedExpression) {
        final paramName = argument.name.label.name;
        if (deprecatedParams.contains(paramName)) {
          rule.reportAtNode(argument);
          return;
        }
      }
    }
  }
}
