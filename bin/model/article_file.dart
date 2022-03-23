import 'dart:io';

import 'package:uuid/uuid.dart';

import '../pool/action_data.dart';
import '../pool/path_pool.dart';
import '../service/markdown_service.dart';
import 'article_index.dart';
import 'article_tag.dart';

class ArticleFile {
  final String uuid;
  final String githubFileUrl;
  final String articleTitle;
  final String fileName;
  final String absolutePath;
  final List<ArticleTag> tags;
  final String markdownBody;

  String _htmlBody = '';
  List<ArticleIndex> _indexList = [];

  String get htmlBody => _htmlBody;

  List<ArticleIndex> get indexList => _indexList;

  ArticleFile(
      {required this.uuid,
      required this.githubFileUrl,
      required this.fileName,
      required this.absolutePath,
      required this.tags,
      required this.markdownBody})
      : articleTitle = fileName.replaceFirst('.md', '');

  ArticleFile.fromFile(File file)
      :
        uuid = Uuid().v4(),
        fileName = file.absolute.path
            .replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), ''),
        absolutePath = file.absolute.path,
        githubFileUrl = _getGithubFileUrl(file.absolute.path),
      tags = _getTags(file.absolute.path),
        markdownBody = _getBody(file.absolute.path),
        articleTitle = file.absolute.path
            .replaceFirst(RegExp(r'(.*)\' + Platform.pathSeparator), '')
            .replaceFirst('.md', '');

  static String _getGithubFileUrl(String absolutePath) {
    var folderName = PathPool.articlesDirName();
    var repo = ActionData.repository();
    var branch = ActionData.branchName();

    var last = folderName + absolutePath.replaceFirst(RegExp('(.*)$folderName'), '').replaceAll('\\','/');
    return 'https://github.com/$repo/blob/$branch/$last';
  }

  static List<ArticleTag> _getTags(String filePath) {
    var file = File(filePath);
    var context = file.readAsStringSync();
    var firstLine = context.replaceAll('\r\n', '\n').split('\n')[0];
    return firstLine.split(' ').map((e) => ArticleTag(e)).toList();
  }

  static String _getBody(String filePath) {
    var file = File(filePath);
    var context = file.readAsStringSync();
    return context.split('\n').sublist(1).join('\n');
  }

  Future<void> setUpMarkdownAndIndex() async {
    var result = await MarkdownService.convertToHtml(markdownBody);
    _htmlBody = result.item1;
    _indexList = result.item2;
  }

  Map asMap() {
    return {
      'uuid': uuid,
      'github_file_url': githubFileUrl,
      'title': articleTitle,
      'body': markdownBody.replaceAll(RegExp(r'[\$\r\n]'), '').replaceAll(RegExp(r'[!"#%&\/()*+,-./:;<=>?@^_`{|}~\[\]「」〔〕“”〈〉『』【】＆＊・（）＄＃＠。、？！｀＋￥％]'), ''),
      'tags': tags.map((e) => e.text).toList()
    };
  }
}
