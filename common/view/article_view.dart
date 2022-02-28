import '../article_edit_log_service.dart';
import '../model/article.dart';
import 'article_menu_view.dart';
import 'custom_markdown_to_html.dart';

class ArticleView {
  static Future<String> html(Article article) async {
    var logs = await ArticleEditLogService.getLogs(article);
    var articleMenuHtml = ArticleMenuView.html(article, logs, ArticleEditLogService.getCommitterList(logs));
    var articleHtml = convertArticleToHtml(article.body).html;

    return '''
$articleMenuHtml
<div class="article-context">$articleHtml</div>
''';
  }
}
