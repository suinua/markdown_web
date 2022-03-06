import 'dart:io';

import '../common/model/article.dart';
import '../common/model/folder.dart';
import '../common/view/article_page.dart';

class ArticleService {
  static void saveFile(String path, Folder topFolder, Article article){
    var file = File('$path/${article.title}.html');
    ArticlePage.html(topFolder, article).then((value) {
      file.writeAsString(value);
    });
  }
}