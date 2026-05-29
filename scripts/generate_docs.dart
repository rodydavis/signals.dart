import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';
import 'package:mustache_template/mustache_template.dart';

final Map<String, String> _globalDocLinks = {};
final Map<String, Map<String, List<MapEntry<String, String>>>>
    _allPackageSidebars = {};
final Map<String, String> _casedTypeNames = {};
final Set<String> _deprecatedHrefs = {};

class MemberInfo {
  final String name;
  final String type; // 'constructor', 'method', 'field'
  final String signature;
  final String comment;
  final bool isStatic;

  MemberInfo({
    required this.name,
    required this.type,
    required this.signature,
    required this.comment,
    required this.isStatic,
  });
}

class DeclInfo {
  final String name;
  final String type; // 'class', 'mixin', 'function', 'variable', 'extension'
  final String comment;
  final List<MemberInfo> members;
  final String? extendedType; // For extensions
  final String? signature; // For functions/variables
  final String originPkg;
  final bool isDeprecated;

  DeclInfo({
    required this.name,
    required this.type,
    required this.comment,
    required this.members,
    required this.originPkg,
    this.extendedType,
    this.signature,
    this.isDeprecated = false,
  });
}

void main() {
  final scriptDir = p.dirname(Platform.script.toFilePath());
  final rootDir = p.canonicalize(p.join(scriptDir, '..'));
  final packagesDir = p.join(rootDir, 'packages');
  final docsContentDir = p.join(rootDir, 'docs', 'content', 'packages');
  final skillsDir = '/Users/rodydavis/.gemini/config/skills';

  // Ensure target directories exist clean
  if (Directory(docsContentDir).existsSync()) {
    Directory(docsContentDir).deleteSync(recursive: true);
  }
  Directory(docsContentDir).createSync(recursive: true);
  Directory(skillsDir).createSync(recursive: true);

  final packages = [
    'preact_signals',
    'signals_core',
    'signals_flutter',
    'signals_hooks',
    'signals_lint',
    'signals_devtools_extension',
    'signals',
  ];

  final Map<String, List<DeclInfo>> parsedDecls = {};
  final Map<String, Map<String, dynamic>> parsedMeta = {};

  // Phase 1: Parse all packages first
  for (final pkgName in packages) {
    final pkgPath = p.join(packagesDir, pkgName);
    final pubspecFile = File(p.join(pkgPath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      continue;
    }

    final pubspec = loadYaml(pubspecFile.readAsStringSync());
    final description = pubspec['description'] ?? 'No description provided.';
    final version = pubspec['version'] ?? '0.0.1';
    parsedMeta[pkgName] = {
      'description': description,
      'version': version,
    };

    final libDir = p.join(pkgPath, 'lib');
    var entrypointPath = p.join(libDir, '$pkgName.dart');
    if (!File(entrypointPath).existsSync()) {
      entrypointPath = p.join(libDir, 'main.dart');
    }
    if (!File(entrypointPath).existsSync()) {
      continue;
    }

    final exportedFiles = getExportedFiles(entrypointPath);
    final List<DeclInfo> decls = [];
    for (final filePath in exportedFiles) {
      decls.addAll(extractDeclarations(filePath, pkgName));
    }
    parsedDecls[pkgName] = decls;
  }

  final libraryPackages = {
    'preact_signals',
    'signals_core',
    'signals_flutter',
    'signals_hooks',
    'signals',
  };

  // Populate the global documentation links map to point to the pretty /types/{type} URLs
  for (final pkgName in packages) {
    if (!libraryPackages.contains(pkgName)) continue;
    final decls = parsedDecls[pkgName];
    if (decls == null) continue;
    for (final decl in decls) {
      if (decl.name.startsWith('_')) continue;
      final key = decl.name.toLowerCase();
      _globalDocLinks[decl.name] = '/types/$key';
      _globalDocLinks[key] = '/types/$key';

      final existing = _casedTypeNames[key];
      if (existing == null ||
          (decl.name.isNotEmpty &&
              decl.name[0] == decl.name[0].toUpperCase())) {
        _casedTypeNames[key] = decl.name;
      }
    }
  }

  // Phase 2: Generate documents and skills with package cross-inclusion logic
  for (final pkgName in packages) {
    final meta = parsedMeta[pkgName];
    if (meta == null) continue;

    final String description = meta['description']!;
    final String version = meta['version']!;

    print('Processing package: $pkgName (v$version)...');

    // Combine declarations based on user inclusion requirements
    final List<DeclInfo> combinedDecls = [];

    // Own declarations
    if (parsedDecls.containsKey(pkgName)) {
      combinedDecls.addAll(parsedDecls[pkgName]!);
    }

    // Inclusion rules
    if (pkgName == 'signals_core') {
      // Include preact_signals in signals_core since signals_core re-exports them
      if (parsedDecls.containsKey('preact_signals')) {
        combinedDecls.addAll(parsedDecls['preact_signals']!);
      }
    } else if (pkgName == 'signals_flutter') {
      // Include signals_core and preact_signals in signals_flutter
      if (parsedDecls.containsKey('signals_core')) {
        combinedDecls.addAll(parsedDecls['signals_core']!);
      }
      if (parsedDecls.containsKey('preact_signals')) {
        combinedDecls.addAll(parsedDecls['preact_signals']!);
      }
    } else if (pkgName == 'signals') {
      // Include signals_core, signals_flutter and preact_signals in signals
      if (parsedDecls.containsKey('signals_core')) {
        combinedDecls.addAll(parsedDecls['signals_core']!);
      }
      if (parsedDecls.containsKey('signals_flutter')) {
        combinedDecls.addAll(parsedDecls['signals_flutter']!);
      }
      if (parsedDecls.containsKey('preact_signals')) {
        combinedDecls.addAll(parsedDecls['preact_signals']!);
      }
    }

    // Deduplicate declarations by name to avoid duplicates during cross-inclusions
    final Map<String, DeclInfo> uniqueDecls = {};
    for (final decl in combinedDecls) {
      uniqueDecls[decl.name] = decl;
    }
    final List<DeclInfo> finalDecls = uniqueDecls.values.toList();

    // Sort declarations by name for readability
    finalDecls
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    print(
        '  Generating docs for $pkgName with ${finalDecls.length} declarations.');

    // 3. Generate Jaspr Content Markdown Page
    generateWebsiteMarkdown(
        pkgName, version, description, finalDecls, docsContentDir, rootDir);
  }

  // Phase 2.5: Generate pretty Types reference pages & build Cross-References
  print('\nGenerating pretty Types reference pages...');
  final typesContentDir = p.join(rootDir, 'docs', 'content', 'types');
  if (Directory(typesContentDir).existsSync()) {
    Directory(typesContentDir).deleteSync(recursive: true);
  }
  Directory(typesContentDir).createSync(recursive: true);

  // Group all declarations from all packages by lowercase name to coalesce classes vs functions
  final Map<String, List<DeclInfo>> groupedTypes = {};
  for (final pkgName in parsedDecls.keys) {
    if (!libraryPackages.contains(pkgName)) continue;
    for (final decl in parsedDecls[pkgName]!) {
      if (decl.name.startsWith('_')) continue;
      final key = decl.name.toLowerCase();
      groupedTypes.putIfAbsent(key, () => []).add(decl);

      final existing = _casedTypeNames[key];
      if (existing == null ||
          (decl.name.isNotEmpty &&
              decl.name[0] == decl.name[0].toUpperCase())) {
        _casedTypeNames[key] = decl.name;
      }
    }
  }

  // Cross-referencing Scan Pass: Find where types appear in docs
  print('  Scanning documentation for cross-references...');
  final Map<String, List<MapEntry<String, String>>> typeReferences = {};
  final contentDir = p.join(rootDir, 'docs', 'content');
  final allDocFiles = <File>[];
  if (Directory(contentDir).existsSync()) {
    final entities = Directory(contentDir).listSync(recursive: true);
    for (final entity in entities) {
      if (entity is File && entity.path.endsWith('.md')) {
        // Skip types directory itself to avoid self-references
        if (entity.path.contains('${p.separator}types${p.separator}')) {
          continue;
        }
        allDocFiles.add(entity);
      }
    }
  }

  // Parse files and check for references
  final List<(String, String, File)> parsedDocFiles = [];
  for (final file in allDocFiles) {
    final content = file.readAsStringSync();
    final fm = parseFrontmatter(content);
    final title = fm['title'] ?? p.basenameWithoutExtension(file.path);

    // Construct site URL
    var relPath = p.relative(file.path, from: contentDir);
    var url = '/' + p.withoutExtension(relPath).replaceAll('\\', '/');
    if (url.endsWith('/index')) {
      url = url.substring(0, url.length - 6);
    }
    if (url == '/index' || url == '') {
      url = '/';
    }
    parsedDocFiles.add((title, url, file));
  }

  // For each type key, scan all doc files
  for (final typeKey in groupedTypes.keys) {
    final group = groupedTypes[typeKey]!;
    final primaryName = group.first.name;
    final referencesList = <MapEntry<String, String>>[];

    final regexes = [
      RegExp(
          r'\[(' +
              RegExp.escape(primaryName) +
              r')(?:<[^>]+>)?(?:\.[a-zA-Z0-9_-]+)?\]',
          caseSensitive: false),
      RegExp(r'\b' + RegExp.escape(primaryName) + r'\b', caseSensitive: false)
    ];

    for (final doc in parsedDocFiles) {
      final (title, url, file) = doc;
      final fileContent = file.readAsStringSync();
      var hasRef = false;
      for (final regex in regexes) {
        if (regex.hasMatch(fileContent)) {
          hasRef = true;
          break;
        }
      }
      if (hasRef) {
        // Ensure no duplicate links
        if (!referencesList.any((ref) => ref.value == url)) {
          referencesList.add(MapEntry(title, url));
        }
      }
    }
    typeReferences[typeKey] = referencesList;
  }

  // Write Type Markdown files
  for (final typeKey in groupedTypes.keys) {
    final group = groupedTypes[typeKey]!;
    // Prioritize class over function, or longest signature
    group.sort((a, b) {
      if (a.type == 'class' && b.type != 'class') return -1;
      if (b.type == 'class' && a.type != 'class') return 1;
      return b.comment.length.compareTo(a.comment.length);
    });

    final primaryName = group.first.name;
    final primaryPkg = group.first.originPkg;

    final isTypeDeprecated = group.any((d) => d.isDeprecated);
    if (isTypeDeprecated) {
      _deprecatedHrefs.add('/types/$typeKey');
    }

    final typeFile = File(p.join(typesContentDir, '$typeKey.md'));
    final sb = StringBuffer();
    sb.writeln('---');
    sb.writeln('title: "Type: $primaryName"');
    sb.writeln(
        'description: "API reference and details for $primaryName from signals.dart."');
    sb.writeln('---');
    sb.writeln();
    if (isTypeDeprecated) {
      sb.writeln(
          '# $primaryName <span class="deprecated-badge">deprecated</span>');
    } else {
      sb.writeln('# $primaryName');
    }
    sb.writeln();

    // Kind description banner
    final kind = group.map((d) => d.type).toSet().join(' & ');
    sb.writeln('<Info>');
    sb.writeln('  <strong>Kind:</strong> <code>$kind</code> &nbsp;|&nbsp;');
    sb.writeln('  <strong>Package:</strong> <code>package:$primaryPkg</code>');
    if (isTypeDeprecated) {
      sb.writeln(
          '  &nbsp;|&nbsp; <span class="deprecated-badge">deprecated</span>');
    }
    sb.writeln('</Info>');
    sb.writeln();

    for (final decl in group) {
      final depBadge = decl.isDeprecated
          ? ' <span class="deprecated-badge">deprecated</span>'
          : '';
      sb.writeln(
          '## ${decl.type[0].toUpperCase()}${decl.type.substring(1)}: ${decl.name}$depBadge');
      sb.writeln();
      if (decl.signature != null && decl.signature!.isNotEmpty) {
        sb.writeln('```dart');
        sb.writeln(decl.signature);
        sb.writeln('```');
        sb.writeln();
      } else if (decl.extendedType != null) {
        sb.writeln('```dart');
        sb.writeln('extension ${decl.name} on ${decl.extendedType}');
        sb.writeln('```');
        sb.writeln();
      }

      final cleanedComment = cleanDocumentationComment(decl.comment);
      if (cleanedComment.isNotEmpty) {
        sb.writeln(cleanedComment);
        sb.writeln();
      }

      // Render members table if class or mixin or extension
      if (decl.members.isNotEmpty) {
        sb.writeln('### Members of ${decl.name}');
        sb.writeln();
        sb.writeln('| Member | Type | Signature | Description |');
        sb.writeln('| :--- | :--- | :--- | :--- |');
        for (final m in decl.members) {
          final firstLine = cleanDocumentationComment(m.comment)
              .split('\n')
              .firstWhere(
                  (line) =>
                      line.trim().isNotEmpty && !line.trim().startsWith('#'),
                  orElse: () => '')
              .replaceAll('|', '\\|')
              .trim();
          sb.writeln(
              '| **${m.name}** | `${m.type}` | `dart ${m.signature}` | $firstLine |');
        }
        sb.writeln();
      }
    }

    // References section
    sb.writeln('## References');
    sb.writeln();
    sb.writeln(
        'The **$primaryName** type is referenced and used in the following pages:');
    sb.writeln();
    final refs = typeReferences[typeKey] ?? [];
    if (refs.isNotEmpty) {
      for (final ref in refs) {
        final uri = Uri.tryParse(ref.value);
        String context = '';
        if (uri != null) {
          final segments = uri.pathSegments;
          if (segments.length >= 2) {
            if (segments[0] == 'packages') {
              context = segments.skip(1).take(segments.length - 2).join('/');
              if (context.isEmpty) {
                context = segments[1];
              }
            } else {
              context = segments.take(segments.length - 1).join('/');
            }
          }
        }

        final normKey = ref.key
            .toLowerCase()
            .replaceAll('_', '')
            .replaceAll('-', '')
            .replaceAll(' ', '');
        final normContext = context
            .toLowerCase()
            .replaceAll('_', '')
            .replaceAll('-', '')
            .replaceAll(' ', '');
        final showContext = context.isNotEmpty && normKey != normContext;

        final suffix = showContext
            ? ' <span style="opacity: 0.6; font-size: 0.85em;">($context)</span>'
            : '';
        sb.writeln('* [${ref.key}](${ref.value})$suffix');
      }
    } else {
      sb.writeln('* No other guides or pages explicitly reference this type.');
    }
    sb.writeln();

    typeFile.writeAsStringSync(sb.toString());
  }
  print(
      '  Successfully generated ${groupedTypes.length} type reference pages!');

  // 5. Generate llms.txt, llms-full.txt and copyable raw markdown folder
  generateLLMFiles(rootDir);

  // 6. Preprocess all markdown files in docs/content/ to convert :::callouts and resolve bracket links
  if (Directory(contentDir).existsSync()) {
    final files = Directory(contentDir).listSync(recursive: true);
    for (final entity in files) {
      if (entity is File && entity.path.endsWith('.md')) {
        final content = entity.readAsStringSync();
        var updated = resolveDartReferences(content);
        updated = convertCallouts(updated);
        updated = convertAllInlineBackticks(updated);
        if (content != updated) {
          entity.writeAsStringSync(updated);
          print(
              'Preprocessed links and callouts in file: ${p.relative(entity.path, from: rootDir)}');
        }
      }
    }
  }

  // 7. Dynamically generate the Jaspr navigation side menu (navigation.dart) to keep it in sync with index/TOC
  generateNavigationFile(rootDir);

  // 8. Generate VS Code snippets, WebView UI and monorepo AI developer skills via mustache
  generateVSCodeAndSkills(rootDir, parsedDecls, parsedMeta);

  print('\nDocumentation and Skills successfully generated!');
}

Set<String> getExportedFiles(String entrypointPath) {
  final Set<String> files = {};
  void helper(String currentPath) {
    if (!File(currentPath).existsSync()) return;
    final resolvedPath = p.canonicalize(currentPath);
    if (files.contains(resolvedPath)) return;
    files.add(resolvedPath);

    try {
      final result = parseFile(
        path: currentPath,
        featureSet: FeatureSet.latestLanguageVersion(),
      );
      for (final directive in result.unit.directives) {
        if (directive is ExportDirective) {
          final uri = directive.uri.stringValue;
          if (uri != null) {
            if (uri.startsWith('package:')) {
              // We skip other external packages
              continue;
            }
            final nextPath =
                p.canonicalize(p.join(p.dirname(currentPath), uri));
            helper(nextPath);
          }
        } else if (directive is PartDirective) {
          final uri = directive.uri.stringValue;
          if (uri != null) {
            final nextPath =
                p.canonicalize(p.join(p.dirname(currentPath), uri));
            helper(nextPath);
          }
        }
      }
    } catch (e) {
      // Quietly continue if file parsing fails
    }
  }

  helper(entrypointPath);
  if (files.length <= 1) {
    final libDir = p.dirname(entrypointPath);
    if (Directory(libDir).existsSync()) {
      final dartFiles = Directory(libDir)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'));
      for (final f in dartFiles) {
        files.add(p.canonicalize(f.path));
      }
    }
  }
  return files;
}

String cleanComment(Comment? commentNode) {
  if (commentNode == null) return '';
  final cleaned = commentNode.tokens.map((token) {
    final lexeme = token.lexeme.trim();
    if (lexeme.startsWith('///')) {
      var rest = lexeme.substring(3);
      if (rest.startsWith(' ')) rest = rest.substring(1);
      return rest;
    } else if (lexeme.startsWith('/**')) {
      return lexeme;
    }
    return lexeme;
  }).join('\n');
  return cleaned.replaceAll('```diff', '```dart');
}

List<DeclInfo> extractDeclarations(String filePath, String pkgName) {
  final List<DeclInfo> decls = [];
  try {
    final result = parseFile(
      path: filePath,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    final unit = result.unit;
    for (final declaration in unit.declarations) {
      bool isDeprecated = false;
      if (declaration is AnnotatedNode) {
        bool isInternal = false;
        for (final annotation in declaration.metadata) {
          final annName = annotation.name.name;
          if (annName == 'internal') {
            isInternal = true;
          }
          if (annName == 'deprecated' || annName == 'Deprecated') {
            isDeprecated = true;
          }
        }
        if (declaration.documentationComment != null) {
          final commentText = declaration.documentationComment!.tokens
              .map((t) => t.lexeme)
              .join('\n');
          if (commentText.contains('@internal')) {
            isInternal = true;
          }
          if (commentText.contains('@deprecated')) {
            isDeprecated = true;
          }
        }
        if (isInternal) continue;
      }
      if (declaration is ClassDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        final comment = cleanComment(declaration.documentationComment);
        final List<MemberInfo> members = [];
        for (final member in declaration.members) {
          if (member is AnnotatedNode) {
            bool memberInternal = false;
            for (final annotation in member.metadata) {
              if (annotation.name.name == 'internal') {
                memberInternal = true;
                break;
              }
            }
            if (member.documentationComment != null) {
              final commentText = member.documentationComment!.tokens
                  .map((t) => t.lexeme)
                  .join('\n');
              if (commentText.contains('@internal')) {
                memberInternal = true;
              }
            }
            if (memberInternal) continue;
          }
          if (member is ConstructorDeclaration) {
            final consName = member.name?.lexeme ?? '';
            final fullConsName = consName.isEmpty ? name : '$name.$consName';
            final consComment = cleanComment(member.documentationComment);
            final paramList = member.parameters.toSource();
            members.add(MemberInfo(
              name: fullConsName,
              type: 'constructor',
              signature: '$fullConsName$paramList',
              comment: consComment,
              isStatic: false,
            ));
          } else if (member is MethodDeclaration) {
            final mName = member.name.lexeme;
            if (mName.startsWith('_')) continue;
            final mComment = cleanComment(member.documentationComment);
            final paramList = member.parameters?.toSource() ?? '';
            final isStatic = member.isStatic ? 'static ' : '';
            final retType = member.returnType?.toSource() ?? '';
            members.add(MemberInfo(
              name: mName,
              type: 'method',
              signature:
                  '${isStatic}${retType.isNotEmpty ? "$retType " : ""}$mName$paramList',
              comment: mComment,
              isStatic: member.isStatic,
            ));
          } else if (member is FieldDeclaration) {
            final isStatic = member.isStatic ? 'static ' : '';
            final typeStr = member.fields.type?.toSource() ?? '';
            for (final variable in member.fields.variables) {
              final fName = variable.name.lexeme;
              if (fName.startsWith('_')) continue;
              final fComment = cleanComment(member.documentationComment);
              members.add(MemberInfo(
                name: fName,
                type: 'field',
                signature:
                    '${isStatic}${typeStr.isNotEmpty ? "$typeStr " : ""}$fName',
                comment: fComment,
                isStatic: member.isStatic,
              ));
            }
          }
        }
        decls.add(DeclInfo(
          name: name,
          type: 'class',
          comment: comment,
          members: members,
          originPkg: pkgName,
          isDeprecated: isDeprecated,
        ));
      } else if (declaration is MixinDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        final comment = cleanComment(declaration.documentationComment);
        final List<MemberInfo> members = [];
        for (final member in declaration.members) {
          if (member is AnnotatedNode) {
            bool memberInternal = false;
            for (final annotation in member.metadata) {
              if (annotation.name.name == 'internal') {
                memberInternal = true;
                break;
              }
            }
            if (member.documentationComment != null) {
              final commentText = member.documentationComment!.tokens
                  .map((t) => t.lexeme)
                  .join('\n');
              if (commentText.contains('@internal')) {
                memberInternal = true;
              }
            }
            if (memberInternal) continue;
          }
          if (member is MethodDeclaration) {
            final mName = member.name.lexeme;
            if (mName.startsWith('_')) continue;
            final mComment = cleanComment(member.documentationComment);
            final paramList = member.parameters?.toSource() ?? '';
            final retType = member.returnType?.toSource() ?? '';
            members.add(MemberInfo(
              name: mName,
              type: 'method',
              signature:
                  '${retType.isNotEmpty ? "$retType " : ""}$mName$paramList',
              comment: mComment,
              isStatic: false,
            ));
          } else if (member is FieldDeclaration) {
            final typeStr = member.fields.type?.toSource() ?? '';
            for (final variable in member.fields.variables) {
              final fName = variable.name.lexeme;
              if (fName.startsWith('_')) continue;
              final fComment = cleanComment(member.documentationComment);
              members.add(MemberInfo(
                name: fName,
                type: 'field',
                signature: '${typeStr.isNotEmpty ? "$typeStr " : ""}$fName',
                comment: fComment,
                isStatic: false,
              ));
            }
          }
        }
        decls.add(DeclInfo(
          name: name,
          type: 'mixin',
          comment: comment,
          members: members,
          originPkg: pkgName,
          isDeprecated: isDeprecated,
        ));
      } else if (declaration is FunctionDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        final comment = cleanComment(declaration.documentationComment);
        final paramList =
            declaration.functionExpression.parameters?.toSource() ?? '';
        final retType = declaration.returnType?.toSource() ?? '';
        final sig = '${retType.isNotEmpty ? "$retType " : ""}$name$paramList';
        decls.add(DeclInfo(
          name: name,
          type: 'function',
          comment: comment,
          members: [],
          signature: sig,
          originPkg: pkgName,
          isDeprecated: isDeprecated,
        ));
      } else if (declaration is TopLevelVariableDeclaration) {
        final comment = cleanComment(declaration.documentationComment);
        final typeStr = declaration.variables.type?.toSource() ?? '';
        for (final variable in declaration.variables.variables) {
          final name = variable.name.lexeme;
          if (name.startsWith('_')) continue;
          final sig = '${typeStr.isNotEmpty ? "$typeStr " : ""}$name';
          decls.add(DeclInfo(
            name: name,
            type: 'variable',
            comment: comment,
            members: [],
            signature: sig,
            originPkg: pkgName,
            isDeprecated: isDeprecated,
          ));
        }
      } else if (declaration is ExtensionDeclaration) {
        final name = declaration.name?.lexeme ?? 'UnnamedExtension';
        if (name.startsWith('_')) continue;
        final comment = cleanComment(declaration.documentationComment);
        final extendedType =
            declaration.extendedType.toSource();
        final List<MemberInfo> members = [];
        for (final member in declaration.members) {
          if (member is AnnotatedNode) {
            bool memberInternal = false;
            for (final annotation in member.metadata) {
              if (annotation.name.name == 'internal') {
                memberInternal = true;
                break;
              }
            }
            if (member.documentationComment != null) {
              final commentText = member.documentationComment!.tokens
                  .map((t) => t.lexeme)
                  .join('\n');
              if (commentText.contains('@internal')) {
                memberInternal = true;
              }
            }
            if (memberInternal) continue;
          }
          if (member is MethodDeclaration) {
            final mName = member.name.lexeme;
            if (mName.startsWith('_')) continue;
            final mComment = cleanComment(member.documentationComment);
            final paramList = member.parameters?.toSource() ?? '';
            final retType = member.returnType?.toSource() ?? '';
            members.add(MemberInfo(
              name: mName,
              type: 'method',
              signature:
                  '${retType.isNotEmpty ? "$retType " : ""}$mName$paramList',
              comment: mComment,
              isStatic: false,
            ));
          }
        }
        decls.add(DeclInfo(
          name: name,
          type: 'extension',
          comment: comment,
          members: members,
          extendedType: extendedType,
          originPkg: pkgName,
          isDeprecated: isDeprecated,
        ));
      }
    }
  } catch (e) {
    // Quietly continue on failure
  }
  return decls;
}

String? getCategoryAndPage(String pkgName, DeclInfo decl) {
  final comment = decl.comment;

  // 1. Check if there is an explicit @link tag first!
  final linkRegExp =
      RegExp(r'@link\s+https://dartsignals\.dev/([a-zA-Z0-9_\-/]+)');
  final match = linkRegExp.firstMatch(comment);
  if (match != null) {
    return match.group(1)!;
  }

  final name = decl.name;
  final nameLower = name.toLowerCase();

  // 2. Mappings for signals_hooks
  if (pkgName == 'signals_hooks') {
    final slug =
        name.split(RegExp(r'(?<=[a-z0-9])(?=[A-Z])')).join('-').toLowerCase();
    if (nameLower.contains('widget') || nameLower.contains('builder')) {
      return 'widgets/$slug';
    }
    return 'hooks/$slug';
  }

  // 3. Mappings for signals_devtools_extension
  if (pkgName == 'signals_devtools_extension') {
    return 'flutter/devtools';
  }

  // 3.5 Mappings for signals_lint
  if (pkgName == 'signals_lint') {
    final allowedPrefixes = [
      'SignalsAvoid',
      'SignalsPrefer',
      'WrapWith',
      'Convert',
      'Migrate'
    ];
    if (!allowedPrefixes.any((prefix) => name.startsWith(prefix))) {
      return null;
    }
    final slug =
        name.split(RegExp(r'(?<=[a-z0-9])(?=[A-Z])')).join('-').toLowerCase();
    return 'flutter/$slug';
  }

  // 4. Mappings for signals_flutter
  if (pkgName == 'signals_flutter') {
    final slug =
        name.split(RegExp(r'(?<=[a-z0-9])(?=[A-Z])')).join('-').toLowerCase();

    // Core Signals
    if (name == 'FlutterSignal' || name == 'signal' || name == 'createSignal') {
      return 'signals/flutter-signal';
    }
    if (name == 'FlutterReadonlySignal' ||
        name == 'readonly' ||
        name == 'FlutterReadonlySignalUtils') {
      return 'signals/flutter-readonly-signal';
    }
    if (name == 'FlutterComputed' ||
        name == 'computed' ||
        name == 'createComputed') {
      return 'signals/flutter-computed';
    }
    if (name == 'TickerSignal' || name == 'tickerSignal') {
      return 'signals/ticker-signal';
    }

    // Widgets
    final widgets = [
      'SignalWidget',
      'SignalBuilder',
      'SignalAnimatedBuilder',
      'SignalCustomPaint',
      'SignalPainterWidget',
      'SignalProxyWidget',
      'WatchBuilder',
      'Watch',
      'MultiSignalProvider',
      'SignalProvider'
    ];
    if (widgets.contains(name)) {
      return 'widgets/$slug';
    }

    // Mixins
    final mixins = [
      'SignalsMixin',
      'ValueListenableSignalMixin',
      'ValueNotifierSignalMixin'
    ];
    if (mixins.contains(name)) {
      return 'mixins/$slug';
    }

    // Effects
    if (name == 'SignalEffect' || name == 'signalEffect') {
      return 'effects/signal-effect';
    }

    // Render
    final renderObjects = [
      'RenderSignalBox',
      'RenderSignalCustomPaint',
      'RenderSignalProxyBox'
    ];
    if (renderObjects.contains(name)) {
      return 'render/$slug';
    }

    // Extensions
    return 'extensions/$slug';
  }

  // 5. Mappings for preact_signals, signals_core, signals
  if (pkgName == 'signals_core' ||
      pkgName == 'preact_signals' ||
      pkgName == 'signals') {
    // Core
    if (name == 'Signal' || name == 'signal') return 'core/signal';
    if (name == 'Computed' || name == 'computed') return 'core/computed';
    if (name == 'Effect' || name == 'effect') return 'core/effect';
    if (name == 'batch') return 'core/batch';
    if (name == 'untracked') return 'core/untracked';
    if (name == 'linkedSignal' || name == 'LinkedSignal')
      return 'core/linked-signal';
    if (name == 'readonly' || name == 'ReadonlySignal') return 'core/readonly';
    if (name.toLowerCase().startsWith('action')) return 'core/action';
    if (name == 'SignalEquality' ||
        name == 'SignalStandardEquality' ||
        name == 'SignalIdentityEquality' ||
        name == 'SignalCustomEquality' ||
        name == 'SignalDeepEquality') return 'utilities/equality';
    if (name == 'SignalModel' ||
        name == 'SignalModelOptions' ||
        name == 'SignalModelConstructor' ||
        name == 'createModel') return 'utilities/model';

    // Mixins
    if (name == 'SignalsMixin') return 'mixins/signals-mixin';
    if (name == 'ChangeStackSignalMixin') return 'mixins/change-stack';
    if (name == 'EventSinkSignalMixin') return 'mixins/event-sink';
    if (name == 'IterableSignalMixin') return 'mixins/iterable';
    if (name == 'ListSignalMixin') return 'mixins/list';
    if (name == 'MapSignalMixin') return 'mixins/map';
    if (name == 'QueueSignalMixin') return 'mixins/queue';
    if (name == 'SetSignalMixin') return 'mixins/set';
    if (name == 'SinkSignalMixin') return 'mixins/sink';
    if (name == 'StreamSignalMixin') return 'mixins/stream';
    if (name == 'TrackedSignalMixin') return 'mixins/tracked';
    if (name == 'ValueListenableSignalMixin') return 'mixins/value-listenable';
    if (name == 'ValueNotifierSignalMixin') return 'mixins/value-notifier';

    // Async
    if (name == 'FutureSignal' ||
        name == 'futureSignal' ||
        name == 'computedAsync' ||
        name == 'computedFrom') {
      if (nameLower.contains('computed')) return 'async/computed';
      return 'async/future';
    }
    if (name == 'StreamSignal' || name == 'streamSignal') return 'async/stream';
    if (name == 'Connect' || name == 'connect') return 'async/connect';
    if (name == 'AsyncState' ||
        name == 'AsyncValue' ||
        name.startsWith('AsyncLoading') ||
        name.startsWith('AsyncData') ||
        name.startsWith('AsyncError')) return 'async/state';
    if (name == 'AsyncSignal' ||
        name == 'asyncSignal' ||
        name == 'AsyncSignalOptions') return 'async/signal';

    // Value
    if (name == 'ChangeStackSignal') return 'value/change-stack';
    if (name == 'IterableSignal') return 'value/iterable';
    if (name == 'ListSignal' || name == 'listSignal') return 'value/list';
    if (name == 'SetSignal' || name == 'setSignal') return 'value/set';
    if (name == 'MapSignal' || name == 'mapSignal') return 'value/map';

    // Utilities
    if (name == 'SignalContainer' || name == 'signalContainer')
      return 'utilities/container';
    if (name == 'SignalsObserver' || name == 'signalsObserver')
      return 'utilities/observer';
    if (name.startsWith('Persisted') ||
        name.startsWith('SignalsKeyValue') ||
        name.startsWith('SignalsInMemoryKeyValue')) {
      return 'utilities/persisted';
    }

    // Fallback dynamic mapping rules for unresolved types across core/signals packages
    if (nameLower.contains('container')) {
      return 'utilities/container';
    }
    if (nameLower.contains('observer') ||
        nameLower.contains('devtools') ||
        name == 'onSignalRead') {
      return 'utilities/observer';
    }
    if (nameLower.contains('timer')) {
      return 'async/signal';
    }
    if (nameLower.contains('tracked')) {
      return 'mixins/tracked';
    }
    if (nameLower.contains('queue')) {
      return 'mixins/queue';
    }
    if (nameLower.contains('error') ||
        nameLower.contains('exception') ||
        nameLower.contains('fail')) {
      return 'core/signal';
    }
    if (nameLower.contains('changestack') || name == 'changeStack') {
      return 'value/change-stack';
    }
    if (name == 'iterableSignal') {
      return 'value/iterable';
    }
    if (nameLower.contains('state') || name == 'AsyncSignalState') {
      return 'async/state';
    }
    if (nameLower.endsWith('options')) {
      return 'core/signal';
    }
    if (nameLower.contains('signal') || nameLower.contains('readonly')) {
      return 'core/signal';
    }
  }

  return null;
}

Map<String, String> parseFrontmatter(String content) {
  final Map<String, String> fm = {};
  if (content.startsWith('---')) {
    final endIdx = content.indexOf('---', 3);
    if (endIdx != -1) {
      final fmText = content.substring(3, endIdx);
      final lines = fmText.split('\n');
      for (final line in lines) {
        final colonIdx = line.indexOf(':');
        if (colonIdx != -1) {
          final key = line.substring(0, colonIdx).trim();
          final val = line.substring(colonIdx + 1).trim();
          fm[key] = val;
        }
      }
    }
  }
  return fm;
}

String stripFrontmatter(String content) {
  if (content.startsWith('---')) {
    final endIdx = content.indexOf('---', 3);
    if (endIdx != -1) {
      return content.substring(endIdx + 3).trim();
    }
  }
  return content.trim();
}

String _resolveReferencesInPlainMarkdown(String text) {
  // Find [Word] or [Word.member] where Word is a word consisting of letters, digits, and underscores/dashes.
  // We match bracketed expressions that don't already have a markdown URL format after them.
  final regExp = RegExp(
      r'\[([a-zA-Z0-9_-]+)(?:<[a-zA-Z0-9_,-]+>)?(?:\.([a-zA-Z0-9_-]+))?\](?!\()');
  return text.replaceAllMapped(regExp, (match) {
    final name = match.group(1)!;
    final member = match.group(2);
    final fullMatch = match.group(0)!;
    if (_globalDocLinks.containsKey(name)) {
      var link = _globalDocLinks[name]!;
      if (member != null) {
        // Append member as fragment anchor (lowercase)
        final memberAnchor = member.toLowerCase();
        link = '$link#$memberAnchor';
      }
      return '$fullMatch($link)';
    }
    // We cannot convert to a link. Default to bolding the bracketed words instead.
    final insideBrackets = fullMatch.substring(1, fullMatch.length - 1);
    return '**$insideBrackets**';
  });
}

String resolveDartReferences(String text) {
  // Split text by triple-backtick code blocks to ensure we don't process brackets in code blocks
  final codeBlockParts = text.split('```');
  for (var i = 0; i < codeBlockParts.length; i++) {
    // Every odd-indexed part is inside a code block
    if (i % 2 == 1) continue;

    // Split by single-backtick inline code
    final inlineParts = codeBlockParts[i].split('`');
    for (var j = 0; j < inlineParts.length; j++) {
      // Every odd-indexed part is inside inline code
      if (j % 2 == 1) continue;

      // Even-indexed parts are normal text where we resolve references
      inlineParts[j] = _resolveReferencesInPlainMarkdown(inlineParts[j]);
    }
    codeBlockParts[i] = inlineParts.join('`');
  }
  return codeBlockParts.join('```');
}

String cleanDocumentationComment(String comment) {
  var cleaned = comment;
  // Remove {@template ...} and {@endtemplate}
  cleaned = cleaned.replaceAll(RegExp(r'\{@template\s+[a-zA-Z0-9_-]+\}'), '');
  cleaned = cleaned.replaceAll('{@endtemplate}', '');

  // Strip lines starting with @link
  cleaned = cleaned
      .split('\n')
      .where((line) => !line.trim().startsWith('@link'))
      .join('\n');

  // Replace ```diff with ```dart
  cleaned = cleaned.replaceAll('```diff', '```dart');

  // Resolve [Bracketed] Dart references to HTML/markdown links
  cleaned = resolveDartReferences(cleaned);

  final calloutsConverted = convertCallouts(cleaned.trim());
  return convertAllInlineBackticks(calloutsConverted);
}

String convertAllInlineBackticks(String text) {
  // Split by fenced code blocks to ensure we don't process brackets/backticks inside code blocks
  final codeBlockParts = text.split('```');
  for (var i = 0; i < codeBlockParts.length; i++) {
    // Every even-indexed part is outside a fenced code block
    if (i % 2 == 0) {
      codeBlockParts[i] =
          codeBlockParts[i].replaceAllMapped(RegExp(r'`([^`\n]+)`'), (match) {
        final code = match.group(1)!;
        return '<code>$code</code>';
      });
    }
  }
  return codeBlockParts.join('```');
}

String convertCallouts(String text) {
  var result = text;

  // Replace :::caution, :::warning, etc.
  final regExp = RegExp(
      r':::(info|caution|warning|danger|tip|note|success|error)\s*\n?([\s\S]*?)\n?\s*:::');
  result = result.replaceAllMapped(regExp, (match) {
    final type = match.group(1)!;
    var content = match.group(2)!;

    // Resolve any markdown-style bold, links, and inline code within the callout content.
    // This ensures they render correctly even though wrapped in custom HTML elements.
    content = content.replaceAllMapped(
        RegExp(r'\*\*([^*]+)\*\*'), (m) => '<strong>${m[1]}</strong>');
    content = content.replaceAllMapped(
        RegExp(r'\*([^*]+)\*'), (m) => '<em>${m[1]}</em>');
    content = content.replaceAllMapped(
        RegExp(r'`([^`\n]+)`'), (m) => '<code>${m[1]}</code>');
    content = content.replaceAllMapped(RegExp(r'\[([^\]\n]+)\]\(([^)\n]+)\)'),
        (m) => '<a href="${m[2]}">${m[1]}</a>');

    // Map to supported jaspr_content Callout components
    String tagName;
    switch (type.toLowerCase()) {
      case 'info':
      case 'note':
        tagName = 'Info';
        break;
      case 'warning':
      case 'caution':
        tagName = 'Warning';
        break;
      case 'error':
      case 'danger':
        tagName = 'Error';
        break;
      case 'success':
      case 'tip':
        tagName = 'Success';
        break;
      default:
        tagName = 'Info';
    }

    return '<$tagName>\n$content\n</$tagName>';
  });

  // Also replace within explicit HTML tags: <Warning>, <Info>, etc.
  final htmlTagRegExp =
      RegExp(r'<(Warning|Info|Success|Error|Caution|Tip|Note)>([\s\S]*?)</\1>');
  result = result.replaceAllMapped(htmlTagRegExp, (match) {
    final tagName = match.group(1)!;
    var content = match.group(2)!;

    // Resolve markdown-style bold, links, and inline code within the callout content.
    content = content.replaceAllMapped(
        RegExp(r'\*\*([^*]+)\*\*'), (m) => '<strong>${m[1]}</strong>');
    content = content.replaceAllMapped(
        RegExp(r'\*([^*]+)\*'), (m) => '<em>${m[1]}</em>');
    content = content.replaceAllMapped(
        RegExp(r'`([^`\n]+)`'), (m) => '<code>${m[1]}</code>');
    content = content.replaceAllMapped(RegExp(r'\[([^\]\n]+)\]\(([^)\n]+)\)'),
        (m) => '<a href="${m[2]}">${m[1]}</a>');

    return '<$tagName>$content</$tagName>';
  });

  return result;
}

Map<String, String> getPackageOverview(String pkgName) {
  switch (pkgName) {
    case 'preact_signals':
      return {
        'overview':
            'The `preact_signals` package is a direct, ultra-high-performance Dart port of Preact.js Signals (v7.0.0). It brings fine-grained reactive programming to Dart VM, command-line interfaces, server environments, and web targets with maximum memory efficiency and minimal execution overhead.',
        'features': '''
- **⚡ High Performance**: Built on a highly optimized, double-linked reactive graph that automatically caches derived values.
- **📦 Memory Efficient**: Automatic memory cleanup and garbage collection of inactive nodes.
- **🎯 Dynamic Dependency Tracking**: Automatically tracks which signals are read during execution and re-evaluates effects surgically only when those specific dependencies update.
- **🧪 Batching Updates**: Group multiple signal updates together into a single transaction so reactions and UI redraws occur only once.
''',
        'code': '''
import 'package:preact_signals/preact_signals.dart';

void main() {
  final count = signal(0);
  final isEven = computed(() => count.value.isEven);

  // Automatically tracks and prints when dependencies update
  final dispose = effect(() {
    print('Count is \${count.value}, isEven: \${isEven.value}');
  });

  count.value = 1;
  count.value = 2;

  dispose();
}
'''
      };

    case 'signals_core':
      return {
        'overview':
            'The `signals_core` package exposes the foundational building blocks of the entire Signals reactive framework. It is 100% platform-agnostic, zero-dependency, and can be integrated into any Dart codebase—including shelf servers, database layers, command-line scripts, or serverless functions.',
        'features': '''
- **📐 Signals & Computeds**: Declare reactive variables and lazy, cacheable derived states.
- **⚡ Effects**: Trigger side effects (like saving to databases, logging, or writing to files) automatically in response to dependency changes.
- **🗂 Advanced Collections**: Built-in reactive collections including `listSignal`, `setSignal`, `mapSignal`, and `iterableSignal`.
- **🕒 Async Bindings**: Easily bind streams and futures directly to reactive states using `futureSignal` and `streamSignal`.
- **🔄 Undo/Redo Change Stack**: Track value histories and enable instant undo/redo functionality using `changeStack`.
''',
        'code': '''
import 'package:signals_core/signals_core.dart';

void main() {
  final count = signal(0);
  final doubleCount = computed(() => count.value * 2);

  effect(() {
    print('Double count: \${doubleCount.value}');
  });

  count.value = 5; // Prints: Double count: 10
}
'''
      };

    case 'signals_flutter':
      return {
        'overview':
            'The `signals_flutter` package delivers high-performance, premium reactive UI updates for Flutter applications. By binding signals directly to the widget tree, it enables surgical, localized widget rebuilds without redrawing parent elements or complex state management boilerplate.',
        'features': '''
- **🚀 Implicit Tracking**: Inherit from [SignalWidget] or [SignalStatefulWidget] to establish automatic, mixin-free reactivity inside widget build methods.
- **⚡ Surgical Rebuilds**: Use [SignalBuilder] to surgically rebuild specific, localized nodes of the widget tree without redrawing parent elements.
- **🔄 Interoperability**: Seamlessly convert back and forth between Dart `Signals`, standard Flutter `ValueNotifiers`, and asynchronous `Streams`.
''',
        'code': '''
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class CounterWidget extends SignalWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing .value implicitly tracks and rebuilds this widget on change:
    return ElevatedButton(
      onPressed: () => counter.value++,
      child: Text('Count: \${counter.value}'),
    );
  }
}
'''
      };

    case 'signals_hooks':
      return {
        'overview':
            'The `signals_hooks` package provides seamless, type-safe bindings for the highly popular `flutter_hooks` package. It enables developers to declare, instantiate, and automatically clean up reactive signals directly inside hook-based functional widgets.',
        'features': '''
- **🎣 Hook-based Signalling**: Instantly declare state with `useSignal()` inside functional Hook widgets.
- **🌀 Automatic Disposal**: No manual cleanup or dispose overrides required; the hook manages the entire signal life cycle.
- **⚡ useComputed & useAsyncComputed**: Create cacheable hook-scoped computations and fetch async states inside your Hook widgets.
''',
        'code': '''
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_hooks.dart';

class HookCounter extends HookWidget {
  const HookCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Creates a signal tied to the widget life cycle
    final count = useSignal(0);
    
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: \${count.value}'),
    );
  }
}
'''
      };

    case 'signals_lint':
      return {
        'overview':
            'The `signals_lint` package is a developer productivity toolkit containing custom compiler diagnostics, real-time IDE analysis rules, and automated quick-fixes. It guarantees that reactive signals are consumed according to best practices, preventing memory leaks and anti-patterns at code time.',
        'features': '''
- **🛡 Anti-pattern Detection**: Warns when signals are instantiated directly inside build methods instead of state initializers.
- **💡 Real-time IDE Quick-fixes**: Supports automated quick-fixes (like replacing standard state parameters with reactive watch methods).
- **📝 Standardized Conventions**: Enforces uniform style guides and signal usage patterns across your team.
''',
        'code': '''
// analysis_options.yaml
analyzer:
  plugins:
    - signals_lint
'''
      };

    case 'signals_devtools_extension':
      return {
        'overview':
            'The `signals_devtools_extension` package provides a premium, highly interactive debugging console and visualization dashboard directly embedded inside Flutter DevTools. It allows developers to inspect, audit, pause, and profile reactive states in real-time, instantly exposing dependency flows, memory lifecycles, and update cycles across all mobile, desktop, and web applications.',
        'features': '''
- **📈 Real-Time Updates Timeline**: View a live, chronological stream of all signal value mutations, computation re-evaluations, and side effect executions complete with deep value diffs and microsecond-level timestamps.
- **🕸 Interactive Physics Node Graph**: Render your entire application\'s reactive structure visually! Tracks the direct flow from raw input `Signals` to reactive intermediate `Computeds` down to final rendering sink `Effects` or widgets.
- **⏸️ Reaction Pause & Replay**: Freeze the reactive event stream dynamically at any point. Snapshot current states, inspect value trees, and play/resume events to track sequential microtask mutations step-by-step.
- **🔍 Deep Node Metadata Drawer**: Select any reactive node inside the graph or table to slide out a comprehensive inspector listing its ID, human-readable debug label, stringified value representation, and dynamic lists of upstream sources and downstream targets.
- **🛡️ Diagnostic Logging & Coalescing**: Option to enable direct VM console print logging or group sequential microtask updates to inspect coalesced batch updates.
''',
        'code': '''
# 1. Start your Flutter application in Debug or Profile Mode:
flutter run

# 2. Open Dart DevTools inside your browser or IDE
# 3. Locate and click the custom "Signals" tab in the main DevTools panel
'''
      };

    case 'signals':
      return {
        'overview':
            'The `signals` package is the main overarching package for the Signals framework. It exports the complete core reactive package (`signals_core`) along with full Flutter extensions (`signals_flutter`) to provide a seamless out-of-the-box state management developer experience.',
        'features': '''
- **📦 Unified Import**: Direct access to all core signals, computations, batch updates, reactive collections, and Flutter builders.
- **🎯 Full Reactivity**: The single source of truth for building extremely responsive, state-of-the-art Flutter and Dart applications.
- **📈 Standardized Ecosystem**: Recommended package entry point for all standard mobile, web, desktop, and multiplatform Flutter development.
''',
        'code': '''
import 'package:signals/signals_flutter.dart';

// Access everything from a single package!
final count = signal(0);
final doubleCount = computed(() => count.value * 2);
'''
      };

    default:
      return {
        'overview': 'Overview for package $pkgName',
        'features': '',
        'code': ''
      };
  }
}

String renderMembersMarkdown(DeclInfo decl) {
  if (decl.members.isEmpty) return '';

  final buffer = StringBuffer();

  final constructors =
      decl.members.where((m) => m.type == 'constructor').toList();
  final fields = decl.members.where((m) => m.type == 'field').toList();
  final methods = decl.members.where((m) => m.type == 'method').toList();

  if (constructors.isNotEmpty) {
    buffer.writeln();
    buffer.writeln('### Constructors');
    buffer.writeln();
    buffer.writeln('<details>');
    buffer.writeln('<summary> View Constructors </summary>');
    buffer.writeln();
    for (final m in constructors) {
      final anchor1 = m.name.toLowerCase().replaceAll('.', '-');
      final anchor2 = m.name.toLowerCase().split('.').last;
      buffer.writeln(
          '##### <a name="$anchor1"></a><a name="$anchor2"></a>`${m.signature}`');
      buffer.writeln();
      if (m.comment.isNotEmpty) {
        buffer.writeln(cleanDocumentationComment(m.comment));
        buffer.writeln();
      }
    }
    buffer.writeln('</details>');
    buffer.writeln();
  }

  if (fields.isNotEmpty) {
    buffer.writeln();
    buffer.writeln('### Properties');
    buffer.writeln();
    buffer.writeln('<details>');
    buffer.writeln('<summary> View Properties </summary>');
    buffer.writeln();
    for (final m in fields) {
      final anchor = m.name.toLowerCase();
      buffer.writeln('##### <a name="$anchor"></a>`${m.signature}`');
      buffer.writeln();
      if (m.comment.isNotEmpty) {
        buffer.writeln(cleanDocumentationComment(m.comment));
        buffer.writeln();
      }
    }
    buffer.writeln('</details>');
    buffer.writeln();
  }

  if (methods.isNotEmpty) {
    buffer.writeln();
    buffer.writeln('### Methods');
    buffer.writeln();
    buffer.writeln('<details>');
    buffer.writeln('<summary> View Methods </summary>');
    buffer.writeln();
    for (final m in methods) {
      final anchor = m.name.toLowerCase();
      buffer.writeln('##### <a name="$anchor"></a>`${m.signature}`');
      buffer.writeln();
      if (m.comment.isNotEmpty) {
        buffer.writeln(cleanDocumentationComment(m.comment));
        buffer.writeln();
      }
    }
    buffer.writeln('</details>');
    buffer.writeln();
  }

  return buffer.toString();
}

void generateWebsiteMarkdown(
  String pkgName,
  String version,
  String description,
  List<DeclInfo> decls,
  String outputDir,
  String rootDir,
) {
  // Create output package dir
  final pkgDir = p.join(outputDir, pkgName);
  final dir = Directory(pkgDir);
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }
  dir.createSync(recursive: true);

  // Group pages by category
  final Map<String, List<MapEntry<String, String>>> pagesByCategory = {};

  // First, group declarations by their destination path
  final Map<String, List<DeclInfo>> declsByPath = {};
  for (final decl in decls) {
    final catPath = getCategoryAndPage(decl.originPkg, decl);
    if (catPath == null) continue;
    final parts = catPath.split('/');
    if (parts.length != 2) continue;
    final path = '${parts[0]}/${parts[1]}';
    declsByPath.putIfAbsent(path, () => []).add(decl);
  }

  for (final path in declsByPath.keys) {
    final pathDecls = declsByPath[path]!;

    // Sort declarations so the one with the longest comment comes first
    pathDecls.sort((a, b) => b.comment.length.compareTo(a.comment.length));

    final parts = path.split('/');
    final category = parts[0];
    final pageName = parts[1];

    var title = pageName
        .split('-')
        .map((word) =>
            word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
    if (pathDecls.first.type == 'class' ||
        pathDecls.first.type == 'mixin' ||
        category == 'hooks') {
      title = pathDecls.first.name;
    }

    var pageDesc = '';
    for (final decl in pathDecls) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      if (cleanedComment.isNotEmpty) {
        pageDesc = extractDescription(cleanedComment);
        break;
      }
    }
    if (pageDesc.isEmpty) {
      pageDesc = 'Documentation for $title';
    }

    final variantRegExp = RegExp(r'^(action|ActionExt)\d+$');
    final primaryDecls =
        pathDecls.where((d) => !variantRegExp.hasMatch(d.name)).toList();
    final variantDecls =
        pathDecls.where((d) => variantRegExp.hasMatch(d.name)).toList();

    // Sort variants so action0..10 are in order, and ActionExt0..10 are in order
    variantDecls.sort((a, b) {
      final aNum =
          int.tryParse(RegExp(r'\d+').firstMatch(a.name)?.group(0) ?? '') ?? 0;
      final bNum =
          int.tryParse(RegExp(r'\d+').firstMatch(b.name)?.group(0) ?? '') ?? 0;
      if (a.name.startsWith('action') && b.name.startsWith('ActionExt'))
        return -1;
      if (a.name.startsWith('ActionExt') && b.name.startsWith('action'))
        return 1;
      return aNum.compareTo(bNum);
    });

    // Source doc comment
    final contentBuffer = StringBuffer();
    var isFirstBlock = true;

    // Render primary declarations first
    for (final decl in primaryDecls) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final membersMarkdown = renderMembersMarkdown(decl);
      if (cleanedComment.isNotEmpty || membersMarkdown.isNotEmpty) {
        if (!isFirstBlock) {
          contentBuffer.writeln();
          contentBuffer.writeln('---');
          contentBuffer.writeln();
          contentBuffer.writeln('## ${decl.name}');
          contentBuffer.writeln();
        } else {
          isFirstBlock = false;
          if (decl.name.toLowerCase() != title.toLowerCase()) {
            contentBuffer.writeln('## ${decl.name}');
            contentBuffer.writeln();
          }
        }
        if (cleanedComment.isNotEmpty) {
          contentBuffer.writeln(cleanedComment);
          contentBuffer.writeln();
        }
        if (membersMarkdown.isNotEmpty) {
          contentBuffer.writeln(membersMarkdown);
        }
      }
    }

    // Render variant declarations in a beautiful, unified table/details section
    if (variantDecls.isNotEmpty) {
      if (!isFirstBlock) {
        contentBuffer.writeln();
        contentBuffer.writeln('---');
        contentBuffer.writeln();
      } else {
        isFirstBlock = false;
      }
      contentBuffer.writeln('## Type-Safe Variants & Extensions');
      contentBuffer.writeln();
      contentBuffer.writeln(
          'To ensure complete type safety and optimize static analysis in Dart, the package exposes distinct variants and extension methods corresponding to the number of arguments (from 0 up to 10):');
      contentBuffer.writeln();

      // Table of variants
      contentBuffer.writeln('| Variant / Extension | Description |');
      contentBuffer.writeln('| --- | --- |');
      for (final decl in variantDecls) {
        final comment = cleanDocumentationComment(decl.comment);
        final desc = extractDescription(comment);
        final signature = decl.signature ??
            (decl.members.isNotEmpty
                ? decl.members.first.signature
                : decl.name);
        contentBuffer.writeln('| `${decl.name}` | $desc <br/> `signature` |');
      }
      contentBuffer.writeln();

      // Full details block (collapsible)
      contentBuffer.writeln('<details>');
      contentBuffer
          .writeln('<summary>Show Full API Signatures & Examples</summary>');
      contentBuffer.writeln();
      for (final decl in variantDecls) {
        contentBuffer.writeln('### ${decl.name}');
        contentBuffer.writeln();
        final comment = cleanDocumentationComment(decl.comment);
        if (comment.isNotEmpty) {
          contentBuffer.writeln(comment);
          contentBuffer.writeln();
        }
        final membersMarkdown = renderMembersMarkdown(decl);
        if (membersMarkdown.isNotEmpty) {
          contentBuffer.writeln(membersMarkdown);
        }
        contentBuffer.writeln('---');
        contentBuffer.writeln();
      }
      contentBuffer.writeln('</details>');
      contentBuffer.writeln();
    }

    var content = contentBuffer.toString().trim();

    // Fallback to manual markdown if AST comment is short or empty
    var manualFile =
        File(p.join(rootDir, 'docs', 'content', category, '$pageName.md'));
    if (!manualFile.existsSync()) {
      manualFile = File(p.join(rootDir, 'website', 'src', 'content', 'docs',
          category, '$pageName.md'));
    }
    if (manualFile.existsSync() && content.length < 1000) {
      final manualContent = manualFile.readAsStringSync();
      final fm = parseFrontmatter(manualContent);
      if (fm.containsKey('title')) title = fm['title']!;
      if (fm.containsKey('description')) pageDesc = fm['description']!;
      content = cleanDocumentationComment(stripFrontmatter(manualContent));
    }

    if (content.isEmpty) {
      content = 'Documentation for $title is currently being updated.';
    }

    // Generate page markdown content
    final pageBuffer = StringBuffer();
    pageBuffer.writeln('---');
    pageBuffer.writeln('title: $title');
    pageBuffer.writeln('description: $pageDesc');
    pageBuffer.writeln('---');
    pageBuffer.writeln();
    pageBuffer.writeln(content);

    // Write file
    final categoryDir = p.join(pkgDir, category);
    Directory(categoryDir).createSync(recursive: true);
    final targetFile = File(p.join(categoryDir, '$pageName.md'));
    targetFile.writeAsStringSync(pageBuffer.toString());

    // Register for package main index.md listing
    pagesByCategory
        .putIfAbsent(category, () => [])
        .add(MapEntry(title, '/packages/$pkgName/$category/$pageName'));

    final isPageDeprecated = pathDecls.any((d) => d.isDeprecated);
    if (isPageDeprecated) {
      _deprecatedHrefs.add('/packages/$pkgName/$category/$pageName');
    }
  }

  // Create package index.md landing page
  final overviewData = getPackageOverview(pkgName);
  final overview = overviewData['overview']!;
  final features = overviewData['features']!;
  final code = overviewData['code']!;

  final indexBuffer = StringBuffer();
  indexBuffer.writeln('---');
  indexBuffer.writeln('title: $pkgName');
  indexBuffer.writeln('description: $description');
  indexBuffer.writeln('---');
  indexBuffer.writeln();

  indexBuffer.writeln('> Version: `$version`');
  indexBuffer.writeln();

  // Show installation command
  final isFlutterPkg =
      pkgName == 'signals_flutter' || pkgName == 'signals_hooks';
  final installCmd =
      isFlutterPkg ? 'flutter pub add $pkgName' : 'dart pub add $pkgName';

  indexBuffer.writeln('## Installation');
  indexBuffer.writeln();
  indexBuffer.writeln('```bash');
  indexBuffer.writeln(installCmd);
  indexBuffer.writeln('```');
  indexBuffer.writeln();

  indexBuffer.writeln(overview);
  indexBuffer.writeln();

  if (features.isNotEmpty) {
    indexBuffer.writeln('## Key Features');
    indexBuffer.writeln();
    indexBuffer.writeln(features);
    indexBuffer.writeln();
  }

  if (code.isNotEmpty) {
    indexBuffer.writeln('## Quick Start');
    indexBuffer.writeln();
    final lang = pkgName == 'signals_devtools_extension' ? 'bash' : 'dart';
    indexBuffer.writeln('```$lang');
    indexBuffer.writeln(code.trim());
    indexBuffer.writeln('```');
    indexBuffer.writeln();
  }

  if (pagesByCategory.isNotEmpty) {
    indexBuffer.writeln('## Package Contents');
    indexBuffer.writeln();
    indexBuffer.writeln('<div class="package-contents-grid">');
    for (final category in pagesByCategory.keys) {
      final categoryTitle = getCategoryGroupTitle(category);
      var icon = '📄';
      switch (category.toLowerCase()) {
        case 'async':
          icon = '⚡';
          break;
        case 'core':
          icon = '📦';
          break;
        case 'value':
          icon = '🔢';
          break;
        case 'mixins':
          icon = '🔌';
          break;
        case 'flutter':
          icon = '💙';
          break;
        case 'utilities':
          icon = '🛠️';
          break;
        case 'reactive':
          icon = '🔄';
          break;
        case 'hooks':
          icon = '🪝';
          break;
        case 'signals':
          icon = '⚡';
          break;
        case 'widgets':
          icon = '📱';
          break;
        case 'effects':
          icon = '🔄';
          break;
        case 'render':
          icon = '🎨';
          break;
        case 'extensions':
          icon = '🧩';
          break;
      }

      indexBuffer.writeln('  <div class="category-card">');
      indexBuffer.writeln('    <div class="category-header">');
      indexBuffer.writeln('      <span class="category-icon">$icon</span>');
      indexBuffer.writeln(
          '      <span class="category-title-text">$categoryTitle</span>');
      indexBuffer.writeln('    </div>');
      indexBuffer.writeln('    <div class="category-links">');
      for (final entry in pagesByCategory[category]!) {
        indexBuffer.writeln(
            '      <a class="content-link" href="${entry.value}">${entry.key}</a>');
      }
      indexBuffer.writeln('    </div>');
      indexBuffer.writeln('  </div>');
    }
    indexBuffer.writeln('</div>');
    indexBuffer.writeln();

    indexBuffer.writeln('''
<style>
  .package-contents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1.25rem;
    margin-top: 1.5rem;
    margin-bottom: 2rem;
  }
  .category-card {
    background-color: transparent;
    border: none;
    border-left: 3px solid var(--card-accent, #3b82f6);
    padding: 0.25rem 0 0.5rem 1rem;
    transition: all 0.2s ease;
    display: flex;
    flex-direction: column;
  }
  .category-card:hover {
    border-left-color: var(--card-accent-hover, #2563eb);
  }
  .category-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
    padding-bottom: 0px;
    border-bottom: none;
  }
  .category-icon {
    font-size: 1.25rem;
  }
  .category-title-text {
    font-weight: 700;
    font-size: 1.05rem;
    color: var(--heading-color, #0f172a);
  }
  .category-links {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
  .content-link {
    font-size: 0.9rem;
    font-weight: 500;
    color: #3b82f6 !important;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    transition: all 0.15s ease;
  }
  .content-link:hover {
    color: #2563eb !important;
    transform: translateX(2px);
  }
  :root {
    --card-accent: #3b82f6;
    --card-accent-hover: #2563eb;
    --heading-color: #0f172a;
  }
  html.dark, [data-theme="dark"], html[data-theme="dark"] {
    --card-accent: #60a5fa;
    --card-accent-hover: #93c5fd;
    --heading-color: #f8fafc;
  }
</style>
''');
  }

  File(p.join(pkgDir, 'index.md')).writeAsStringSync(indexBuffer.toString());
  _allPackageSidebars[pkgName] = pagesByCategory;
}

