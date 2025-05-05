import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const TypeChecker buildContextType = TypeChecker.fromName(
  'BuildContext',
  packageName: 'flutter',
);

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

class SignalsAvoidCreateInBuildMethod extends DartLintRule {
  const SignalsAvoidCreateInBuildMethod() : super(code: _code);

  static const _code = LintCode(
    name: 'signals_avoid_create_in_build_method',
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
    const types = [
      TypeChecker.fromName(
        'Signal',
        packageName: 'signals_core',
      ),
      TypeChecker.fromName(
        'Computed',
        packageName: 'signals_core',
      ),
      TypeChecker.fromName(
        'SignalValueNotifier',
        packageName: 'signals_flutter',
      ),
      TypeChecker.fromName(
        'SignalValueListenable',
        packageName: 'signals_flutter',
      ),
    ];

    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      final ancestor = node.thisOrAncestorMatching((method) {
        final isMethod = method is MethodDeclaration && method.name.lexeme == buildMethod;
        if (!isMethod) return false;

        if (_findStateClass(node) != null) {
          return types.any((e) => e.isAssignableFromType(element.type));
        }

        return false;
      });

      if (ancestor != null) {
        reporter.atElement(element, code);
      }
    });
  }
}

const TypeChecker stateClass = TypeChecker.fromName(
  'State',
  packageName: 'flutter',
);

const TypeChecker statelessClass = TypeChecker.fromName(
  'StatelessWidget',
  packageName: 'flutter',
);

AstNode? _findStateClass(AstNode node) {
  return node.parent?.thisOrAncestorMatching((node) {
    if (node is! ClassDeclaration) return false;

    /// Looking for the class which is a [ConsumerState]
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;
    final extendsType = extendsClause.superclass.type;
    if (extendsType == null) return false;

    return stateClass.isExactlyType(extendsType) || statelessClass.isExactlyType(extendsType);
  });
}
