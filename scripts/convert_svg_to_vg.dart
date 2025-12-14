/// Script to convert all SVG files to .vg format using vector_graphics_compiler
///
/// Run this script with: dart run scripts/convert_svg_to_vg.dart
///
/// This will convert all .svg files in assets/svg/ to .vg format
/// The .vg files will be placed next to their corresponding .svg files

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as path;

Future<void> main() async {
  final svgDir = Directory('assets/svg');

  if (!await svgDir.exists()) {
    log('Error: assets/svg directory not found');
    exit(1);
  }

  final svgFiles = svgDir.listSync(recursive: true).whereType<File>().where((file) => file.path.endsWith('.svg')).toList();

  if (svgFiles.isEmpty) {
    log('No SVG files found in assets/svg');
    exit(0);
  }

  log('Found ${svgFiles.length} SVG files to convert\n');

  int successCount = 0;
  int failCount = 0;

  for (final svgFile in svgFiles) {
    try {
      final svgPath = svgFile.path;
      final vgPath = svgPath.replaceAll('.svg', '.vg');

      log('Converting: ${path.basename(svgPath)}...');

      // Run vector_graphics_compiler with correct flags
      final result = await Process.run('dart', ['run', 'vector_graphics_compiler', '-i', svgPath, '-o', vgPath], runInShell: true);

      if (result.exitCode == 0) {
        log('  ✓ Success: ${path.basename(vgPath)}\n');
        successCount++;
      } else {
        final errorOutput = result.stderr.toString().trim();
        final stdOutput = result.stdout.toString().trim();
        log('  ✗ Failed:');
        if (errorOutput.isNotEmpty) {
          log('    Error: $errorOutput');
        }
        if (stdOutput.isNotEmpty && stdOutput != errorOutput) {
          log('    Output: $stdOutput');
        }
        if (errorOutput.isEmpty && stdOutput.isEmpty) {
          log('    Exit code: ${result.exitCode}');
        }
        log('');
        failCount++;
      }
    } catch (e) {
      log('  ✗ Error: $e\n');
      failCount++;
    }
  }

  log('\n=== Conversion Complete ===');
  log('Success: $successCount');
  log('Failed: $failCount');

  if (successCount > 0) {
    log('\nNote: Remember to update your pubspec.yaml to include .vg files in assets');
    log('Add: - assets/svg/**/*.vg');
  }
}
