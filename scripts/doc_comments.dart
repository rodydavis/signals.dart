import 'dart:io';

void main(List<String> args) {
  replaceCoreDoc('signal');
  replaceCoreDoc('computed');
  replaceCoreDoc('effect');
  replaceCoreDoc('batch');
  replaceCoreDoc('untracked');
  replaceAsyncDoc('connect');
  replaceAsyncDoc('future');
  replaceAsyncDoc('stream');
  replaceAsyncDoc('state');
  replaceComment(
    'signal',
    'website/src/content/docs/dart/async/state.md',
    'packages/signals_core/lib/src/async/signal.dart',
  );
  replaceComment(
    'observer',
    'website/src/content/docs/dart/utilities/observer.md',
    'packages/signals_core/lib/src/core/observer.dart',
  );
  replaceComment(
    'watch',
    'website/src/content/docs/flutter/watch.md',
    'packages/signals_flutter/lib/src/watch/widget.dart',
  );
  replaceComment(
    'value',
    'website/src/content/docs/flutter/value-notifier.md',
    'packages/signals_flutter/lib/src/extensions/value_notifier.dart',
  );
  replaceComment(
    'value',
    'website/src/content/docs/flutter/value-listenable.md',
    'packages/signals_flutter/lib/src/extensions/value_listenable.dart',
  );
}

void replaceCoreDoc(String token) {
  replaceComment(
    token,
    'website/src/content/docs/dart/core/$token.md',
    'packages/signals_core/lib/src/core/$token.dart',
  );
}

void replaceAsyncDoc(String token) {
  replaceComment(
    token,
    'website/src/content/docs/dart/async/$token.md',
    'packages/signals_core/lib/src/async/$token.dart',
  );
}

void replaceComment(String token, String documentation, String code) {
  final doc = File(documentation);
  final file = File(code);
  final link = documentation
      .replaceFirst('website/src/content/docs/', 'https://dartsignals.dev/')
      .replaceFirst('.md', '');
  final result = updateComment(
    file.readAsStringSync(),
    doc.readAsStringSync(),
    ('/// {@template $token}', '/// {@endtemplate}'),
    link,
  );
  // print(result);
  file.writeAsStringSync(result);
}

String replaceContent(
  String source,
  String replace,
  (String, String) tokens,
  String link,
) {
  final (startToken, endToken) = tokens;
  // final startIdx = source.indexOf(startToken);
  // final endIdx = source.indexOf(endToken);
  // if (startIdx == -1 || endIdx == -1) {
  //   throw Exception('Missing start or end token');
  // }
  // final prefix = source.substring(0, startIdx);
  // final suffix = source.substring(endIdx + endToken.length + 1);
  String prefix = '';
  String suffix = '';
  final sb = StringBuffer();
  sb.write(prefix);
  sb.writeln(startToken);
  sb.writeln(docToComment(replace, link));

  sb.writeln(endToken);
  sb.writeln(suffix);
  return sb.toString().trim();
}

String docToComment(String source, String link) {
  String afterDash = source;
  afterDash = afterDash.substring(
    afterDash.indexOf('---', afterDash.indexOf('---') + 3) + 3,
  );
  afterDash = afterDash.trim();
  afterDash = afterDash.split('\n').map((e) => '/// $e').join('\n');
  afterDash = '$afterDash\n/// @link $link';
  return afterDash.trim();
}

String updateComment(
  String source,
  String replace,
  (String, String) tokens,
  String link,
) {
  final (startToken, endToken) = tokens;
  List<String> out = [];
  final lines = source.split('\n');
  bool inside = false;
  String padding = '';
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.contains(startToken)) {
      inside = true;
      padding = line.substring(0, line.indexOf('///'));
      out.add('$padding$startToken');
      out.addAll(
          docToComment(replace, link).split('\n').map((e) => '$padding$e'));
      out.add('$padding$endToken');
    } else if (line.contains(endToken)) {
      inside = false;
    } else {
      if (inside) continue;
      out.add(line);
    }
  }
  return out.join('\n');
}