void generateSkillMarkdown(
  String pkgName,
  String version,
  String description,
  List<DeclInfo> decls,
  String skillsOutputDir,
) {
  final priorityPrimitives = {
    'Signal',
    'signal',
    'Computed',
    'computed',
    'Effect',
    'effect',
    'batch',
    'untracked',
    'futureSignal',
    'computedAsync',
    'computedFrom',
    'streamSignal',
    'listSignal',
    'ListSignal',
    'setSignal',
    'SetSignal',
    'mapSignal',
    'MapSignal',
    'linkedSignal',
    'LinkedSignal',
    'connect',
    'Connect',
    'AsyncState',
    'AsyncValue',
    'AsyncLoading',
    'AsyncData',
    'AsyncError',
    'SignalWidget',
    'SignalBuilder',
    'SignalStatefulWidget',
    'SignalProvider',
    'SignalsMixin',
    'useSignal',
    'useComputed',
    'useAsyncComputed',
  };

  final buffer = StringBuffer();
  buffer.writeln('---');
  buffer.writeln('name: $pkgName');
  buffer.writeln('description: $description (v$version)');
  buffer.writeln('---');
  buffer.writeln();
  buffer.writeln('# $pkgName API Best Practices & Primitive Definitions');
  buffer.writeln();
  buffer.writeln(
      'This guide outlines the primitive definitions, classes, functions, and standard design paradigms exposed by `package:$pkgName` (version `$version`).');
  buffer.writeln();

  // Sort declarations: priority ones first, then alphabetical by name
  final sortedDecls = List<DeclInfo>.from(decls);
  sortedDecls.sort((a, b) {
    final aPriority = priorityPrimitives.contains(a.name);
    final bPriority = priorityPrimitives.contains(b.name);
    if (aPriority && !bPriority) return -1;
    if (!aPriority && bPriority) return 1;
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  });

  // Group sorted declarations
  final priorityList =
      sortedDecls.where((d) => priorityPrimitives.contains(d.name)).toList();
  final nonPriorityClasses = sortedDecls
      .where((d) =>
          !priorityPrimitives.contains(d.name) &&
          (d.type == 'class' || d.type == 'mixin'))
      .toList();
  final nonPriorityFunctions = sortedDecls
      .where(
          (d) => !priorityPrimitives.contains(d.name) && d.type == 'function')
      .toList();
  final extensions = sortedDecls.where((d) => d.type == 'extension').toList();
  final variables = sortedDecls.where((d) => d.type == 'variable').toList();

  // Helper to get online link
  String getOnlineDocLink(DeclInfo decl) {
    if (_globalDocLinks.containsKey(decl.name)) {
      return 'https://dartsignals.dev${_globalDocLinks[decl.name]}';
    }
    // Try lowercase or slug variant
    final lowerName = decl.name.toLowerCase();
    if (_globalDocLinks.containsKey(lowerName)) {
      return 'https://dartsignals.dev${_globalDocLinks[lowerName]}';
    }
    final targetPkg =
        (pkgName == 'signals_core' || pkgName == 'signals_flutter')
            ? 'signals'
            : pkgName;
    return 'https://dartsignals.dev/packages/$targetPkg';
  }

  // 1. Priority Reactivity Primitives
  if (priorityList.isNotEmpty) {
    buffer.writeln('## Core Reactivity Primitives');
    buffer.writeln();
    buffer.writeln(
        'These are the primary reactive primitives and components exposed by this package. Use them as the primary building blocks for your application state.');
    buffer.writeln();

    for (final decl in priorityList) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final link = getOnlineDocLink(decl);

      buffer.writeln('### `${decl.name}` (${decl.type})');
      buffer.writeln();
      buffer.writeln('[Read full documentation and examples]($link)');
      buffer.writeln();
      if (cleanedComment.isNotEmpty) {
        buffer.writeln(cleanedComment);
        buffer.writeln();
      }

      if (decl.members.isNotEmpty) {
        buffer.writeln('#### Public API & Signatures');
        buffer.writeln();
        for (final m in decl.members) {
          buffer.writeln('- **`${m.type}`** `${m.signature}`');
          if (m.comment.isNotEmpty) {
            final mClean = cleanDocumentationComment(m.comment);
            final firstLine = extractDescription(mClean);
            if (firstLine.isNotEmpty) {
              buffer.writeln('  > $firstLine');
            }
          }
        }
        buffer.writeln();
      }
      buffer.writeln('---');
      buffer.writeln();
    }
  }

  // 2. Primary Interfaces & Classes (Non-priority)
  if (nonPriorityClasses.isNotEmpty) {
    buffer.writeln('## Primary Interfaces & Classes');
    buffer.writeln();
    buffer.writeln(
        'The following additional classes and mixins support advanced reactivity, state bindings, or standard patterns:');
    buffer.writeln();

    for (final decl in nonPriorityClasses) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final desc = extractDescription(cleanedComment);
      final link = getOnlineDocLink(decl);

      buffer.writeln('### Class `${decl.name}`');
      if (desc.isNotEmpty) {
        buffer.writeln('$desc');
      } else {
        buffer.writeln('API definition for `${decl.name}`.');
      }
      buffer.writeln('- **Type**: `${decl.type}`');
      buffer.writeln('- **Documentation**: [Online API Reference]($link)');

      if (decl.members.isNotEmpty) {
        buffer.writeln('- **Key Members**:');
        for (final m in decl.members.take(8)) {
          buffer.writeln('  - `${m.signature}`');
        }
      }
      buffer.writeln();
    }
  }

  // 3. Utility Functions
  if (nonPriorityFunctions.isNotEmpty) {
    buffer.writeln('## Key Utility Functions');
    buffer.writeln();
    buffer.writeln(
        'The following standalone helper functions perform specialized reactive orchestrations:');
    buffer.writeln();

    for (final decl in nonPriorityFunctions) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final desc = extractDescription(cleanedComment);
      final link = getOnlineDocLink(decl);

      buffer.writeln('### Function `${decl.name}`');
      buffer.writeln('```dart');
      buffer.writeln('${decl.signature ?? decl.name}');
      buffer.writeln('```');
      if (desc.isNotEmpty) {
        buffer.writeln('$desc');
      }
      buffer.writeln('- **Documentation**: [Online API Reference]($link)');
      buffer.writeln();
    }
  }

  // 4. Extensions
  if (extensions.isNotEmpty) {
    buffer.writeln('## API Extension Utilities');
    buffer.writeln();
    buffer.writeln(
        'The following extension methods add seamless reactive bindings or features directly to standard Dart types:');
    buffer.writeln();

    for (final decl in extensions) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final desc = extractDescription(cleanedComment);
      final link = getOnlineDocLink(decl);
      final target = decl.extendedType ?? 'unknown type';

      buffer.writeln('### Extension `${decl.name}` on `$target`');
      if (desc.isNotEmpty) {
        buffer.writeln('$desc');
      }
      buffer.writeln('- **Extended Type**: `$target`');
      buffer.writeln('- **Documentation**: [Online API Reference]($link)');
      if (decl.members.isNotEmpty) {
        buffer.writeln('- **Provided Methods**:');
        for (final m in decl.members) {
          buffer.writeln('  - `${m.signature}`');
        }
      }
      buffer.writeln();
    }
  }

  // 5. Variables
  if (variables.isNotEmpty) {
    buffer.writeln('## Global Variables and Callbacks');
    buffer.writeln();
    for (final decl in variables) {
      final cleanedComment = cleanDocumentationComment(decl.comment);
      final desc = extractDescription(cleanedComment);
      final link = getOnlineDocLink(decl);

      buffer.writeln('### `${decl.name}`');
      buffer.writeln('```dart');
      buffer.writeln('${decl.signature ?? decl.name}');
      buffer.writeln('```');
      if (desc.isNotEmpty) {
        buffer.writeln('$desc');
      }
      buffer.writeln('- **Documentation**: [Online API Reference]($link)');
      buffer.writeln();
    }
  }

  buffer.writeln('## Usage and Best Practices');
  buffer.writeln();
  buffer.writeln(
      '- Always favor fine-grained, computed dependencies rather than manual callbacks where possible.');
  buffer.writeln(
      '- Clean up effects and stream listeners by calling the returned dispose functions.');
  buffer.writeln(
      '- Restrict mutating signals directly within computed properties or active rendering phases to prevent cyclic dependencies.');

  final skillPkgDir = p.join(skillsOutputDir, pkgName);
  Directory(skillPkgDir).createSync(recursive: true);
  File(p.join(skillPkgDir, 'SKILL.md')).writeAsStringSync(buffer.toString());
}

