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

    var basedArticleHtml = markdownToHtml(article.body);
    var newArticleHtml = '';
    void convert(List<IndexLevel> levels) {
      var index = 0;
      basedArticleHtml.replaceAll('\r\n', '\n').split('\n').forEach((line) {
        var isMatch = false;
        levels.forEach((level) {
          var result = RegExp('<${level.toString()}>(.*)</${level.toString()}>')
              .firstMatch(line);
          isMatch = result != null ? true : isMatch; //trueだったら上書き

          if (result != null) {
            var targetPlane = line.substring(result.start, result.end);
            var text = targetPlane
                .replaceFirst('<${level.toString()}>', '')
                .replaceFirst('</${level.toString()}>', '');
            var id = ArticleIndex.generateId(index, text);
            var replace = targetPlane
                .replaceFirst('<${level.toString()}>',
                    '<${level.toString()} id="${Uri.parse(id)}">')
                .replaceFirst('</${level.toString()}>',
                    '</${level.toString()}>');
            newArticleHtml += replace;
          }
        });
        if (!isMatch) newArticleHtml += line;
        index++;
      });
    }

    convert([IndexLevel.h1, IndexLevel.h2]);

    return '''
$articleMenuHtml
<div class="article-context">$newArticleHtml</div>
''';
  }
}
