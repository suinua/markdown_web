import 'dart:io';

import 'package:markdown/markdown.dart';

import 'folder_analyzer.dart';

class Article {
  final List<Tag> tags;
  final String title;
  final String body;
  final String url;

  Article({required this.tags, required this.title, required this.body, required this.url});

  Article.fromLocalFile(LocalFile localFile)
      : tags = localFile.tags.map((e) => Tag(e)).toList(),
        title = localFile.name.replaceAll('.md', ''),
        body = localFile.context,
        url = localFile.path.replaceAll(RegExp(r'(.*)articles\' + Platform.pathSeparator), '').replaceAll('md', 'html');

  String toHtmlAsMenu() {
    return '''
<div class="article" id="$url">
    <div class="article-title">$title</div>
</div>
''';
  }

  void saveAsHtml(String path) {
    var context = '''
<link rel="stylesheet" href="css/article.css">

<script src="highlight/highlight.min.js"></script>
<link rel="stylesheet" href="highlight/styles/idea.min.css">
<script>hljs.highlightAll();</script>

${markdownToHtml(body)}
  ''';

    var file = File('$path/$title.html');
    file.writeAsString(context);
  }
}

class Tag {
  final String text;

  Tag(this.text);
}
