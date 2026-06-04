import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

/// An IDE quick-assist refactoring tool that automatically converts a standard
/// `StatelessWidget` to extend the reactive [SignalWidget] instead.
class ConvertStatelessToSignalWidget extends ResolvedCorrectionProducer {
  static const _assistKind = AssistKind(
    'signals_lint.assist.convertStatelessToSignalWidget',
    60,
    'Convert to SignalWidget',
  );

  ConvertStatelessToSignalWidget({required super.context});

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
    if (superclass.name.lexeme != 'StatelessWidget') return;

    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(
        superclass.sourceRange,
        'SignalWidget',
      );
    });
  }
}
