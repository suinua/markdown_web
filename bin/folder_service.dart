import 'dart:io';

import '../common/model/folder.dart';
import 'article_service.dart';

class FolderService {
  static void saveAsHtml(String parentPath, Folder folder) {
    var path = parentPath + Platform.pathSeparator + folder.name;
    Directory(path).create().then((_) {
      if (folder.articles.length + folder.folders.length == 0) {
        File(path + Platform.pathSeparator + '.gitkeep').create();
      }
      folder.articles.forEach((article) {
        ArticleService.saveFile(path, article);
      });

      folder.folders.forEach((folder) {
        saveAsHtml(path, folder);
      });
    });
  }
}