import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// An IDE quick-fix refactoring tool (Dart Assist) that automatically migrates a positional or named 
/// `Watch` constructor call to use the modern, type-safe [SignalBuilder] component.
///
/// :::important
/// The `Watch` widget was updated and aligned under the standard [SignalBuilder] paradigm in v7. 
/// This automated refactoring quick-fix updates your positional widget structure to a type-safe 
/// `SignalBuilder(builder: (context) => ...)` signature seamlessly.
/// :::
///
/// ### How to use
/// 1. Place your cursor on the `Watch` constructor call.
/// 2. Click the lightbulb icon or press your IDE's quick-fix shortcut (`Alt+Enter` or `Cmd+.`).
/// 3. Select the **Migrate Watch to SignalBuilder** assist option.
///
/// ### Examples
///
/// **Before:**
/// ```dart
/// Widget build(BuildContext context) {
///   return Watch((context) => Text('${counter.value}')); // LINT: Positional Watch
/// }
/// ```
///
/// **After (Apply Assist):**
/// ```dart
/// Widget build(BuildContext context) {
///   return SignalBuilder(builder: (context) => Text('${counter.value}')); // OK
/// }
/// ```
class MigrateWatchToSignalBuilder extends DartAssist {
  MigrateWatchToSignalBuilder();

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final constructorName = node.constructorName;
      final typeName = constructorName.type.name.lexeme;
      if (typeName != 'Watch') return;

      if (!target.intersects(constructorName.sourceRange)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Migrate Watch to SignalBuilder',
        priority: 7,
      );

      changeBuilder.addDartFileEdit((builder) {
        final constructorIdentifier = constructorName.name;
        if (constructorIdentifier == null) {
          final arguments = node.argumentList.arguments;
          if (arguments.isNotEmpty && arguments.first is! NamedExpression) {
            final positionalArg = arguments.first;
            builder.addSimpleReplacement(
              node.sourceRange,
              'SignalBuilder(builder: ${positionalArg.toSource()})',
            );
          }
        } else if (constructorIdentifier.name == 'builder') {
          builder.addSimpleReplacement(
            constructorName.sourceRange,
            'SignalBuilder',
          );
        }
      });
    });
  }
}