void generateLLMFiles(String rootDir) {
  final rawMdDir = p.join(rootDir, 'docs', 'web', 'raw_markdown');
  if (Directory(rawMdDir).existsSync()) {
    Directory(rawMdDir).deleteSync(recursive: true);
  }
  Directory(rawMdDir).createSync(recursive: true);

  // We will keep a list of all pages for llms.txt & llms-full.txt
  final List<({String title, String description, String path, String content})>
      allPages = [];

  // Helper to register page
  void registerPage(String title, String description, String routePath,
      String originalMarkdown) {
    // Write copy to raw_markdown
    final targetRawFile = File(p.join(rawMdDir, '$routePath.md'));
    targetRawFile.parent.createSync(recursive: true);
    targetRawFile.writeAsStringSync(originalMarkdown);

    allPages.add((
      title: title,
      description: description,
      path: routePath,
      content: stripFrontmatter(originalMarkdown),
    ));
  }

  // 1. Process all manual markdown files in docs/content/
  final List<String> manualFiles = [
    'index.md',
    'reference/overview.md',
    'reference/install.md',
    'reference/ai.md',
    'guides/persisted-signals.md',
    'guides/dependency-injection.md',
    'guides/bi-directional-data-flow.md',
    'guides/value-notifier.md',
  ];

  for (final relPath in manualFiles) {
    final file = File(p.join(rootDir, 'docs', 'content', relPath));
    if (file.existsSync()) {
      final rawContent = file.readAsStringSync();
      final fm = parseFrontmatter(rawContent);
      final title = fm['title'] ?? relPath;
      final description = fm['description'] ?? 'Documentation for $title';

      final routePath = relPath.replaceAll('.md', '');
      registerPage(title, description, routePath, rawContent);
    }
  }

  // 2. Process all generated files under docs/content/packages/
  final genPackagesDir =
      Directory(p.join(rootDir, 'docs', 'content', 'packages'));
  if (genPackagesDir.existsSync()) {
    final genFiles = genPackagesDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.md'));
    for (final file in genFiles) {
      final relativeToPackages =
          p.relative(file.path, from: genPackagesDir.path);
      final rawContent = file.readAsStringSync();
      final fm = parseFrontmatter(rawContent);
      final title = fm['title'] ?? relativeToPackages;
      final description = fm['description'] ?? 'API reference for $title';

      final routePath = 'packages/${relativeToPackages.replaceAll('.md', '')}';
      registerPage(title, description, routePath, rawContent);
    }
  }

  // 3. Generate llms.txt
  final llmsBuffer = StringBuffer();
  llmsBuffer.writeln('# Signals.dart');
  llmsBuffer.writeln();
  llmsBuffer.writeln(
      '> Fine-grained reactive programming framework for Dart and Flutter. Based on the Preact Signals model, offering 100% native, glitch-free, memoized reactivity across VM, CLI, server, web, and Flutter.');
  llmsBuffer.writeln();

  // Group pages into sections
  final manualDocs =
      allPages.where((p) => !p.path.startsWith('packages/')).toList();
  final pkgDocs =
      allPages.where((p) => p.path.startsWith('packages/')).toList();

  llmsBuffer.writeln('## Core Guides & Reference');
  llmsBuffer.writeln();
  for (final page in manualDocs) {
    final urlPath = page.path == 'index' ? '' : page.path;
    llmsBuffer.writeln(
        '- [${page.title}](https://dartsignals.dev/$urlPath): ${page.description}');
  }
  llmsBuffer.writeln();

  llmsBuffer.writeln('## Packages & API Reference');
  llmsBuffer.writeln();
  // Group package pages by package name
  final Map<String, List<dynamic>> pagesByPackage = {};
  for (final page in pkgDocs) {
    final parts = page.path.split('/');
    if (parts.length > 1) {
      final pkgName = parts[1];
      pagesByPackage.putIfAbsent(pkgName, () => []).add(page);
    }
  }

  for (final pkgName in pagesByPackage.keys) {
    llmsBuffer.writeln('### Package `package:$pkgName`');
    llmsBuffer.writeln();
    for (final page in pagesByPackage[pkgName]!) {
      llmsBuffer.writeln(
          '- [${page.title}](https://dartsignals.dev/${page.path}): ${page.description}');
    }
    llmsBuffer.writeln();
  }

  File(p.join(rootDir, 'docs', 'web', 'llms.txt'))
      .writeAsStringSync(llmsBuffer.toString());
  print('Generated docs/web/llms.txt');

  // 4. Generate llms-full.txt (Concatenated markdown for LLM ingestion)
  final llmsFullBuffer = StringBuffer();
  llmsFullBuffer.writeln('# Signals.dart - Full Reference Manual');
  llmsFullBuffer.writeln();
  llmsFullBuffer.writeln(
      '> This document concatenates all manuals, guides, and API references for package:signals.dart.');
  llmsFullBuffer.writeln();

  for (final page in allPages) {
    llmsFullBuffer.writeln('---');
    llmsFullBuffer.writeln('## Page: ${page.title}');
    llmsFullBuffer.writeln(
        'Url: https://dartsignals.dev/${page.path == "index" ? "" : page.path}');
    llmsFullBuffer.writeln('Description: ${page.description}');
    llmsFullBuffer.writeln('---');
    llmsFullBuffer.writeln();
    llmsFullBuffer.writeln(page.content);
    llmsFullBuffer.writeln();
  }

  File(p.join(rootDir, 'docs', 'web', 'llms-full.txt'))
      .writeAsStringSync(llmsFullBuffer.toString());
  print('Generated docs/web/llms-full.txt');
}

