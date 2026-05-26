import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// An IDE quick-fix refactoring tool (Dart Assist) that automatically converts a standard 
/// `StatefulWidget` to extend the reactive [SignalStatefulWidget] instead.
///
/// :::tip
/// By extending `SignalStatefulWidget` instead of `StatefulWidget`, your widget state automatically 
/// registers fine-grained dependency tracking for any signals referenced within its `build` method. It 
/// will rebuild automatically when their values change, removing the need for manual listener 
/// lifecycle management or `setState` calls.
/// :::
///
/// ### How to use
/// 1. Place your cursor on the widget class declaration (e.g., `class MyWidget extends StatefulWidget`).
/// 2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
/// 3. Select the **Convert to SignalStatefulWidget** assist option.
///
/// ### Examples
///
/// **Before:**
/// ```dart
/// class CounterWidget extends StatefulWidget {
///   const CounterWidget({super.key});
///
///   @override
///   State<CounterWidget> createState() => _CounterWidgetState();
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// class CounterWidget extends SignalStatefulWidget {
///   const CounterWidget({super.key});
///
///   @override
///   State<CounterWidget> createState() => _CounterWidgetState();
/// }
/// ```
class ConvertStatefulToSignalStatefulWidget extends DartAssist {
  ConvertStatefulToSignalStatefulWidget();

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
      if (superclass.name.lexeme != 'StatefulWidget') return;

      if (!target.intersects(node.name.sourceRange) &&
          !target.intersects(extendsClause.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Convert to SignalStatefulWidget',
        priority: 6,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          superclass.sourceRange,
          'SignalStatefulWidget',
        );
      });
    });
  }
}
