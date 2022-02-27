import 'dart:io';

import 'package:markdown/markdown.dart';
import 'package:uuid/uuid.dart';

import '../common/model/article.dart';
import '../common/model/article_index.dart';
import '../common/model/tag.dart';

class LocalFile {
  final String name;
  final String path;
  final List<String> tags;
  final String context;

  LocalFile(this.path)
      : name = path.replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), ''),
        tags = _getTags(path),
        context = _getContext(path);

  static List<String> _getTags(String path) {
    var file = File(path);
    var context = file.readAsStringSync();
    var firstLine = context.replaceAll('\r\n', '\n').split('\n')[0];
    return firstLine.split(' ');
  }

  static String _getContext(String path) {
    var file = File(path);
    var context = file.readAsStringSync();
    return context.split('\n').sublist(1).join('\n');
  }

  Map asJson() {
    return {'name': name, 'tags': tags};
  }

  Article toArticle() {
    var indexList = <ArticleIndex>[];

    void add(List<IndexLevel> levels) {
      var index = 0;
      markdownToHtml(context)
          .replaceAll('\r\n', '\n')
          .split('\n')
          .forEach((line) {
        levels.forEach((level) {
          var result = RegExp('<${level.toString()}>(.*)</${level.toString()}>')
              .firstMatch(line);
          if (result != null) {
            var targetPlane = line.substring(result.start, result.end);
            var text = targetPlane
                .replaceFirst('<${level.toString()}>', '')
                .replaceFirst('</${level.toString()}>', '');
            indexList.add(ArticleIndex(index, level, text));
          }
        });
        index++;
      });
    }

    add([IndexLevel.h1, IndexLevel.h2]);

    return Article(
        uuid: Uuid().v4(),
        tags: tags.map((e) => Tag(e)).toList(),
        title: name.replaceAll('.md', ''),
        body: context,
        url: path
            .replaceAll(
                RegExp(r'(.*)' +
                    (Platform.environment['INPUT_ARTICLES_DIRECTORY_PATH'] ??
                        'articles') +
                    r'\' +
                    Platform.pathSeparator),
                '')
            .replaceAll('md', 'html'),
        indexList: indexList);
  }
}