const _categoryOrder = [
  'core',
  'value',
  'async',
  'signals',
  'widgets',
  'mixins',
  'effects',
  'render',
  'extensions',
  'utilities',
  'flutter',
  'hooks',
];

String getCategoryGroupTitle(String category) {
  switch (category.toLowerCase()) {
    case 'core':
      return 'Core Primitives';
    case 'value':
      return 'Reactive Collections';
    case 'mixins':
      return 'Reactive Mixins';
    case 'async':
      return 'Async Primitives';
    case 'utilities':
      return 'Utilities';
    case 'flutter':
      return 'Flutter Components';
    case 'hooks':
      return 'Hooks';
    case 'widgets':
      return 'Flutter Widgets';
    case 'signals':
      return 'Reactive Signals';
    case 'effects':
      return 'Lifecycle & Effects';
    case 'render':
      return 'Low-Level Render Objects';
    case 'extensions':
      return 'Widget & Context Extensions';
    default:
      return category[0].toUpperCase() + category.substring(1);
  }
}

List<String> getSortedCategories(Map<String, dynamic> categoriesMap) {
  final keys = categoriesMap.keys.toList();
  keys.sort((a, b) {
    final idxA = _categoryOrder.indexOf(a);
    final idxB = _categoryOrder.indexOf(b);
    if (idxA == -1 && idxB == -1) return a.compareTo(b);
    if (idxA == -1) return 1;
    if (idxB == -1) return -1;
    return idxA.compareTo(idxB);
  });
  return keys;
}

