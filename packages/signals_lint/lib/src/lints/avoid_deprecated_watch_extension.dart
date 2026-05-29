// ignore_for_file: deprecated_member_use
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import '../utils.dart';

const _errorMessage =
    'Use of deprecated BuildContext.watch() or BuildContext.unwatch() extensions is discouraged in v7.';
const _correctionMessage =
    'Migrate to SignalBuilder, SignalWidget, or SignalStatefulWidget for implicit and safer reactive updates.';

/// A Dart static analysis rule that detects and warns against using the deprecated
/// `.watch(context)` and `.unwatch(context)` extension methods in v7.
class SignalsAvoidDeprecatedWatchExtension extends AnalysisRule {
  SignalsAvoidDeprecatedWatchExtension()
      : super(
          name: 'signals_avoid_deprecated_watch_extension',
          description: 'Avoid deprecated BuildContext.watch() or BuildContext.unwatch() extensions.',
        );

  static const _code = LintCode(
    'signals_avoid_deprecated_watch_extension',
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
  final SignalsAvoidDeprecatedWatchExtension rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final name = node.methodName.name;
    if (name == 'watch') {
      final target = node.realTarget;
      if (target != null) {
        final type = target.staticType;
        if (type != null && (
          isTypeOf(type, 'Signal', 'signals_core') ||
          isTypeOf(type, 'ReadonlySignal', 'signals_core') ||
          isTypeOf(type, 'Computed', 'signals_core')
        )) {
          rule.reportAtNode(node.methodName);
        }
      }
    }
  }
}
