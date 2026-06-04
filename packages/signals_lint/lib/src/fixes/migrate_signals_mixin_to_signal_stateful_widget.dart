import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:collection/collection.dart';

/// An IDE quick-fix and refactoring tool that automatically migrates a deprecated
/// `SignalsMixin` usage on a `State` class to extend the reactive [SignalStatefulWidget] instead.
class MigrateSignalsMixinToSignalStatefulWidget extends ResolvedCorrectionProducer {
  static const _fixKind = FixKind(
    'signals_lint.fix.migrateSignalsMixinToSignalStatefulWidget',
    70,
    'Migrate SignalsMixin to SignalStatefulWidget',
  );

  static const _assistKind = AssistKind(
    'signals_lint.assist.migrateSignalsMixinToSignalStatefulWidget',
    70,
    'Migrate SignalsMixin to SignalStatefulWidget',
  );

  MigrateSignalsMixinToSignalStatefulWidget({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _fixKind;

  @override
  AssistKind get assistKind => _assistKind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final classDecl = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classDecl == null) return;

    final withClause = classDecl.withClause;
    if (withClause == null) return;

    final signalsMixinType = withClause.mixinTypes.firstWhereOrNull(
      (t) => t.name.lexeme == 'SignalsMixin',
    );
    if (signalsMixinType == null) return;

    await builder.addDartFileEdit(file, (builder) {
      // 1. Remove SignalsMixin from the with clause
      final otherMixins = withClause.mixinTypes
          .where((t) => t != signalsMixinType)
          .map((t) => t.toSource())
          .join(', ');

      final mixinReplacement =
          otherMixins.isEmpty ? '' : ' with $otherMixins';
      builder.addSimpleReplacement(withClause.sourceRange, mixinReplacement);

      // 2. Try to find the parent StatefulWidget and change it to SignalStatefulWidget
      final extendsClause = classDecl.extendsClause;
      if (extendsClause != null) {
        final superclass = extendsClause.superclass;
        if (superclass.name.lexeme == 'State') {
          final typeArgs = superclass.typeArguments;
          if (typeArgs != null && typeArgs.arguments.isNotEmpty) {
            final widgetName = typeArgs.arguments.first.toSource();
            final unit = classDecl.thisOrAncestorOfType<CompilationUnit>();
            if (unit != null) {
              ClassDeclaration? widgetClass;
              for (final declaration in unit.declarations) {
                if (declaration is ClassDeclaration &&
                    declaration.namePart.typeName.lexeme == widgetName) {
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
  }
}
