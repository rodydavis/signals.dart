import 'dart:developer';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:eval_calculator/core/evaluation.dart';
import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';

import '../widgets/warn.dart';
import 'value_row.dart';

class EvalContext {
  final vars = <String, ReadonlySignal<double?>>{};

  ValueRow? addRow(BuildContext context, String definition) {
    log('Adding a new row: $definition');

    // Try parsing.
    final declaration = parseDefinition(definition);
    if (declaration == null) {
      warn('Definition not well-formed.', context: context);
      return null;
    }

    // Declaration successful.
    final lhs = declaration.name.toString();
    final rhs = declaration.initializer;

    if (vars[lhs] != null) {
      // warn('Cannot redefine variable $lhs.', context: context);
      // return null;
      vars[lhs]!.dispose();
    }

    if (rhs == null) {
      warn('Cannot define because RHS is null.', context: context);
      return null;
    }

    final type = (rhs is Literal) ? ValueType.number : ValueType.formula;

    late final ReadonlySignal<double?> signalObject;
    if (type == ValueType.number) {
      signalObject = signal(double.tryParse(rhs.toString()) ?? -1.0);
    } else {
      final dependentVars = getIdentifiers(rhs);
      final allPredefined = dependentVars.every(
        (varName) => vars[varName] != null,
      );
      if (!allPredefined) {
        final undefinedVars =
            dependentVars.where((varName) => vars[varName] == null).toList();

        warn(
          'The variable(s) $undefinedVars are undefined.',
          context: context,
        );
        return null;
      }
      final dependentVarsMap = Map.fromEntries(
        dependentVars.map((varName) => MapEntry(varName, vars[varName])),
      );
      log('Dependent vars map: $dependentVarsMap');

      signalObject = computed(() => evalNode(rhs, dependentVarsMap));
    }

    vars[lhs] = signalObject;

    final object = ValueRow(
      definition: definition,
      lhs: lhs,
      rhs: rhs,
      type: type,
      signalObject: signalObject,
    );
    return object;
  }
}
