import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard
/// `StatelessWidget` to extend the reactive [SignalWidget] instead.
///
/// :::tip
/// By extending `SignalWidget` instead of `StatelessWidget`, your widget automatically registers
/// fine-grained dependency tracking for any signals referenced within its `build` method. It
/// will rebuild automatically when their values change, removing the need for manual listener
/// code or wrapper components.
/// :::
///
/// ### How to use
/// 1. Place your cursor on the widget class declaration (e.g., `class MyWidget extends StatelessWidget`).
/// 2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
/// 3. Select the **Convert to SignalWidget** assist option.
///
/// ### Examples
///
/// **Before:**
/// ```dart
/// class CounterDisplay extends StatelessWidget {
///   const CounterDisplay({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Text('Count: ${counter.value}');
///   }
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// class CounterDisplay extends SignalWidget {
///   const CounterDisplay({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Text('Count: ${counter.value}');
///   }
/// }
/// ```
class ConvertStatelessToSignalWidget extends DartAssist {
  ConvertStatelessToSignalWidget();

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addClassDeclaration((node) {
      final extendsClause = node.extendsClause;
      if (extendsClause == null) return;

      final superclass = extendsClause.superclass;
      if (superclass.name.lexeme != 'StatelessWidget') return;

      if (!target.intersects(node.name.sourceRange) &&
          !target.intersects(extendsClause.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Convert to SignalWidget',
        priority: 6,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          superclass.sourceRange,
          'SignalWidget',
        );
      });
    });
  }
}
