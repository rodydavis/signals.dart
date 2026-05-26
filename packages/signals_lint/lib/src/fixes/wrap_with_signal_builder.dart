import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// An IDE quick-fix refactoring tool (Dart Assist) that automatically wraps any
/// instantiated widget expression inside a [SignalBuilder] component.
///
/// :::tip
/// Wrapping a widget inside `SignalBuilder(builder: (context) => ...)` optimizes rebuilding
/// performance by confining redraws strictly to the smallest possible sub-tree whenever
/// reactive signals read inside the builder change.
/// :::
///
/// ### How to use
/// 1. Place your cursor on any widget constructor call (e.g., `Text('...')`).
/// 2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
/// 3. Select the **Wrap with SignalBuilder** assist option.
///
/// ### Examples
///
/// **Before (Cursor on `Text` constructor):**
/// ```dart
/// Widget build(BuildContext context) {
///   return Text('Counter: ${counter.value}');
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// Widget build(BuildContext context) {
///   return SignalBuilder(builder: (context) => Text('Counter: ${counter.value}'));
/// }
/// ```
class WrapWithSignalBuilder extends DartAssist {
  WrapWithSignalBuilder();

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      if (!target.intersects(node.constructorName.sourceRange)) {
        return;
      }

      final createdType = node.constructorName.type.type;
      if (createdType == null) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Wrap with SignalBuilder',
        priority: 5,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleInsertion(
            node.offset, 'SignalBuilder(builder: (context) => ');
        builder.addSimpleInsertion(node.end, ')');
      });
    });
  }
}
