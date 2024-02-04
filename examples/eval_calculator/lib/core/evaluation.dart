import 'dart:developer';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:signals/signals_flutter.dart';

void _gatherVariableDeclarations(
  AstNode unit,
  List<VariableDeclaration> declarations,
) {
  for (final child in unit.childEntities) {
    if (child is VariableDeclaration) {
      declarations.add(child);
    } else if (child is AstNode) {
      _gatherVariableDeclarations(child, declarations);
    } else {
      // Pass
    }
  }
}

VariableDeclaration? _getMainStatement(AstNode unit) {
  final List<VariableDeclaration> declarations = [];
  _gatherVariableDeclarations(unit, declarations);
  if (declarations.length == 1) {
    return declarations.single;
  } else {
    return null;
  }
}

VariableDeclaration? parseDefinition(String definition) {
  final parseResult = parseString(
    content: 'final $definition;',
    throwIfDiagnostics: false,
  );
  if (parseResult.errors.isNotEmpty) {
    log('Parsed with error: ${parseResult.errors}');
    return null;
  }
  return _getMainStatement(parseResult.unit);
}

/// Debug by printing the structure of [unit].
void recurse(AstNode unit, [String prefix = '']) {
  // Experiment with AST types
  if (unit is VariableDeclaration) log('${prefix}Variable decl. found');

  log('$prefix${unit.runtimeType} : $unit {');
  for (final x in unit.childEntities) {
    if (x is AstNode) {
      recurse(x, '$prefix  ');
    } else {
      log('$prefix  Token: $x');
    }
  }
  log('$prefix}');
}

class ComputeNode {
  final String definition;

  // an AST node used for computation
  final dynamic rootNode;

  ComputeNode({
    required this.definition,
    required this.rootNode,
  });

  double? eval(Map<String, double> inputs) {
    return evalNode(rootNode, inputs);
  }
}

/// Evaluates the value of [node] given [inputs] for values of variables.
double? evalNode(dynamic node, Map<String, dynamic> inputs) {
  if (node is Literal) {
    if (node is IntegerLiteral) return node.value?.toDouble();
    if (node is DoubleLiteral) return node.value;
  } else if (node is Identifier) {
    final answer = inputs[node.name];
    if (answer is Signal || answer is Computed) {
      return answer.value;
    } else if (answer is double || answer is int) {
      return answer;
    }
  } else if (node is ParenthesizedExpression) {
    return evalNode(node.expression, inputs);
  } else if (node is PrefixExpression && node.operator.toString() == '-') {
    final answer = evalNode(node.operand, inputs);
    return answer == null ? null : -answer;
  } else if (node is BinaryExpression &&
      ['+', '-', '*', '/'].contains(node.operator.toString())) {
    final operator = node.operator.toString();
    final left = evalNode(node.leftOperand, inputs);
    final right = evalNode(node.rightOperand, inputs);
    if (left == null || right == null) return null;
    if (operator == '/' && right == 0.0) return null;
    switch (operator) {
      case '+':
        return left + right;
      case '-':
        return left - right;
      case '*':
        return left * right;
      case '/':
        return left / right;
    }
  }
  return null;
}

void _gatherIdentifiers(
  AstNode unit,
  List<Identifier> identifiers,
) {
  if (unit is Identifier) {
    identifiers.add(unit);
  } else {
    for (final child in unit.childEntities) {
      if (child is AstNode) {
        _gatherIdentifiers(child, identifiers);
      } else {
        // Pass
      }
    }
  }
}

Set<String> getIdentifiers(AstNode unit) {
  final List<Identifier> identifiers = [];
  _gatherIdentifiers(unit, identifiers);
  return Set.from(identifiers.map((e) => e.name));
}
