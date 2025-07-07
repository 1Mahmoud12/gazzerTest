import 'dart:io';

final textRegex = RegExp(r'Text\(\"([a-zA-Z_][a-zA-Z0-9_\s]*)\"');
final textSpanRegex = RegExp(r'text: \"([a-zA-Z_][a-zA-Z0-9_\s]*)\"');

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

  if (!sourceDir.existsSync()) {
    print('Error: lib/ directory not found.');
    return;
  }

  int replaced = 0;

  await for (var entity in sourceDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = await entity.readAsString();
      bool hasChanges = false;

      // Replace Text("...") patterns
      content = content.replaceAllMapped(textRegex, (match) {
        final originalText = match.group(1)!;
        final camelCaseKey = toCamelCase(originalText);
        hasChanges = true;
        replaced++;
        return 'Text(L10n.tr().$camelCaseKey"';
      });

      // Replace text: "..." patterns
      content = content.replaceAllMapped(textSpanRegex, (match) {
        final originalText = match.group(1)!;
        final camelCaseKey = toCamelCase(originalText);
        hasChanges = true;
        replaced++;
        return 'text: L10n.tr().$camelCaseKey';
      });

      // Write the modified content back to the file if there were changes
      if (hasChanges) {
        await entity.writeAsString(content);
        print('Updated: ${entity.path}');
      }
    }
  }

  print('✅ Replaced $replaced text strings with L10n.tr() calls.');
}
