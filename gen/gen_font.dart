import 'dart:io';
// dart run gen/gen_font.dart
void main(List<String> args) {
  // Check if a folder name argument is provided
  if (args.isEmpty) {
    print('Usage: dart run gen_font.dart <folder_name>');
    return;
  }

  String folderName = args[0];

  // Construct the full path to the folder
  final String basePath = 'assets/fonts/$folderName';

  // Check if the directory exists
  if (!Directory(basePath).existsSync()) {
    print('Directory does not exist: $basePath');
    return;
  }

  try {
    final directory = Directory(basePath);
    final List<FileSystemEntity> files = directory.listSync();

    // Filter for .ttf files and sort them
    final List<String> fontFiles = files
        .where((file) => file.path.toLowerCase().endsWith('.ttf'))
        .map((file) => file.uri.pathSegments.last) // Get only the file name
        .toList()
      ..sort();

    if (fontFiles.isEmpty) {
      print('No .ttf files found in the directory.');
      return;
    }

    // Map for font weight keywords to numbers
    final Map<String, int> weightMap = {
      'Light': 300,
      'Bold': 700,
      'Thin': 100,
      'ExtraLight': 200,

      'Regular': 400,
      'Medium': 500,

      'ExtraBold': 800,
      // Adjusted to 600

      'SemiBold': 600,
      'Black': 900,
    };

    // Generate the YAML-like string
    final StringBuffer yamlString = StringBuffer();
    yamlString.writeln('fonts:');
    yamlString.writeln('  - family: $folderName');
    yamlString.writeln('    fonts:');

    for (final String file in fontFiles) {
      // Determine weight based on filename
      int? weight;
      weightMap.forEach((key, value) {
        if (file.toLowerCase().contains(key.toLowerCase())) {
          weight = value;
        }
      });

      yamlString.writeln('      - asset: $basePath/$file');

      // If a weight was determined, add it to the output
      if (weight != null) {
        yamlString.writeln('        weight: $weight');
      }
    }

    // Print the generated YAML
    print('Generated YAML:');
    print(yamlString.toString());
  } catch (e) {
    print('Error reading directory: $e');
  }
}
