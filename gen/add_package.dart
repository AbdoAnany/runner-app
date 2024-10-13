import 'dart:io';

void main() {
  final pubspecPath = 'pubspec.yaml';
  final requirementsPath = 'gen/requirements.txt'; // Path to your requirements file

  final pubspecFile = File(pubspecPath);
  final requirementsFile = File(requirementsPath);

  if (!pubspecFile.existsSync()) {
    print('Error: pubspec.yaml not found.');
    return;
  }

  if (!requirementsFile.existsSync()) {
    print('Error: $requirementsPath not found.');
    return;
  }

  // Read the requirements file
  final requirementsContent = requirementsFile.readAsLinesSync();

  // Prepare lists for dependencies and dev_dependencies
  List<String> dependencies = [];
  List<String> devDependencies = [];

  bool isDevDependencies = false;

  // Parse the requirements file
  for (var line in requirementsContent) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) {
      // Skip empty lines or comments
      continue;
    }

    // If a line contains a special marker (e.g., `# dev_dependencies`), we start adding to dev_dependencies
    if (line.startsWith('# dev_dependencies')) {
      isDevDependencies = true;
      continue;
    }

    if (isDevDependencies) {
      devDependencies.add(line);
    } else {
      dependencies.add(line);
    }
  }

  // Read the current content of the pubspec.yaml file
  final pubspecContent = pubspecFile.readAsStringSync();

  // Prepare dependency blocks
  String dependenciesBlock = 'dependencies:\n';
  for (var dep in dependencies) {
    dependenciesBlock += '  ${dep.replaceAll(":", ": ")}\n';
  }

  String devDependenciesBlock = 'dev_dependencies:\n';
  for (var devDep in devDependencies) {
    devDependenciesBlock += '  ${devDep.replaceAll(":", ": ")}\n';
  }

  // Append dependencies and dev dependencies to the pubspec.yaml
  final updatedContent = pubspecContent + '\n' + dependenciesBlock + '\n' + devDependenciesBlock;

  // Write the updated content back to pubspec.yaml
  pubspecFile.writeAsStringSync(updatedContent);

  print('Packages added to pubspec.yaml from $requirementsPath. Run "flutter pub get" to install them.');
}
