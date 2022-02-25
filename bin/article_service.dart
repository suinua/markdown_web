import 'dart:io';

import '../common/model/article.dart';
import '../common/view/article_view.dart';

class ArticleService {
  static void saveFile(String path,Article article){
    var file = File('$path/${article.title}.html');
    ArticleView.html(article).then((value) {
      file.writeAsString(value);
    });
  }
}