String extractDescription(String comment) {
  if (comment.isEmpty) return '';
  final lines = comment.trim().split('\n');
  if (lines.isEmpty) return '';
  final firstLine = lines.first.trim();
  if (firstLine.isEmpty) return '';

  var cleanText = firstLine
      .replaceAllMapped(RegExp(r'\[([^\]]+)\]\([^)]+\)'), (m) => m[1]!)
      .replaceAllMapped(RegExp(r'\[([^\]]+)\]'), (m) => m[1]!)
      .replaceAll(RegExp(r'`'), '')
      .replaceAll(RegExp(r'\*\*'), '')
      .replaceAll(RegExp(r'__'), '')
      .replaceAll(RegExp(r'\*'), '');

  cleanText = cleanText.replaceAll(RegExp(r'^#+\s+'), '');

  final dotIndex = cleanText.indexOf(RegExp(r'\.\s'));
  if (dotIndex != -1) {
    cleanText = cleanText.substring(0, dotIndex + 1);
  } else if (!cleanText.endsWith('.')) {
    cleanText = '$cleanText.';
  }

  if (cleanText.length > 150) {
    return '${cleanText.substring(0, 147)}...';
  }
  return cleanText;
}

String generatePackageGroups(String pkgName) {
  final buffer = StringBuffer();
  final pkgSidebar = _allPackageSidebars[pkgName];
  if (pkgSidebar == null || pkgSidebar.isEmpty) {
    return '';
  }

  final sortedCategories = getSortedCategories(pkgSidebar);
  for (final category in sortedCategories) {
    final title = getCategoryGroupTitle(category);
    buffer.writeln('          SidebarGroup(');
    buffer.writeln('            title: \'$title\',');
    buffer.writeln('            links: [');
    for (final entry in pkgSidebar[category]!) {
      buffer.writeln(
          '              SidebarLink(text: "${entry.key}", href: \'${entry.value}\'),');
    }
    buffer.writeln('            ],');
    buffer.writeln('          ),');
  }
  return buffer.toString();
}

