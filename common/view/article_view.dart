import 'package:markdown/markdown.dart';

import '../model/article.dart';

class ArticleView {
  static String html(Article article) {
    return '''<div class="article-context">${markdownToHtml(article.body)}</div>''';
  }
}
