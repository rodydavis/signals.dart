// ignore_for_file: deprecated_member_use
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';
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

/// A Dart lint rule that checks and reports instances where a signal or computed
/// variable is created directly inside Flutter's `build(BuildContext context)` method.
///
/// :::caution
/// Creating a signal inside the build method is a severe reactive anti-pattern.
/// On every widget rebuild, a brand new signal instance is created, resetting its value
/// and breaking state persistence. This can lead to bugs, infinite rebuild loops, and
/// high memory consumption.
/// :::
///
/// ### Examples
///
/// **Incorrect:**
/// ```dart
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final counter = signal(0); // LINT: Created in build() method
///     return Text('${counter.value}');
///   }
/// }
/// ```
///
/// **Correct:**
/// ```dart
/// class MyWidget extends StatelessWidget {
///   // Define signals outside the build method (e.g. as a field, in an InheritedWidget, or global)
///   final counter = signal(0);
///
///   @override
///   Widget build(BuildContext context) {
///     return Text('${counter.value}');
///   }
/// }
/// ```
///
/// ### How to suppress
/// If you have a highly specific edge case and need to ignore this lint, you can suppress it by adding
/// a line-level comment:
/// ```dart
/// // ignore: signals_avoid_create_in_build_method
/// final mySignal = signal(42);
/// ```
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
        'ReadonlySignal',
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

    void checkNode(AstNode node, DartType? type, String? name) {
      final isCreator = (name != null && creatorNames.contains(name)) ||
          (type != null && types.any((e) => e.isAssignableFromType(type)));

      if (!isCreator) return;

      final ancestor = node.thisOrAncestorMatching((method) {
        final isMethod =
            method is MethodDeclaration && method.name.lexeme == buildMethod;
        if (!isMethod) return false;

        return _findStateClass(node) != null;
      });

      if (ancestor != null) {
        reporter.atNode(node, code);
      }
    }

    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;
      checkNode(node, element.type, null);
    });

    context.registry.addInstanceCreationExpression((node) {
      final type = node.staticType;
      checkNode(node, type, null);
    });

    context.registry.addMethodInvocation((node) {
      final name = node.methodName.name;
      final type = node.staticType;
      checkNode(node, type, name);
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

    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;
    final extendsType = extendsClause.superclass.type;
    if (extendsType == null) return false;

    return stateClass.isAssignableFromType(extendsType) ||
        statelessClass.isAssignableFromType(extendsType);
  });
}
