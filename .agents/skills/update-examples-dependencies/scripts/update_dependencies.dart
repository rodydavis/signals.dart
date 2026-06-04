import 'dart:io';

void main() async {
  print('=== Examples Dependency Updater ===');

  // 1. Scan packages/ to build a map of local packages and their current versions
  final packagesDir = Directory('./packages');
  if (!packagesDir.existsSync()) {
    print('Error: Could not find packages/ directory in root.');
    exit(1);
  }

  final localVersions = <String, String>{};
  for (final entity in packagesDir.listSync()) {
    if (entity is Directory) {
      final pubspecFile = File('${entity.path}/pubspec.yaml');
      if (pubspecFile.existsSync()) {
        final lines = pubspecFile.readAsLinesSync();
        String? name;
        String? version;
        for (final line in lines) {
          final trimmed = line.trim();
          if (trimmed.startsWith('name:')) {
            name = trimmed.substring(5).trim();
          } else if (trimmed.startsWith('version:')) {
            version = trimmed.substring(8).trim();
          }
        }
        if (name != null && version != null) {
          localVersions[name] = version;
        }
      }
    }
  }

  print('Detected local packages and versions:');
  localVersions.forEach((pkg, ver) {
    print('  - $pkg: $ver');
  });

  // 2. Scan examples/ for pubspec.yaml files
  final examplesDir = Directory('./examples');
  if (!examplesDir.existsSync()) {
    print('Error: Could not find examples/ directory.');
    exit(1);
  }

  final examplePubspecs = <File>[];
  for (final entity in examplesDir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('pubspec.yaml')) {
      examplePubspecs.add(entity);
    }
  }

  print('\nFound ${examplePubspecs.length} example pubspec(s) to process.');

  // 3. For each example pubspec, check and update local dependencies
  for (final pubspecFile in examplePubspecs) {
    final relativePath = pubspecFile.path.replaceFirst('./', '');
    print('Checking $relativePath...');

    final lines = pubspecFile.readAsLinesSync();
    var modified = false;
    final newLines = <String>[];

    for (final line in lines) {
      var newLine = line;
      // Match key: value or key: "value" or key: 'value'
      final match = RegExp(r'^(\s+)(signals|signals_core|signals_flutter|signals_hooks|signals_lint|preact_signals|signals_devtools_extension):\s*(.*)$').firstMatch(line);
      
      if (match != null) {
        final indent = match.group(1)!;
        final depName = match.group(2)!;
        final currentConstraint = match.group(3)!.trim();

        if (localVersions.containsKey(depName)) {
          final latestVersion = localVersions[depName]!;
          final targetConstraint = '^$latestVersion';

          // Clean current constraint if it has quotes or comments
          var cleanConstraint = currentConstraint;
          if ((cleanConstraint.startsWith("'") && cleanConstraint.endsWith("'")) ||
              (cleanConstraint.startsWith('"') && cleanConstraint.endsWith('"'))) {
            cleanConstraint = cleanConstraint.substring(1, cleanConstraint.length - 1);
          }
          // Remove any inline comments for comparison
          if (cleanConstraint.contains('#')) {
            cleanConstraint = cleanConstraint.split('#').first.trim();
          }

          if (cleanConstraint != targetConstraint) {
            newLine = '$indent$depName: $targetConstraint';
            print('  -> Updating $depName from "$currentConstraint" to "$targetConstraint"');
            modified = true;
          }
        }
      }
      newLines.add(newLine);
    }

    if (modified) {
      pubspecFile.writeAsStringSync(newLines.join('\n') + '\n');
      print('  -> Saved updates to $relativePath');
    } else {
      print('  -> Already up to date.');
    }

    // 4. Run dart pub upgrade or flutter pub upgrade in this directory
    final projectDir = pubspecFile.parent;
    final hasFlutter = lines.any((l) => l.trim() == 'sdk: flutter' || l.trim().startsWith('flutter:'));
    final cmd = hasFlutter ? 'flutter' : 'dart';
    final args = ['pub', 'upgrade'];

    print('  -> Running "$cmd pub upgrade" in ${projectDir.path}...');
    final result = await Process.run(cmd, args, workingDirectory: projectDir.path);
    if (result.exitCode != 0) {
      print('  [WARNING] "$cmd pub upgrade" failed with exit code ${result.exitCode}');
      print('  Stdout: ${result.stdout}');
      print('  Stderr: ${result.stderr}');
    } else {
      print('  -> Dependency upgrade completed successfully.');
    }
  }

  print('\n=== Dependency Upgrade Complete ===');
}
