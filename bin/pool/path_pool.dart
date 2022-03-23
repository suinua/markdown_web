import 'dart:io';
import 'package:path/path.dart' as path;

class PathPool {
  //EXPORT
  static String EXPORT_FOLDER_NAME = 'export';

  static String exportDir() {
    var env = Platform.environment;
    return path.join(
        env['GITHUB_ACTION_PATH'] ?? _basedPathForDebug(), EXPORT_FOLDER_NAME);
  }

  static String exportThumbnailDir() {
    return path.join(exportDir(), 'thumbnails');
  }

  //Article
  static String articlesDirName() {
    var dirPath = Platform.environment['ARTICLES_DIRECTORY_PATH'];
    return dirPath ?? 'articles';
  }

  static String articlesDir() {
    var env = Platform.environment;
    return path.join(
        env['GITHUB_WORKSPACE'] ?? _basedPathForDebug(), articlesDirName());
  }

  static String ASSETS_FOLDER_NAME = 'assets';

  static String assetsDir() {
    var env = Platform.environment;
    return path.join(
        env['GITHUB_ACTION_PATH'] ?? _basedPathForDebug(), ASSETS_FOLDER_NAME);
  }

  //Thumbnail Generator
  static String thumbnailGenerator() {
    var env = Platform.environment;
    return path.join(env['GITHUB_ACTION_PATH'] ?? _basedPathForDebug(),
        'thumbnail_generator/main.py');
  }

  static String _basedPathForDebug() {
    return Platform.script.path
        .replaceRange(0, 1, '')
        .replaceFirst(RegExp('bin(.*)'), '');
  }
}
