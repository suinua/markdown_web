import 'dart:convert';

import 'package:html/parser.dart';
import 'package:markdown/markdown.dart';
import 'package:http/http.dart' as http;

import '../model/article_index.dart';

class ArticleConvertResult {
  final String html;
  final  List<ArticleIndex> indexList;

  ArticleConvertResult(this.html, this.indexList);
}

Future<ArticleConvertResult> convertArticleToHtml(String articleTitle, String markdown) async {
  var basedArticleHtml = markdownToHtml(markdown, blockSyntaxes: [const TableSyntax()]);
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


  //url embed
  var embedMatchList = RegExp(r'embed:(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+').allMatches(newArticleHtml).toList();
  for (var i = 0; i < embedMatchList.length; i++) {
    var match = embedMatchList[i];
    var matchedText = match.group(0)!;
    var url = matchedText.replaceFirst('embed:', '');

    var html ='';
    if (RegExp('https://twitter.com/(.*)/status/').hasMatch(url)) {
      var response = await http.get(Uri.parse('https://publish.twitter.com/oembed?url='+url));
      var json = jsonDecode(response.body);
      html = json['html'];
    } else {
      html = await generateEmbed(url);
    }
    newArticleHtml = newArticleHtml.replaceFirst(matchedText, html);
  }

  return ArticleConvertResult(newArticleHtml, indexList);
}

Future<String> generateEmbed(String url) async {
  try {
    var hostUrl = url.replaceFirst(RegExp('(.*)://'), '').replaceFirst(RegExp('/(.*)'), '');
    var faviconPath ='https://$hostUrl/favicon.ico';

    var response = await http.get(Uri.parse(url));
    var title = parse(response.body).getElementsByTagName('title')[0].text;

    return  '''
<a href="$url" class="url-embed">
  <div class="url-embed-context">
    <div class="url-embed-site-title">$title</div>
      <div class="url-embed-site-host"><img class="url-embed-fav-icon" src="$faviconPath">$hostUrl</div>
  </div>
  <div class="url-embed-thumnail">
    <img src="https://s.wordpress.com/mshots/v1/$url?w=250">
  </div>
</a>
  ''';
  } catch(e) {
    print(e);
    return url;
  }
}
