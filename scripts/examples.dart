// Update examples.json in assets
import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

void main(List<String> args) {
//  [
//   {
//     "title": "Counter",
//     "description": "A simple counter example using signals.",
//     "link": "/examples/counter"
//   },
//   {
//     "title": "Counter2",
//     "description": "A simple counter example using signals.",
//     "link": "/examples/counter"
//   }
// ]
  final outFile = File('./website/src/assets/examples.json');
  final examplesDir = Directory('./examples');
  final outDir = Directory('./website/src/content/docs/examples');
  outDir.createSync(recursive: true);
  // Loop over every example directory and parse out
  // title/description from pubspec.yaml
  final examples = examplesDir.listSync().whereType<Directory>().map((e) {
    final pubspec = File('${e.path}/pubspec.yaml');
    final yaml = loadYaml(pubspec.readAsStringSync());
    final title = yaml['name'];
    final description = yaml['description'];
    final filename = e.path.split('/').last;
    final link =
        'https://github.com/rodydavis/signals.dart/tree/main/examples/$filename';
    // final readmeFile = File('${outDir.path}/$filename.md');
    // readmeFile.writeAsStringSync(createMd(
    //   title,
    //   description,
    //   File('${e.path}/README.md').readAsStringSync(),
    // ));
    return {'title': title, 'description': description, 'link': link};
  }).toList();

  const encoder = JsonEncoder.withIndent('  ');
  outFile.writeAsStringSync(encoder.convert(examples));
}

String createMd(String title, String description, String content) {
  return '''
---
title: $title
description: $description
---
$content
'''
      .trim();
}
