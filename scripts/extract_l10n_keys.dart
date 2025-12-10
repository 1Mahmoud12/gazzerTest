import 'dart:convert';
import 'dart:developer';
import 'dart:io';

final textRegex = RegExp(r'Text\("([a-zA-Z_][a-zA-Z0-9_\s]*)"');
final textSpanRegex = RegExp(r'text: "([a-zA-Z_][a-zA-Z0-9_\s]*)"');

String toCamelCase(String text) {
  // Remove spaces and convert to camelCase
  final words = text.split(' ');
  if (words.isEmpty) return text;

  String result = words[0].toLowerCase();
  for (int i = 1; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      result += words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }
  return result;
}

void main() async {
  final sourceDir = Directory('lib');
  const arbPath = 'lib/core/presentation/localization/app_new.arb';
  final Set<String> keys = {};

  if (!sourceDir.existsSync()) {
    log('Error: lib/ directory not found.');
    return;
  }

  await for (final entity in sourceDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = await entity.readAsString();
      final matches = textRegex.allMatches(content).toList();
      matches.addAll(textSpanRegex.allMatches(content));
      if (matches.isEmpty) continue;
      keys.add("${entity.uri.pathSegments.last.replaceAll('.dart', '')}__________________FILEE");
      for (final match in matches) {
        keys.add(toCamelCase(match.group(1)!));
      }
    }
  }

  final Map<String, dynamic> arbContent = {'@@locale': 'en'};

  for (final key in keys) {
    arbContent[key] = key.splitMapJoin(RegExp('([A-Z])'), onMatch: (m) => '_${m.group(0)}', onNonMatch: (n) => n);
    // arbContent["@${key}"] = {"description": "", "type": "text"};
  }

  final arbFile = File(arbPath);
  arbFile.createSync(recursive: true);
  arbFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arbContent));

  log('✅ Generated $arbPath with ${keys.length} keys.');
}
