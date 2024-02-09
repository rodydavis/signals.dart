import 'dart:async';

import 'package:_fe_analyzer_shared/src/macros/api.dart';

macro class Signalable implements FieldDeclarationsMacro {
  const Signalable();

  @override
  Future<void> buildDeclarationsForField(FieldDeclaration field, MemberDeclarationBuilder builder) async {

    final name = field.identifier.name;

     var signal = await builder.resolveIdentifier(Uri.parse('package:signals_core/src/core/signals.dart'), 'signal');

     var ninja = DeclarationCode.fromParts(
        //[field.type.code, ' get ${publicName}Ninja => ', field.identifier, ';']);
        ['final ${name}Signal = ',
        signal,
        '(8);'],
        );
    builder.declareInType(ninja);
  
  }
}
