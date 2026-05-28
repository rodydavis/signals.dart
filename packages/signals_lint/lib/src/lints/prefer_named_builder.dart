// ignore_for_file: deprecated_member_use
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

const _errorMessage =
    'Use of positional builder arguments in Watch / SignalBuilder is discouraged.';
const _correctionMessage =
    'Use the named "builder:" parameter to ensure compatibility and consistency with the v7 API.';

/// A Dart static analysis rule that detects positional builder parameters in `Watch`
/// or `SignalBuilder` constructors and encourages using the named `builder` argument.
class SignalsPreferNamedBuilder extends AnalysisRule {
  SignalsPreferNamedBuilder()
      : super(
          name: 'signals_prefer_named_builder',
          description: 'Prefer named builder parameter in Watch/SignalBuilder.',
        );

  static const _code = LintCode(
    'signals_prefer_named_builder',
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
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final SignalsPreferNamedBuilder rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final name = node.constructorName.type.element?.name;
    if (name != 'SignalBuilder' && name != 'Watch') return;

    final arguments = node.argumentList.arguments;
    for (final argument in arguments) {
      if (argument is! NamedArgument) {
        rule.reportAtNode(argument);
        return;
      }
    }
  }
}
