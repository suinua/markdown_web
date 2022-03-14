import 'dart:io';

import 'package:uuid/uuid.dart';

import '../common/model/article.dart';
import '../common/model/tag.dart';
import '../common/view/custom_markdown_to_html.dart';

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

  Future<Article> toArticle() async {
    var title = name.replaceAll('.md', '');

    var repository = Platform.environment['GITHUB_REPOSITORY'] ?? 'suinua/markdown_web';
    var userName = repository.split('/')[0];
    var repositoryName = repository.split('/')[1];
    var basedUrl = '';
    if (repositoryName == '$userName.github.io') {
      basedUrl = 'https://$userName.github.io/';
    } else {
      basedUrl = 'https://$userName.github.io/$repositoryName/';
    }
    var articlePath =  path.replaceAll(RegExp(r'(.*)' +(Platform.environment['INPUT_ARTICLES_DIRECTORY_PATH'] ?? 'articles') + r'\' + Platform.pathSeparator), '').replaceAll('md', 'html');

    var markdownResult = await convertArticleToHtml(title,context);
    var indexList = markdownResult.indexList;
    return Article(
        uuid: Uuid().v4(),
        tags: tags.map((e) => Tag(e)).toList(),
        title: title,
        body: context,
        path: articlePath,
        url: basedUrl + articlePath.replaceAll(r'\', '/'),
        indexList: indexList);
  }
}
