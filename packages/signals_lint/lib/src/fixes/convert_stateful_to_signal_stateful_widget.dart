import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

/// An IDE quick-assist refactoring tool that automatically converts a standard
/// `StatefulWidget` to extend the reactive [SignalStatefulWidget] instead.
class ConvertStatefulToSignalStatefulWidget extends ResolvedCorrectionProducer {
  static const _assistKind = AssistKind(
    'signals_lint.assist.convertStatefulToSignalStatefulWidget',
    60,
    'Convert to SignalStatefulWidget',
  );

  ConvertStatefulToSignalStatefulWidget({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  AssistKind get assistKind => _assistKind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final classDecl = node.thisOrAncestorOfType<ClassDeclaration>();
    if (classDecl == null) return;

    final extendsClause = classDecl.extendsClause;
    if (extendsClause == null) return;

    final superclass = extendsClause.superclass;
    if (superclass.name.lexeme != 'StatefulWidget') return;

    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(
        superclass.sourceRange,
        'SignalStatefulWidget',
      );
    });
  }
}
