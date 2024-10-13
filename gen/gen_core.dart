import 'dart:io';
// dart run gen/gen_core.dart
void main() {
  final basePath = 'lib/core';

  final directories = [
    'constants',
    'errors',
    'network',
    'di',
    'utils',
    'themes',
  ];

  // Create directories
  for (var dir in directories) {
    createDirectory('$basePath/$dir');
  }

  // Create files in core/constants
  createFile('$basePath/constants/app_colors.dart');
  createFile('$basePath/constants/app_fonts.dart');
  createFile('$basePath/constants/app_strings.dart');
  createFile('$basePath/constants/app_images.dart');

  // Create files in core/errors
  createFile('$basePath/errors/app_exception.dart');
  createFile('$basePath/errors/failure.dart');
  createFile('$basePath/errors/error_messages.dart');

  // Create files in core/network
  createFile('$basePath/network/api_client.dart');
  createFile('$basePath/network/network_info.dart');
  createFile('$basePath/network/api_interceptors.dart');

  // Create file in core/di
  createFile('$basePath/di/injector.dart');

  // Create files in core/utils
  createFile('$basePath/utils/date_time_utils.dart');
  createFile('$basePath/utils/string_extensions.dart');
  createFile('$basePath/utils/validators.dart');

  // Create files in core/themes
  createFile('$basePath/themes/app_theme.dart');
  createFile('$basePath/themes/text_styles.dart');

  print('Flutter Clean Architecture Core structure created successfully.');
}

void createDirectory(String path) {
  final dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    print('Directory created: $path');
  } else {
    print('Directory already exists: $path');
  }
}

void createFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync('// TODO: Implement $path');
    print('File created: $path');
  } else {
    print('File already exists: $path');
  }
}
