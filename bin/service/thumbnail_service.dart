import 'dart:io';

import 'package:path/path.dart' as path;
import '../custom_logger.dart';
import '../pool/path_pool.dart';

class ThumbNailService {
  static Future<void> generateImage(String title) async {
    await Directory(PathPool.exportThumbnailDir()).create();

    var destination = path.join(PathPool.exportThumbnailDir(),title);
    var result = await Process.run('python', ['thumbnail_generator/main.py', title, destination]);
    if (result.stderr.toString().isEmpty) {
      CustomLogger.simple.i('python $title $destination > stdout: ${result.stdout}');
    } else {
      CustomLogger.simple.w('python $title $destination > stderr: ${result.stderr}');
    }

  }
}
