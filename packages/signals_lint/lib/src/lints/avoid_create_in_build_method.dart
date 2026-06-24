// ignore_for_file: deprecated_member_use
import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import '../utils.dart';

const buildMethod = 'build';

const _errorMessage = '''
Signals should not be created in the build method because will 
create a new signal every time the element is rebuilt.
''';

const _correctionMessage = '''
Create the new signals outside the build() method in the class or globally.

For StatelessWidgets you can define the signals as a static variable, pass in 
from the constructor or declare globally.

```diff
+ final counter = signal(0);
...
@override
Widget build(BuildContext context) {
- final counter = signal(0);
  return ...;   
}
```
''';

/// A Dart lint rule that checks and reports instances where a signal or computed
/// variable is created directly inside Flutter's `build(BuildContext context)` method.
class SignalsAvoidCreateInBuildMethod extends AnalysisRule {
  SignalsAvoidCreateInBuildMethod()
      : super(
          name: 'signals_avoid_create_in_build_method',
          description: 'Avoid creating signals inside Flutter build methods.',
        );

  static const _code = LintCode(
    'signals_avoid_create_in_build_method',
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
    registry.addVariableDeclaration(this, visitor);
    registry.addInstanceCreationExpression(this, visitor);
    registry.addMethodInvocation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final SignalsAvoidCreateInBuildMethod rule;
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

  void checkNode(AstNode node, DartType? type, String? name) {
    final isCreator = (name != null && creatorNames.contains(name)) ||
        (type != null && (
          isTypeOf(type, 'Signal', 'signals_core') ||
          isTypeOf(type, 'ReadonlySignal', 'signals_core') ||
          isTypeOf(type, 'Computed', 'signals_core') ||
          isTypeOf(type, 'SignalValueNotifier', 'signals_flutter') ||
          isTypeOf(type, 'SignalValueListenable', 'signals_flutter')
        ));

    if (!isCreator) return;

    final ancestor = node.thisOrAncestorMatching((method) {
      final isMethod =
          method is MethodDeclaration && method.name.lexeme == buildMethod;
      if (!isMethod) return false;

      return _findStateClass(node) != null;
    });

    if (ancestor != null) {
      rule.reportAtNode(node);
    }
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    final fragment = node.declaredFragment;
    final element = fragment?.element;
    if (element == null) return;
    checkNode(node, element.type, null);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final type = node.staticType;
    checkNode(node, type, null);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final name = node.methodName.name;
    final type = node.staticType;
    checkNode(node, type, name);
  }
}

const stateClassPackage = 'flutter';
const stateClassName = 'State';
const statelessWidgetName = 'StatelessWidget';

AstNode? _findStateClass(AstNode node) {
  return node.parent?.thisOrAncestorMatching((node) {
    if (node is! ClassDeclaration) return false;

    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;
    final extendsType = extendsClause.superclass.type;
    if (extendsType == null) return false;

    return isTypeOf(extendsType, stateClassName, stateClassPackage) ||
        isTypeOf(extendsType, statelessWidgetName, stateClassPackage);
  });
}
