import 'package:markdown/markdown.dart';

import '../model/article_index.dart';

class ArticleConvertResult {
  final String html;
  final  List<ArticleIndex> indexList;

  ArticleConvertResult(this.html, this.indexList);
}

ArticleConvertResult convertArticleToHtml(String articleTitle,String markdown) {
  var basedArticleHtml =
      markdownToHtml(markdown, blockSyntaxes: [const TableSyntax()]);
  var newArticleHtml = '<h1 class="title">$articleTitle</h1><div class="article-context">';

  var indexList = <ArticleIndex>[];
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
              .replaceFirst('<${level.toString()}>','<${level.toString()}>')
              .replaceFirst('</${level.toString()}>', '</${level.toString()}>');
          newArticleHtml += '<div id="${Uri.parse(id)}"></div>' + replace;
          indexList.add(ArticleIndex(index, level, text));
        }
      });
      if (!isMatch) newArticleHtml += '\n' + line;
      index++;
    });
  }

  convert([IndexLevel.h1, IndexLevel.h2]);
  newArticleHtml = newArticleHtml.replaceAll('<table>', '<table class="uk-table">');
  newArticleHtml += '</div>';
  return ArticleConvertResult(newArticleHtml, indexList);
}
