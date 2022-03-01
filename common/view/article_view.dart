import '../article_edit_log_service.dart';
import '../model/article.dart';
import 'article_detail_view.dart';
import 'custom_markdown_to_html.dart';

class ArticleView {
  static Future<String> html(Article article) async {
    var logs = await ArticleEditLogService.getLogs(article);
    var articleHtml = convertArticleToHtml(article.title, article.body).html;
    var articleDetailHtml = ArticleDetailView.toHtml(logs, ArticleEditLogService.getCommitterList(logs));

    return '''
<div class="article-context-wrap">
$articleHtml
<div class="share">
    <a href="" class="uk-icon-button uk-margin-small-right" uk-icon="twitter"></a>
    <a href="" class="uk-icon-button uk-margin-small-right" uk-icon="facebook"></a>
    <a href="" class="uk-icon-button uk-margin-small-right" uk-icon="reddit"></a>
    <button class="uk-button uk-button-secondary github-button"><span uk-icon="github"></span>Go Github</button>
</div>
$articleDetailHtml
</div>
''';
  }
}
