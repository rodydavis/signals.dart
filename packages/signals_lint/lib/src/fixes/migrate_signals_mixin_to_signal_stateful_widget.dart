import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a deprecated
/// `SignalsMixin` usage on a `State` class to extend the reactive [SignalStatefulWidget] instead.
///
/// :::important
/// Since `SignalsMixin` is deprecated in `signals` v7, this automated quick-fix does two things:
/// 1. Removes `SignalsMixin` from your State class's `with` clause.
/// 2. Changes the parent widget class's superclass from `StatefulWidget` to `SignalStatefulWidget`.
/// This results in a cleaner, highly optimized codebase that runs with zero unnecessary overhead.
/// :::
///
/// ### How to use
/// 1. Place your cursor on the `SignalsMixin` name in the State's class signature.
/// 2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
/// 3. Select the **Migrate SignalsMixin to SignalStatefulWidget** assist option.
///
/// ### Examples
///
/// **Before:**
/// ```dart
/// class MyWidget extends StatefulWidget {
///   const MyWidget({super.key});
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> with SignalsMixin { // LINT: Deprecated SignalsMixin
///   @override
///   Widget build(BuildContext context) {
///     return Text('${counter.value}');
///   }
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// class MyWidget extends SignalStatefulWidget {
///   const MyWidget({super.key});
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   @override
///   Widget build(BuildContext context) {
///     return Text('${counter.value}'); // OK
///   }
/// }
/// ```
class MigrateSignalsMixinToSignalStatefulWidget extends DartAssist {
  MigrateSignalsMixinToSignalStatefulWidget();

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addClassDeclaration((node) {
      final withClause = node.withClause;
      if (withClause == null) return;

      final signalsMixinType = withClause.mixinTypes.firstWhereOrNull(
        (t) => t.name.lexeme == 'SignalsMixin',
      );
      if (signalsMixinType == null) return;

      if (!target.intersects(signalsMixinType.sourceRange) &&
          !target.intersects(withClause.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Migrate SignalsMixin to SignalStatefulWidget',
        priority: 7,
      );

      changeBuilder.addDartFileEdit((builder) {
        // 1. Remove SignalsMixin from the with clause
        final otherMixins = withClause.mixinTypes
            .where((t) => t != signalsMixinType)
            .map((t) => t.toSource())
            .join(', ');

        final mixinReplacement =
            otherMixins.isEmpty ? '' : ' with $otherMixins';
        builder.addSimpleReplacement(withClause.sourceRange, mixinReplacement);

        // 2. Try to find the parent StatefulWidget and change it to SignalStatefulWidget
        final extendsClause = node.extendsClause;
        if (extendsClause != null) {
          final superclass = extendsClause.superclass;
          if (superclass.name.lexeme == 'State') {
            final typeArgs = superclass.typeArguments;
            if (typeArgs != null && typeArgs.arguments.isNotEmpty) {
              final widgetName = typeArgs.arguments.first.toSource();
              final unit = node.thisOrAncestorOfType<CompilationUnit>();
              if (unit != null) {
                ClassDeclaration? widgetClass;
                for (final declaration in unit.declarations) {
                  if (declaration is ClassDeclaration &&
                      declaration.name.lexeme == widgetName) {
                    widgetClass = declaration;
                    break;
                  }
                }

                if (widgetClass != null) {
                  final widgetExtends = widgetClass.extendsClause;
                  if (widgetExtends != null &&
                      widgetExtends.superclass.name.lexeme ==
                          'StatefulWidget') {
                    builder.addSimpleReplacement(
                      widgetExtends.superclass.sourceRange,
                      'SignalStatefulWidget',
                    );
                  }
                }
              }
            }
          }
        }
      });
    });
  }
}