String generateSidebarLinksOnly(String pkgName) {
  final buffer = StringBuffer();
  final pkgSidebar = _allPackageSidebars[pkgName];
  if (pkgSidebar != null) {
    final sortedCategories = getSortedCategories(pkgSidebar);
    for (final category in sortedCategories) {
      for (final entry in pkgSidebar[category]!) {
        buffer.writeln(
            '              SidebarLink(text: "${entry.key}", href: \'${entry.value}\'),');
      }
    }
  }
  return buffer.toString();
}

void generateNavigationFile(String rootDir) {
  final List<String> types = [];
  final typesDir = Directory(p.join(rootDir, 'docs', 'content', 'types'));
  if (typesDir.existsSync()) {
    final files = typesDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.md'));
    for (final f in files) {
      final name = p.basenameWithoutExtension(f.path);
      types.add(name);
    }
    types.sort();
  }

  final navFile =
      File(p.join(rootDir, 'docs', 'lib', 'components', 'navigation.dart'));
  final bgImageValue =
      r'''url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' fill=\'none\' viewBox=\'0 0 20 20\'%3E%3Cpath stroke=\'%2364748b\' stroke-linecap=\'round\' stroke-linejoin=\'round\' stroke-width=\'1.5\' d=\'m6 8 4 4 4-4\'/%3E%3C/svg%3E")''';

  final buffer = StringBuffer();
  buffer.writeln('''// GENERATED FILE - DO NOT EDIT MANUALLY
// Generated by scripts/generate_docs.dart

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar.dart' hide Sidebar;
import 'package:jaspr_content/components/sidebar_toggle_button.dart';
import 'package:jaspr_content/jaspr_content.dart';

class DynamicHeader extends StatelessComponent {
  const DynamicHeader({
    required this.logo,
    required this.title,
    this.items = const [],
    super.key,
  });

  final String logo;
  final String title;
  final List<Component> items;

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      header(classes: 'header', [
        const SidebarToggleButton(),
        a(classes: 'header-title', href: '/', [
          img(src: logo, alt: 'Logo'),
          span([Component.text(title)]),
        ]),
        div(classes: 'header-content', [
          div(classes: 'header-items', items),
        ]),
      ]),
    ]);
  }

  static List<StyleRule> get _styles => [
    css('.docs .header-container').styles(
      raw: {
        'backdrop-filter': 'none !important',
        '-webkit-backdrop-filter': 'none !important',
        'background-color': 'var(--background) !important',
      },
    ),
    css('.header', [
      css('&').styles(
        height: 4.rem,
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.column(1.rem),
        padding: Padding.symmetric(horizontal: 1.rem, vertical: .25.rem),
        margin: Margin.symmetric(horizontal: Unit.auto),
        border: Border.only(
          bottom: BorderSide(color: Color('#0000000d'), width: 1.px),
        ),
      ),
      css.media(MediaQuery.all(minWidth: 768.px), [
        css('&').styles(padding: Padding.symmetric(horizontal: 2.5.rem))
      ]),
      css('.header-title', [
        css('&').styles(
          display: Display.inlineFlex,
          flex: Flex(basis: 15.rem),
          alignItems: AlignItems.center,
          gap: Gap.column(.75.rem),
          textDecoration: TextDecoration.none,
          raw: {'color': 'inherit'},
        ),
        css('img').styles(
          height: 1.5.rem,
          width: Unit.auto,
          raw: {
            'filter': 'brightness(0.3) contrast(1.3) saturate(1.5)',
          },
        ),
        css('span').styles(fontWeight: FontWeight.w700),
      ]),
      css('.header-content', [
        css('&').styles(
          display: Display.flex,
          flex: Flex(grow: 1),
          justifyContent: JustifyContent.end,
          alignItems: AlignItems.center,
        ),
      ]),
      css('.header-items', [
        css('&').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.column(0.5.rem),
        ),
      ]),
    ]),
    css('[data-theme="dark"] .header .header-title img, html.dark .header .header-title img', [
      css('&').styles(
        raw: {
          'filter': 'none',
        },
      ),
    ]),
    css('.deprecated-badge').styles(
      raw: {
        'font-size': '10px',
        'font-weight': '700',
        'text-transform': 'uppercase',
        'color': '#ef4444',
        'background-color': '#fef2f2',
        'border': '1px solid #fca5a5',
        'border-radius': '4px',
        'padding': '1px 6px',
        'margin-left': '8px',
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'line-height': '1',
        'vertical-align': 'middle',
      },
    ),
    css('html.dark .deprecated-badge, [data-theme="dark"] .deprecated-badge').styles(
      raw: {
        'color': '#fca5a5',
        'background-color': '#7f1d1d',
        'border-color': '#991b1b',
      },
    ),''');

  for (final href in _deprecatedHrefs) {
    buffer.writeln(
        '''    css('.sidebar-container a[href="$href"]::after, .sidebar a[href="$href"]::after').styles(
      raw: {
        'content': '"deprecated"',
        'font-size': '8px',
        'font-weight': '700',
        'text-transform': 'uppercase',
        'color': '#ef4444',
        'background-color': '#fef2f2',
        'border': '1px solid #fca5a5',
        'border-radius': '4px',
        'padding': '0 5px',
        'margin-left': '8px',
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'line-height': '1',
        'height': '14px',
      },
    ),
    css('html.dark .sidebar-container a[href="$href"]::after, html.dark .sidebar a[href="$href"]::after, [data-theme="dark"] .sidebar a[href="$href"]::after').styles(
      raw: {
        'color': '#fca5a5',
        'background-color': '#7f1d1d',
        'border-color': '#991b1b',
      },
    ),''');
  }

  buffer.writeln('''  ];
}

class DynamicSidebar extends StatelessComponent {
  const DynamicSidebar({super.key});

  @override
  Component build(BuildContext context) {
    final currentUrl = context.page.url;

    // 1a. Types Section
    if (currentUrl.startsWith('/types/')) {
      return Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "← Back to Overview", href: '/'),
            ],
          ),
          SidebarGroup(
            title: 'Types Reference',
            links: [
''');
  for (final t in types) {
    final cased = _casedTypeNames[t] ??
        (t.isEmpty ? '' : '${t[0].toUpperCase()}${t.substring(1)}');
    final escapedCased = cased.replaceAll(r'$', r'\$');
    final escapedT = t.replaceAll(r'$', r'\$');
    buffer.writeln(
        "              SidebarLink(text: '$escapedCased', href: '/types/$escapedT'),");
  }
  buffer.writeln('''            ],
          ),
        ],
      );
    }

    // 1. Guides Section
    if (!currentUrl.startsWith('/packages/')) {
      return Sidebar(
        groups: [
          const SidebarGroup(
            links: [
              SidebarLink(text: "Overview", href: '/'),
            ],
          ),
          const SidebarGroup(
            title: 'Reference',
            links: [
              SidebarLink(text: "Overview", href: '/reference/overview'),
              SidebarLink(text: "Installing", href: '/reference/install'),
              SidebarLink(text: "AI Integration", href: '/reference/ai'),
            ],
          ),
          const SidebarGroup(
            title: 'AI Developer Skills',
            links: [
              SidebarLink(text: "signals-dart", href: '/skills/signals-dart'),
              SidebarLink(text: "signals-flutter", href: '/skills/signals-flutter'),
              SidebarLink(text: "signals-hooks", href: '/skills/signals-hooks'),
              SidebarLink(text: "signals-lint", href: '/skills/signals-lint'),
              SidebarLink(text: "signals-migration-6-to-7", href: '/skills/signals-migration-6-to-7'),
              SidebarLink(text: "signals-preact-dart", href: '/skills/signals-preact-dart'),
            ],
          ),
          const SidebarGroup(
            title: 'Guides',
            links: [
              SidebarLink(text: "Persisted Signals", href: '/guides/persisted-signals'),
              SidebarLink(text: "Dependency Injection", href: '/guides/dependency-injection'),
              SidebarLink(text: "Bi-directional Data Flow", href: '/guides/bi-directional-data-flow'),
              SidebarLink(text: "Value Notifier", href: '/guides/value-notifier'),
            ],
          ),
        ],
      );
    }

    // 2. Preact Signals Section
    if (currentUrl.startsWith('/packages/preact_signals')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/preact_signals/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('preact_signals'));
  buffer.writeln('''        ],
      );
    }

    // 3. Signals Core Section
    if (currentUrl.startsWith('/packages/signals_core')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals_core/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals_core'));
  buffer.writeln('''        ],
      );
    }

    // 4. Signals Flutter Section
    if (currentUrl.startsWith('/packages/signals_flutter')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals_flutter/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals_flutter'));
  buffer.writeln('''        ],
      );
    }

    // 5. Signals Hooks Section
    if (currentUrl.startsWith('/packages/signals_hooks')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals_hooks/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals_hooks'));
  buffer.writeln('''        ],
      );
    }

    // 5.1. Signals DevTools Extension Section
    if (currentUrl.startsWith('/packages/signals_devtools_extension')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals_devtools_extension/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals_devtools_extension'));
  buffer.writeln('''        ],
      );
    }

    // 5.2. Signals Lint Section
    if (currentUrl.startsWith('/packages/signals_lint')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals_lint/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals_lint'));
  buffer.writeln('''        ],
      );
    }

    // 6. Unified Signals Section
    if (currentUrl.startsWith('/packages/signals')) {
      return const Sidebar(
        groups: [
          SidebarGroup(
            links: [
              SidebarLink(text: "Overview & Index", href: '/packages/signals/'),
            ],
          ),
''');
  buffer.write(generatePackageGroups('signals'));
  buffer.writeln('''        ],
      );
    }

    // Fallback Sidebar
    return const Sidebar(
      groups: [],
    );
  }
}

class Sidebar extends StatelessComponent {
  const Sidebar({this.currentRoute, required this.groups, super.key});

  final String? currentRoute;
  final List<SidebarGroup> groups;

  @override
  Component build(BuildContext context) {
    final currentUrl = currentRoute ?? context.page.url;

    String activePackageUrl;
    if (currentUrl.startsWith('/packages/signals_flutter')) {
      activePackageUrl = '/packages/signals_flutter';
    } else if (currentUrl.startsWith('/packages/signals_core')) {
      activePackageUrl = '/packages/signals_core';
    } else if (currentUrl.startsWith('/packages/preact_signals')) {
      activePackageUrl = '/packages/preact_signals';
    } else if (currentUrl.startsWith('/packages/signals_hooks')) {
      activePackageUrl = '/packages/signals_hooks';
    } else if (currentUrl.startsWith('/packages/signals_devtools_extension')) {
      activePackageUrl = '/packages/signals_devtools_extension';
    } else if (currentUrl.startsWith('/packages/signals_lint')) {
      activePackageUrl = '/packages/signals_lint';
    } else if (currentUrl.startsWith('/packages/signals')) {
      activePackageUrl = '/packages/signals';
    } else {
      activePackageUrl = '/';
    }

    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      nav(classes: 'sidebar', [
        button(classes: 'sidebar-close', [
          span([Component.text('✕')]),
        ]),
        select(
          classes: 'package-switcher',
          value: activePackageUrl,
          attributes: {
            'onchange': 'window.location.href = this.value',
          },
          [
            option(
              value: '/',
              selected: currentUrl == '/' || currentUrl.startsWith('/guides/') || currentUrl.startsWith('/reference/'),
              [Component.text('📖 Guides & Overview')],
            ),
            option(
              value: '/packages/signals',
              selected: currentUrl == '/packages/signals' || currentUrl.startsWith('/packages/signals/'),
              [Component.text('📦 signals')],
            ),
            option(
              value: '/packages/signals_flutter',
              selected: currentUrl == '/packages/signals_flutter' || currentUrl.startsWith('/packages/signals_flutter/'),
              [Component.text('📱 signals_flutter')],
            ),
            option(
              value: '/packages/signals_core',
              selected: currentUrl == '/packages/signals_core' || currentUrl.startsWith('/packages/signals_core/'),
              [Component.text('⚡ signals_core')],
            ),
            option(
              value: '/packages/preact_signals',
              selected: currentUrl == '/packages/preact_signals' || currentUrl.startsWith('/packages/preact_signals/'),
              [Component.text('⚛️ preact_signals')],
            ),
            option(
              value: '/packages/signals_hooks',
              selected: currentUrl == '/packages/signals_hooks' || currentUrl.startsWith('/packages/signals_hooks/'),
              [Component.text('🪝 signals_hooks')],
            ),
            option(
              value: '/packages/signals_devtools_extension',
              selected: currentUrl == '/packages/signals_devtools_extension' || currentUrl.startsWith('/packages/signals_devtools_extension/'),
              [Component.text('🛠️ signals_devtools')],
            ),
            option(
              value: '/packages/signals_lint',
              selected: currentUrl == '/packages/signals_lint' || currentUrl.startsWith('/packages/signals_lint/'),
              [Component.text('🔍 signals_lint')],
            ),
          ],
        ),
        div([
          for (final group in groups)
            div(classes: 'sidebar-group', [
              if (group.title case final groupTitle?) h3([Component.text(groupTitle)]),
              ul([
                for (final item in group.links)
                  li([
                    div(classes: currentUrl == item.href ? 'active' : null, [
                      a(href: item.href, [Component.text(item.text)]),
                    ]),
                  ]),
              ]),
            ]),
        ]),
        script(
          content: """
(function() {
  function scrollToActive() {
    var active = document.querySelector(".sidebar .active");
    if (active) {
      active.scrollIntoView({ block: "nearest", behavior: "instant" });
    }
  }
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", scrollToActive);
  } else {
    scrollToActive();
  }
  setTimeout(scrollToActive, 50);
  setTimeout(scrollToActive, 150);
})();
""",
        ),
      ]),
    ]);
  }

  static List<StyleRule> get _styles => [
    css('.sidebar', [
      css('&').styles(
        position: Position.relative(),
        fontSize: 0.875.rem,
        lineHeight: 1.25.rem,
        padding: Padding.only(left: 0.5.rem, bottom: 1.25.rem, top: 0.75.rem),
      ),
      css.media(MediaQuery.all(minWidth: 1024.px), [css('&').styles(padding: Padding.only(top: Unit.zero))]),
      css('.sidebar-close', [
        css('&').styles(
          position: Position.absolute(top: 0.75.rem, right: 0.75.rem),
        ),
        css.media(MediaQuery.all(minWidth: 1024.px), [css('&').styles(display: Display.none)]),
      ]),
      css('.sidebar-group', [
        css('&').styles(
          padding: Padding.only(top: 1.5.rem, right: 0.75.rem),
        ),
        css('h3').styles(
          fontWeight: FontWeight.w600,
          fontSize: 14.px,
          padding: Padding.only(left: 0.75.rem),
          margin: Margin.only(bottom: 1.rem, top: Unit.zero),
        ),
        css('ul').styles(listStyle: ListStyle.none, margin: Margin.zero, padding: Padding.zero),
        css('li', [
          css('div', [
            css('&').styles(
              opacity: 0.75,
              margin: Margin.only(bottom: 1.px),
              whiteSpace: WhiteSpace.noWrap,
              overflow: Overflow.hidden,
              textOverflow: TextOverflow.ellipsis,
              radius: BorderRadius.circular(.375.rem),
              display: Display.flex,
              transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
            ),
            css('&:hover').styles(opacity: 1, backgroundColor: Color('#0000000d')),
            css('&.active').styles(
              opacity: 1,
              color: Color('#3b82f6'),
              fontWeight: FontWeight.w700,
              backgroundColor: Color('color-mix(in srgb, currentColor 15%, transparent)'),
            ),
          ]),
          css('a').styles(
            padding: Padding.only(left: 12.px, top: .5.rem, bottom: .5.rem),
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            flex: Flex(grow: 1),
          ),
        ]),
      ]),
    ]),
    css('.package-switcher', [
      css('&').styles(
        display: Display.block,
        margin: Margin.only(top: 1.5.rem, bottom: 1.rem, left: 1.rem, right: 1.rem),
        padding: Padding.only(top: 0.625.rem, bottom: 0.625.rem, left: 1.rem, right: 2.5.rem),
        fontSize: 0.875.rem,
        fontWeight: FontWeight.w600,
        radius: BorderRadius.circular(0.5.rem),
        cursor: Cursor.pointer,
        transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
        raw: {
          'width': 'calc(100% - 2rem)',
          'appearance': 'none',
          '-webkit-appearance': 'none',
          'background-image': '$bgImageValue',
          'background-position': 'right 0.75rem center',
          'background-repeat': 'no-repeat',
          'background-size': '1.25rem',
          'border': '1px solid var(--border, #e2e8f0)',
          'background-color': 'var(--bg-card, #ffffff)',
          'color': 'var(--text, #0f172a)',
        },
      ),
      css('&:hover').styles(
        raw: {
          'border-color': '#cbd5e1',
          'background-color': '#f8fafc',
        },
      ),
      css('&:focus').styles(
        raw: {
          'border-color': '#3b82f6',
          'box-shadow': '0 0 0 2px rgba(59, 130, 246, 0.15)',
        },
      ),
    ]),
    css('[data-theme="dark"] .package-switcher, html.dark .package-switcher', [
      css('&').styles(
        raw: {
          'border-color': '#475569',
          'background-color': '#1e293b',
          'color': '#f8fafc',
        },
      ),
      css('&:hover').styles(
        raw: {
          'border-color': '#64748b',
          'background-color': '#0f172a',
        },
      ),
      css('&:focus').styles(
        raw: {
          'border-color': '#3b82f6',
        },
      ),
    ]),
    css('[data-theme="dark"] .package-switcher option, html.dark .package-switcher option', [
      css('&').styles(
        raw: {
          'background-color': '#1e293b',
          'color': '#f8fafc',
        },
      ),
    ]),
  ];
}
''');

  navFile.writeAsStringSync(buffer.toString());
  print('Generated docs/lib/components/navigation.dart');
}

