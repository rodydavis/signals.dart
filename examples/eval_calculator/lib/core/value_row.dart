import 'package:analyzer/dart/ast/ast.dart';

class ValueRow {
  final String definition;
  final String lhs;
  final AstNode rhs;
  final ValueType type;
  final dynamic signalObject;

  ValueRow({
    required this.definition,
    required this.lhs,
    required this.rhs,
    required this.type,
    required this.signalObject,
  });
}

enum ValueType {
  number,
  formula,
}
