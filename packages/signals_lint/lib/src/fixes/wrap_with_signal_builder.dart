import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

/// An IDE quick-assist refactoring tool that automatically wraps any
/// instantiated widget expression inside a [SignalBuilder] component.
class WrapWithSignalBuilder extends ResolvedCorrectionProducer {
  static const _assistKind = AssistKind(
    'signals_lint.assist.wrapWithSignalBuilder',
    50,
    'Wrap with SignalBuilder',
  );

  WrapWithSignalBuilder({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  AssistKind get assistKind => _assistKind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final instanceCreation = node.thisOrAncestorOfType<InstanceCreationExpression>();
    if (instanceCreation == null) return;

    final createdType = instanceCreation.constructorName.type.type;
    if (createdType == null) return;

    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleInsertion(
          instanceCreation.offset, 'SignalBuilder(builder: (context) => ');
      builder.addSimpleInsertion(instanceCreation.end, ')');
    });
  }
}
