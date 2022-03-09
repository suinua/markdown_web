import '../article_edit_log_service.dart';
import '../model/article.dart';
import 'article_detail_view.dart';
import 'custom_markdown_to_html.dart';

class ArticleView {
  static Future<String> html(Article article) async {
    var logs = await ArticleEditLogService.getLogs(article);
    var convertResult = await convertArticleToHtml(article.title, article.body);
    var articleHtml = convertResult.html;
    var articleDetailHtml = ArticleDetailView.toHtml(logs, ArticleEditLogService.getCommitterList(logs));

    return '''
<div class="article-context-wrap">
$articleHtml
<div class="share">
    <span url="https://twitter.com/intent/tweet?ref_src=twsrc%5Etfw&url=${article.title} ${article.url}" class="uk-icon-button uk-margin-small-right twitter-button" uk-icon="twitter"></span>
    <span text="${article.title}\n${article.url}" class="uk-icon-button uk-margin-small-right copy-link-button" uk-icon="link"></span><div class="copied-message">Copied!</div>
    <button class="uk-button uk-button-secondary github-button"><span uk-icon="github"></span>Go Github</button>
</div>
$articleDetailHtml
</div>
''';
  }
}
