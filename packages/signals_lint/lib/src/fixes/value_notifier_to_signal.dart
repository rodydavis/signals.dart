// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/source/source_range.dart';
// import 'package:custom_lint_builder/custom_lint_builder.dart';
// import 'package:signals_lint/src/utils.dart';

// class ValueNotifierToSignal extends DartAssist {
//   ValueNotifierToSignal();

//   static const _checker = TypeChecker.fromName(
//     'ValueNotifier',
//     packageName: 'flutter',
//   );

//   @override
//   void run(
//     CustomLintResolver resolver,
//     ChangeReporter reporter,
//     CustomLintContext context,
//     SourceRange target,
//   ) {
//     context.registry.addClassDeclaration((node) {
//       final type = node.declaredElement?.thisType;
//       if (type == null) return;

//       final extendsType = node.extendsClause?.superclass.type;
//       if (extendsType?.convert(_checker.isAssignableFromType) ?? false) {
//         return;
//       }
//       final extendsElement = extendsType!.element;
//       if (extendsElement == null) return;

//       final changeBuilder = reporter.createChangeBuilder(
//         message: 'Convert to SignalValueNotifier',
//         priority: 30,
//       );

//       changeBuilder.addDartFileEdit((builder) {
//         final pkg = Uri.parse('package:signals/signals_flutter.dart');
//         builder.importLibrary(pkg);
//         int start = 0, end = 0;
//         if (extendsElement is ClassElement) {
//           // start = extendsElement.;
//         }
//         final sb = StringBuffer();
//         for (final item in extendsElement.children) {
//           sb.writeln('- ${item.name}');
//         }
//         builder.addReplacement(
//           SourceRange(extendsElement.nameOffset, extendsElement.nameLength),
//           (builder) {
//             builder.write('SignalValueNotifier: "${sb.toString()}"');
//           },
//         );
//       });
//     });
//   }
// }
