import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

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
  final String? extendedType;
  final String? signature;
  final String originPkg;

  DeclInfo({
    required this.name,
    required this.type,
    required this.comment,
    required this.members,
    required this.originPkg,
    this.extendedType,
    this.signature,
  });
}

void main(List<String> args) {
  // Determine root directory dynamically relative to this script file
  final scriptDir = p.dirname(Platform.script.toFilePath());
  final rootDir = p.canonicalize(p.join(scriptDir, '..'));
  final packagesDir = p.join(rootDir, 'packages');

  final exemptFromExample = {
    // preact_signals
    'SignalEffectException',
    'SignalOptionsBase',
    'action10',
    'action6',
    'action7',
    'action8',
    'action9',

    // signals_core
    'AsyncData',
    'AsyncDataRefreshing',
    'AsyncDataReloading',
    'AsyncError',
    'AsyncErrorRefreshing',
    'AsyncErrorReloading',
    'AsyncLoading',
    'AsyncSignalOptions',
    'ChangeSignalOptions',
    'ComputedOptions',
    'DevToolsSignalsObserver',
    'disableSignalsDevTools',
    'EffectCycleDetectionError',
    'EffectOptions',
    'IterableSignalOptions',
    'LazySignalInitializationError',
    'linkedSignal',
    'LinkedSignalOptions',
    'LinkedSignalPreviousState',
    'ListSignalOptions',
    'LoggingSignalsObserver',
    'MapSignalOptions',
    'PersistedBoolSignal',
    'PersistedDoubleSignal',
    'PersistedEnumSignal',
    'PersistedIntSignal',
    'PersistedNullableBoolSignal',
    'PersistedNullableDoubleSignal',
    'PersistedNullableEnumSignal',
    'PersistedNullableIntSignal',
    'PersistedNullableNumSignal',
    'PersistedNullableStringSignal',
    'PersistedNumSignal',
    'PersistedSignalOptions',
    'PersistedStringSignal',
    'queueSignal',
    'QueueSignal',
    'QueueSignalOptions',
    'ReadonlySignalOptions',
    'reloadSignalsDevTools',
    'SetSignalOptions',
    'Signal',
    'SignalOptions',
    'signalsDevToolsEnabled',
    'SignalsError',
    'SignalsInMemoryKeyValueStore',
    'SignalsReadAfterDisposeError',
    'SignalsWriteAfterDisposeError',
    'timerSignal',
    'TimerSignal',
    'trackedSignal',
    'TrackedSignal',
    'TrackedSignalOptions',

    // signals_flutter
    'ConvertedSignalStatefulElement',
    'ConvertedSignalStatefulWidget',
    'ConvertedSignalWidget',
    'FlutterReadonlySignal',
    'MultiSignalProvider',
    'readonly',
    'RenderSignalBox',
    'RenderSignalCustomPaint',
    'RenderSignalProxyBox',
    'SignalCustomPaint',
    'SignalElement',
    'SignalProxyWidget',
    'SignalStatefulElement',
    'ValueListenableSignalMixin',
    'ValueNotifierSignalMixin',

    // signals_lint
    'createPlugin',

    // signals_devtools_extension
    'SignalsDevToolsExtension',

    // computedFrom overloads & extensions
    'computedFrom1',
    'computedFrom2',
    'computedFrom3',
    'computedFrom4',
    'computedFrom5',
    'computedFrom6',
    'computedFrom7',
    'computedFrom8',
    'computedFrom9',
    'computedFrom10',
    'ComputedFromExt1',
    'ComputedFromExt2',
    'ComputedFromExt3',
    'ComputedFromExt4',
    'ComputedFromExt5',
    'ComputedFromExt6',
    'ComputedFromExt7',
    'ComputedFromExt8',
    'ComputedFromExt9',
    'ComputedFromExt10',
  };

  print('================================================================');
  print('🔍 RUNNING PUBLIC API DOCUMENTATION & EXAMPLES COVERAGE CHECK');
  print('================================================================');
  print('Project Root: $rootDir\n');

  final packages = [
    'preact_signals',
    'signals_core',
    'signals_flutter',
    'signals_hooks',
    'signals_lint',
    'signals_devtools_extension',
    'signals',
  ];

  var overallTotal = 0;
  var overallWithComments = 0;
  var overallWithExamples = 0;
  var overallMapped = 0;
  var hasFailures = false;

  final Map<String, List<String>> missingCommentsReport = {};
  final Map<String, List<String>> missingExamplesReport = {};
  final Map<String, List<String>> missingMappingReport = {};

  for (final pkgName in packages) {
    final pkgPath = p.join(packagesDir, pkgName);
    final pubspecFile = File(p.join(pkgPath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) continue;

    final libDir = p.join(pkgPath, 'lib');
    var entrypointPath = p.join(libDir, '$pkgName.dart');
    if (!File(entrypointPath).existsSync()) {
      entrypointPath = p.join(libDir, 'main.dart');
    }
    if (!File(entrypointPath).existsSync()) continue;

    final exportedFiles = getExportedFiles(entrypointPath);
    final List<DeclInfo> decls = [];
    for (final filePath in exportedFiles) {
      decls.addAll(extractDeclarations(filePath, pkgName));
    }

    // Deduplicate declarations by name
    final Map<String, DeclInfo> uniqueDecls = {};
    for (final decl in decls) {
      uniqueDecls[decl.name] = decl;
    }
    final finalDecls = uniqueDecls.values.toList();
    finalDecls
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    var pkgTotal = finalDecls.length;
    var pkgWithComments = 0;
    var pkgWithExamples = 0;
    var pkgMapped = 0;

    missingCommentsReport[pkgName] = [];
    missingExamplesReport[pkgName] = [];
    missingMappingReport[pkgName] = [];

    final List<String> strictExampleFailures = [];
    for (final decl in finalDecls) {
      final hasComment = decl.comment.trim().isNotEmpty;
      final hasExample =
          decl.comment.contains('```dart') || decl.comment.contains('```');
      final mappedPath = getCategoryAndPage(pkgName, decl);
      final isMapped = mappedPath != null;

      if (hasComment)
        pkgWithComments++;
      else
        missingCommentsReport[pkgName]!.add('${decl.type} ${decl.name}');

      if (hasExample)
        pkgWithExamples++;
      else if (hasComment)
        missingExamplesReport[pkgName]!.add('${decl.type} ${decl.name}');

      if (isMapped)
        pkgMapped++;
      else
        missingMappingReport[pkgName]!.add('${decl.type} ${decl.name}');

      // Strict check: non-exempt public classes and functions must have at least one code example block
      if (pkgName != 'signals_devtools_extension' &&
          (decl.type == 'class' || decl.type == 'function') &&
          !hasExample &&
          !exemptFromExample.contains(decl.name)) {
        strictExampleFailures.add('${decl.type} ${decl.name}');
      }
    }

    final commentPercent = pkgTotal > 0
        ? (pkgWithComments / pkgTotal * 100).toStringAsFixed(1)
        : '100';
    final examplePercent = pkgWithComments > 0
        ? (pkgWithExamples / pkgWithComments * 100).toStringAsFixed(1)
        : '100';
    final mappingPercent =
        pkgTotal > 0 ? (pkgMapped / pkgTotal * 100).toStringAsFixed(1) : '100';

    print('📦 Package: $pkgName');
    print('   - Total Public Declarations: $pkgTotal');
    print(
        '   - Has Source Doc Comments:  $pkgWithComments / $pkgTotal ($commentPercent%)');
    print(
        '   - Has Code Examples:        $pkgWithExamples / $pkgWithComments ($examplePercent%)');
    print(
        '   - Mapped in website docs:   $pkgMapped / $pkgTotal ($mappingPercent%)');
    if (strictExampleFailures.isNotEmpty) {
      print(
          '   ❌ FAILURES: Missing required code example (class/function not in exempt list):');
      for (final fail in strictExampleFailures) {
        print('     * $fail');
      }
      hasFailures = true;
    }
    print('');

    overallTotal += pkgTotal;
    overallWithComments += pkgWithComments;
    overallWithExamples += pkgWithExamples;
    overallMapped += pkgMapped;
  }

  final overallCommentPercent =
      overallTotal > 0 ? (overallWithComments / overallTotal * 100) : 100.0;
  final overallExamplePercent = overallWithComments > 0
      ? (overallWithExamples / overallWithComments * 100)
      : 100.0;
  final overallMappingPercent =
      overallTotal > 0 ? (overallMapped / overallTotal * 100) : 100.0;

  print('================================================================');
  print('📊 OVERALL REPORT SUMMARY');
  print('================================================================');
  print('Total Monorepo Public APIs:  $overallTotal');
  print(
      'Source Doc Comments:         $overallWithComments / $overallTotal (${overallCommentPercent.toStringAsFixed(1)}%)');
  print(
      'Examples in Doc Comments:    $overallWithExamples / $overallWithComments (${overallExamplePercent.toStringAsFixed(1)}%)');
  print(
      'Website Documentation Map:   $overallMapped / $overallTotal (${overallMappingPercent.toStringAsFixed(1)}%)');
  print('================================================================\n');

  // Print detailed missing documentation sections
  for (final pkgName in packages) {
    final missingComments = missingCommentsReport[pkgName] ?? [];
    final missingExamples = missingExamplesReport[pkgName] ?? [];
    final missingMappings = missingMappingReport[pkgName] ?? [];

    if (missingComments.isNotEmpty ||
        missingExamples.isNotEmpty ||
        missingMappings.isNotEmpty) {
      print('⚠️ [$pkgName] Details:');
      if (missingComments.isNotEmpty) {
        print('  ❌ Missing Doc Comments (///):');
        for (final item in missingComments) {
          print('     * $item');
        }
      }
      if (missingExamples.isNotEmpty) {
        print('  💡 Missing Code Examples inside comments:');
        for (final item in missingExamples) {
          print('     * $item');
        }
      }
      if (missingMappings.isNotEmpty) {
        print('  🗺️ Missing website category mappings (getCategoryAndPage):');
        for (final item in missingMappings) {
          print('     * $item');
        }
      }
      print('');
    }
  }

  // Enforce coverage standard threshold (e.g. at least 90% doc comment coverage)
  const targetThreshold = 90.0;
  if (overallCommentPercent < targetThreshold) {
    print(
        '❌ FAILED: Overall Doc Comment Coverage is ${overallCommentPercent.toStringAsFixed(1)}% which is below the target $targetThreshold% threshold!');
    hasFailures = true;
  }

  if (hasFailures) {
    exit(1);
  } else {
    print('✅ SUCCESS: Documentation coverage verification passed!');
    exit(0);
  }
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
            if (uri.startsWith('package:')) continue;
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
      // Quietly ignore
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
  return commentNode.tokens.map((token) {
    final lexeme = token.lexeme.trim();
    if (lexeme.startsWith('///')) {
      var rest = lexeme.substring(3);
      if (rest.startsWith(' ')) rest = rest.substring(1);
      return rest;
    }
    return lexeme;
  }).join('\n');
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
      if (declaration is AnnotatedNode) {
        bool isInternal = false;
        for (final annotation in declaration.metadata) {
          if (annotation.name.name == 'internal') {
            isInternal = true;
          }
        }
        if (declaration.documentationComment != null) {
          final commentText = declaration.documentationComment!.tokens
              .map((t) => t.lexeme)
              .join('\n');
          if (commentText.contains('@internal')) {
            isInternal = true;
          }
        }
        if (isInternal) continue;
      }
      if (declaration is ClassDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        decls.add(DeclInfo(
          name: name,
          type: 'class',
          comment: cleanComment(declaration.documentationComment),
          members: [],
          originPkg: pkgName,
        ));
      } else if (declaration is MixinDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        decls.add(DeclInfo(
          name: name,
          type: 'mixin',
          comment: cleanComment(declaration.documentationComment),
          members: [],
          originPkg: pkgName,
        ));
      } else if (declaration is FunctionDeclaration) {
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        decls.add(DeclInfo(
          name: name,
          type: 'function',
          comment: cleanComment(declaration.documentationComment),
          members: [],
          originPkg: pkgName,
        ));
      } else if (declaration is TopLevelVariableDeclaration) {
        for (final variable in declaration.variables.variables) {
          final name = variable.name.lexeme;
          if (name.startsWith('_')) continue;
          decls.add(DeclInfo(
            name: name,
            type: 'variable',
            comment: cleanComment(declaration.documentationComment),
            members: [],
            originPkg: pkgName,
          ));
        }
      } else if (declaration is ExtensionDeclaration) {
        final name = declaration.name?.lexeme ?? 'UnnamedExtension';
        if (name.startsWith('_')) continue;
        decls.add(DeclInfo(
          name: name,
          type: 'extension',
          comment: cleanComment(declaration.documentationComment),
          members: [],
          originPkg: pkgName,
        ));
      }
    }
  } catch (e) {
    // Ignore
  }
  return decls;
}

