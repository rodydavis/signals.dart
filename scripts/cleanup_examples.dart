import 'dart:io';

void main() async {
  final platforms = [
    'ios',
    'android',
    'web',
    'macos',
    'windows',
    'linux',
  ];

  final projectPaths = <String>[];

  // Root examples
  final examplesDir = Directory('examples');
  if (await examplesDir.exists()) {
    await for (final entity in examplesDir.list()) {
      if (entity is Directory) {
        projectPaths.add(entity.path);
      }
    }
  }

  // Package examples
  final packagesDir = Directory('packages');
  if (await packagesDir.exists()) {
    await for (final package in packagesDir.list()) {
      if (package is Directory) {
        final exampleDir = Directory('${package.path}/example');
        if (await exampleDir.exists()) {
          projectPaths.add(exampleDir.path);
        }
      }
    }
  }

  if (projectPaths.isEmpty) {
    print('No example projects found.');
    return;
  }

  print('Cleaning up platform folders in ${projectPaths.length} projects...');

  int deletedCount = 0;
  for (final projectPath in projectPaths) {
    for (final platform in platforms) {
      final platformDir = Directory('$projectPath/$platform');
      if (await platformDir.exists()) {
        try {
          await platformDir.delete(recursive: true);
          print('Deleted: ${platformDir.path}');
          deletedCount++;
        } catch (e) {
          print('Error deleting ${platformDir.path}: $e');
        }
      }
    }
  }

  print('\nCleanup complete! Deleted $deletedCount platform folders.');
}