void generateVSCodeAndSkills(
  String rootDir,
  Map<String, List<DeclInfo>> parsedDecls,
  Map<String, Map<String, dynamic>> parsedMeta,
) {
  print('\nGenerating VS Code and Skills via Mustache...');
  // 1. Read snippets_data.yaml
  final yamlFile = File(p.join(rootDir, 'scripts', 'snippets_data.yaml'));
  if (!yamlFile.existsSync()) {
    print('Error: snippets_data.yaml not found!');
    return;
  }
  final List yamlList = loadYaml(yamlFile.readAsStringSync()) as List;

  // 2. Prepare snippets data for Mustache
  final List<Map<String, dynamic>> snippets = [];
  for (final item in yamlList) {
    final map = Map<String, dynamic>.from(item as Map);
    final List<String> bodyLines = List<String>.from(map['body'] as List);
    final List<Map<String, dynamic>> bodyLinesMap = [];
    for (var i = 0; i < bodyLines.length; i++) {
      bodyLinesMap.add({
        'line': bodyLines[i],
        'last': i == bodyLines.length - 1,
      });
    }
    map['body_lines'] = bodyLinesMap;
    snippets.add(map);
  }

  for (var i = 0; i < snippets.length; i++) {
    snippets[i]['last'] = i == snippets.length - 1;
  }

  // 3. Render VS Code snippets file
  final snippetsTemplateFile = File(p.join(rootDir, 'scripts', 'templates', 'vscode_snippets.json.mustache'));
  if (snippetsTemplateFile.existsSync()) {
    final template = Template(snippetsTemplateFile.readAsStringSync(), htmlEscapeValues: false);
    final rendered = template.renderString({'snippets': snippets});
    final targetSnippetsFile = File(p.join(rootDir, 'editors', 'vscode', 'snippets', 'signals.json'));
    targetSnippetsFile.parent.createSync(recursive: true);
    targetSnippetsFile.writeAsStringSync(rendered);
    print('  Generated VS Code snippets: ${targetSnippetsFile.path}');
  } else {
    print('Error: vscode_snippets.json.mustache template not found!');
  }

  // 4. Render VS Code extension.ts (visual cheat-sheet HTML)
  final extensionTemplateFile = File(p.join(rootDir, 'scripts', 'templates', 'extension.ts.mustache'));
  if (extensionTemplateFile.existsSync()) {
    final coreSnippets = snippets.where((s) => s['isFlutter'] == false).map((s) {
      final copy = Map<String, dynamic>.from(s);
      if (copy['example'] != null) {
        copy['example'] = (copy['example'] as String).replaceAll('\$', '\\\$');
      }
      return copy;
    }).toList();
    final flutterSnippets = snippets.where((s) => s['isFlutter'] == true).map((s) {
      final copy = Map<String, dynamic>.from(s);
      if (copy['example'] != null) {
        copy['example'] = (copy['example'] as String).replaceAll('\$', '\\\$');
      }
      return copy;
    }).toList();

    for (var i = 0; i < coreSnippets.length; i++) {
      coreSnippets[i]['last'] = i == coreSnippets.length - 1;
    }
    for (var i = 0; i < flutterSnippets.length; i++) {
      flutterSnippets[i]['last'] = i == flutterSnippets.length - 1;
    }

    final signalsVersion = parsedMeta['signals']?['version'] ?? '7.0.0';

    final template = Template(extensionTemplateFile.readAsStringSync(), htmlEscapeValues: false);
    final rendered = template.renderString({
      'core_snippets': coreSnippets,
      'flutter_snippets': flutterSnippets,
      'signals_version': signalsVersion,
    });
    final targetExtensionFile = File(p.join(rootDir, 'editors', 'vscode', 'src', 'web', 'extension.ts'));
    targetExtensionFile.parent.createSync(recursive: true);
    targetExtensionFile.writeAsStringSync(rendered);
    print('  Generated VS Code extension.ts: ${targetExtensionFile.path}');
  } else {
    print('Error: extension.ts.mustache template not found!');
  }

  // 5. Render AI Developer Skills (SKILL.md)
  final skillTemplateFile = File(p.join(rootDir, 'scripts', 'templates', 'skill_definition.md.mustache'));
  if (skillTemplateFile.existsSync()) {
    final skillTemplate = Template(skillTemplateFile.readAsStringSync(), htmlEscapeValues: false);

    final skillTargets = [
      (
        pkgName: 'signals-dart',
        originPkg: 'signals_core',
        description: 'Advanced reactive state primitives, collections, mixins, and utilities of signals_core.',
        isFlutter: false,
      ),
      (
        pkgName: 'signals-flutter',
        originPkg: 'signals_flutter',
        description: 'Comprehensive guide and best practices for integrating reactive signals cleanly inside Flutter applications.',
        isFlutter: true,
      ),
      (
        pkgName: 'signals-preact-dart',
        originPkg: 'preact_signals',
        description: 'Core reactive programming best practices and primitive definitions for preact_signals in Dart.',
        isFlutter: false,
      ),
    ];

    String getCommentSummary(String comment) {
      final cleaned = cleanDocumentationComment(comment).trim();
      if (cleaned.isEmpty) return '';
      final firstLine = cleaned.split('\n').first.trim();
      return firstLine.replaceAll('*', '').replaceAll('#', '').replaceAll('`', '').trim();
    }

    for (final target in skillTargets) {
      final filteredSnippets = snippets.where((s) => s['isFlutter'] == target.isFlutter).toList();
      for (var i = 0; i < filteredSnippets.length; i++) {
        filteredSnippets[i]['last'] = i == filteredSnippets.length - 1;
      }

      final List<DeclInfo> pkgDecls = parsedDecls[target.originPkg] ?? [];
      final List<Map<String, dynamic>> parsedDeclsMap = [];
      for (final d in pkgDecls) {
        if (d.name.startsWith('_')) continue;
        
        final List<Map<String, dynamic>> membersList = [];
        for (final m in d.members) {
          membersList.add({
            'name': m.name,
            'type': m.type,
            'signature': m.signature,
            'comment': cleanDocumentationComment(m.comment),
            'isStatic': m.isStatic,
          });
        }

        parsedDeclsMap.add({
          'name': d.name,
          'type': d.type,
          'comment': cleanDocumentationComment(d.comment),
          'summary': getCommentSummary(d.comment),
          'signature': d.signature,
          'isDeprecated': d.isDeprecated,
          'members': membersList,
          'has_members': membersList.isNotEmpty,
        });
      }

      final pkgMeta = parsedMeta[target.originPkg] ?? {'version': '7.0.0'};
      final version = pkgMeta['version'] ?? '7.0.0';

      final renderedSkill = skillTemplate.renderString({
        'pkgName': target.pkgName,
        'description': target.description,
        'version': version,
        'rootDir': rootDir,
        'snippets': filteredSnippets,
        'decls': parsedDeclsMap,
      });

      final targetSkillDirs = [
        p.join(rootDir, 'skills', target.pkgName),
        p.join(rootDir, 'editors', 'vscode', 'skills', target.pkgName),
      ];

      for (final dirPath in targetSkillDirs) {
        Directory(dirPath).createSync(recursive: true);
        
        // Clean and create primitives/
        final primitivesDir = Directory(p.join(dirPath, 'primitives'));
        if (primitivesDir.existsSync()) primitivesDir.deleteSync(recursive: true);
        primitivesDir.createSync(recursive: true);

        // Clean and create api/
        final apiDir = Directory(p.join(dirPath, 'api'));
        if (apiDir.existsSync()) apiDir.deleteSync(recursive: true);
        apiDir.createSync(recursive: true);

        // Clean up legacy static directories if present (e.g. core/ in signals-preact-dart)
        final coreDir = Directory(p.join(dirPath, 'core'));
        if (coreDir.existsSync()) coreDir.deleteSync(recursive: true);

        // Write main SKILL.md
        File(p.join(dirPath, 'SKILL.md')).writeAsStringSync(renderedSkill);

        // Generate primitive subfiles
        for (final s in filteredSnippets) {
          final content = StringBuffer();
          content.writeln('# Primitive: `${s['name']}`');
          content.writeln();
          content.writeln('- **Category**: ${s['category']}');
          content.writeln('- **Description**: ${s['description']}');
          content.writeln();
          content.writeln('---');
          content.writeln();
          content.writeln('## Standard Usage Example');
          content.writeln();
          content.writeln('```dart');
          content.writeln(s['example']);
          content.writeln('```');
          
          File(p.join(primitivesDir.path, '${s['name']}.md')).writeAsStringSync(content.toString());
        }

        // Generate API subfiles
        for (final d in parsedDeclsMap) {
          final content = StringBuffer();
          content.writeln('# ${d['type']} `${d['name']}`');
          content.writeln();
          if (d['isDeprecated'] == true) {
            content.writeln('> [!WARNING]');
            content.writeln('> This API is deprecated. Avoid using it in new code.');
            content.writeln();
          }
          content.writeln(d['comment']);
          content.writeln();
          content.writeln('---');
          content.writeln();
          if (d['signature'] != null && (d['signature'] as String).isNotEmpty) {
            content.writeln('## Signature');
            content.writeln();
            content.writeln('```dart');
            content.writeln(d['signature']);
            content.writeln('```');
            content.writeln();
          }

          if (d['has_members'] == true) {
            content.writeln('## Members of `${d['name']}`');
            content.writeln();
            content.writeln('| Member | Type | Signature | Description |');
            content.writeln('| :--- | :--- | :--- | :--- |');
            for (final m in d['members'] as List) {
              content.writeln('| **${m['name']}** | `${m['type']}` | `${m['signature']}` | ${m['comment']} |');
            }
          }

          File(p.join(apiDir.path, '${d['name']}.md')).writeAsStringSync(content.toString());
        }
      }
      print('  Generated Skill: ${target.pkgName} with directory tables and subfiles.');
    }

    // 6. Generate AI Skills documentation preview pages for the Jaspr site
    final skillsDir = Directory(p.join(rootDir, 'skills'));
    final docsSkillsDir = Directory(p.join(rootDir, 'docs', 'content', 'skills'));
    if (skillsDir.existsSync()) {
      docsSkillsDir.createSync(recursive: true);
      for (final entity in skillsDir.listSync()) {
        if (entity is Directory) {
          final skillName = p.basename(entity.path);
          final skillFile = File(p.join(entity.path, 'SKILL.md'));
          if (skillFile.existsSync()) {
            final content = skillFile.readAsStringSync();
            // Extract frontmatter description and name
            var name = skillName;
            var description = 'AI Developer Skill for $skillName';
            var skillBody = content;

            final frontmatterMatch = RegExp(r'^---\r?\n([\s\S]*?)\r?\n---').firstMatch(content);
            if (frontmatterMatch != null) {
              final frontmatterText = frontmatterMatch.group(1) ?? '';
              // Parse frontmatter yaml-like lines
              for (final line in frontmatterText.split('\n')) {
                final parts = line.split(':');
                if (parts.length >= 2) {
                  final key = parts[0].trim();
                  final val = parts.sublist(1).join(':').trim();
                  if (key == 'name') {
                    name = val;
                  } else if (key == 'description') {
                    description = val;
                  }
                }
              }
              // Strip frontmatter from skillBody
              skillBody = content.substring(frontmatterMatch.end).trim();
            }

            // Generate the Jaspr markdown page
            final docsSkillFile = File(p.join(docsSkillsDir.path, '$skillName.md'));
            final newContent = StringBuffer();
            newContent.writeln('---');
            newContent.writeln('title: $name AI Skill');
            newContent.writeln('description: $description');
            newContent.writeln('---');
            newContent.writeln();
            newContent.writeln('# $name AI Developer Skill');
            newContent.writeln();
            newContent.writeln('> $description');
            newContent.writeln();
            newContent.writeln('---');
            newContent.writeln();
            newContent.writeln('### 📥 Installation');
            newContent.writeln();
            newContent.writeln('To instantly install this AI developer skill into your local workspace under `.agents/skills/`, run:');
            newContent.writeln();
            newContent.writeln('```bash');
            newContent.writeln('npx skills add rodydavis/signals.dart/tree/main/skills/$skillName');
            newContent.writeln('```');
            newContent.writeln();
            newContent.writeln('---');
            newContent.writeln();
            newContent.writeln('## 📄 SKILL.md Preview');
            newContent.writeln();
            newContent.writeln('````plaintext');
            newContent.writeln(skillBody);
            newContent.writeln('````');

            docsSkillFile.writeAsStringSync(newContent.toString());
            print('  Generated Docs Skill Page: ${docsSkillFile.path}');
          }
        }
      }
    }
  } else {
    print('Error: skill_definition.md.mustache template not found!');
  }
}
