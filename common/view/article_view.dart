import 'package:markdown/markdown.dart';

import '../article_edit_log_service.dart';
import '../model/article.dart';
import '../model/article_index.dart';
import 'article_menu_view.dart';

class ArticleView {
  static Future<String> html(Article article) async {
    var logs = await ArticleEditLogService.getLogs(article);
    var articleMenuHtml = ArticleMenuView.html(
        article, logs, ArticleEditLogService.getCommitterList(logs));

    var articleHtml = markdownToHtml(article.body);
    void convert(IndexLevel level) {
    var index = 0;
    articleHtml.replaceAll('\r\n', '\n').split('\n').forEach((line) {
      var result = RegExp('<${level.toString()}>(.*)</${level.toString()}>').firstMatch(line);
      if (result != null) {
        var targetPlane = line.substring(result.start, result.end);
        var text = targetPlane.replaceFirst('<${level.toString()}>', '').replaceFirst(
            '</${level.toString()}>', '');
        var id = '$text-$index';
        var replace = targetPlane.replaceFirst('<${level.toString()}>', '<section id="$id"><${level.toString()}>')
            .replaceFirst('</${level.toString()}>', '</${level.toString()}><section>');
        articleHtml = articleHtml.replaceFirst(targetPlane, replace
        );
      }
      index++;
    });
    };


    convert(IndexLevel.h1);
    convert(IndexLevel.h2);

    return '''
$articleMenuHtml
<div class="article-context">$articleHtml</div>
''';
  }
}
