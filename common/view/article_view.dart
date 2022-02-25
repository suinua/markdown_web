import 'package:markdown/markdown.dart';

import '../article_edit_log_service.dart';
import '../model/article.dart';
import 'article_menu_view.dart';

class ArticleView {
  static Future<String> html(Article article) async {
    var logs = await ArticleEditLogService.getLogs(article);
    var articleMenuHtml = ArticleMenuView.html(article, logs, ArticleEditLogService.getCommitterList(logs));

    return '''
$articleMenuHtml
<div class="article-context">${markdownToHtml(article.body)}</div>
''';
  }
}
