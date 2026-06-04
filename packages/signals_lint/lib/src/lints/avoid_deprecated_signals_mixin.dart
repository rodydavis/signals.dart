// ignore_for_file: deprecated_member_use
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

const _errorMessage =
    'SignalsMixin is deprecated in v7 to avoid unnecessary state overhead.';
const _correctionMessage =
    'Migrate your widget to extend SignalWidget / SignalStatefulWidget, or use SignalBuilder to surgically wrap only the rebuildable widgets.';

/// A Dart static analysis rule that detects and warns against using the deprecated `SignalsMixin` in v7.
class SignalsAvoidDeprecatedSignalsMixin extends AnalysisRule {
  SignalsAvoidDeprecatedSignalsMixin()
      : super(
          name: 'signals_avoid_deprecated_signals_mixin',
          description: 'Avoid deprecated SignalsMixin.',
        );

  static const _code = LintCode(
    'signals_avoid_deprecated_signals_mixin',
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
    registry.addClassDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final SignalsAvoidDeprecatedSignalsMixin rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final withClause = node.withClause;
    if (withClause == null) return;

    for (final mixinType in withClause.mixinTypes) {
      final element = mixinType.element;
      if (element != null && element.name == 'SignalsMixin') {
        rule.reportAtNode(mixinType);
        return;
      }
      // Fallback name matching if type resolution is incomplete
      if (mixinType.name.lexeme == 'SignalsMixin') {
        rule.reportAtNode(mixinType);
        return;
      }
    }
  }
}
