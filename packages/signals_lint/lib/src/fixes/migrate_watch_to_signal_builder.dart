import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';

/// An IDE quick-fix and refactoring tool that automatically migrates a positional or named
/// `Watch` constructor call to use the modern, type-safe [SignalBuilder] component.
class MigrateWatchToSignalBuilder extends ResolvedCorrectionProducer {
  static const _fixKind = FixKind(
    'signals_lint.fix.migrateWatchToSignalBuilder',
    70,
    'Migrate Watch to SignalBuilder',
  );

  static const _assistKind = AssistKind(
    'signals_lint.assist.migrateWatchToSignalBuilder',
    70,
    'Migrate Watch to SignalBuilder',
  );

  MigrateWatchToSignalBuilder({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => _fixKind;

  @override
  AssistKind get assistKind => _assistKind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    final instanceCreation = node.thisOrAncestorOfType<InstanceCreationExpression>();
    if (instanceCreation == null) return;

    final constructorName = instanceCreation.constructorName;
    final typeName = constructorName.type.name.lexeme;
    if (typeName != 'Watch') return;

    await builder.addDartFileEdit(file, (builder) {
      final constructorIdentifier = constructorName.name;
      if (constructorIdentifier == null) {
        final arguments = instanceCreation.argumentList.arguments;
        if (arguments.isNotEmpty && arguments.first is! NamedExpression) {
          final positionalArg = arguments.first;
          builder.addSimpleReplacement(
            instanceCreation.sourceRange,
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
  }
}
