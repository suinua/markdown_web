import 'dart:io';

import '../common/model/folder.dart';
import 'article_service.dart';

class FolderService {
  static void saveTopFolder(Folder topFolder, String outputPath) {
    topFolder.articles.forEach((article) {
      ArticleService.saveFile(outputPath, topFolder, article);
    });

    topFolder.folders.forEach((folder) {
      _saveFolder(outputPath, folder, topFolder);
    });
  }

  static void _saveFolder(String parentPath, Folder folder, Folder topParentFolder) {
    var path = parentPath + Platform.pathSeparator + folder.name;

    Directory(path).create().then((_) {
      if (folder.articles.length + folder.folders.length == 0) {
        File(path + Platform.pathSeparator + '.gitkeep').create();
      }

      folder.articles.forEach((article) {
        ArticleService.saveFile(path, topParentFolder, article);
      });

      folder.folders.forEach((folder) {
        _saveFolder(path, folder, topParentFolder);
      });
    });
  }
}