String? getCategoryAndPage(String pkgName, DeclInfo decl) {
  final comment = decl.comment;
  final linkRegExp =
      RegExp(r'@link\s+https://dartsignals\.dev/([a-zA-Z0-9_\-/]+)');
  final match = linkRegExp.firstMatch(comment);
  if (match != null) {
    return match.group(1)!;
  }

  final name = decl.name;
  final nameLower = name.toLowerCase();

  if (pkgName == 'signals_hooks') {
    final slug =
        name.split(RegExp(r'(?<=[a-z0-9])(?=[A-Z])')).join('-').toLowerCase();
    if (nameLower.contains('widget') || nameLower.contains('builder')) {
      return 'widgets/$slug';
    }
    return 'hooks/$slug';
  }

  if (pkgName == 'signals_devtools_extension') {
    return 'flutter/devtools';
  }

  if (pkgName == 'signals_lint') {
    final allowedPrefixes = [
      'SignalsAvoid',
      'SignalsPrefer',
      'WrapWith',
      'Convert',
      'Migrate'
    ];
    if (!allowedPrefixes.any((prefix) => name.startsWith(prefix))) return null;
    final slug =
        name.split(RegExp(r'(?<=[a-z0-9])(?=[A-Z])')).join('-').toLowerCase();
    return 'flutter/$slug';
  }

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

  if (pkgName == 'signals_core' ||
      pkgName == 'preact_signals' ||
      pkgName == 'signals') {
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
    if (name == 'FutureSignal' ||
        name == 'futureSignal' ||
        name == 'computedAsync' ||
        name.startsWith('computedFrom') ||
        name.startsWith('ComputedFromExt')) {
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
    if (name == 'ChangeStackSignal') return 'value/change-stack';
    if (name == 'IterableSignal') return 'value/iterable';
    if (name == 'ListSignal' || name == 'listSignal') return 'value/list';
    if (name == 'SetSignal' || name == 'setSignal') return 'value/set';
    if (name == 'MapSignal' || name == 'mapSignal') return 'value/map';
    if (name == 'SignalContainer' || name == 'signalContainer')
      return 'utilities/container';
    if (name == 'SignalsObserver' || name == 'signalsObserver')
      return 'utilities/observer';
    if (name.startsWith('Persisted') ||
        name.startsWith('SignalsKeyValue') ||
        name.startsWith('SignalsInMemoryKeyValue'))
      return 'utilities/persisted';

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
