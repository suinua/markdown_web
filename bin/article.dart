import 'dart:io';

import 'package:markdown/markdown.dart';
import 'package:uuid/uuid.dart';

import 'folder_analyzer.dart';

class Article {
  final String uuid;
  final List<Tag> tags;
  final String title;
  final String body;
  final String url;

  Article(
      {required this.uuid,
      required this.tags,
      required this.title,
      required this.body,
      required this.url});

  Article.fromLocalFile(LocalFile localFile)
      : uuid = Uuid().v4(),
        tags = localFile.tags.map((e) => Tag(e)).toList(),
        title = localFile.name.replaceAll('.md', ''),
        body = localFile.context,
        url = localFile.path
            .replaceAll(
                RegExp(r'(.*)' +
                    (Platform.environment['INPUT_ARTICLES_DIRECTORY_PATH'] ??
                        'articles') +
                    r'\' +
                    Platform.pathSeparator),
                '')
            .replaceAll('md', 'html');

  String toHtmlAsMenu(bool isLast) {
    var tagsAsHtml = tags.map((e) => e.toHtmlOnMenu()).toList().join();
    return '''
<div class="article-and-tags-container" id="article-and-tags-container-$uuid">
  <div class="article" uuid="$uuid" url="$url">
      <div class="article-title">${isLast ? '└─' : '├─' }<div class="article-title-text" id="article-title-text-$uuid">$title</div></div>
  </div>
  <div class="tag-button" article-id="$uuid"><span uk-icon="tag"></span></div>
  <div class="tags" id="tags-$uuid">$tagsAsHtml</div>
</div>
''';
  }

  String toHtml() {
    return '''
<link rel="stylesheet" href="css/article.css">

<script src="highlight/highlight.min.js"></script>
<link rel="stylesheet" href="highlight/styles/idea.min.css">
<script>hljs.highlightAll();</script>

${markdownToHtml(body)}
  ''';
  }

  void saveAsHtml(String path) {
    var context = toHtml();
    var file = File('$path/$title.html');
    file.writeAsString(context);
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'tags': tags.map((e) => e.text).toList(),
      'title': title,
      'body': body,
      'url': url
    };
  }
}

class Tag {
  final String text;

  Tag(this.text);

  String toHtmlOnMenu() {
    return '''<a class="tag" tag-text="$text">#$text</a>''';
  }
}
