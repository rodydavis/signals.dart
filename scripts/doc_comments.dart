import 'dart:io';

void main(List<String> args) {
  replaceCoreDoc('signal');
  replaceCoreDoc('computed');
  replaceCoreDoc('effect');
  replaceCoreDoc('batch');
  replaceCoreDoc('untracked');
}

void replaceCoreDoc(String token) {
  final doc = File('website/src/content/docs/dart/core/$token.md');
  final file = File('packages/signals_core/lib/src/core/$token.dart');

  final result = replaceContent(
    file.readAsStringSync(),
    doc.readAsStringSync(),
    ('/// {@template $token}', '/// {@endtemplate}'),
  );
  // print(result);
  file.writeAsStringSync(result);
}

String replaceContent(
  String source,
  String replace,
  (String, String) tokens,
) {
  final (startToken, endToken) = tokens;
  final startIdx = source.indexOf(startToken);
  final endIdx = source.indexOf(endToken);
  if (startIdx == -1 || endIdx == -1) {
    throw Exception('Missing start or end token');
  }
  final prefix = source.substring(0, startIdx);
  final suffix = source.substring(endIdx + endToken.length + 1);
  String afterDash = replace;
  afterDash = afterDash.substring(
    afterDash.indexOf('---', afterDash.indexOf('---') + 3) + 3,
  );
  afterDash = afterDash.trim();
  afterDash = afterDash.split('\n').map((e) => '/// $e').join('\n');
  final sb = StringBuffer();
  sb.write(prefix);
  sb.writeln(startToken);
  sb.writeln(afterDash);
  sb.writeln(endToken);
  sb.writeln(suffix);
  return sb.toString().trim();
}
